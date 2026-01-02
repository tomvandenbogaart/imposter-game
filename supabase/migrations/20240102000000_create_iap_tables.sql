-- IAP Tables Migration
-- Creates tables for In-App Purchases, entitlements, and transaction tracking

-- Product types enum
CREATE TYPE product_type AS ENUM ('ads', 'packs', 'bundle');
CREATE TYPE purchase_status AS ENUM ('pending', 'completed', 'refunded', 'failed');
CREATE TYPE store_type AS ENUM ('ios', 'android');

-- Products table (source of truth for available products)
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  store_product_id VARCHAR(100) NOT NULL UNIQUE,
  type product_type NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price_cents INTEGER NOT NULL,
  currency VARCHAR(3) DEFAULT 'EUR',
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- User entitlements table
CREATE TABLE entitlements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  source VARCHAR(20) DEFAULT 'iap',
  granted_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ, -- NULL for permanent entitlements
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, product_id)
);

-- IAP transactions table (audit trail)
CREATE TABLE iap_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  store store_type NOT NULL,
  store_transaction_id VARCHAR(255) NOT NULL,
  store_product_id VARCHAR(100) NOT NULL,
  purchase_token TEXT, -- Android purchase token or iOS receipt data
  status purchase_status DEFAULT 'pending',
  verified_at TIMESTAMPTZ,
  error_message TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(store, store_transaction_id)
);

-- Add is_premium column to word_packs table
ALTER TABLE word_packs ADD COLUMN IF NOT EXISTS is_premium BOOLEAN DEFAULT FALSE;

-- Indexes for performance
CREATE INDEX idx_products_store_id ON products(store_product_id);
CREATE INDEX idx_products_type ON products(type);
CREATE INDEX idx_products_active ON products(active);
CREATE INDEX idx_entitlements_user ON entitlements(user_id);
CREATE INDEX idx_entitlements_product ON entitlements(product_id);
CREATE INDEX idx_transactions_user ON iap_transactions(user_id);
CREATE INDEX idx_transactions_store_tx ON iap_transactions(store, store_transaction_id);
CREATE INDEX idx_transactions_status ON iap_transactions(status);
CREATE INDEX idx_word_packs_premium ON word_packs(is_premium);

-- Enable RLS on new tables
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE entitlements ENABLE ROW LEVEL SECURITY;
ALTER TABLE iap_transactions ENABLE ROW LEVEL SECURITY;
