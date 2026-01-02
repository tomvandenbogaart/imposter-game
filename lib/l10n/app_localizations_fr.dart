// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sus Night';

  @override
  String get welcome_title => 'SUS NIGHT';

  @override
  String get welcome_subtitle => 'Trouvez l\'imposteur parmi vous';

  @override
  String get welcome_offlineMode_title => 'Multijoueur Hors Ligne';

  @override
  String get welcome_offlineMode_subtitle => 'Passez le téléphone';

  @override
  String get welcome_playOffline_button => 'Jouer Hors Ligne';

  @override
  String get welcome_onlineMode_title => 'Multijoueur En Ligne';

  @override
  String get welcome_onlineMode_subtitle => 'Jouez avec des amis à distance';

  @override
  String get welcome_yourName_label => 'Votre Nom';

  @override
  String get welcome_yourName_hint => 'Entrez votre nom d\'affichage';

  @override
  String get welcome_createRoom_button => 'Créer une Salle';

  @override
  String get welcome_joinRoom_button => 'Rejoindre une Salle';

  @override
  String get welcome_or_divider => 'OU';

  @override
  String get localSetup_title => 'Partie Locale';

  @override
  String get localSetup_players_header => 'Joueurs';

  @override
  String localSetup_playerCount(int current) {
    return '$current/12';
  }

  @override
  String get localSetup_addPlayer_button => 'Ajouter un Joueur';

  @override
  String get localSetup_settings_title => 'Paramètres';

  @override
  String localSetup_settingsSummary(
    int rounds,
    String roundsLabel,
    String timer,
    String packName,
  ) {
    return '$rounds $roundsLabel · $timer chrono · $packName';
  }

  @override
  String get localSetup_startRound_button => 'Démarrer la Manche';

  @override
  String localSetup_defaultPlayerName(int number) {
    return 'Joueur $number';
  }

  @override
  String get localSetup_roundSingular => 'manche';

  @override
  String get localSetup_roundPlural => 'manches';

  @override
  String get localSetup_random => 'Aléatoire';

  @override
  String get localSetup_loading => 'Chargement...';

  @override
  String get localSettings_title => 'Paramètres';

  @override
  String get localSettings_numberOfRounds => 'Nombre de Manches';

  @override
  String get localSettings_discussionTime => 'Temps de Discussion';

  @override
  String get localSettings_wordPack => 'Pack de Mots';

  @override
  String get localSettings_selectPack_hint => 'Sélectionnez un pack';

  @override
  String get localSettings_randomAllPacks => 'Aléatoire (Tous les Packs)';

  @override
  String get localSettings_revealProtection_title => 'Protection de Révélation';

  @override
  String get localSettings_revealProtection_subtitle =>
      'Maintenir pour révéler les cartes';

  @override
  String get localSettings_allowPause_title => 'Autoriser la Pause';

  @override
  String get localSettings_allowPause_subtitle =>
      'Activer la pause pendant la discussion';

  @override
  String get localSettings_hapticFeedback_title => 'Retour Haptique';

  @override
  String get localSettings_hapticFeedback_subtitle =>
      'Vibrer lors de la révélation et des votes';

  @override
  String get localSettings_language_title => 'Langue';

  @override
  String get localSettings_language_subtitle =>
      'Choisir la langue de l\'application';

  @override
  String get localSettings_language_system => 'Défaut du Système';

  @override
  String get privacy_vote_label => 'Vote';

  @override
  String get privacy_player_label => 'Joueur';

  @override
  String privacy_progress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get privacy_passPhoneTo => 'Passez le téléphone à';

  @override
  String get privacy_toSeeRole => 'pour voir son rôle';

  @override
  String get privacy_toCastVote => 'pour voter';

  @override
  String privacy_ensurePrivacy(String playerName) {
    return 'Assurez-vous que seul $playerName peut voir l\'écran';
  }

  @override
  String get privacy_holdToContinue_button => 'Maintenir pour Continuer';

  @override
  String get privacy_continue_button => 'Continuer';

  @override
  String get cardReveal_yourRole => 'Votre Rôle';

  @override
  String get cardReveal_tapToReveal => 'Touchez la carte pour révéler';

  @override
  String get cardReveal_tapToReveal_card => 'TOUCHER POUR RÉVÉLER';

  @override
  String get cardReveal_roleAwaits => 'Votre rôle vous attend';

  @override
  String get cardReveal_hideCard_button => 'Cacher la Carte';

  @override
  String get cardReveal_findImposter => 'Trouvez l\'imposteur !';

  @override
  String get cardReveal_imposter_title => 'IMPOSTEUR';

  @override
  String get cardReveal_yourHint => 'Votre indice :';

  @override
  String get cardReveal_noHint => 'Pas d\'indice';

  @override
  String get cardReveal_blendIn =>
      'Intégrez-vous ! Faites semblant de connaître le mot.';

  @override
  String get cardReveal_unknown => 'Inconnu';

  @override
  String get allSet_title => 'Prêt !';

  @override
  String get allSet_subtitle => 'Tous les joueurs ont vu leurs cartes';

  @override
  String get allSet_players_label => 'Joueurs';

  @override
  String get allSet_timer_label => 'Chrono';

  @override
  String get allSet_imposter_label => 'Imposteur';

  @override
  String get allSet_instruction =>
      'Discutez pour trouver l\'imposteur. L\'imposteur doit se fondre sans connaître le mot !';

  @override
  String get allSet_startDiscussion_button => 'Démarrer la Discussion';

  @override
  String get discussion_title => 'Discussion';

  @override
  String get discussion_findImposter => 'Trouvez l\'imposteur !';

  @override
  String discussion_playerStarts(String playerName) {
    return '$playerName commence !';
  }

  @override
  String get discussion_paused => 'EN PAUSE';

  @override
  String get discussion_pause_button => 'Pause';

  @override
  String get discussion_resume_button => 'Reprendre';

  @override
  String get discussion_players_label => 'Joueurs';

  @override
  String get discussion_skipToVote_button => 'Passer au Vote';

  @override
  String voting_title(String playerName) {
    return 'Vote de $playerName';
  }

  @override
  String get voting_whoIsImposter => 'Qui est l\'imposteur ?';

  @override
  String get voting_confirmVote_button => 'Confirmer le Vote';

  @override
  String results_roundOf(int current, int total) {
    return 'Manche $current sur $total';
  }

  @override
  String get results_groupWins => 'Le Groupe Gagne !';

  @override
  String get results_imposterWins => 'L\'Imposteur Gagne !';

  @override
  String get results_voteTied => 'Égalité des votes !';

  @override
  String get results_imposterFound => 'L\'imposteur a été trouvé !';

  @override
  String get results_imposterEscaped => 'L\'imposteur s\'est échappé !';

  @override
  String get results_wasImposter => 'était l\'Imposteur';

  @override
  String results_hint(String hint) {
    return 'Indice : $hint';
  }

  @override
  String get results_currentStandings => 'Classement Actuel';

  @override
  String results_points(int points) {
    return '$points pts';
  }

  @override
  String get results_nextRound_button => 'Manche Suivante';

  @override
  String get results_endGameEarly_button => 'Terminer la Partie';

  @override
  String get results_seeFinalResults_button => 'Voir les Résultats Finaux';

  @override
  String get results_playAgain_button => 'Rejouer';

  @override
  String get finalResults_winner => 'Gagnant !';

  @override
  String get finalResults_tie => 'Égalité !';

  @override
  String get finalResults_gameOver => 'Partie Terminée !';

  @override
  String get finalResults_noPoints => 'Personne n\'a marqué de points !';

  @override
  String finalResults_roundsPlayed(int count) {
    return '$count manches jouées';
  }

  @override
  String get finalResults_finalStandings => 'Classement Final';

  @override
  String get finalResults_playAgain_button => 'Rejouer';

  @override
  String get finalResults_exitToHome_button => 'Retour à l\'Accueil';

  @override
  String get joinRoom_title => 'Rejoindre une Salle';

  @override
  String get joinRoom_subtitle => 'Entrez le code de la salle pour rejoindre';

  @override
  String get joinRoom_roomCode_label => 'Code de Salle';

  @override
  String get joinRoom_roomCode_hint => 'ABC123';

  @override
  String get joinRoom_joinGame_button => 'Rejoindre';

  @override
  String get lobby_title => 'Salon';

  @override
  String get lobby_roomCode_label => 'Code de Salle';

  @override
  String get lobby_tapToCopy => 'Toucher pour copier';

  @override
  String get lobby_host_label => 'Hôte';

  @override
  String get lobby_startGame_button => 'Démarrer la Partie';

  @override
  String get lobby_needMorePlayers =>
      'Au moins 3 joueurs requis pour commencer';

  @override
  String get lobby_waitingForHost => 'En attente de l\'hôte...';

  @override
  String get store_title => 'Boutique';

  @override
  String get store_unlockPremium => 'Débloquer les Fonctionnalités Premium';

  @override
  String get store_supportDevelopment =>
      'Soutenez le développement et améliorez votre expérience';

  @override
  String get store_bestValue => 'MEILLEURE VALEUR';

  @override
  String get store_best => 'MEILLEUR';

  @override
  String get store_oneTime => 'unique';

  @override
  String get store_purchase_button => 'Acheter';

  @override
  String get store_owned => 'Possédé';

  @override
  String get store_restorePurchases_button => 'Restaurer les Achats';

  @override
  String get store_purchaseSuccessful => 'Achat réussi !';

  @override
  String store_purchasesRestored(int count) {
    return '$count achat(s) restauré(s) !';
  }

  @override
  String get store_noRestore => 'Aucun achat à restaurer';

  @override
  String get store_purchaseFailed => 'Achat échoué';

  @override
  String get store_noProducts => 'Aucun produit disponible';

  @override
  String get store_failedToLoadProducts => 'Échec du chargement des produits';

  @override
  String get store_failedToLoadStore => 'Échec du chargement de la boutique';

  @override
  String get store_retry_button => 'Réessayer';

  @override
  String get store_whatYouGet => 'Ce que vous obtenez';

  @override
  String get store_adFree => 'Expérience sans publicité';

  @override
  String get store_allWordPacks => 'Tous les packs de mots';

  @override
  String get store_futurePacks => 'Packs futurs inclus';

  @override
  String get store_supportDev => 'Soutenir le développement';

  @override
  String get store_legalApple =>
      'Les achats sont traités par l\'App Store Apple. Tous les achats sont des paiements uniques.';

  @override
  String get store_legalGoogle =>
      'Les achats sont traités par Google Play. Tous les achats sont des paiements uniques.';

  @override
  String get premiumPack_title => 'Pack Premium';

  @override
  String get premiumPack_message =>
      'Ce pack de mots fait partie de la collection premium. Débloquez tous les packs pour y accéder !';

  @override
  String get premiumPack_cancel_button => 'Annuler';

  @override
  String get premiumPack_viewStore_button => 'Voir la Boutique';

  @override
  String get error_enterName => 'Veuillez entrer votre nom';

  @override
  String error_createRoom(String error) {
    return 'Erreur lors de la création de la salle : $error';
  }

  @override
  String get error_allPlayersNeedName =>
      'Tous les joueurs doivent avoir un nom';

  @override
  String get error_minPlayers => 'Au moins 3 joueurs requis';

  @override
  String get error_loadWords =>
      'Impossible de charger les mots. Vérifiez votre connexion.';

  @override
  String error_generic(String error) {
    return 'Erreur : $error';
  }

  @override
  String get error_roomCodeInvalid =>
      'Veuillez entrer un code de salle valide de 6 caractères';

  @override
  String error_joinRoom(String error) {
    return 'Erreur lors de la connexion : $error';
  }

  @override
  String error_startGame(String error) {
    return 'Erreur lors du démarrage : $error';
  }

  @override
  String get error_failedToLoadPacks => 'Échec du chargement des packs';

  @override
  String get snackbar_roomCodeCopied => 'Code de salle copié !';

  @override
  String get wordPackSelector_title => 'Choisissez votre Thème';

  @override
  String get wordPackSelector_viewAll => 'Voir tout';

  @override
  String get wordPackSelector_random => 'Aléatoire';
}
