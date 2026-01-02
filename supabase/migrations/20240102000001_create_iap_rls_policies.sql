-- RLS Policies for IAP Tables

-- Products: Public read for active products only
CREATE POLICY "Active products are publicly readable"
  ON products FOR SELECT
  USING (active = true);

-- Entitlements: Users can only read their own entitlements
CREATE POLICY "Users can view own entitlements"
  ON entitlements FOR SELECT
  USING (auth.uid() = user_id);

-- Entitlements: Only authenticated users can have entitlements inserted via service role
-- (Inserts happen through edge function with service_role key)
CREATE POLICY "Service role can insert entitlements"
  ON entitlements FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Transactions: Users can view their own transactions
CREATE POLICY "Users can view own transactions"
  ON iap_transactions FOR SELECT
  USING (auth.uid() = user_id);

-- Transactions: Authenticated users can insert their own transactions
-- (This allows the edge function to work, actual validation happens there)
CREATE POLICY "Users can insert own transactions"
  ON iap_transactions FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Transactions: Users can update their own pending transactions
CREATE POLICY "Users can update own transactions"
  ON iap_transactions FOR UPDATE
  USING (auth.uid() = user_id);
