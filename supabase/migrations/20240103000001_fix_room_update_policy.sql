-- Fix: Allow room creator to set initial host_player_id
-- The original policy only allowed host to update, but host_player_id starts as NULL

-- Drop the old policy
DROP POLICY IF EXISTS "Host can update room" ON rooms;

-- Create new policy that allows:
-- 1. Setting host_player_id when it's currently NULL (initial assignment)
-- 2. Host updating the room after that
CREATE POLICY "Host can update room or set initial host"
  ON rooms FOR UPDATE
  USING (
    -- Allow if host_player_id is NULL (initial setup)
    host_player_id IS NULL
    OR
    -- Allow if current user is the host
    host_player_id IN (SELECT id FROM players WHERE user_id = auth.uid())
  );
