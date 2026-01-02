-- Add skip_votes table to track players who want to skip discussion
CREATE TABLE IF NOT EXISTS skip_votes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  round_id UUID NOT NULL REFERENCES rounds(id) ON DELETE CASCADE,
  player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(round_id, player_id)
);

-- Enable RLS
ALTER TABLE skip_votes ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read skip votes for rounds they're in
CREATE POLICY "Users can read skip votes for their rounds"
  ON skip_votes FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM rounds r
      JOIN players p ON p.room_id = r.room_id
      WHERE r.id = skip_votes.round_id
      AND p.user_id = auth.uid()
    )
  );

-- Allow authenticated users to insert their own skip votes
CREATE POLICY "Users can insert their own skip votes"
  ON skip_votes FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM players p
      WHERE p.id = skip_votes.player_id
      AND p.user_id = auth.uid()
    )
  );

-- Allow authenticated users to delete their own skip votes
CREATE POLICY "Users can delete their own skip votes"
  ON skip_votes FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM players p
      WHERE p.id = skip_votes.player_id
      AND p.user_id = auth.uid()
    )
  );

-- Enable realtime for skip_votes
ALTER PUBLICATION supabase_realtime ADD TABLE skip_votes;
