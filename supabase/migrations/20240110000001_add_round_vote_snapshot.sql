-- Store imposter name and vote results snapshot so they persist after players leave
-- The vote_results is a JSON array of {player_id, player_name, vote_count, is_imposter}

ALTER TABLE rounds ADD COLUMN imposter_name VARCHAR(20);
ALTER TABLE rounds ADD COLUMN vote_results JSONB;
