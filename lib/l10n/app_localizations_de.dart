// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Sus Night';

  @override
  String get welcome_title => 'SUS NIGHT';

  @override
  String get welcome_subtitle => 'Finde den Hochstapler unter euch';

  @override
  String get welcome_offlineMode_title => 'Offline Multiplayer';

  @override
  String get welcome_offlineMode_subtitle => 'Reicht das Handy herum';

  @override
  String get welcome_playOffline_button => 'Offline Spielen';

  @override
  String get welcome_onlineMode_title => 'Online Multiplayer';

  @override
  String get welcome_onlineMode_subtitle => 'Spielt mit Freunden aus der Ferne';

  @override
  String get welcome_yourName_label => 'Dein Name';

  @override
  String get welcome_yourName_hint => 'Gib deinen Anzeigenamen ein';

  @override
  String get welcome_createRoom_button => 'Raum Erstellen';

  @override
  String get welcome_joinRoom_button => 'Raum Beitreten';

  @override
  String get welcome_or_divider => 'ODER';

  @override
  String get localSetup_title => 'Lokales Spiel';

  @override
  String get localSetup_players_header => 'Spieler';

  @override
  String localSetup_playerCount(int current) {
    return '$current/12';
  }

  @override
  String get localSetup_addPlayer_button => 'Spieler Hinzufügen';

  @override
  String get localSetup_settings_title => 'Einstellungen';

  @override
  String localSetup_settingsSummary(
    int rounds,
    String roundsLabel,
    String timer,
    String packName,
  ) {
    return '$rounds $roundsLabel · $timer Timer · $packName';
  }

  @override
  String get localSetup_startRound_button => 'Runde Starten';

  @override
  String localSetup_defaultPlayerName(int number) {
    return 'Spieler $number';
  }

  @override
  String get localSetup_roundSingular => 'Runde';

  @override
  String get localSetup_roundPlural => 'Runden';

  @override
  String get localSetup_random => 'Zufällig';

  @override
  String get localSetup_loading => 'Laden...';

  @override
  String get localSettings_title => 'Einstellungen';

  @override
  String get localSettings_numberOfRounds => 'Anzahl der Runden';

  @override
  String get localSettings_discussionTime => 'Diskussionszeit';

  @override
  String get localSettings_wordPack => 'Wortpaket';

  @override
  String get localSettings_selectPack_hint => 'Paket auswählen';

  @override
  String get localSettings_randomAllPacks => 'Zufällig (Alle Pakete)';

  @override
  String get localSettings_revealProtection_title => 'Aufdeckschutz';

  @override
  String get localSettings_revealProtection_subtitle =>
      'Halten zum Aufdecken der Karten';

  @override
  String get localSettings_allowPause_title => 'Pause Erlauben';

  @override
  String get localSettings_allowPause_subtitle =>
      'Pause während der Diskussion ermöglichen';

  @override
  String get localSettings_hapticFeedback_title => 'Haptisches Feedback';

  @override
  String get localSettings_hapticFeedback_subtitle =>
      'Vibration beim Aufdecken und Abstimmen';

  @override
  String get localSettings_language_title => 'Sprache';

  @override
  String get localSettings_language_subtitle => 'App-Sprache wählen';

  @override
  String get localSettings_language_system => 'Systemstandard';

  @override
  String get privacy_vote_label => 'Stimme';

  @override
  String get privacy_player_label => 'Spieler';

  @override
  String privacy_progress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get privacy_passPhoneTo => 'Gib das Handy an';

  @override
  String get privacy_toSeeRole => 'um ihre Rolle zu sehen';

  @override
  String get privacy_toCastVote => 'um abzustimmen';

  @override
  String privacy_ensurePrivacy(String playerName) {
    return 'Stelle sicher, dass nur $playerName den Bildschirm sehen kann';
  }

  @override
  String get privacy_holdToContinue_button => 'Halten zum Fortfahren';

  @override
  String get privacy_continue_button => 'Weiter';

  @override
  String get cardReveal_yourRole => 'Deine Rolle';

  @override
  String get cardReveal_tapToReveal => 'Tippe auf die Karte zum Aufdecken';

  @override
  String get cardReveal_tapToReveal_card => 'TIPPEN ZUM AUFDECKEN';

  @override
  String get cardReveal_roleAwaits => 'Deine Rolle wartet';

  @override
  String get cardReveal_hideCard_button => 'Karte Verstecken';

  @override
  String get cardReveal_findImposter => 'Finde den Hochstapler!';

  @override
  String get cardReveal_imposter_title => 'HOCHSTAPLER';

  @override
  String get cardReveal_yourHint => 'Dein Hinweis:';

  @override
  String get cardReveal_noHint => 'Kein Hinweis';

  @override
  String get cardReveal_blendIn =>
      'Misch dich unter! Tu so, als würdest du das Wort kennen.';

  @override
  String get cardReveal_unknown => 'Unbekannt';

  @override
  String get allSet_title => 'Bereit!';

  @override
  String get allSet_subtitle => 'Alle Spieler haben ihre Karten gesehen';

  @override
  String get allSet_players_label => 'Spieler';

  @override
  String get allSet_timer_label => 'Timer';

  @override
  String get allSet_imposter_label => 'Hochstapler';

  @override
  String get allSet_instruction =>
      'Diskutiert, um den Hochstapler zu finden. Der Hochstapler muss sich ohne das Wort zu kennen tarnen!';

  @override
  String get allSet_startDiscussion_button => 'Diskussion Starten';

  @override
  String get discussion_title => 'Diskussion';

  @override
  String get discussion_findImposter => 'Finde den Hochstapler!';

  @override
  String discussion_playerStarts(String playerName) {
    return '$playerName beginnt!';
  }

  @override
  String get discussion_paused => 'PAUSIERT';

  @override
  String get discussion_pause_button => 'Pause';

  @override
  String get discussion_resume_button => 'Fortsetzen';

  @override
  String get discussion_players_label => 'Spieler';

  @override
  String get discussion_skipToVote_button => 'Zur Abstimmung';

  @override
  String voting_title(String playerName) {
    return '${playerName}s Stimme';
  }

  @override
  String get voting_whoIsImposter => 'Wer ist der Hochstapler?';

  @override
  String get voting_confirmVote_button => 'Stimme Bestätigen';

  @override
  String results_roundOf(int current, int total) {
    return 'Runde $current von $total';
  }

  @override
  String get results_groupWins => 'Die Gruppe Gewinnt!';

  @override
  String get results_imposterWins => 'Der Hochstapler Gewinnt!';

  @override
  String get results_voteTied => 'Stimmengleichheit!';

  @override
  String get results_imposterFound => 'Der Hochstapler wurde gefunden!';

  @override
  String get results_imposterEscaped => 'Der Hochstapler ist entkommen!';

  @override
  String get results_wasImposter => 'war der Hochstapler';

  @override
  String results_hint(String hint) {
    return 'Hinweis: $hint';
  }

  @override
  String get results_currentStandings => 'Aktuelle Rangliste';

  @override
  String results_points(int points) {
    return '$points Pkt';
  }

  @override
  String get results_nextRound_button => 'Nächste Runde';

  @override
  String get results_endGameEarly_button => 'Spiel Vorzeitig Beenden';

  @override
  String get results_seeFinalResults_button => 'Endergebnisse Ansehen';

  @override
  String get results_playAgain_button => 'Nochmal Spielen';

  @override
  String get finalResults_winner => 'Gewinner!';

  @override
  String get finalResults_tie => 'Unentschieden!';

  @override
  String get finalResults_gameOver => 'Spiel Vorbei!';

  @override
  String get finalResults_noPoints => 'Niemand hat Punkte erzielt!';

  @override
  String finalResults_roundsPlayed(int count) {
    return '$count Runden gespielt';
  }

  @override
  String get finalResults_finalStandings => 'Endstand';

  @override
  String get finalResults_playAgain_button => 'Nochmal Spielen';

  @override
  String get finalResults_exitToHome_button => 'Zum Startbildschirm';

  @override
  String get joinRoom_title => 'Raum Beitreten';

  @override
  String get joinRoom_subtitle => 'Gib den Raumcode ein, um beizutreten';

  @override
  String get joinRoom_roomCode_label => 'Raumcode';

  @override
  String get joinRoom_roomCode_hint => 'ABC123';

  @override
  String get joinRoom_joinGame_button => 'Beitreten';

  @override
  String get lobby_title => 'Lobby';

  @override
  String get lobby_roomCode_label => 'Raumcode';

  @override
  String get lobby_tapToCopy => 'Tippen zum Kopieren';

  @override
  String get lobby_host_label => 'Host';

  @override
  String get lobby_startGame_button => 'Spiel Starten';

  @override
  String get lobby_needMorePlayers => 'Mindestens 3 Spieler zum Starten nötig';

  @override
  String get lobby_waitingForHost => 'Warte auf Host...';

  @override
  String get store_title => 'Shop';

  @override
  String get store_unlockPremium => 'Premium-Funktionen Freischalten';

  @override
  String get store_supportDevelopment =>
      'Unterstütze die Entwicklung und verbessere dein Erlebnis';

  @override
  String get store_bestValue => 'BESTER WERT';

  @override
  String get store_best => 'BESTE';

  @override
  String get store_oneTime => 'einmalig';

  @override
  String get store_purchase_button => 'Kaufen';

  @override
  String get store_owned => 'Besitzt';

  @override
  String get store_restorePurchases_button => 'Käufe Wiederherstellen';

  @override
  String get store_purchaseSuccessful => 'Kauf erfolgreich!';

  @override
  String store_purchasesRestored(int count) {
    return '$count Kauf/Käufe wiederhergestellt!';
  }

  @override
  String get store_noRestore => 'Keine Käufe zum Wiederherstellen';

  @override
  String get store_purchaseFailed => 'Kauf fehlgeschlagen';

  @override
  String get store_noProducts => 'Keine Produkte verfügbar';

  @override
  String get store_failedToLoadProducts =>
      'Produkte konnten nicht geladen werden';

  @override
  String get store_failedToLoadStore => 'Shop konnte nicht geladen werden';

  @override
  String get store_retry_button => 'Erneut Versuchen';

  @override
  String get store_whatYouGet => 'Was du bekommst';

  @override
  String get store_adFree => 'Werbefreies Erlebnis';

  @override
  String get store_allWordPacks => 'Alle Wortpakete';

  @override
  String get store_futurePacks => 'Zukünftige Pakete inklusive';

  @override
  String get store_supportDev => 'Entwicklung unterstützen';

  @override
  String get store_legalApple =>
      'Käufe werden über den Apple App Store abgewickelt. Alle Käufe sind Einmalzahlungen.';

  @override
  String get store_legalGoogle =>
      'Käufe werden über Google Play abgewickelt. Alle Käufe sind Einmalzahlungen.';

  @override
  String get premiumPack_title => 'Premium-Paket';

  @override
  String get premiumPack_message =>
      'Dieses Wortpaket ist Teil der Premium-Kollektion. Schalte alle Pakete frei, um Zugang zu erhalten!';

  @override
  String get premiumPack_cancel_button => 'Abbrechen';

  @override
  String get premiumPack_viewStore_button => 'Shop Ansehen';

  @override
  String get error_enterName => 'Bitte gib deinen Namen ein';

  @override
  String error_createRoom(String error) {
    return 'Fehler beim Erstellen des Raums: $error';
  }

  @override
  String get error_allPlayersNeedName =>
      'Alle Spieler müssen einen Namen haben';

  @override
  String get error_minPlayers => 'Mindestens 3 Spieler erforderlich';

  @override
  String get error_loadWords =>
      'Wörter konnten nicht geladen werden. Überprüfe deine Verbindung.';

  @override
  String error_generic(String error) {
    return 'Fehler: $error';
  }

  @override
  String get error_roomCodeInvalid =>
      'Bitte gib einen gültigen 6-stelligen Raumcode ein';

  @override
  String error_joinRoom(String error) {
    return 'Fehler beim Beitreten: $error';
  }

  @override
  String error_startGame(String error) {
    return 'Fehler beim Starten: $error';
  }

  @override
  String get error_failedToLoadPacks => 'Pakete konnten nicht geladen werden';

  @override
  String get snackbar_roomCodeCopied => 'Raumcode kopiert!';

  @override
  String get wordPackSelector_title => 'Wähle dein Thema';

  @override
  String get wordPackSelector_viewAll => 'Alle anzeigen';

  @override
  String get wordPackSelector_random => 'Zufällig';
}
