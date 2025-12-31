-- Word packs table
CREATE TABLE word_packs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(50) NOT NULL,
  language VARCHAR(10) DEFAULT 'en',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Words table
CREATE TABLE words (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  pack_id UUID REFERENCES word_packs(id) ON DELETE CASCADE,
  word VARCHAR(100) NOT NULL,
  hint VARCHAR(200),
  difficulty INTEGER DEFAULT 1 CHECK (difficulty BETWEEN 1 AND 3)
);

-- Rooms table
CREATE TABLE rooms (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(6) UNIQUE NOT NULL,
  host_player_id UUID,
  status VARCHAR(20) DEFAULT 'waiting' CHECK (status IN ('waiting', 'playing', 'voting', 'results', 'finished')),
  current_round_id UUID,
  settings JSONB DEFAULT '{"roundDuration": 120, "minPlayers": 3, "maxPlayers": 10}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Players table
CREATE TABLE players (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID REFERENCES rooms(id) ON DELETE CASCADE,
  user_id UUID NOT NULL,
  display_name VARCHAR(20) NOT NULL,
  is_ready BOOLEAN DEFAULT FALSE,
  is_connected BOOLEAN DEFAULT TRUE,
  joined_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add foreign key for host_player_id after players table exists
ALTER TABLE rooms ADD CONSTRAINT fk_host_player FOREIGN KEY (host_player_id) REFERENCES players(id) ON DELETE SET NULL;

-- Rounds table
CREATE TABLE rounds (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  room_id UUID REFERENCES rooms(id) ON DELETE CASCADE,
  round_number INTEGER NOT NULL,
  word_id UUID REFERENCES words(id),
  imposter_player_id UUID REFERENCES players(id),
  started_at TIMESTAMPTZ DEFAULT NOW(),
  ends_at TIMESTAMPTZ,
  state VARCHAR(20) DEFAULT 'reveal' CHECK (state IN ('reveal', 'discussion', 'voting', 'results'))
);

-- Add foreign key for current_round_id after rounds table exists
ALTER TABLE rooms ADD CONSTRAINT fk_current_round FOREIGN KEY (current_round_id) REFERENCES rounds(id) ON DELETE SET NULL;

-- Votes table
CREATE TABLE votes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  round_id UUID REFERENCES rounds(id) ON DELETE CASCADE,
  voter_player_id UUID REFERENCES players(id),
  voted_player_id UUID REFERENCES players(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(round_id, voter_player_id)
);

-- Player cards table (secure - RLS protected)
CREATE TABLE player_cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  round_id UUID REFERENCES rounds(id) ON DELETE CASCADE,
  player_id UUID REFERENCES players(id),
  card_type VARCHAR(20) NOT NULL CHECK (card_type IN ('word', 'imposter')),
  payload JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(round_id, player_id)
);

-- Indexes for performance
CREATE INDEX idx_rooms_code ON rooms(code);
CREATE INDEX idx_players_room ON players(room_id);
CREATE INDEX idx_players_user ON players(user_id);
CREATE INDEX idx_rounds_room ON rounds(room_id);
CREATE INDEX idx_votes_round ON votes(round_id);
CREATE INDEX idx_player_cards_round ON player_cards(round_id);
CREATE INDEX idx_player_cards_player ON player_cards(player_id);
CREATE INDEX idx_words_pack ON words(pack_id);
