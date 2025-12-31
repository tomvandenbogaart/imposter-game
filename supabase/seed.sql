-- Seed word packs and words

-- Create General word pack
INSERT INTO word_packs (id, name, language) VALUES
  ('550e8400-e29b-41d4-a716-446655440000', 'General', 'en');

-- Insert words with hints
INSERT INTO words (pack_id, word, hint, difficulty) VALUES
  -- Easy words (difficulty 1)
  ('550e8400-e29b-41d4-a716-446655440000', 'Apple', 'A common fruit that keeps doctors away', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Pizza', 'Italian food, usually round', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Guitar', 'Musical instrument with strings', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Beach', 'Sandy place near water', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Coffee', 'Morning beverage, brown and bitter', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Phone', 'Device for communication', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Movie', 'Entertainment you watch', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Dog', 'Popular pet, mans best friend', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Rain', 'Water falling from sky', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Book', 'Contains stories or information', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Car', 'Four-wheeled transportation', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Sun', 'Bright thing in the sky', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Ice Cream', 'Cold sweet dessert', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Television', 'Screen for watching shows', 1),
  ('550e8400-e29b-41d4-a716-446655440000', 'Soccer', 'Sport with a round ball', 1),

  -- Medium words (difficulty 2)
  ('550e8400-e29b-41d4-a716-446655440000', 'Telescope', 'Device for looking at stars', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Volcano', 'Mountain that can erupt', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Parachute', 'Used for falling slowly', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Lighthouse', 'Guides ships at night', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Compass', 'Shows direction', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Cactus', 'Desert plant with spikes', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Penguin', 'Bird that cannot fly', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Pyramid', 'Ancient triangular structure', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Submarine', 'Underwater vehicle', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Fireworks', 'Explosive celebration in sky', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Treasure', 'Hidden valuable items', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Dentist', 'Doctor for teeth', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Waterfall', 'Water falling from height', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Dinosaur', 'Extinct reptile', 2),
  ('550e8400-e29b-41d4-a716-446655440000', 'Vampire', 'Mythical blood drinker', 2),

  -- Hard words (difficulty 3)
  ('550e8400-e29b-41d4-a716-446655440000', 'Nostalgia', 'Feeling about the past', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Democracy', 'Type of government system', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Algorithm', 'Step-by-step process', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Philosophy', 'Study of existence', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Hypothesis', 'Scientific guess', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Constellation', 'Star pattern in sky', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Encryption', 'Making data secret', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Meditation', 'Mental relaxation practice', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Archaeology', 'Study of ancient things', 3),
  ('550e8400-e29b-41d4-a716-446655440000', 'Biodiversity', 'Variety of life forms', 3);
