-- Enable Row Level Security on all tables
ALTER TABLE rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE rounds ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE word_packs ENABLE ROW LEVEL SECURITY;
ALTER TABLE words ENABLE ROW LEVEL SECURITY;

-- Rooms policies
CREATE POLICY "Rooms are viewable by everyone"
  ON rooms FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can create rooms"
  ON rooms FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Host can update room"
  ON rooms FOR UPDATE
  USING (
    host_player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
  );

-- Players policies
CREATE POLICY "Players are viewable by everyone"
  ON players FOR SELECT
  USING (true);

CREATE POLICY "Users can join rooms"
  ON players FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own player"
  ON players FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can leave rooms"
  ON players FOR DELETE
  USING (auth.uid() = user_id);

-- Rounds policies
CREATE POLICY "Rounds are viewable by room participants"
  ON rounds FOR SELECT
  USING (
    room_id IN (SELECT room_id FROM players WHERE user_id = auth.uid())
  );

CREATE POLICY "Service role can insert rounds"
  ON rounds FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

CREATE POLICY "Service role can update rounds"
  ON rounds FOR UPDATE
  USING (auth.uid() IS NOT NULL);

-- Player Cards policies - CRITICAL: Users can only see their own card
CREATE POLICY "Users can only see their own card"
  ON player_cards FOR SELECT
  USING (
    player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
  );

-- Service role can insert cards (for edge functions)
CREATE POLICY "Service role inserts cards"
  ON player_cards FOR INSERT
  WITH CHECK (auth.uid() IS NOT NULL);

-- Votes policies
CREATE POLICY "Votes are visible to room participants"
  ON votes FOR SELECT
  USING (
    round_id IN (
      SELECT r.id FROM rounds r
      JOIN players p ON p.room_id = r.room_id
      WHERE p.user_id = auth.uid()
    )
  );

CREATE POLICY "Players can vote once per round"
  ON votes FOR INSERT
  WITH CHECK (
    voter_player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
  );

-- Word packs and words are public read
CREATE POLICY "Word packs are public"
  ON word_packs FOR SELECT
  USING (true);

CREATE POLICY "Words are public"
  ON words FOR SELECT
  USING (true);

-- Enable realtime for relevant tables
ALTER PUBLICATION supabase_realtime ADD TABLE rooms;
ALTER PUBLICATION supabase_realtime ADD TABLE players;
ALTER PUBLICATION supabase_realtime ADD TABLE rounds;
ALTER PUBLICATION supabase_realtime ADD TABLE votes;
