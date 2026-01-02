// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sus Night';

  @override
  String get welcome_title => 'SUS NIGHT';

  @override
  String get welcome_subtitle => 'Find the sus among you';

  @override
  String get welcome_offlineMode_title => 'Offline Multiplayer';

  @override
  String get welcome_offlineMode_subtitle => 'Pass the phone around';

  @override
  String get welcome_playOffline_button => 'Play Offline';

  @override
  String get welcome_onlineMode_title => 'Online Multiplayer';

  @override
  String get welcome_onlineMode_subtitle => 'Play with friends remotely';

  @override
  String get welcome_yourName_label => 'Your Name';

  @override
  String get welcome_yourName_hint => 'Enter your display name';

  @override
  String get welcome_createRoom_button => 'Create Room';

  @override
  String get welcome_joinRoom_button => 'Join Room';

  @override
  String get welcome_or_divider => 'OR';

  @override
  String get localSetup_title => 'Local Game';

  @override
  String get localSetup_players_header => 'Players';

  @override
  String localSetup_playerCount(int current) {
    return '$current/12';
  }

  @override
  String get localSetup_addPlayer_button => 'Add Player';

  @override
  String get localSetup_settings_title => 'Settings';

  @override
  String localSetup_settingsSummary(
    int rounds,
    String roundsLabel,
    String timer,
    String packName,
  ) {
    return '$rounds $roundsLabel · $timer timer · $packName';
  }

  @override
  String get localSetup_startRound_button => 'Start Round';

  @override
  String localSetup_defaultPlayerName(int number) {
    return 'Player $number';
  }

  @override
  String get localSetup_roundSingular => 'round';

  @override
  String get localSetup_roundPlural => 'rounds';

  @override
  String get localSetup_random => 'Random';

  @override
  String get localSetup_loading => 'Loading...';

  @override
  String get localSettings_title => 'Settings';

  @override
  String get localSettings_numberOfRounds => 'Number of Rounds';

  @override
  String get localSettings_discussionTime => 'Discussion Time';

  @override
  String get localSettings_wordPack => 'Word Pack';

  @override
  String get localSettings_selectPack_hint => 'Select a pack';

  @override
  String get localSettings_randomAllPacks => 'Random (All Packs)';

  @override
  String get localSettings_revealProtection_title => 'Reveal Protection';

  @override
  String get localSettings_revealProtection_subtitle =>
      'Require hold to reveal cards';

  @override
  String get localSettings_allowPause_title => 'Allow Pause';

  @override
  String get localSettings_allowPause_subtitle =>
      'Enable pause during discussion';

  @override
  String get localSettings_hapticFeedback_title => 'Haptic Feedback';

  @override
  String get localSettings_hapticFeedback_subtitle =>
      'Vibrate on card reveal and votes';

  @override
  String get localSettings_language_title => 'Language';

  @override
  String get localSettings_language_subtitle => 'Choose app language';

  @override
  String get localSettings_language_system => 'System Default';

  @override
  String get privacy_vote_label => 'Vote';

  @override
  String get privacy_player_label => 'Player';

  @override
  String privacy_progress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get privacy_passPhoneTo => 'Pass the phone to';

  @override
  String get privacy_toSeeRole => 'to see their role';

  @override
  String get privacy_toCastVote => 'to cast their vote';

  @override
  String privacy_ensurePrivacy(String playerName) {
    return 'Make sure only $playerName can see the screen';
  }

  @override
  String get privacy_holdToContinue_button => 'Hold to Continue';

  @override
  String get privacy_continue_button => 'Continue';

  @override
  String get cardReveal_yourRole => 'Your Role';

  @override
  String get cardReveal_tapToReveal => 'Tap the card to reveal';

  @override
  String get cardReveal_tapToReveal_card => 'TAP TO REVEAL';

  @override
  String get cardReveal_roleAwaits => 'Your role awaits';

  @override
  String get cardReveal_hideCard_button => 'Hide Card';

  @override
  String get cardReveal_findImposter => 'Find the imposter!';

  @override
  String get cardReveal_imposter_title => 'IMPOSTER';

  @override
  String get cardReveal_yourHint => 'Your hint:';

  @override
  String get cardReveal_noHint => 'No hint';

  @override
  String get cardReveal_blendIn => 'Blend in! Pretend you know the word.';

  @override
  String get cardReveal_unknown => 'Unknown';

  @override
  String get allSet_title => 'All Set!';

  @override
  String get allSet_subtitle => 'All players have seen their cards';

  @override
  String get allSet_players_label => 'Players';

  @override
  String get allSet_timer_label => 'Timer';

  @override
  String get allSet_imposter_label => 'Imposter';

  @override
  String get allSet_instruction =>
      'Discuss to find the imposter. The imposter blends in without knowing the word!';

  @override
  String get allSet_startDiscussion_button => 'Start Discussion';

  @override
  String get discussion_title => 'Discussion';

  @override
  String get discussion_findImposter => 'Find the imposter!';

  @override
  String discussion_playerStarts(String playerName) {
    return '$playerName starts!';
  }

  @override
  String get discussion_paused => 'PAUSED';

  @override
  String get discussion_pause_button => 'Pause';

  @override
  String get discussion_resume_button => 'Resume';

  @override
  String get discussion_players_label => 'Players';

  @override
  String get discussion_skipToVote_button => 'Skip to Vote';

  @override
  String voting_title(String playerName) {
    return '$playerName\'s Vote';
  }

  @override
  String get voting_whoIsImposter => 'Who is the imposter?';

  @override
  String get voting_confirmVote_button => 'Confirm Vote';

  @override
  String results_roundOf(int current, int total) {
    return 'Round $current of $total';
  }

  @override
  String get results_groupWins => 'Group Wins!';

  @override
  String get results_imposterWins => 'Imposter Wins!';

  @override
  String get results_voteTied => 'The vote was tied!';

  @override
  String get results_imposterFound => 'The imposter was found!';

  @override
  String get results_imposterEscaped => 'The imposter escaped!';

  @override
  String get results_wasImposter => 'was the Imposter';

  @override
  String results_hint(String hint) {
    return 'Hint: $hint';
  }

  @override
  String get results_currentStandings => 'Current Standings';

  @override
  String results_points(int points) {
    return '$points pts';
  }

  @override
  String get results_nextRound_button => 'Next Round';

  @override
  String get results_endGameEarly_button => 'End Game Early';

  @override
  String get results_seeFinalResults_button => 'See Final Results';

  @override
  String get results_playAgain_button => 'Play Again';

  @override
  String get finalResults_winner => 'Winner!';

  @override
  String get finalResults_tie => 'It\'s a Tie!';

  @override
  String get finalResults_gameOver => 'Game Over!';

  @override
  String get finalResults_noPoints => 'No one scored any points!';

  @override
  String finalResults_roundsPlayed(int count) {
    return '$count rounds played';
  }

  @override
  String get finalResults_finalStandings => 'Final Standings';

  @override
  String get finalResults_playAgain_button => 'Play Again';

  @override
  String get finalResults_exitToHome_button => 'Exit to Home';

  @override
  String get joinRoom_title => 'Join Room';

  @override
  String get joinRoom_subtitle => 'Enter the room code to join the game';

  @override
  String get joinRoom_roomCode_label => 'Room Code';

  @override
  String get joinRoom_roomCode_hint => 'ABC123';

  @override
  String get joinRoom_joinGame_button => 'Join Game';

  @override
  String get lobby_title => 'Lobby';

  @override
  String get lobby_roomCode_label => 'Room Code';

  @override
  String get lobby_tapToCopy => 'Tap to copy';

  @override
  String get lobby_host_label => 'Host';

  @override
  String get lobby_startGame_button => 'Start Game';

  @override
  String get lobby_needMorePlayers => 'Need at least 3 players to start';

  @override
  String get lobby_waitingForHost => 'Waiting for host to start...';

  @override
  String get store_title => 'Store';

  @override
  String get store_unlockPremium => 'Unlock Premium Features';

  @override
  String get store_supportDevelopment =>
      'Support development and enhance your experience';

  @override
  String get store_bestValue => 'BEST VALUE';

  @override
  String get store_best => 'BEST';

  @override
  String get store_oneTime => 'one-time';

  @override
  String get store_purchase_button => 'Purchase';

  @override
  String get store_owned => 'Owned';

  @override
  String get store_restorePurchases_button => 'Restore Purchases';

  @override
  String get store_purchaseSuccessful => 'Purchase successful!';

  @override
  String store_purchasesRestored(int count) {
    return '$count purchase(s) restored!';
  }

  @override
  String get store_noRestore => 'No purchases to restore';

  @override
  String get store_purchaseFailed => 'Purchase failed';

  @override
  String get store_noProducts => 'No products available';

  @override
  String get store_failedToLoadProducts => 'Failed to load products';

  @override
  String get store_failedToLoadStore => 'Failed to load store';

  @override
  String get store_retry_button => 'Retry';

  @override
  String get store_whatYouGet => 'What you get';

  @override
  String get store_adFree => 'Ad-free experience';

  @override
  String get store_allWordPacks => 'All word packs';

  @override
  String get store_futurePacks => 'Future packs included';

  @override
  String get store_supportDev => 'Support development';

  @override
  String get store_legalApple =>
      'Purchases are processed by Apple App Store. All purchases are one-time payments.';

  @override
  String get store_legalGoogle =>
      'Purchases are processed by Google Play. All purchases are one-time payments.';

  @override
  String get premiumPack_title => 'Premium Pack';

  @override
  String get premiumPack_message =>
      'This word pack is part of the premium collection. Unlock all packs to access it!';

  @override
  String get premiumPack_cancel_button => 'Cancel';

  @override
  String get premiumPack_viewStore_button => 'View Store';

  @override
  String get error_enterName => 'Please enter your name';

  @override
  String error_createRoom(String error) {
    return 'Error creating room: $error';
  }

  @override
  String get error_allPlayersNeedName => 'All players must have a name';

  @override
  String get error_minPlayers => 'At least 3 players required';

  @override
  String get error_loadWords => 'Could not load words. Check your connection.';

  @override
  String error_generic(String error) {
    return 'Error: $error';
  }

  @override
  String get error_roomCodeInvalid =>
      'Please enter a valid 6-character room code';

  @override
  String error_joinRoom(String error) {
    return 'Error joining room: $error';
  }

  @override
  String error_startGame(String error) {
    return 'Error starting game: $error';
  }

  @override
  String get error_failedToLoadPacks => 'Failed to load packs';

  @override
  String get snackbar_roomCodeCopied => 'Room code copied!';

  @override
  String get wordPackSelector_title => 'Choose Your Theme';

  @override
  String get wordPackSelector_viewAll => 'View All';

  @override
  String get wordPackSelector_random => 'Random';
}
