-- Add category and seasonal fields to word_packs table
-- This migration adds support for pack categories, sorting, and seasonal availability

-- Add category field for grouping packs in UI
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS category VARCHAR(50);

-- Add icon name for pack display
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS icon_name VARCHAR(50);

-- Add sort order for custom ordering within categories
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 0;

-- Add seasonal pack support
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS is_seasonal BOOLEAN DEFAULT FALSE;
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS available_from TIMESTAMPTZ;
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS available_until TIMESTAMPTZ;

-- Create indexes for efficient querying
CREATE INDEX IF NOT EXISTS idx_word_packs_category ON word_packs(category);
CREATE INDEX IF NOT EXISTS idx_word_packs_sort_order ON word_packs(sort_order);
CREATE INDEX IF NOT EXISTS idx_word_packs_seasonal ON word_packs(is_seasonal);
CREATE INDEX IF NOT EXISTS idx_word_packs_availability ON word_packs(available_from, available_until);
