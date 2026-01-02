-- Update default minPlayers to 2 for testing
ALTER TABLE rooms
ALTER COLUMN settings
SET DEFAULT '{"roundDuration": 120, "minPlayers": 2, "maxPlayers": 10}'::jsonb;
