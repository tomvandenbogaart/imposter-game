-- Add reveal_ends_at column to rounds table for synchronized card reveal timing
ALTER TABLE rounds ADD COLUMN reveal_ends_at TIMESTAMPTZ;
