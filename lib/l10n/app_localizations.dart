import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('nl'),
  ];

  /// The app title
  ///
  /// In en, this message translates to:
  /// **'Sus Night'**
  String get appTitle;

  /// No description provided for @welcome_title.
  ///
  /// In en, this message translates to:
  /// **'SUS NIGHT'**
  String get welcome_title;

  /// No description provided for @welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Find the sus among you'**
  String get welcome_subtitle;

  /// No description provided for @welcome_offlineMode_title.
  ///
  /// In en, this message translates to:
  /// **'Offline Multiplayer'**
  String get welcome_offlineMode_title;

  /// No description provided for @welcome_offlineMode_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Pass the phone around'**
  String get welcome_offlineMode_subtitle;

  /// No description provided for @welcome_playOffline_button.
  ///
  /// In en, this message translates to:
  /// **'Play Offline'**
  String get welcome_playOffline_button;

  /// No description provided for @welcome_onlineMode_title.
  ///
  /// In en, this message translates to:
  /// **'Online Multiplayer'**
  String get welcome_onlineMode_title;

  /// No description provided for @welcome_onlineMode_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Play with friends remotely'**
  String get welcome_onlineMode_subtitle;

  /// No description provided for @welcome_yourName_label.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get welcome_yourName_label;

  /// No description provided for @welcome_yourName_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your display name'**
  String get welcome_yourName_hint;

  /// No description provided for @welcome_createRoom_button.
  ///
  /// In en, this message translates to:
  /// **'Create Room'**
  String get welcome_createRoom_button;

  /// No description provided for @welcome_joinRoom_button.
  ///
  /// In en, this message translates to:
  /// **'Join Room'**
  String get welcome_joinRoom_button;

  /// No description provided for @welcome_or_divider.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get welcome_or_divider;

  /// No description provided for @localSetup_title.
  ///
  /// In en, this message translates to:
  /// **'Local Game'**
  String get localSetup_title;

  /// No description provided for @localSetup_players_header.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get localSetup_players_header;

  /// No description provided for @localSetup_playerCount.
  ///
  /// In en, this message translates to:
  /// **'{current}/12'**
  String localSetup_playerCount(int current);

  /// No description provided for @localSetup_addPlayer_button.
  ///
  /// In en, this message translates to:
  /// **'Add Player'**
  String get localSetup_addPlayer_button;

  /// No description provided for @localSetup_settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get localSetup_settings_title;

  /// No description provided for @localSetup_settingsSummary.
  ///
  /// In en, this message translates to:
  /// **'{rounds} {roundsLabel} · {timer} timer · {packName}'**
  String localSetup_settingsSummary(
    int rounds,
    String roundsLabel,
    String timer,
    String packName,
  );

  /// No description provided for @localSetup_startRound_button.
  ///
  /// In en, this message translates to:
  /// **'Start Round'**
  String get localSetup_startRound_button;

  /// No description provided for @localSetup_defaultPlayerName.
  ///
  /// In en, this message translates to:
  /// **'Player {number}'**
  String localSetup_defaultPlayerName(int number);

  /// No description provided for @localSetup_roundSingular.
  ///
  /// In en, this message translates to:
  /// **'round'**
  String get localSetup_roundSingular;

  /// No description provided for @localSetup_roundPlural.
  ///
  /// In en, this message translates to:
  /// **'rounds'**
  String get localSetup_roundPlural;

  /// No description provided for @localSetup_random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get localSetup_random;

  /// No description provided for @localSetup_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get localSetup_loading;

  /// No description provided for @localSettings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get localSettings_title;

  /// No description provided for @localSettings_numberOfRounds.
  ///
  /// In en, this message translates to:
  /// **'Number of Rounds'**
  String get localSettings_numberOfRounds;

  /// No description provided for @localSettings_discussionTime.
  ///
  /// In en, this message translates to:
  /// **'Discussion Time'**
  String get localSettings_discussionTime;

  /// No description provided for @localSettings_wordPack.
  ///
  /// In en, this message translates to:
  /// **'Word Pack'**
  String get localSettings_wordPack;

  /// No description provided for @localSettings_selectPack_hint.
  ///
  /// In en, this message translates to:
  /// **'Select a pack'**
  String get localSettings_selectPack_hint;

  /// No description provided for @localSettings_randomAllPacks.
  ///
  /// In en, this message translates to:
  /// **'Random (All Packs)'**
  String get localSettings_randomAllPacks;

  /// No description provided for @localSettings_revealProtection_title.
  ///
  /// In en, this message translates to:
  /// **'Reveal Protection'**
  String get localSettings_revealProtection_title;

  /// No description provided for @localSettings_revealProtection_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Require hold to reveal cards'**
  String get localSettings_revealProtection_subtitle;

  /// No description provided for @localSettings_allowPause_title.
  ///
  /// In en, this message translates to:
  /// **'Allow Pause'**
  String get localSettings_allowPause_title;

  /// No description provided for @localSettings_allowPause_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable pause during discussion'**
  String get localSettings_allowPause_subtitle;

  /// No description provided for @localSettings_hapticFeedback_title.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get localSettings_hapticFeedback_title;

  /// No description provided for @localSettings_hapticFeedback_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on card reveal and votes'**
  String get localSettings_hapticFeedback_subtitle;

  /// No description provided for @localSettings_language_title.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get localSettings_language_title;

  /// No description provided for @localSettings_language_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get localSettings_language_subtitle;

  /// No description provided for @localSettings_language_system.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get localSettings_language_system;

  /// No description provided for @privacy_vote_label.
  ///
  /// In en, this message translates to:
  /// **'Vote'**
  String get privacy_vote_label;

  /// No description provided for @privacy_player_label.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get privacy_player_label;

  /// No description provided for @privacy_progress.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String privacy_progress(int current, int total);

  /// No description provided for @privacy_passPhoneTo.
  ///
  /// In en, this message translates to:
  /// **'Pass the phone to'**
  String get privacy_passPhoneTo;

  /// No description provided for @privacy_toSeeRole.
  ///
  /// In en, this message translates to:
  /// **'to see their role'**
  String get privacy_toSeeRole;

  /// No description provided for @privacy_toCastVote.
  ///
  /// In en, this message translates to:
  /// **'to cast their vote'**
  String get privacy_toCastVote;

  /// No description provided for @privacy_ensurePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Make sure only {playerName} can see the screen'**
  String privacy_ensurePrivacy(String playerName);

  /// No description provided for @privacy_holdToContinue_button.
  ///
  /// In en, this message translates to:
  /// **'Hold to Continue'**
  String get privacy_holdToContinue_button;

  /// No description provided for @privacy_continue_button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get privacy_continue_button;

  /// No description provided for @cardReveal_yourRole.
  ///
  /// In en, this message translates to:
  /// **'Your Role'**
  String get cardReveal_yourRole;

  /// No description provided for @cardReveal_tapToReveal.
  ///
  /// In en, this message translates to:
  /// **'Tap the card to reveal'**
  String get cardReveal_tapToReveal;

  /// No description provided for @cardReveal_tapToReveal_card.
  ///
  /// In en, this message translates to:
  /// **'TAP TO REVEAL'**
  String get cardReveal_tapToReveal_card;

  /// No description provided for @cardReveal_roleAwaits.
  ///
  /// In en, this message translates to:
  /// **'Your role awaits'**
  String get cardReveal_roleAwaits;

  /// No description provided for @cardReveal_hideCard_button.
  ///
  /// In en, this message translates to:
  /// **'Hide Card'**
  String get cardReveal_hideCard_button;

  /// No description provided for @cardReveal_findImposter.
  ///
  /// In en, this message translates to:
  /// **'Find the imposter!'**
  String get cardReveal_findImposter;

  /// No description provided for @cardReveal_imposter_title.
  ///
  /// In en, this message translates to:
  /// **'IMPOSTER'**
  String get cardReveal_imposter_title;

  /// No description provided for @cardReveal_yourHint.
  ///
  /// In en, this message translates to:
  /// **'Your hint:'**
  String get cardReveal_yourHint;

  /// No description provided for @cardReveal_noHint.
  ///
  /// In en, this message translates to:
  /// **'No hint'**
  String get cardReveal_noHint;

  /// No description provided for @cardReveal_blendIn.
  ///
  /// In en, this message translates to:
  /// **'Blend in! Pretend you know the word.'**
  String get cardReveal_blendIn;

  /// No description provided for @cardReveal_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get cardReveal_unknown;

  /// No description provided for @allSet_title.
  ///
  /// In en, this message translates to:
  /// **'All Set!'**
  String get allSet_title;

  /// No description provided for @allSet_subtitle.
  ///
  /// In en, this message translates to:
  /// **'All players have seen their cards'**
  String get allSet_subtitle;

  /// No description provided for @allSet_players_label.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get allSet_players_label;

  /// No description provided for @allSet_timer_label.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get allSet_timer_label;

  /// No description provided for @allSet_imposter_label.
  ///
  /// In en, this message translates to:
  /// **'Imposter'**
  String get allSet_imposter_label;

  /// No description provided for @allSet_instruction.
  ///
  /// In en, this message translates to:
  /// **'Discuss to find the imposter. The imposter blends in without knowing the word!'**
  String get allSet_instruction;

  /// No description provided for @allSet_startDiscussion_button.
  ///
  /// In en, this message translates to:
  /// **'Start Discussion'**
  String get allSet_startDiscussion_button;

  /// No description provided for @discussion_title.
  ///
  /// In en, this message translates to:
  /// **'Discussion'**
  String get discussion_title;

  /// No description provided for @discussion_findImposter.
  ///
  /// In en, this message translates to:
  /// **'Find the imposter!'**
  String get discussion_findImposter;

  /// No description provided for @discussion_playerStarts.
  ///
  /// In en, this message translates to:
  /// **'{playerName} starts!'**
  String discussion_playerStarts(String playerName);

  /// No description provided for @discussion_paused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get discussion_paused;

  /// No description provided for @discussion_pause_button.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get discussion_pause_button;

  /// No description provided for @discussion_resume_button.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get discussion_resume_button;

  /// No description provided for @discussion_players_label.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get discussion_players_label;

  /// No description provided for @discussion_skipToVote_button.
  ///
  /// In en, this message translates to:
  /// **'Skip to Vote'**
  String get discussion_skipToVote_button;

  /// No description provided for @voting_title.
  ///
  /// In en, this message translates to:
  /// **'{playerName}\'s Vote'**
  String voting_title(String playerName);

  /// No description provided for @voting_whoIsImposter.
  ///
  /// In en, this message translates to:
  /// **'Who is the imposter?'**
  String get voting_whoIsImposter;

  /// No description provided for @voting_confirmVote_button.
  ///
  /// In en, this message translates to:
  /// **'Confirm Vote'**
  String get voting_confirmVote_button;

  /// No description provided for @results_roundOf.
  ///
  /// In en, this message translates to:
  /// **'Round {current} of {total}'**
  String results_roundOf(int current, int total);

  /// No description provided for @results_groupWins.
  ///
  /// In en, this message translates to:
  /// **'Group Wins!'**
  String get results_groupWins;

  /// No description provided for @results_imposterWins.
  ///
  /// In en, this message translates to:
  /// **'Imposter Wins!'**
  String get results_imposterWins;

  /// No description provided for @results_voteTied.
  ///
  /// In en, this message translates to:
  /// **'The vote was tied!'**
  String get results_voteTied;

  /// No description provided for @results_imposterFound.
  ///
  /// In en, this message translates to:
  /// **'The imposter was found!'**
  String get results_imposterFound;

  /// No description provided for @results_imposterEscaped.
  ///
  /// In en, this message translates to:
  /// **'The imposter escaped!'**
  String get results_imposterEscaped;

  /// No description provided for @results_wasImposter.
  ///
  /// In en, this message translates to:
  /// **'was the Imposter'**
  String get results_wasImposter;

  /// No description provided for @results_hint.
  ///
  /// In en, this message translates to:
  /// **'Hint: {hint}'**
  String results_hint(String hint);

  /// No description provided for @results_currentStandings.
  ///
  /// In en, this message translates to:
  /// **'Current Standings'**
  String get results_currentStandings;

  /// No description provided for @results_points.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String results_points(int points);

  /// No description provided for @results_nextRound_button.
  ///
  /// In en, this message translates to:
  /// **'Next Round'**
  String get results_nextRound_button;

  /// No description provided for @results_endGameEarly_button.
  ///
  /// In en, this message translates to:
  /// **'End Game Early'**
  String get results_endGameEarly_button;

  /// No description provided for @results_seeFinalResults_button.
  ///
  /// In en, this message translates to:
  /// **'See Final Results'**
  String get results_seeFinalResults_button;

  /// No description provided for @results_playAgain_button.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get results_playAgain_button;

  /// No description provided for @finalResults_winner.
  ///
  /// In en, this message translates to:
  /// **'Winner!'**
  String get finalResults_winner;

  /// No description provided for @finalResults_tie.
  ///
  /// In en, this message translates to:
  /// **'It\'s a Tie!'**
  String get finalResults_tie;

  /// No description provided for @finalResults_gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over!'**
  String get finalResults_gameOver;

  /// No description provided for @finalResults_noPoints.
  ///
  /// In en, this message translates to:
  /// **'No one scored any points!'**
  String get finalResults_noPoints;

  /// No description provided for @finalResults_roundsPlayed.
  ///
  /// In en, this message translates to:
  /// **'{count} rounds played'**
  String finalResults_roundsPlayed(int count);

  /// No description provided for @finalResults_finalStandings.
  ///
  /// In en, this message translates to:
  /// **'Final Standings'**
  String get finalResults_finalStandings;

  /// No description provided for @finalResults_playAgain_button.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get finalResults_playAgain_button;

  /// No description provided for @finalResults_exitToHome_button.
  ///
  /// In en, this message translates to:
  /// **'Exit to Home'**
  String get finalResults_exitToHome_button;

  /// No description provided for @joinRoom_title.
  ///
  /// In en, this message translates to:
  /// **'Join Room'**
  String get joinRoom_title;

  /// No description provided for @joinRoom_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the room code to join the game'**
  String get joinRoom_subtitle;

  /// No description provided for @joinRoom_roomCode_label.
  ///
  /// In en, this message translates to:
  /// **'Room Code'**
  String get joinRoom_roomCode_label;

  /// No description provided for @joinRoom_roomCode_hint.
  ///
  /// In en, this message translates to:
  /// **'ABC123'**
  String get joinRoom_roomCode_hint;

  /// No description provided for @joinRoom_joinGame_button.
  ///
  /// In en, this message translates to:
  /// **'Join Game'**
  String get joinRoom_joinGame_button;

  /// No description provided for @lobby_title.
  ///
  /// In en, this message translates to:
  /// **'Lobby'**
  String get lobby_title;

  /// No description provided for @lobby_roomCode_label.
  ///
  /// In en, this message translates to:
  /// **'Room Code'**
  String get lobby_roomCode_label;

  /// No description provided for @lobby_tapToCopy.
  ///
  /// In en, this message translates to:
  /// **'Tap to copy'**
  String get lobby_tapToCopy;

  /// No description provided for @lobby_host_label.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get lobby_host_label;

  /// No description provided for @lobby_startGame_button.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get lobby_startGame_button;

  /// No description provided for @lobby_needMorePlayers.
  ///
  /// In en, this message translates to:
  /// **'Need at least 3 players to start'**
  String get lobby_needMorePlayers;

  /// No description provided for @lobby_waitingForHost.
  ///
  /// In en, this message translates to:
  /// **'Waiting for host to start...'**
  String get lobby_waitingForHost;

  /// No description provided for @store_title.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store_title;

  /// No description provided for @store_unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock Premium Features'**
  String get store_unlockPremium;

  /// No description provided for @store_supportDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Support development and enhance your experience'**
  String get store_supportDevelopment;

  /// No description provided for @store_bestValue.
  ///
  /// In en, this message translates to:
  /// **'BEST VALUE'**
  String get store_bestValue;

  /// No description provided for @store_best.
  ///
  /// In en, this message translates to:
  /// **'BEST'**
  String get store_best;

  /// No description provided for @store_oneTime.
  ///
  /// In en, this message translates to:
  /// **'one-time'**
  String get store_oneTime;

  /// No description provided for @store_purchase_button.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get store_purchase_button;

  /// No description provided for @store_owned.
  ///
  /// In en, this message translates to:
  /// **'Owned'**
  String get store_owned;

  /// No description provided for @store_restorePurchases_button.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get store_restorePurchases_button;

  /// No description provided for @store_purchaseSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Purchase successful!'**
  String get store_purchaseSuccessful;

  /// No description provided for @store_purchasesRestored.
  ///
  /// In en, this message translates to:
  /// **'{count} purchase(s) restored!'**
  String store_purchasesRestored(int count);

  /// No description provided for @store_noRestore.
  ///
  /// In en, this message translates to:
  /// **'No purchases to restore'**
  String get store_noRestore;

  /// No description provided for @store_purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed'**
  String get store_purchaseFailed;

  /// No description provided for @store_noProducts.
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get store_noProducts;

  /// No description provided for @store_failedToLoadProducts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load products'**
  String get store_failedToLoadProducts;

  /// No description provided for @store_failedToLoadStore.
  ///
  /// In en, this message translates to:
  /// **'Failed to load store'**
  String get store_failedToLoadStore;

  /// No description provided for @store_retry_button.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get store_retry_button;

  /// No description provided for @store_whatYouGet.
  ///
  /// In en, this message translates to:
  /// **'What you get'**
  String get store_whatYouGet;

  /// No description provided for @store_adFree.
  ///
  /// In en, this message translates to:
  /// **'Ad-free experience'**
  String get store_adFree;

  /// No description provided for @store_allWordPacks.
  ///
  /// In en, this message translates to:
  /// **'All word packs'**
  String get store_allWordPacks;

  /// No description provided for @store_futurePacks.
  ///
  /// In en, this message translates to:
  /// **'Future packs included'**
  String get store_futurePacks;

  /// No description provided for @store_supportDev.
  ///
  /// In en, this message translates to:
  /// **'Support development'**
  String get store_supportDev;

  /// No description provided for @store_legalApple.
  ///
  /// In en, this message translates to:
  /// **'Purchases are processed by Apple App Store. All purchases are one-time payments.'**
  String get store_legalApple;

  /// No description provided for @store_legalGoogle.
  ///
  /// In en, this message translates to:
  /// **'Purchases are processed by Google Play. All purchases are one-time payments.'**
  String get store_legalGoogle;

  /// No description provided for @premiumPack_title.
  ///
  /// In en, this message translates to:
  /// **'Premium Pack'**
  String get premiumPack_title;

  /// No description provided for @premiumPack_message.
  ///
  /// In en, this message translates to:
  /// **'This word pack is part of the premium collection. Unlock all packs to access it!'**
  String get premiumPack_message;

  /// No description provided for @premiumPack_cancel_button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get premiumPack_cancel_button;

  /// No description provided for @premiumPack_viewStore_button.
  ///
  /// In en, this message translates to:
  /// **'View Store'**
  String get premiumPack_viewStore_button;

  /// No description provided for @error_enterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get error_enterName;

  /// No description provided for @error_createRoom.
  ///
  /// In en, this message translates to:
  /// **'Error creating room: {error}'**
  String error_createRoom(String error);

  /// No description provided for @error_allPlayersNeedName.
  ///
  /// In en, this message translates to:
  /// **'All players must have a name'**
  String get error_allPlayersNeedName;

  /// No description provided for @error_minPlayers.
  ///
  /// In en, this message translates to:
  /// **'At least 3 players required'**
  String get error_minPlayers;

  /// No description provided for @error_loadWords.
  ///
  /// In en, this message translates to:
  /// **'Could not load words. Check your connection.'**
  String get error_loadWords;

  /// No description provided for @error_generic.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error_generic(String error);

  /// No description provided for @error_roomCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 6-character room code'**
  String get error_roomCodeInvalid;

  /// No description provided for @error_joinRoom.
  ///
  /// In en, this message translates to:
  /// **'Error joining room: {error}'**
  String error_joinRoom(String error);

  /// No description provided for @error_startGame.
  ///
  /// In en, this message translates to:
  /// **'Error starting game: {error}'**
  String error_startGame(String error);

  /// No description provided for @error_failedToLoadPacks.
  ///
  /// In en, this message translates to:
  /// **'Failed to load packs'**
  String get error_failedToLoadPacks;

  /// No description provided for @snackbar_roomCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Room code copied!'**
  String get snackbar_roomCodeCopied;

  /// No description provided for @wordPackSelector_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Theme'**
  String get wordPackSelector_title;

  /// No description provided for @wordPackSelector_viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get wordPackSelector_viewAll;

  /// No description provided for @wordPackSelector_random.
  ///
  /// In en, this message translates to:
  /// **'Random'**
  String get wordPackSelector_random;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
