import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { room_id } = await req.json()

    if (!room_id) {
      return new Response(
        JSON.stringify({ error: 'room_id is required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Create Supabase client with service role key
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!

    const supabase = createClient(supabaseUrl, supabaseServiceKey)

    // 1. Get all connected players in room
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

    // 2. Get a random word
    const { data: words, error: wordsError } = await supabase
      .from('words')
      .select('id, word, hint')

    if (wordsError || !words || words.length === 0) {
      throw new Error('Failed to get words')
    }

    const selectedWord = words[Math.floor(Math.random() * words.length)]

    // 3. Select random imposter
    const imposterIndex = Math.floor(Math.random() * players.length)
    const imposterId = players[imposterIndex].id

    // 4. Get current round count
    const { data: existingRounds } = await supabase
      .from('rounds')
      .select('round_number')
      .eq('room_id', room_id)
      .order('round_number', { ascending: false })
      .limit(1)

    const roundNumber = existingRounds && existingRounds.length > 0
      ? existingRounds[0].round_number + 1
      : 1

    // 5. Calculate timer end (2 minutes from now)
    const endsAt = new Date(Date.now() + 120 * 1000).toISOString()

    // 6. Create round
    const { data: round, error: roundError } = await supabase
      .from('rounds')
      .insert({
        room_id,
        round_number: roundNumber,
        word_id: selectedWord.id,
        imposter_player_id: imposterId,
        ends_at: endsAt,
        state: 'reveal'
      })
      .select()
      .single()

    if (roundError) {
      throw new Error(`Failed to create round: ${roundError.message}`)
    }

    // 7. Create player cards
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

    // 8. Update room status and current round
    const { error: roomError } = await supabase
      .from('rooms')
      .update({
        status: 'playing',
        current_round_id: round.id
      })
      .eq('id', room_id)

    if (roomError) {
      throw new Error(`Failed to update room: ${roomError.message}`)
    }

    // 9. Schedule state transitions
    // After 5 seconds, move to discussion
    setTimeout(async () => {
      await supabase
        .from('rounds')
        .update({ state: 'discussion' })
        .eq('id', round.id)
    }, 5000)

    // After timer ends, move to voting
    setTimeout(async () => {
      await supabase
        .from('rounds')
        .update({ state: 'voting' })
        .eq('id', round.id)
    }, 125 * 1000) // 5s reveal + 120s discussion

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
