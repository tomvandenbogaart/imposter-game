-- Seed IAP Products

INSERT INTO products (store_product_id, type, name, description, price_cents, currency) VALUES
  ('remove_ads', 'ads', 'Remove Ads', 'Remove all advertisements permanently', 399, 'EUR'),
  ('all_packs', 'packs', 'All Word Packs', 'Unlock all current and future premium word packs', 899, 'EUR'),
  ('packs_no_ads', 'bundle', 'Ultimate Bundle', 'All word packs + ad-free experience - Best value!', 999, 'EUR');

-- Mark the default "General" pack as free (not premium)
UPDATE word_packs SET is_premium = FALSE WHERE name = 'General';
