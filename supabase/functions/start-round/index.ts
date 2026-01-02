import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

// Note: This function uses the service role key to bypass RLS
// The function itself validates room_id is provided

serve(async (req) => {
  console.log('start-round function called')
  console.log('Method:', req.method)
  console.log('Headers:', JSON.stringify(Object.fromEntries(req.headers.entries())))

  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const body = await req.json()
    console.log('Request body:', JSON.stringify(body))
    const { room_id } = body

    if (!room_id) {
      return new Response(
        JSON.stringify({ error: 'room_id is required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Create Supabase client with service role key
    const supabaseUrl = Deno.env.get('SUPABASE_URL')
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')

    console.log('Supabase URL:', supabaseUrl)
    console.log('Service key exists:', !!supabaseServiceKey)

    if (!supabaseUrl || !supabaseServiceKey) {
      throw new Error('Missing Supabase environment variables')
    }

    const supabase = createClient(supabaseUrl, supabaseServiceKey)

    // 1. Get room settings to check for selected pack
    const { data: room, error: roomError } = await supabase
      .from('rooms')
      .select('settings')
      .eq('id', room_id)
      .single()

    if (roomError) {
      throw new Error(`Failed to get room: ${roomError.message}`)
    }

    const packId = room?.settings?.packId

    // 2. Get all connected players in room
    const { data: players, error: playersError } = await supabase
      .from('players')
      .select('id')
      .eq('room_id', room_id)
      .eq('is_connected', true)

    if (playersError) {
      throw new Error(`Failed to get players: ${playersError.message}`)
    }

    if (!players || players.length < 3) {
      return new Response(
        JSON.stringify({ error: 'Not enough players (minimum 3 required)' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // 3. Get a random word (filtered by packId if specified)
    let wordsQuery = supabase
      .from('words')
      .select('id, word, hint')

    if (packId) {
      wordsQuery = wordsQuery.eq('pack_id', packId)
    }

    const { data: words, error: wordsError } = await wordsQuery

    if (wordsError || !words || words.length === 0) {
      throw new Error(packId ? 'No words found in selected pack' : 'Failed to get words')
    }

    const selectedWord = words[Math.floor(Math.random() * words.length)]

    // 4. Select random imposter
    const imposterIndex = Math.floor(Math.random() * players.length)
    const imposterId = players[imposterIndex].id

    // 5. Get current round count
    const { data: existingRounds } = await supabase
      .from('rounds')
      .select('round_number')
      .eq('room_id', room_id)
      .order('round_number', { ascending: false })
      .limit(1)

    const roundNumber = existingRounds && existingRounds.length > 0
      ? existingRounds[0].round_number + 1
      : 1

    // 6. Calculate timing
    // Reveal phase: 10 seconds for players to see their cards
    // Discussion phase: 2 minutes (120 seconds) after reveal ends
    const revealEndsAt = new Date(Date.now() + 10 * 1000).toISOString()
    const endsAt = new Date(Date.now() + 10 * 1000 + 120 * 1000).toISOString()

    // 7. Create round
    const { data: round, error: roundError } = await supabase
      .from('rounds')
      .insert({
        room_id,
        round_number: roundNumber,
        word_id: selectedWord.id,
        imposter_player_id: imposterId,
        reveal_ends_at: revealEndsAt,
        ends_at: endsAt,
        state: 'reveal'
      })
      .select()
      .single()

    if (roundError) {
      throw new Error(`Failed to create round: ${roundError.message}`)
    }

    // 8. Create player cards
    const playerCards = players.map(player => ({
      round_id: round.id,
      player_id: player.id,
      card_type: player.id === imposterId ? 'imposter' : 'word',
      payload: player.id === imposterId
        ? { hint: selectedWord.hint }
        : { word: selectedWord.word }
    }))

    const { error: cardsError } = await supabase
      .from('player_cards')
      .insert(playerCards)

    if (cardsError) {
      throw new Error(`Failed to create player cards: ${cardsError.message}`)
    }

    // 9. Update room status and current round
    const { error: roomUpdateError } = await supabase
      .from('rooms')
      .update({
        status: 'playing',
        current_round_id: round.id
      })
      .eq('id', room_id)

    if (roomUpdateError) {
      throw new Error(`Failed to update room: ${roomUpdateError.message}`)
    }

    // Note: State transitions (reveal -> discussion -> voting) are handled client-side
    // because edge functions cannot use setTimeout reliably (they terminate after response)

    return new Response(
      JSON.stringify({
        success: true,
        round_id: round.id,
        player_count: players.length
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Error:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
