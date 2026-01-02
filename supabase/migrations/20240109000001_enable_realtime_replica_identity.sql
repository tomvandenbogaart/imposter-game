-- Enable REPLICA IDENTITY FULL on tables that need realtime DELETE events with filters
-- This is required for Supabase realtime to receive DELETE events when using column filters,
-- because the filter needs to match against the OLD row data (which is only available with FULL)

ALTER TABLE players REPLICA IDENTITY FULL;
ALTER TABLE votes REPLICA IDENTITY FULL;
ALTER TABLE skip_votes REPLICA IDENTITY FULL;

-- Ensure these tables are part of the realtime publication
-- (Supabase creates the supabase_realtime publication automatically,
-- but we need to ensure our tables are included)
DO $$
BEGIN
  -- Add tables to the realtime publication if not already added
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'players'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE players;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'votes'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE votes;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'skip_votes'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE skip_votes;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'rooms'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE rooms;
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables
    WHERE pubname = 'supabase_realtime' AND tablename = 'rounds'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE rounds;
  END IF;
END
$$;
