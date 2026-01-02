// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Sus Night';

  @override
  String get welcome_title => 'SUS NIGHT';

  @override
  String get welcome_subtitle => 'Vind de bedrieger onder jullie';

  @override
  String get welcome_offlineMode_title => 'Offline Multiplayer';

  @override
  String get welcome_offlineMode_subtitle => 'Geef de telefoon door';

  @override
  String get welcome_playOffline_button => 'Speel Offline';

  @override
  String get welcome_onlineMode_title => 'Online Multiplayer';

  @override
  String get welcome_onlineMode_subtitle => 'Speel met vrienden op afstand';

  @override
  String get welcome_yourName_label => 'Je Naam';

  @override
  String get welcome_yourName_hint => 'Voer je weergavenaam in';

  @override
  String get welcome_createRoom_button => 'Maak Kamer';

  @override
  String get welcome_joinRoom_button => 'Join Kamer';

  @override
  String get welcome_or_divider => 'OF';

  @override
  String get localSetup_title => 'Lokaal Spel';

  @override
  String get localSetup_players_header => 'Spelers';

  @override
  String localSetup_playerCount(int current) {
    return '$current/12';
  }

  @override
  String get localSetup_addPlayer_button => 'Speler Toevoegen';

  @override
  String get localSetup_settings_title => 'Instellingen';

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
  String get localSetup_startRound_button => 'Start Ronde';

  @override
  String localSetup_defaultPlayerName(int number) {
    return 'Speler $number';
  }

  @override
  String get localSetup_roundSingular => 'ronde';

  @override
  String get localSetup_roundPlural => 'rondes';

  @override
  String get localSetup_random => 'Willekeurig';

  @override
  String get localSetup_loading => 'Laden...';

  @override
  String get localSettings_title => 'Instellingen';

  @override
  String get localSettings_numberOfRounds => 'Aantal Rondes';

  @override
  String get localSettings_discussionTime => 'Discussietijd';

  @override
  String get localSettings_wordPack => 'Woordenpakket';

  @override
  String get localSettings_selectPack_hint => 'Selecteer een pakket';

  @override
  String get localSettings_randomAllPacks => 'Willekeurig (Alle Pakketten)';

  @override
  String get localSettings_revealProtection_title => 'Onthulbeveiliging';

  @override
  String get localSettings_revealProtection_subtitle =>
      'Houd ingedrukt om kaarten te onthullen';

  @override
  String get localSettings_allowPause_title => 'Pauzeren Toestaan';

  @override
  String get localSettings_allowPause_subtitle =>
      'Pauzeren tijdens discussie inschakelen';

  @override
  String get localSettings_hapticFeedback_title => 'Haptische Feedback';

  @override
  String get localSettings_hapticFeedback_subtitle =>
      'Trillen bij kaartonthulling en stemmen';

  @override
  String get localSettings_language_title => 'Taal';

  @override
  String get localSettings_language_subtitle => 'Kies app-taal';

  @override
  String get localSettings_language_system => 'Systeemstandaard';

  @override
  String get privacy_vote_label => 'Stem';

  @override
  String get privacy_player_label => 'Speler';

  @override
  String privacy_progress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get privacy_passPhoneTo => 'Geef de telefoon aan';

  @override
  String get privacy_toSeeRole => 'om hun rol te zien';

  @override
  String get privacy_toCastVote => 'om te stemmen';

  @override
  String privacy_ensurePrivacy(String playerName) {
    return 'Zorg dat alleen $playerName het scherm kan zien';
  }

  @override
  String get privacy_holdToContinue_button => 'Houd ingedrukt om door te gaan';

  @override
  String get privacy_continue_button => 'Doorgaan';

  @override
  String get cardReveal_yourRole => 'Je Rol';

  @override
  String get cardReveal_tapToReveal => 'Tik op de kaart om te onthullen';

  @override
  String get cardReveal_tapToReveal_card => 'TIK OM TE ONTHULLEN';

  @override
  String get cardReveal_roleAwaits => 'Je rol wacht';

  @override
  String get cardReveal_hideCard_button => 'Verberg Kaart';

  @override
  String get cardReveal_findImposter => 'Vind de bedrieger!';

  @override
  String get cardReveal_imposter_title => 'BEDRIEGER';

  @override
  String get cardReveal_yourHint => 'Je hint:';

  @override
  String get cardReveal_noHint => 'Geen hint';

  @override
  String get cardReveal_blendIn => 'Doe alsof je het woord kent.';

  @override
  String get cardReveal_unknown => 'Onbekend';

  @override
  String get allSet_title => 'Klaar!';

  @override
  String get allSet_subtitle => 'Alle spelers hebben hun kaarten gezien';

  @override
  String get allSet_players_label => 'Spelers';

  @override
  String get allSet_timer_label => 'Timer';

  @override
  String get allSet_imposter_label => 'Bedrieger';

  @override
  String get allSet_instruction =>
      'Bespreek om de bedrieger te vinden. De bedrieger probeert mee te doen zonder het woord te kennen!';

  @override
  String get allSet_startDiscussion_button => 'Start Discussie';

  @override
  String get discussion_title => 'Discussie';

  @override
  String get discussion_findImposter => 'Vind de bedrieger!';

  @override
  String discussion_playerStarts(String playerName) {
    return '$playerName begint!';
  }

  @override
  String get discussion_paused => 'GEPAUZEERD';

  @override
  String get discussion_pause_button => 'Pauze';

  @override
  String get discussion_resume_button => 'Hervat';

  @override
  String get discussion_players_label => 'Spelers';

  @override
  String get discussion_skipToVote_button => 'Ga Naar Stemmen';

  @override
  String voting_title(String playerName) {
    return 'Stem van $playerName';
  }

  @override
  String get voting_whoIsImposter => 'Wie is de bedrieger?';

  @override
  String get voting_confirmVote_button => 'Bevestig Stem';

  @override
  String results_roundOf(int current, int total) {
    return 'Ronde $current van $total';
  }

  @override
  String get results_groupWins => 'De Groep Wint!';

  @override
  String get results_imposterWins => 'De Bedrieger Wint!';

  @override
  String get results_voteTied => 'De stemming is gelijk!';

  @override
  String get results_imposterFound => 'De bedrieger is gevonden!';

  @override
  String get results_imposterEscaped => 'De bedrieger is ontsnapt!';

  @override
  String get results_wasImposter => 'was de Bedrieger';

  @override
  String results_hint(String hint) {
    return 'Hint: $hint';
  }

  @override
  String get results_currentStandings => 'Huidige Stand';

  @override
  String results_points(int points) {
    return '$points ptn';
  }

  @override
  String get results_nextRound_button => 'Volgende Ronde';

  @override
  String get results_endGameEarly_button => 'Spel Vroeg Beëindigen';

  @override
  String get results_seeFinalResults_button => 'Bekijk Eindresultaten';

  @override
  String get results_playAgain_button => 'Opnieuw Spelen';

  @override
  String get finalResults_winner => 'Winnaar!';

  @override
  String get finalResults_tie => 'Gelijkspel!';

  @override
  String get finalResults_gameOver => 'Spel Afgelopen!';

  @override
  String get finalResults_noPoints => 'Niemand heeft punten gescoord!';

  @override
  String finalResults_roundsPlayed(int count) {
    return '$count rondes gespeeld';
  }

  @override
  String get finalResults_finalStandings => 'Eindstand';

  @override
  String get finalResults_playAgain_button => 'Opnieuw Spelen';

  @override
  String get finalResults_exitToHome_button => 'Terug naar Home';

  @override
  String get joinRoom_title => 'Join Kamer';

  @override
  String get joinRoom_subtitle => 'Voer de kamercode in om mee te doen';

  @override
  String get joinRoom_roomCode_label => 'Kamercode';

  @override
  String get joinRoom_roomCode_hint => 'ABC123';

  @override
  String get joinRoom_joinGame_button => 'Doe Mee';

  @override
  String get lobby_title => 'Lobby';

  @override
  String get lobby_roomCode_label => 'Kamercode';

  @override
  String get lobby_tapToCopy => 'Tik om te kopiëren';

  @override
  String get lobby_host_label => 'Host';

  @override
  String get lobby_startGame_button => 'Start Spel';

  @override
  String get lobby_needMorePlayers => 'Minimaal 3 spelers nodig om te starten';

  @override
  String get lobby_waitingForHost => 'Wachten tot host start...';

  @override
  String get store_title => 'Winkel';

  @override
  String get store_unlockPremium => 'Ontgrendel Premium Functies';

  @override
  String get store_supportDevelopment =>
      'Ondersteun de ontwikkeling en verbeter je ervaring';

  @override
  String get store_bestValue => 'BESTE WAARDE';

  @override
  String get store_best => 'BESTE';

  @override
  String get store_oneTime => 'eenmalig';

  @override
  String get store_purchase_button => 'Kopen';

  @override
  String get store_owned => 'In bezit';

  @override
  String get store_restorePurchases_button => 'Herstel Aankopen';

  @override
  String get store_purchaseSuccessful => 'Aankoop succesvol!';

  @override
  String store_purchasesRestored(int count) {
    return '$count aankoop(en) hersteld!';
  }

  @override
  String get store_noRestore => 'Geen aankopen om te herstellen';

  @override
  String get store_purchaseFailed => 'Aankoop mislukt';

  @override
  String get store_noProducts => 'Geen producten beschikbaar';

  @override
  String get store_failedToLoadProducts => 'Producten laden mislukt';

  @override
  String get store_failedToLoadStore => 'Winkel laden mislukt';

  @override
  String get store_retry_button => 'Opnieuw';

  @override
  String get store_whatYouGet => 'Wat je krijgt';

  @override
  String get store_adFree => 'Advertentievrije ervaring';

  @override
  String get store_allWordPacks => 'Alle woordenpakketten';

  @override
  String get store_futurePacks => 'Toekomstige pakketten inbegrepen';

  @override
  String get store_supportDev => 'Ondersteun ontwikkeling';

  @override
  String get store_legalApple =>
      'Aankopen worden verwerkt via de Apple App Store. Alle aankopen zijn eenmalige betalingen.';

  @override
  String get store_legalGoogle =>
      'Aankopen worden verwerkt via Google Play. Alle aankopen zijn eenmalige betalingen.';

  @override
  String get premiumPack_title => 'Premium Pakket';

  @override
  String get premiumPack_message =>
      'Dit woordenpakket is onderdeel van de premium collectie. Ontgrendel alle pakketten om toegang te krijgen!';

  @override
  String get premiumPack_cancel_button => 'Annuleren';

  @override
  String get premiumPack_viewStore_button => 'Bekijk Winkel';

  @override
  String get error_enterName => 'Voer je naam in';

  @override
  String error_createRoom(String error) {
    return 'Fout bij maken kamer: $error';
  }

  @override
  String get error_allPlayersNeedName => 'Alle spelers moeten een naam hebben';

  @override
  String get error_minPlayers => 'Minimaal 3 spelers vereist';

  @override
  String get error_loadWords =>
      'Kon woorden niet laden. Controleer je verbinding.';

  @override
  String error_generic(String error) {
    return 'Fout: $error';
  }

  @override
  String get error_roomCodeInvalid => 'Voer een geldige 6-tekens kamercode in';

  @override
  String error_joinRoom(String error) {
    return 'Fout bij joinen kamer: $error';
  }

  @override
  String error_startGame(String error) {
    return 'Fout bij starten spel: $error';
  }

  @override
  String get error_failedToLoadPacks => 'Pakketten laden mislukt';

  @override
  String get snackbar_roomCodeCopied => 'Kamercode gekopieerd!';

  @override
  String get wordPackSelector_title => 'Kies je Thema';

  @override
  String get wordPackSelector_viewAll => 'Bekijk Alles';

  @override
  String get wordPackSelector_random => 'Willekeurig';
}
