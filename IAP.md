## Monetization: In-App Purchases (IAP)

### Goals

* Monetize without harming the core party experience.
* Keep the base game fully playable for free.
* Use monetization to remove friction and unlock premium content.
* Apply decoy pricing so the combined option is the natural choice.

---

## Paid Model Overview (3 Options Only)

The store presents **exactly three paid options**.
Two act as decoys. One is the primary conversion target.

---

### 1. Free Version (With Ads)

* Price: **€0**
* Includes:

  * Full core gameplay
  * Free word packs
* Ads shown:

  * Between rounds
  * On pack selection screens
* No ads during active gameplay.

Purpose:
Provides a complete experience while introducing light friction that encourages upgrading.

---

### 2. Remove Ads (Decoy)

* Price: **€3.99**
* Includes:

  * Permanent removal of all ads
* Does **not** include:

  * Any premium word packs

Purpose:
Feels useful but limited. Sets a price anchor that makes the combined option feel far superior.

---

### 3. Buy All Packs (Decoy)

* Price: **€8.99**
* Includes:

  * All current premium word packs
  * All future word packs
* Ads remain enabled.

Purpose:
Strong content value but intentionally incomplete. Creates contrast with the combined offer.

---

### 4. Buy Packs + Remove Ads (Primary Option)

**Best Value and Highlighted**

* Price: **€9.99**
* Includes:

  * All current premium word packs
  * All future word packs
  * Permanent ad removal
* One-time purchase.

Purpose:
For a minimal price difference, users get everything. This option is the store’s intentional default choice.

---

## Summary Pricing Table

| Option             | Price     | Word Packs       | Ads Removed |
| ------------------ | --------- | ---------------- | ----------- |
| Free               | €0        | Free only        | No          |
| Remove Ads         | €3.99     | No               | Yes         |
| Buy All Packs      | €8.99     | All              | No          |
| **Packs + No Ads** | **€9.99** | **All + future** | **Yes**     |

---

## Platform Strategy

* **iOS App Store and Google Play Billing** using Flutter IAP.
* The server is the source of truth for entitlements.
* Entitlements are stored and resolved via Supabase.

---

## Identity and Authentication

* Use Supabase Auth.
* MVP approach:

  * Default to anonymous users.
  * Allow upgrade to Apple or Google sign-in.
* Purchases must survive:

  * App reinstalls
  * Device changes
* Always support “Restore Purchases”.

---

## Entitlements Data Model (Supabase)

### products

* id (uuid)
* store_product_id (text)
* type (ads | packs | bundle)
* name (text)
* active (bool)

### entitlements

* id (uuid)
* user_id (uuid)
* product_id (uuid)
* source (iap)
* created_at

Optional:

### iap_transactions

* id (uuid)
* user_id (uuid)
* store (ios | android)
* store_transaction_id (text)
* store_product_id (text)
* purchase_token_or_receipt (text)
* status (purchased | refunded | pending)
* created_at

---

## Purchase Flow

1. App loads product catalog from Supabase.
2. App queries the native stores for pricing and availability.
3. User selects one of the three options.
4. Store purchase completes successfully.
5. App sends transaction data to a Supabase Edge Function.
6. Entitlement is granted and synced instantly.
7. UI updates immediately to unlock content or remove ads.

---

## Restore Purchases Flow

1. User taps “Restore Purchases”.
2. App requests restore from the native store.
3. Each restored transaction is sent to Supabase.
4. Server reconciles entitlements.
5. Access is restored without user friction.

---

## Security Notes

* MVP:

  * Grant entitlements after successful store confirmation.
* Hardened:

  * Validate Apple receipts and Play purchase tokens server-side.
  * Revoke entitlements on refunds or chargebacks.

---

## UX Requirements

* No hard paywalls.
* Store screen:

  * Exactly three purchase cards.
  * Combined option visually emphasized.
  * Clear comparison of what’s included.
* Word packs screen:

  * Free packs visible.
  * Locked packs show preview and upgrade CTA.
* Restore purchases button always visible.
* If a premium pack is selected:

  * Only the host needs to own it to start rounds.

---

## Acceptance Criteria for IAP MVP

* Exactly three purchasable items exist in the stores.
* Ads are shown only to free and packs-only users.
* Packs unlock correctly after purchase.
* Combined option unlocks packs and removes ads.
* Entitlements persist via Supabase.
* Restore purchases works reliably.
* Locked content cannot be accessed without entitlement.
* Store UI clearly nudges users toward the combined option.
