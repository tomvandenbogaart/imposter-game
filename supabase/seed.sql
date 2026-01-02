-- Seed word packs and words
-- Safe to run multiple times (uses upsert pattern)

-- =====================================================
-- WORD PACKS (16 total: 1 FREE, 15 PREMIUM)
-- =====================================================

-- Delete existing words first (to avoid duplicates on re-run)
DELETE FROM words;

-- Create/update word packs with categories
INSERT INTO word_packs (id, name, language, is_premium, category, icon_name, sort_order) VALUES
  -- FREE PACKS (1)
  ('550e8400-e29b-41d4-a716-446655440000', 'General', 'en', false, 'free', 'category', 0),

  -- ENTERTAINMENT (5)
  ('550e8400-e29b-41d4-a716-446655440001', 'Pop Culture & Memes', 'en', true, 'entertainment', 'trending_up', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Party Classics', 'en', true, 'entertainment', 'celebration', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Movies & TV', 'en', true, 'entertainment', 'movie', 10),
  ('550e8400-e29b-41d4-a716-446655440004', 'Music & Artists', 'en', true, 'entertainment', 'music_note', 11),
  ('550e8400-e29b-41d4-a716-446655440005', 'Tech & Gaming', 'en', true, 'entertainment', 'sports_esports', 12),

  -- LIFESTYLE (4)
  ('550e8400-e29b-41d4-a716-446655440006', 'Sports', 'en', true, 'lifestyle', 'sports_soccer', 20),
  ('550e8400-e29b-41d4-a716-446655440007', 'Travel & Places', 'en', true, 'lifestyle', 'flight', 21),
  ('550e8400-e29b-41d4-a716-446655440008', 'Food & Drinks', 'en', true, 'lifestyle', 'restaurant', 22),
  ('550e8400-e29b-41d4-a716-446655440009', 'Fashion & Brands', 'en', true, 'lifestyle', 'checkroom', 23),

  -- KNOWLEDGE (4)
  ('550e8400-e29b-41d4-a716-44665544000a', 'Professions & Jobs', 'en', true, 'knowledge', 'work', 30),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Animals', 'en', true, 'knowledge', 'pets', 31),
  ('550e8400-e29b-41d4-a716-44665544000c', 'History & Legends', 'en', true, 'knowledge', 'auto_stories', 32),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Science & Space', 'en', true, 'knowledge', 'rocket', 33),

  -- TRENDING (2)
  ('550e8400-e29b-41d4-a716-44665544000e', 'TikTok & Social Media', 'en', true, 'trending', 'phone_iphone', 40),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Internet Classics', 'en', true, 'trending', 'language', 41)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  is_premium = EXCLUDED.is_premium,
  category = EXCLUDED.category,
  icon_name = EXCLUDED.icon_name,
  sort_order = EXCLUDED.sort_order;


-- =====================================================
-- GENERAL PACK (FREE) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440000', 'Apple', 'Cupertino''s fruit of choice', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Pizza', 'Margherita''s royal namesake', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Guitar', 'Hendrix set his on fire', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Beach', 'Baywatch''s office', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Coffee', 'Ethiopian goat herders discovered this', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Phone', 'Bell''s invention, pocket edition', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Rain', 'Prince wanted purple this', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Book', 'Gutenberg''s gift to humanity', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Car', 'Benz''s horseless carriage', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Sun', 'Ra''s domain', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Moon', 'Armstrong''s footprint location', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Tree', 'Bodhi enlightenment spot', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'House', 'Dr. Gregory''s surname', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Dog', 'Pavlov''s drooling subject', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440000', 'Telescope', 'Hubble''s orbital namesake', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Volcano', 'Pompeii''s destroyer', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Parachute', 'Da Vinci sketched one', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Lighthouse', 'Alexandria had a famous one', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Compass', 'Chinese invention that points north', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Pyramid', 'Giza''s geometric wonder', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Submarine', 'Nautilus in Verne''s story', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Fireworks', 'Chinese New Year essential', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Treasure', 'Oak Island''s alleged secret', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Waterfall', 'Niagara''s claim to fame', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Bridge', 'Golden Gate''s type', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Castle', 'Dracula''s Transylvanian home type', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Island', 'Robinson Crusoe''s prison', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Mountain', 'Everest''s classification', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440000', 'Nostalgia', 'Swiss soldiers'' medical condition', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Democracy', 'Athens gave this to the world', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Algorithm', 'Al-Khwarizmi''s legacy', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Philosophy', 'Socrates drank hemlock for this', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Hypothesis', 'Scientific method step two', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Constellation', 'Orion is one of these', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Encryption', 'Enigma machine''s purpose', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Meditation', 'Buddhist path to enlightenment', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Archaeology', 'Indiana Jones''s day job', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Biodiversity', 'Amazon rainforest''s wealth', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Renaissance', 'Medici-funded cultural rebirth', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Paradox', 'Zeno''s arrow is one', 3);


-- =====================================================
-- POP CULTURE & MEMES PACK (FREE) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440001', 'Rizz', 'Charisma check in D&D terms', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Slay', 'Medieval compliment nowadays', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'NPC', 'Skyrim citizens behave like this', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Vibe', 'Beach Boys picked up these', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Cap', 'Pinocchio''s verbal equivalent', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Flex', 'Showing off, gym style', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Ghost', 'Casper''s dating strategy', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Stan', 'Eminem wrote a song about this fan type', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Tea', 'British drink, American gossip', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Shade', 'Trees provide this, so do haters', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Lowkey', 'Loki''s brother is the opposite', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Salty', 'Ocean water and sore losers', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Bet', 'Gambling agreement or approval', 1),
  ('550e8400-e29b-41d4-a716-446655440001', 'Lit', 'Fire state or party state', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440001', 'Skibidi', 'Toilet-themed DaFuq?!Boom creation', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Griddy', 'Jefferson''s endzone signature', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Stanley Cup', 'Hockey trophy or hydration status symbol', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Delulu', 'Clinical optimism slang', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Simp', 'Squirrels In My Pants acronym joke', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Boomer', 'Post-war generation, now an insult', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Karen', 'Manager''s nemesis name', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Ratio', 'Twitter''s democracy in action', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Sigma', 'Greek letter or lone wolf male', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Glaze', 'Donut coating or excessive praise', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Mid', 'Average, but insulting', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Drip', 'Faucet leak or fashion sense', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Bussin', 'Bus-related or food-related', 2),
  ('550e8400-e29b-41d4-a716-446655440001', 'Yeet', 'Opposite of yoink', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440001', 'Gaslighting', 'Ingrid Bergman''s 1944 thriller', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Cheugy', 'Millennial aesthetic crime', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Parasocial', 'One-sided celebrity friendship type', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Copium', 'Hopium''s darker cousin', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Situationship', 'Relationship without the label', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Liminal', 'Backrooms aesthetic type', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Based', '4chan approval term', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Mewing', 'Orthotropics technique made viral', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Gyatt', 'Exclamation of appreciation', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Ick', 'Sudden attraction killer', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Snatched', 'Wig status after a great look', 3),
  ('550e8400-e29b-41d4-a716-446655440001', 'Chronically Online', 'Touch grass prescription needed', 3);


-- =====================================================
-- PARTY CLASSICS PACK (FREE) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440002', 'Beer Pong', 'Solo cup trajectory sport', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Karaoke', 'Empty orchestra in Japanese', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Shots', 'Lil Jon''s repeated command', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Dance Floor', 'Saturday Night Fever''s stage', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'DJ', 'Khaled''s job title', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Hangover', 'Vegas movie trilogy title', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Playlist', 'Spotify''s bread and butter', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Cheers', 'Boston bar sitcom title', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Toast', 'Wedding speech or bread state', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Pregame', 'Before the main event warm-up', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Mixer', 'Soda''s role in cocktails', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Selfie', 'Kim K''s book subject', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Balloon', 'Up''s travel method', 1),
  ('550e8400-e29b-41d4-a716-446655440002', 'Confetti', 'New Year''s Eve snowfall', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440002', 'Truth or Dare', 'Binary interrogation game', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Limbo', 'Hermes Conrad''s Olympic event', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Never Have I Ever', 'Confession through finger elimination', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Spin the Bottle', 'Glass compass of chaos', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Flip Cup', 'Table edge acrobatics', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Kings', 'Deck-based drinking rules', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Quarters', 'Currency meets glassware', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Charades', 'Silent acting guessing game', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Pictionary', 'Artistic guessing game', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Cards Against Humanity', 'Apples to Apples for adults', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Jenga', 'Wooden tower anxiety', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Mafia', 'Town versus deception', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Werewolf', 'Village versus lycanthrope', 2),
  ('550e8400-e29b-41d4-a716-446655440002', 'Pinata', 'Blindfolded candy violence', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440002', 'Champagne', 'Dom Perignon''s accidental creation', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Pub Crawl', 'Bar hopping with a plan', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Keg Stand', 'Inverted consumption challenge', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Taboo', 'Word guessing with forbidden clues', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Codenames', 'Spy-themed word association', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Jackbox', 'Digital party game collection', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Icebreaker', 'Titanic''s enemy or party starter', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Secret Santa', 'Anonymous gift exchange', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'White Elephant', 'Useless gift exchange game', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Cocktail', 'Tom Cruise shook them in the 80s', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Designated Driver', 'The hero of the night', 3),
  ('550e8400-e29b-41d4-a716-446655440002', 'Afterparty', 'When the party refuses to die', 3);


-- =====================================================
-- MOVIES & TV PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440003', 'Popcorn', 'Orville Redenbacher''s empire', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Remote', 'Adam Sandler''s Click device', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Cinema', 'Lumiere brothers'' invention venue', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Netflix', 'Hastings'' DVD-by-mail pivot', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Cartoon', 'Disney''s original format', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Sequel', 'Rocky had five of these', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Trailer', 'Coming soon preview', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Oscar', 'Gold bald man statue', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Credits', 'Stay for Marvel''s after these', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Streaming', 'Cable''s replacement', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Comedy', 'Tragedy''s theatrical twin', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Horror', 'Hitchcock''s preferred genre', 1),
  ('550e8400-e29b-41d4-a716-446655440003', 'Stunt', 'Tom Cruise does his own', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440003', 'Lightsaber', 'Elegant weapon for a civilized age', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Hogwarts', 'Scottish magical boarding school', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Wakanda', 'Vibranium''s source nation', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'DeLorean', '88 problems solved by speed', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Mordor', 'Simply walking is not advised', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Thanos', 'Purple titan with jewelry obsession', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Cliffhanger', 'Sylvester Stallone mountain movie', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Documentary', 'Tiger King''s format', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Soundtrack', 'Hans Zimmer''s specialty', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Binge-watching', 'Netflix''s intended use case', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Sitcom', 'Friends'' format', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Reboot', 'Hollywood''s creativity shortcut', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Spoiler', 'Internet comment section danger', 2),
  ('550e8400-e29b-41d4-a716-446655440003', 'Plot Twist', 'Shyamalan''s signature', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440003', 'Cinematography', 'Roger Deakins'' craft', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Protagonist', 'Greek for first actor', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Antagonist', 'Joker''s role type', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Screenplay', 'Aaron Sorkin''s product', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Auteur', 'French director theory', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'MacGuffin', 'Hitchcock''s plot device term', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Rosebud', 'Kane''s final word', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Method Acting', 'Daniel Day-Lewis''s approach', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Noir', 'Bogart''s film style', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Montage', 'Rocky''s training sequence type', 3),
  ('550e8400-e29b-41d4-a716-446655440003', 'Fourth Wall', 'Deadpool breaks this constantly', 3);


-- =====================================================
-- MUSIC & ARTISTS PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440004', 'Guitar', 'Clapton is God''s instrument', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Drums', 'Phil Collins'' weapon of choice', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Piano', 'Elton John''s throne accessory', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Concert', 'Taylor Swift''s Eras event', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Album', 'Vinyl''s digital descendant', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Band', 'Liverpool''s Fab Four were this', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Lyrics', 'Bob Dylan won Nobel for these', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Stage', 'Madonna''s falling location', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Microphone', 'Freddie Mercury''s signature half-stand', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Headphones', 'Beats by Dre product', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Vinyl', 'Hipster''s preferred format', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Radio', 'Killed the video star', 1),
  ('550e8400-e29b-41d4-a716-446655440004', 'Spotify', 'Daniel Ek''s green machine', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440004', 'Encore', 'French for again', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Grammy', 'Beyonce has 32 of these', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Remix', 'Producer''s second take', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Autotune', 'Cher''s Believe innovation', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Mosh Pit', 'Metal concert''s danger zone', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Verse', 'Before the chorus', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Bridge', 'Song structure transition', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Acoustic', 'MTV Unplugged format', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Cover', 'Disturbed did Sound of Silence', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Falsetto', 'Bee Gees'' signature range', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Collab', 'Feature''s casual name', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Groupie', 'Band''s superfan follower', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Roadie', 'Tour''s unsung heroes', 2),
  ('550e8400-e29b-41d4-a716-446655440004', 'Backstage', 'VIP pass destination', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440004', 'Syncopation', 'Jazz''s rhythmic displacement', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Crescendo', 'Ravel''s Bolero is one long this', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Aria', 'Opera''s solo moment', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Cadence', 'Musical phrase ending', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Timbre', 'Instrument''s unique voice quality', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Leitmotif', 'Star Wars themes are these', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Virtuoso', 'Paganini''s skill level', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Dissonance', 'Tension before resolution', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Polyrhythm', 'Tool and King Crimson specialty', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'Sample', 'Hip hop built on these', 3),
  ('550e8400-e29b-41d4-a716-446655440004', 'A Cappella', 'Pitch Perfect''s style', 3);


-- =====================================================
-- TECH & GAMING PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440005', 'Minecraft', 'Notch''s blocky creation', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Fortnite', 'Epic''s battle bus game', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Mario', 'Nintendo''s Italian plumber', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'PlayStation', 'Sony''s X button debate console', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Xbox', 'Microsoft''s green brand', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Twitch', 'Amazon''s streaming platform', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Discord', 'Nitro-powered chat app', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'WiFi', 'Wireless fidelity abbreviation', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Password', 'Hunter2 is not a good one', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Download', 'Napster''s original sin', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Emoji', 'Shigetaka Kurita''s pictograms', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Selfie', 'Front camera''s purpose', 1),
  ('550e8400-e29b-41d4-a716-446655440005', 'Meme', 'Dawkins coined this term', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440005', 'Among Us', 'Colored astronauts with trust issues', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Bitcoin', 'Satoshi Nakamoto''s experiment', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Elden Ring', 'Miyazaki''s open world souls game', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Speedrun', 'GDQ''s specialty', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Esports', 'Competitive gaming industry', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Streamer', 'Ninja''s profession', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Mod', 'Skyrim has thousands of these', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Noob', 'New player or insult', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Rage Quit', 'Sore loser''s exit strategy', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Easter Egg', 'Hidden developer secret', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Pixel', 'Digital art''s smallest unit', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Avatar', 'Digital self representation', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Lag', 'Every online gamer''s excuse', 2),
  ('550e8400-e29b-41d4-a716-446655440005', 'Respawn', 'Death''s temporary nature', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440005', 'Algorithm', 'TikTok''s secret sauce', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Blockchain', 'Distributed ledger buzzword', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Metaverse', 'Zuckerberg''s expensive pivot', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Roguelike', 'Death means starting over genre', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Permadeath', 'One life per character', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Gacha', 'Japanese gambling game mechanic', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Loot Box', 'Gambling''s gaming disguise', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Nerf', 'Balance patch weakening', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Buff', 'Balance patch strengthening', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'RNG', 'Random number generator luck', 3),
  ('550e8400-e29b-41d4-a716-446655440005', 'Kernel', 'Operating system''s core', 3);


-- =====================================================
-- SPORTS PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440006', 'Basketball', 'Naismith''s peach basket game', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Soccer', 'Rest of world calls it football', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Tennis', 'Wimbledon''s sport', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Golf', 'Tiger Woods'' domain', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Swimming', 'Phelps'' 23 gold medal sport', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Boxing', 'Ali floated like a butterfly in', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Hockey', 'Gretzky''s frozen sport', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Baseball', 'America''s pastime', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Football', 'Super Bowl''s sport', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Olympics', 'Baron de Coubertin revived these', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Marathon', '26.2 miles of Greek history', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Referee', 'Everyone''s favorite scapegoat', 1),
  ('550e8400-e29b-41d4-a716-446655440006', 'Coach', 'Ted Lasso''s profession', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440006', 'Touchdown', 'Six points in American football', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Slam Dunk', 'Jordan''s signature move', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Hat Trick', 'Three goals, one game', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Penalty', 'Yellow card consequence', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Draft', 'Where careers begin in US sports', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Playoffs', 'Regular season''s reward', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'MVP', 'Most valuable player trophy', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Underdog', 'Rocky''s story archetype', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Rivalry', 'Red Sox vs Yankees relationship', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Stadium', 'Colosseum''s modern descendant', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Goalkeeper', 'Last line of defense', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Surfing', 'Duke Kahanamoku''s legacy', 2),
  ('550e8400-e29b-41d4-a716-446655440006', 'Skateboarding', 'Tony Hawk''s Pro discipline', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440006', 'Triathlon', 'Ironman''s triple sport', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Decathlon', 'Bruce Jenner''s ten events', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Fencing', 'Olympic sword combat', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Archery', 'Legolas'' competitive sport', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Curling', 'Chess on ice with brooms', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Biathlon', 'Skiing plus shooting', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Dressage', 'Horse dancing competition', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Jai Alai', 'Fastest ball sport in the world', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Polo', 'Sport of kings on horseback', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Rowing', 'Oxford vs Cambridge annual race', 3),
  ('550e8400-e29b-41d4-a716-446655440006', 'Steeplechase', 'Horse jumps with water hazards', 3);


-- =====================================================
-- TRAVEL & PLACES PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440007', 'Passport', 'Blue booklet of freedom', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Airport', 'Where journeys take off', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Hotel', 'Trivago''s search result', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Beach', 'Baywatch filming location', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Vacation', 'Chevy Chase''s film series', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Tourist', 'Camera around neck stereotype', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Luggage', 'Samsonite''s specialty', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Map', 'Dora always needs one', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Souvenir', 'Proof you were there', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Cruise', 'Titanic''s transport type', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Safari', 'African wildlife tour', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Camping', 'Sleeping outdoors on purpose', 1),
  ('550e8400-e29b-41d4-a716-446655440007', 'Roadtrip', 'Kerouac''s travel style', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440007', 'Eiffel Tower', 'Gustave''s iron lattice', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Colosseum', 'Gladiator''s arena', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Taj Mahal', 'Shah Jahan''s love monument', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Great Wall', 'Visible from space myth', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Machu Picchu', 'Incan cloud city', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Jet Lag', 'Time zone body confusion', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Currency', 'Exchange rate subject', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Customs', 'Border declaration point', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Hostel', 'Budget traveler''s bunk bed', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Backpacking', 'Europe gap year tradition', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Itinerary', 'Type A traveler''s Bible', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Landmark', 'Instagram check-in spot', 2),
  ('550e8400-e29b-41d4-a716-446655440007', 'Excursion', 'Organized day adventure', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440007', 'Pilgrimage', 'Santiago de Compostela''s purpose', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Wanderlust', 'German travel itch word', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Archipelago', 'Indonesia and Philippines geography', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Fjord', 'Norway''s glacial valleys', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Visa', 'Entry permission stamp', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Layover', 'Connection flight waiting', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Expedition', 'Shackleton''s Antarctic type', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Aurora Borealis', 'Northern lights formal name', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Meridian', 'Greenwich''s famous line', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Hemisphere', 'Earth''s half portion', 3),
  ('550e8400-e29b-41d4-a716-446655440007', 'Longitude', 'East-west measurement', 3);


-- =====================================================
-- FOOD & DRINKS PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440008', 'Pizza', 'Naples'' gift to America', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Burger', 'McDonald''s foundation', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Sushi', 'Tokyo''s raw art form', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Taco', 'Tuesday''s designated food', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Coffee', 'Starbucks'' liquid gold', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Chocolate', 'Aztec currency that melts', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Ice Cream', 'Ben & Jerry''s product', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Pasta', 'Italy''s carb export', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Pancake', 'IHOP''s specialty', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Sandwich', 'Earl invented this for gambling', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Salad', 'Caesar''s namesake dish', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Steak', 'Rare, medium, or well done', 1),
  ('550e8400-e29b-41d4-a716-446655440008', 'Smoothie', 'Fruit''s blended fate', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440008', 'Croissant', 'Austrian crescent, French fame', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Avocado', 'Millennial''s mortgage enemy', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Espresso', 'Italy''s concentrated awakening', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Guacamole', 'Super Bowl''s green dip', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Kimchi', 'Korea''s fermented national dish', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Ramen', 'Japanese instant or artisan noodles', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Sourdough', 'San Francisco''s fermented pride', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Dim Sum', 'Hong Kong brunch tradition', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Tapas', 'Spain''s small plates philosophy', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Pho', 'Vietnam''s aromatic soup', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Paella', 'Valencia''s saffron rice', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Hummus', 'Middle East''s chickpea spread', 2),
  ('550e8400-e29b-41d4-a716-446655440008', 'Churros', 'Spanish fried dough with chocolate', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440008', 'Bruschetta', 'Tomatoes on their garlic throne', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Prosciutto', 'Parma''s aged leg', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Tiramisu', 'Italian pick me up dessert', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Ceviche', 'Peru''s citrus-cooked fish', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Tartare', 'Steak''s raw French form', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Gnocchi', 'Italian potato pasta', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Aioli', 'Garlic emulsion from Provence', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Umami', 'Japanese fifth taste', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Mise en Place', 'Chef''s prep philosophy', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Amuse-Bouche', 'Complimentary chef''s bite', 3),
  ('550e8400-e29b-41d4-a716-446655440008', 'Sommelier', 'Wine whisperer profession', 3);


-- =====================================================
-- FASHION & BRANDS PACK (PREMIUM) - 30 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440009', 'Nike', 'Greek goddess of victory brand', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Gucci', 'Migos'' favorite designer', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Sneakers', 'Michael Jordan''s endorsement type', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Jeans', 'Levi Strauss'' gold rush invention', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Sunglasses', 'Ray-Ban''s aviator product', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Hoodie', 'Zuckerberg''s uniform', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Dress', 'Was it white and gold or blue and black', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Handbag', 'Birkin''s namesake accessory', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Watch', 'Rolex''s product category', 1),
  ('550e8400-e29b-41d4-a716-446655440009', 'Perfume', 'Chanel No. 5 product type', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440009', 'Runway', 'Fashion Week''s stage', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Vintage', 'Thrift store treasure category', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Supreme', 'Red box logo streetwear', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Athleisure', 'Yoga pants as daily wear', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Capsule Wardrobe', 'Minimalist closet approach', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Fast Fashion', 'Shein''s business model', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Monogram', 'Louis Vuitton''s LV pattern', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Collaboration', 'Nike x Off-White type', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Drop', 'Limited release sneaker event', 2),
  ('550e8400-e29b-41d4-a716-446655440009', 'Resale', 'StockX business model', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440009', 'Haute Couture', 'Paris''s handmade fashion elite', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Silhouette', 'Outfit''s shape outline', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Pret-a-Porter', 'Ready to wear French term', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Avant-Garde', 'Experimental fashion category', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Bespoke', 'Savile Row custom tailoring', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Patina', 'Leather''s aging beauty', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Colorway', 'Sneaker color variation term', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Lookbook', 'Season''s styled photography', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Atelier', 'French fashion workshop', 3),
  ('550e8400-e29b-41d4-a716-446655440009', 'Sample Sale', 'Industry insider discount event', 3);


-- =====================================================
-- PROFESSIONS & JOBS PACK (PREMIUM) - 30 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-44665544000a', 'Doctor', 'Grey''s Anatomy profession', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Teacher', 'Walter White started as this', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Chef', 'Ratatouille''s Remy aspiration', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Pilot', 'Sully''s profession', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Firefighter', 'Dalmatian''s traditional partner', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Lawyer', 'Better Call Saul profession', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Astronaut', 'NASA''s space traveler', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Actor', 'Hollywood''s professional pretenders', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Musician', 'Spotify pays these poorly', 1),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Photographer', 'Annie Leibovitz''s title', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-44665544000a', 'Architect', 'Ted Mosby''s career', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Therapist', 'Couch and notepad stereotype', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Journalist', 'Clark Kent''s day job', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Veterinarian', 'Animal doctor formal title', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Barista', 'Coffee artist profession', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Influencer', 'Sponsored content creator', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Programmer', 'Silicon Valley''s backbone', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Entrepreneur', 'Shark Tank''s visitors', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Surgeon', 'Operating room specialist', 2),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Detective', 'Sherlock''s profession', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-44665544000a', 'Actuary', 'Risk calculation mathematician', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Etymologist', 'Word origin researcher', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Sommelier', 'Wine expert certification', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Epidemiologist', 'Fauci''s specialty', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Ornithologist', 'Bird scientist', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Curator', 'Museum collection guardian', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Arborist', 'Tree surgeon', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Cartographer', 'Map maker profession', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Entomologist', 'Insect scientist', 3),
  ('550e8400-e29b-41d4-a716-44665544000a', 'Underwriter', 'Insurance risk assessor', 3);


-- =====================================================
-- ANIMALS PACK (PREMIUM) - 40 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-44665544000b', 'Elephant', 'Republicans'' mascot', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Dolphin', 'Miami NFL team mascot', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Kangaroo', 'Australia''s boxing marsupial', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Penguin', 'Linux''s Tux is one', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Giraffe', 'Geoffrey from Toys R Us', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Parrot', 'Pirates'' shoulder companion', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Turtle', 'Ninja teens were mutant these', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Rabbit', 'Energizer''s mascot species', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Lion', 'Disney''s Simba species', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Shark', 'Left ones from the tank', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Butterfly', 'Caterpillar''s final form', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Owl', 'Harry Potter''s Hedwig', 1),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Bear', 'Yogi and Paddington species', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-44665544000b', 'Chameleon', 'Karma''s colorful animal', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Octopus', 'Paul predicted World Cup matches', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Cheetah', 'Chester from Cheetos', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Flamingo', 'Pink lawn ornament bird', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Peacock', 'NBC''s colorful logo', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Sloth', 'Flash from Zootopia', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Koala', 'Eucalyptus specialist', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Panda', 'WWF''s logo animal', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Gorilla', 'Harambe was one', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Hedgehog', 'Sonic''s species', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Capybara', 'Internet''s chill rodent', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Crocodile', 'Steve Irwin''s specialty', 2),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Ostrich', 'Allegedly buries head in sand', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-44665544000b', 'Platypus', 'Perry the agent species', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Narwhal', 'Ocean''s unicorn', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Pangolin', 'World''s most trafficked mammal', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Axolotl', 'Mexican walking fish that isn''t', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Tardigrade', 'Survives space vacuum', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Quokka', 'World''s happiest animal', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Okapi', 'Forest giraffe of Congo', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Dugong', 'Mermaid myth inspiration', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Cassowary', 'World''s most dangerous bird', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Capuchin', 'Ross''s monkey Marcel', 3),
  ('550e8400-e29b-41d4-a716-44665544000b', 'Mantis Shrimp', 'Sees 16 colors, punches hard', 3);


-- =====================================================
-- HISTORY & LEGENDS PACK (PREMIUM) - 30 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-44665544000c', 'Pyramid', 'Giza''s triangular tombs', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Viking', 'Ragnar Lothbrok''s people', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Knight', 'Monty Python''s holy grail seekers', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Pirate', 'Jack Sparrow''s occupation', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Gladiator', 'Russell Crowe''s Maximus role', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Samurai', 'Japan''s warrior class', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Pharaoh', 'Egypt''s god-kings', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Castle', 'Medieval defense structure', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Dragon', 'Game of Thrones'' fire breathers', 1),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Unicorn', 'Scotland''s national animal', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-44665544000c', 'Cleopatra', 'Egypt''s famous queen', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Spartacus', 'Roman slave rebellion leader', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Trojan Horse', 'Greek''s wooden infiltration', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Crusade', 'Medieval holy war', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Renaissance', 'Europe''s cultural rebirth', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Atlantis', 'Plato''s sunken city', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Excalibur', 'Arthur''s legendary sword', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Medusa', 'Snake hair stone gaze', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Minotaur', 'Labyrinth''s beast', 2),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Valhalla', 'Viking warrior afterlife', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-44665544000c', 'Rosetta Stone', 'Egyptian translation key', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Terracotta Army', 'Qin Shi Huang''s clay soldiers', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Mesopotamia', 'Cradle of civilization', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Pompeii', 'Vesuvius'' preserved victim', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Oracle', 'Delphi''s prophecy source', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Sphinx', 'Riddle-asking lion body', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Leviathan', 'Biblical sea monster', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Ragnarok', 'Norse apocalypse', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Golem', 'Prague''s clay guardian', 3),
  ('550e8400-e29b-41d4-a716-44665544000c', 'Valkyrie', 'Norse battlefield choosers', 3);


-- =====================================================
-- SCIENCE & SPACE PACK (PREMIUM) - 30 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-44665544000d', 'Rocket', 'SpaceX''s reusable vehicle', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Planet', 'Pluto lost this status', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Asteroid', 'Dinosaur extinction cause', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Telescope', 'Hubble and James Webb are these', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Robot', 'WALL-E and R2-D2 are these', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Dinosaur', '65 million years extinct', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Gravity', 'Newton''s apple lesson', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Atom', 'Matter''s tiny building block', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'DNA', 'Watson and Crick''s helix', 1),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Volcano', 'Yellowstone has a super one', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-44665544000d', 'Black Hole', 'Event horizon''s home', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Supernova', 'Star''s explosive death', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Nebula', 'Star nursery in space', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Milky Way', 'Our galactic address', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Mars', 'Elon''s colonization target', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Satellite', 'GPS depends on these', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Vaccine', 'Jenner''s smallpox innovation', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Evolution', 'Darwin''s controversial theory', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Photosynthesis', 'Plants'' solar power process', 2),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Electricity', 'Tesla vs Edison battle subject', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-44665544000d', 'Quantum', 'Schrodinger''s cat experiment realm', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Antimatter', 'Dan Brown''s Angels plot device', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Entropy', 'Universe''s disorder tendency', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Quasar', 'Brightest objects in universe', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Neutron Star', 'Densest known stellar object', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Exoplanet', 'Outside our solar system', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'CRISPR', 'Gene editing scissors', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Mitochondria', 'Cell''s powerhouse meme', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Higgs Boson', 'God particle nickname', 3),
  ('550e8400-e29b-41d4-a716-44665544000d', 'Pangaea', 'Supercontinent name', 3);


-- =====================================================
-- TIKTOK & SOCIAL MEDIA PACK (PREMIUM) - 30 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-44665544000e', 'TikTok', 'ByteDance''s viral machine', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Instagram', 'Facebook''s photo purchase', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Snapchat', 'Disappearing message pioneer', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'YouTube', 'Google''s video acquisition', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Twitter', 'Now called X by Musk', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Hashtag', 'Pound sign''s social rebrand', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Filter', 'Beautification layer', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Story', 'Content that expires in 24 hours', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Like', 'Heart button action', 1),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Follow', 'Subscribe button alternative', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-44665544000e', 'Duet', 'TikTok''s split screen feature', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'For You Page', 'TikTok''s algorithm feed', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Reel', 'Instagram''s TikTok copy', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Verified', 'Blue checkmark status', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Trending', 'Popular right now section', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Shadowban', 'Invisible platform punishment', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Collab', 'Creator partnership content', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Stitch', 'TikTok response feature', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Viral', 'Spreading like wildfire online', 2),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Algorithm', 'Content recommendation brain', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-44665544000e', 'Parasocial', 'One-sided creator relationship', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Doomscrolling', 'Negative content addiction', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Engagement Rate', 'Creator analytics metric', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Creator Fund', 'Platform payment program', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Monetization', 'Turning views into cash', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Brand Deal', 'Sponsored content agreement', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Facetune', 'Photo editing confession app', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Clout', 'Internet influence currency', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Cancel Culture', 'Public accountability mob', 3),
  ('550e8400-e29b-41d4-a716-44665544000e', 'Rage Bait', 'Intentionally provocative content', 3);


-- =====================================================
-- INTERNET CLASSICS PACK (PREMIUM) - 30 words
-- =====================================================
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy (difficulty 1)
  ('550e8400-e29b-41d4-a716-44665544000f', 'Rickroll', 'Never gonna give you up trick', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Keyboard Cat', 'Musical feline meme', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Doge', 'Such wow shiba inu', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Trollface', 'Problem? rage comic face', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Nyan Cat', 'Pop-tart rainbow feline', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Grumpy Cat', 'Tardar Sauce''s internet name', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Fail', 'Epic opposite of success', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'LOL', 'Laughing out loud acronym', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Meme', 'Dawkins''s replicating idea', 1),
  ('550e8400-e29b-41d4-a716-44665544000f', 'GIF', 'Animated image format debate', 1),

  -- Medium (difficulty 2)
  ('550e8400-e29b-41d4-a716-44665544000f', 'Harambe', 'Cincinnati Zoo gorilla', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Pepe', 'Feels good man frog', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Wojak', 'Feels guy line drawing', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Stonks', 'Meme man''s financial advice', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Distracted Boyfriend', 'Stock photo meme template', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Woman Yelling at Cat', 'Housewives meets Smudge', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Success Kid', 'Fist pump toddler', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Bad Luck Brian', 'Braces and sweater vest kid', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Shrek', 'Layers like an onion ogre', 2),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Loss', 'Four panel hospital comic', 2),

  -- Hard (difficulty 3)
  ('550e8400-e29b-41d4-a716-44665544000f', 'All Your Base', 'Are belong to us quote', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Numa Numa', 'Romanian song lip sync', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Leroy Jenkins', 'At least I have chicken', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Double Rainbow', 'So intense guy', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Charlie Bit My Finger', 'British toddler pain video', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Dramatic Chipmunk', 'Intense stare prairie dog', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Peanut Butter Jelly Time', 'Dancing banana song', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Ceiling Cat', 'Is watching you meme', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'This Is Fine', 'Dog in burning room', 3),
  ('550e8400-e29b-41d4-a716-44665544000f', 'Philosoraptor', 'Dinosaur deep thoughts', 3);
