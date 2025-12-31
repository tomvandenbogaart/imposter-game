## Project Summary: “Imposter Word” Party Game (Flutter + Supabase)

### Goal

Build a real-time multiplayer party game where players must guess a secret word together, but one random player is the Imposter. Most players see the exact word on their card. The Imposter sees a vague hint about what the word could be, and must blend in while trying to figure out the word. After a short discussion phase, players vote on who they think is the Imposter.

### Core Gameplay Loop

1. **Lobby**

   * Host creates a room.
   * Others join via room code or link.
   * Players set display name and optionally an avatar color.
   * Host selects a word pack (or “random mix”) and starts game.

2. **Role + Card Reveal**

   * System selects a random secret word for the round.
   * System selects exactly 1 Imposter (optionally configurable to 2 for large groups later).
   * All players open “My Card”:

     * Normal players see the exact secret word.
     * Imposter sees only a **hint** (category, related words, or short clue), not the word.

3. **Discussion Timer**

   * A countdown starts (configurable, like 60 to 180 seconds).
   * Players discuss aloud in real life, app only shows timer and maybe “Ask subtle questions” tips.

4. **Voting**

   * Each player votes for one person.
   * After everyone votes or timer ends, results show.
   * If the most voted player is the Imposter, group wins. Otherwise Imposter wins.
   * Optionally: reveal word after result.

5. **Next Round**

   * Host starts next round, rotates host optional.

### Key Requirements

* **Flutter app** with **custom UI/UX**, not Material default.

  * Use a branded design system: custom typography, spacing, components, buttons, cards, transitions.
  * Smooth animations and tactile interactions.
  * Dark mode first, with high contrast party vibe.
* **Supabase** for:

  * Auth (anonymous or lightweight guest identity)
  * Database (rooms, players, rounds, votes)
  * Realtime subscriptions (room state, players, votes, timers)
  * Optional Edge Functions for secure role assignment + word selection
* **Fairness and security**

  * The secret word and imposter identity must not be readable by other clients.
  * Avoid storing the plaintext secret word in a way any player can fetch.
  * Only the correct player should be able to fetch their card content.

### MVP Feature Set

* Create/join room by code
* Player list, ready state
* Start round
* Private “My Card” view (word vs hint)
* Discussion timer synced to room
* Voting flow + results
* Multiple rounds in one room
* Word packs stored in Supabase (seeded data)

### Suggested UX Screens

1. Welcome (Create room, Join room)
2. Join room (enter code)
3. Lobby

   * Room code, copy/share
   * Player list with ready toggles
   * Host controls: pack selection, timer length, start button
4. Round Reveal

   * Big card animation
   * “Tap to reveal” so people can pass phone around safely
5. Timer / Discussion
6. Voting
7. Results
8. Round summary + next round

### Data Model (Supabase Tables)

**rooms**

* id (uuid)
* code (text, unique short code)
* host_player_id (uuid)
* status (lobby | reveal | discussion | voting | results)
* current_round_id (uuid, nullable)
* settings (jsonb: timerSeconds, packId, etc.)
* created_at

**players**

* id (uuid)
* room_id (uuid)
* display_name (text)
* is_ready (bool)
* joined_at
* is_connected (bool optional)

**rounds**

* id (uuid)
* room_id (uuid)
* round_number (int)
* started_at, ends_at (timestamp for discussion)
* state (reveal | discussion | voting | results)

**votes**

* id (uuid)
* round_id (uuid)
* voter_player_id (uuid)
* voted_player_id (uuid)
* created_at

**word_packs**

* id (uuid)
* name (text)
* language (text like “nl”)
* created_at

**words**

* id (uuid)
* pack_id (uuid)
* word (text)
* hint (text)
* difficulty (int optional)

### Role Assignment and Secret Handling (Important)

Use one of these approaches:

**Option A (Recommended): Edge Function driven**

* On “start round”:

  * Edge Function picks word + imposter server-side.
  * Saves only what’s needed to drive state.
  * Creates per-player “card payload” records that are only readable by that player using RLS.

Add table:

**player_cards**

* id (uuid)
* round_id (uuid)
* player_id (uuid)
* card_type (word | hint)
* payload (text) // either the word or the hint
* created_at

RLS: player can only select rows where player_id = auth.uid() (or mapped guest id).

**Option B: Encrypt word in DB**

* Store encrypted word and distribute decryption keys only to non-imposters.
* More complex, not needed for MVP.

### Realtime Flow

Clients subscribe to:

* room row changes (status, current_round_id, timer timestamps)
* players list changes
* votes changes

Timer sync:

* Store `ends_at` in rounds.
* Clients display countdown based on server timestamp to avoid drift.

### UI Style Direction

* Custom design system:

  * Rounded card surfaces, soft shadows, bold typography.
  * Distinct role reveal motion: flip card, blur background, confetti on win.
  * Color-coded player chips.
* No default Material widgets styling.

  * Use raw widgets + custom components, or minimal Material base with fully overridden ThemeData and custom components.
* Microinteractions:

  * Tap-to-reveal, haptics, animated timers, vote confirmation.

### Tech Constraints / Stack

* Flutter (latest stable)
* Supabase Flutter SDK
* State management: choose one and keep consistent (Riverpod recommended)
* Navigation: go_router
* Animations: flutter_animate or implicit animations (keep it polished)
* Typography: use Google Fonts or bundled custom font

### Acceptance Criteria for MVP

* Host can create room, others can join reliably
* Round start assigns exactly 1 imposter
* Each player only sees their own card content
* Discussion timer is consistent across devices
* Voting works and results are correct
* UI feels custom and premium, not default Material

### Nice-to-Haves After MVP

* Multiple imposters for big rooms
* Word packs by theme (sports, movies, work, Dutch-focused, etc.)
* “Pass the phone” mode with privacy overlay
* Rejoin support if app is closed briefly
* Moderation: kick player, change host
* Stats: win rate, rounds played