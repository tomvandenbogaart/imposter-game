-- Add delete policy for votes table
-- Allows users to delete their own votes (for leaving room)
CREATE POLICY "Users can delete their own votes"
  ON votes FOR DELETE
  USING (
    voter_player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
  );

-- Also allow deleting votes cast FOR a player (when that player leaves)
CREATE POLICY "Users can delete votes for their player"
  ON votes FOR DELETE
  USING (
    voted_player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
  );
