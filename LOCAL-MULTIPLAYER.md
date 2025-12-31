# Feature File: Local Multiplayer (One Phone Mode)

## Goal
Add a Local Multiplayer mode where one phone is passed around. One player is the Imposter. Players are created locally by entering names. The app manages private card reveals safely on the same device.

## Entry Point
Home screen adds a new primary action:
- "Play Local (One Phone)"

## Core Flow
1. Setup
   - User enters number of players (min 3, max 12 for MVP).
   - User enters player names (editable list).
   - Optional settings:
     - Discussion timer length (60–180 sec).
     - Word pack selection (use same packs as online; include free packs locally).
     - "Reveal protection" ON by default (requires pass step between players).
   - Start Round button.

2. Role + Card Reveal (Pass-the-Phone)
   - App randomly selects:
     - secret word
     - imposter index
   - For each player in order:
     - Show "Pass to {PlayerName}" screen with a privacy overlay.
     - Require an interaction to continue (press-and-hold 1s or double tap).
     - Then show "Tap to Reveal" card.
     - On reveal:
       - If normal player: show WORD
       - If imposter: show HINT only
     - Include "Hide Card" button. When pressed:
       - card flips back
       - show "Pass phone to next player" screen
   - After last player: show "All set" screen and a Start Discussion button.

3. Discussion Timer
   - Fullscreen timer with pause/resume only if enabled in settings (default OFF).
   - When timer ends, show "Time to Vote".

4. Voting (One Device)
   - In local mode, voting is done in sequence:
     - For each player:
       - "Pass to {PlayerName}" privacy screen
       - Player selects a suspect from the list (cannot vote themselves, optional toggle).
       - Confirm vote
       - Return to pass screen for next player
   - After all votes: show results.

5. Results
   - Show who was voted most, show who the Imposter was, and reveal the word.
   - Win condition:
     - If top-voted player is Imposter => Group wins
     - Else => Imposter wins
   - Handle ties:
     - MVP rule: tie means Imposter wins OR run a quick tie-break vote among tied players (choose one rule and keep consistent).
   - Next Round:
     - "Play Next Round" with same players and settings.
     - "Edit Players" and "Change Pack" actions.

## Local Data (No Supabase)
All state stays in memory for MVP. Optional persistence with shared_preferences later.

### Models
- LocalPlayer:
  - id (uuid or incremental)
  - name
- LocalRound:
  - roundNumber
  - secretWord
  - hint
  - imposterPlayerId
  - votes: Map<voterId, votedId>

### Services
- LocalWordService:
  - getRandomWord(packId) -> {word, hint}
  - Uses embedded JSON assets for free packs.
  - If user has IAP premium packs, allow those packs locally as well (entitlement check).
- LocalGameEngine:
  - createRound(players, settings) -> LocalRound
  - computeResults(round) -> ResultSummary
- RevealFlowController:
  - manages "pass phone" -> "tap reveal" -> "hide" steps with enforced privacy.

## Privacy/Anti-Cheating UX Requirements
- Always show a neutral privacy screen between players.
- Card content must never be visible in app switcher snapshots:
  - Use secure flag on Android if possible (FLAG_SECURE).
  - On iOS, blur/cover content when app goes to background.
- Prevent accidental back navigation during reveal and voting:
  - confirm dialog or disable back for critical steps.
- Add optional "Haptic confirm" on reveal/hide.

## UI Requirements (Custom Design)
- Use the same custom design system as online mode.
- Big, readable typography.
- Card flip animation for reveal/hide.
- Timer uses custom ring/arc animation (optional).
- Buttons: primary, secondary, destructive (custom components).

## Settings
- timerSeconds (default 120)
- packId (default free/mixed)
- allowSelfVote (default false)
- tieRule (default "imposterWins" for MVP)
- pauseEnabled (default false)
- revealProtectionEnabled (default true)

## Acceptance Criteria
- Player can add names and start a local game without internet.
- Exactly one imposter is chosen each round.
- Each player can reveal only their own card in sequence with pass screen protection.
- Voting happens per-player with privacy screens.
- Results are correct and show imposter + word.
- UI feels custom, not default Material.

## Out of Scope (Later)
- Multiple imposters
- Persistent stats
- Local multiplayer with multiple devices (Bluetooth/Wi-Fi)
- Custom word creation
