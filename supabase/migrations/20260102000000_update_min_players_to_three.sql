-- Update default minPlayers back to 3 for online multiplayer
ALTER TABLE rooms
ALTER COLUMN settings
SET DEFAULT '{"roundDuration": 120, "minPlayers": 3, "maxPlayers": 10}'::jsonb;
