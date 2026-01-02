-- Add columns to store round result (so it doesn't recalculate when votes are deleted)
ALTER TABLE rounds ADD COLUMN group_wins BOOLEAN;
ALTER TABLE rounds ADD COLUMN most_voted_player_id UUID REFERENCES players(id) ON DELETE SET NULL;
