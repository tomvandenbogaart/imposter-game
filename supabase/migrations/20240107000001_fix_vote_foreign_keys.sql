-- Fix foreign keys on votes table to cascade on player delete
-- First drop the existing constraints
ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_voter_player_id_fkey;
ALTER TABLE votes DROP CONSTRAINT IF EXISTS votes_voted_player_id_fkey;

-- Re-add with ON DELETE CASCADE
ALTER TABLE votes
  ADD CONSTRAINT votes_voter_player_id_fkey
  FOREIGN KEY (voter_player_id) REFERENCES players(id) ON DELETE CASCADE;

ALTER TABLE votes
  ADD CONSTRAINT votes_voted_player_id_fkey
  FOREIGN KEY (voted_player_id) REFERENCES players(id) ON DELETE CASCADE;

-- Also fix player_cards foreign key
ALTER TABLE player_cards DROP CONSTRAINT IF EXISTS player_cards_player_id_fkey;
ALTER TABLE player_cards
  ADD CONSTRAINT player_cards_player_id_fkey
  FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE;

-- Fix rounds imposter_player_id foreign key
ALTER TABLE rounds DROP CONSTRAINT IF EXISTS rounds_imposter_player_id_fkey;
ALTER TABLE rounds
  ADD CONSTRAINT rounds_imposter_player_id_fkey
  FOREIGN KEY (imposter_player_id) REFERENCES players(id) ON DELETE SET NULL;
