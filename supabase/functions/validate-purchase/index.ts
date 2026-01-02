import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface ValidatePurchaseRequest {
  store: 'ios' | 'android'
  store_product_id: string
  store_transaction_id: string
  purchase_token?: string
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Get user from auth header
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: 'Missing authorization header' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabaseAnonKey = Deno.env.get('SUPABASE_ANON_KEY')!

    // Create client with service role for admin operations
    const supabaseAdmin = createClient(supabaseUrl, supabaseServiceKey)

    // Create client with user's JWT to verify auth
    const supabaseClient = createClient(supabaseUrl, supabaseAnonKey, {
      global: { headers: { Authorization: authHeader } }
    })

    // Verify user
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser()
    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: 'Invalid user' }),
        { status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const body: ValidatePurchaseRequest = await req.json()
    const { store, store_product_id, store_transaction_id, purchase_token } = body

    // Validate required fields
    if (!store || !store_product_id || !store_transaction_id) {
      return new Response(
        JSON.stringify({ error: 'Missing required fields: store, store_product_id, store_transaction_id' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Check for duplicate transaction
    const { data: existingTx } = await supabaseAdmin
      .from('iap_transactions')
      .select('id, status')
      .eq('store', store)
      .eq('store_transaction_id', store_transaction_id)
      .maybeSingle()

    if (existingTx && existingTx.status === 'completed') {
      // Transaction already processed, return current entitlements
      const { data: entitlements } = await supabaseAdmin
        .from('entitlements')
        .select(`
          id,
          product:products(id, type, store_product_id)
        `)
        .eq('user_id', user.id)

      return new Response(
        JSON.stringify({
          success: true,
          message: 'Transaction already processed',
          entitlements: entitlements?.map(e => ({
            id: e.id,
            productType: (e.product as any)?.type,
            productId: (e.product as any)?.store_product_id
          })) || []
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Record/update transaction
    const { data: transaction, error: txError } = await supabaseAdmin
      .from('iap_transactions')
      .upsert({
        user_id: user.id,
        store,
        store_transaction_id,
        store_product_id,
        purchase_token: purchase_token || null,
        status: 'pending',
        updated_at: new Date().toISOString()
      }, {
        onConflict: 'store,store_transaction_id'
      })
      .select()
      .single()

    if (txError) {
      console.error('Transaction error:', txError)
      throw new Error(`Failed to record transaction: ${txError.message}`)
    }

    // MVP Approach: Trust store confirmation, grant entitlements
    // In production, add server-side receipt/token validation here:
    // - iOS: Verify with App Store Server API
    // - Android: Verify with Google Play Developer API

    // Get product info
    const { data: product, error: productError } = await supabaseAdmin
      .from('products')
      .select('id, type')
      .eq('store_product_id', store_product_id)
      .eq('active', true)
      .single()

    if (productError || !product) {
      await supabaseAdmin
        .from('iap_transactions')
        .update({ status: 'failed', error_message: 'Product not found or inactive' })
        .eq('id', transaction.id)

      return new Response(
        JSON.stringify({ error: 'Product not found or inactive' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Determine which entitlements to grant based on product type
    const productsToGrant: string[] = []

    if (product.type === 'ads') {
      // Just ads removal
      productsToGrant.push(product.id)
    } else if (product.type === 'packs') {
      // Just packs
      productsToGrant.push(product.id)
    } else if (product.type === 'bundle') {
      // Bundle grants both ads and packs entitlements
      const { data: adsProduct } = await supabaseAdmin
        .from('products')
        .select('id')
        .eq('type', 'ads')
        .eq('active', true)
        .single()

      const { data: packsProduct } = await supabaseAdmin
        .from('products')
        .select('id')
        .eq('type', 'packs')
        .eq('active', true)
        .single()

      if (adsProduct) productsToGrant.push(adsProduct.id)
      if (packsProduct) productsToGrant.push(packsProduct.id)
    }

    // Grant entitlements (upsert to handle re-purchases gracefully)
    for (const productId of productsToGrant) {
      const { error: entitlementError } = await supabaseAdmin
        .from('entitlements')
        .upsert({
          user_id: user.id,
          product_id: productId,
          source: 'iap',
          granted_at: new Date().toISOString()
        }, {
          onConflict: 'user_id,product_id'
        })

      if (entitlementError) {
        console.error('Entitlement error:', entitlementError)
        // Continue anyway - don't fail the whole transaction
      }
    }

    // Mark transaction as completed
    await supabaseAdmin
      .from('iap_transactions')
      .update({
        status: 'completed',
        verified_at: new Date().toISOString(),
        updated_at: new Date().toISOString()
      })
      .eq('id', transaction.id)

    // Fetch and return updated entitlements
    const { data: entitlements } = await supabaseAdmin
      .from('entitlements')
      .select(`
        id,
        product:products(id, type, store_product_id)
      `)
      .eq('user_id', user.id)

    return new Response(
      JSON.stringify({
        success: true,
        entitlements: entitlements?.map(e => ({
          id: e.id,
          productType: (e.product as any)?.type,
          productId: (e.product as any)?.store_product_id
        })) || []
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Error:', error)
    return new Response(
      JSON.stringify({ error: (error as Error).message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
