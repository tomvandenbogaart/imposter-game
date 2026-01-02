// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sus Night';

  @override
  String get welcome_title => 'SUS NIGHT';

  @override
  String get welcome_subtitle => 'Encuentra al impostor entre ustedes';

  @override
  String get welcome_offlineMode_title => 'Multijugador Sin Conexión';

  @override
  String get welcome_offlineMode_subtitle => 'Pasen el teléfono';

  @override
  String get welcome_playOffline_button => 'Jugar Sin Conexión';

  @override
  String get welcome_onlineMode_title => 'Multijugador En Línea';

  @override
  String get welcome_onlineMode_subtitle => 'Juega con amigos a distancia';

  @override
  String get welcome_yourName_label => 'Tu Nombre';

  @override
  String get welcome_yourName_hint => 'Ingresa tu nombre de pantalla';

  @override
  String get welcome_createRoom_button => 'Crear Sala';

  @override
  String get welcome_joinRoom_button => 'Unirse a Sala';

  @override
  String get welcome_or_divider => 'O';

  @override
  String get localSetup_title => 'Partida Local';

  @override
  String get localSetup_players_header => 'Jugadores';

  @override
  String localSetup_playerCount(int current) {
    return '$current/12';
  }

  @override
  String get localSetup_addPlayer_button => 'Agregar Jugador';

  @override
  String get localSetup_settings_title => 'Configuración';

  @override
  String localSetup_settingsSummary(
    int rounds,
    String roundsLabel,
    String timer,
    String packName,
  ) {
    return '$rounds $roundsLabel · $timer cronómetro · $packName';
  }

  @override
  String get localSetup_startRound_button => 'Iniciar Ronda';

  @override
  String localSetup_defaultPlayerName(int number) {
    return 'Jugador $number';
  }

  @override
  String get localSetup_roundSingular => 'ronda';

  @override
  String get localSetup_roundPlural => 'rondas';

  @override
  String get localSetup_random => 'Aleatorio';

  @override
  String get localSetup_loading => 'Cargando...';

  @override
  String get localSettings_title => 'Configuración';

  @override
  String get localSettings_numberOfRounds => 'Número de Rondas';

  @override
  String get localSettings_discussionTime => 'Tiempo de Discusión';

  @override
  String get localSettings_wordPack => 'Paquete de Palabras';

  @override
  String get localSettings_selectPack_hint => 'Selecciona un paquete';

  @override
  String get localSettings_randomAllPacks => 'Aleatorio (Todos los Paquetes)';

  @override
  String get localSettings_revealProtection_title => 'Protección de Revelación';

  @override
  String get localSettings_revealProtection_subtitle =>
      'Mantener para revelar las cartas';

  @override
  String get localSettings_allowPause_title => 'Permitir Pausa';

  @override
  String get localSettings_allowPause_subtitle =>
      'Habilitar pausa durante la discusión';

  @override
  String get localSettings_hapticFeedback_title => 'Retroalimentación Háptica';

  @override
  String get localSettings_hapticFeedback_subtitle =>
      'Vibrar al revelar cartas y votar';

  @override
  String get localSettings_language_title => 'Idioma';

  @override
  String get localSettings_language_subtitle =>
      'Elegir idioma de la aplicación';

  @override
  String get localSettings_language_system => 'Predeterminado del Sistema';

  @override
  String get privacy_vote_label => 'Voto';

  @override
  String get privacy_player_label => 'Jugador';

  @override
  String privacy_progress(int current, int total) {
    return '$current / $total';
  }

  @override
  String get privacy_passPhoneTo => 'Pasa el teléfono a';

  @override
  String get privacy_toSeeRole => 'para ver su rol';

  @override
  String get privacy_toCastVote => 'para votar';

  @override
  String privacy_ensurePrivacy(String playerName) {
    return 'Asegúrate de que solo $playerName pueda ver la pantalla';
  }

  @override
  String get privacy_holdToContinue_button => 'Mantén para Continuar';

  @override
  String get privacy_continue_button => 'Continuar';

  @override
  String get cardReveal_yourRole => 'Tu Rol';

  @override
  String get cardReveal_tapToReveal => 'Toca la carta para revelar';

  @override
  String get cardReveal_tapToReveal_card => 'TOCA PARA REVELAR';

  @override
  String get cardReveal_roleAwaits => 'Tu rol te espera';

  @override
  String get cardReveal_hideCard_button => 'Ocultar Carta';

  @override
  String get cardReveal_findImposter => '¡Encuentra al impostor!';

  @override
  String get cardReveal_imposter_title => 'IMPOSTOR';

  @override
  String get cardReveal_yourHint => 'Tu pista:';

  @override
  String get cardReveal_noHint => 'Sin pista';

  @override
  String get cardReveal_blendIn => '¡Intégrate! Finge que conoces la palabra.';

  @override
  String get cardReveal_unknown => 'Desconocido';

  @override
  String get allSet_title => '¡Listos!';

  @override
  String get allSet_subtitle => 'Todos los jugadores han visto sus cartas';

  @override
  String get allSet_players_label => 'Jugadores';

  @override
  String get allSet_timer_label => 'Cronómetro';

  @override
  String get allSet_imposter_label => 'Impostor';

  @override
  String get allSet_instruction =>
      'Discutan para encontrar al impostor. ¡El impostor debe integrarse sin conocer la palabra!';

  @override
  String get allSet_startDiscussion_button => 'Iniciar Discusión';

  @override
  String get discussion_title => 'Discusión';

  @override
  String get discussion_findImposter => '¡Encuentra al impostor!';

  @override
  String discussion_playerStarts(String playerName) {
    return '¡$playerName comienza!';
  }

  @override
  String get discussion_paused => 'PAUSADO';

  @override
  String get discussion_pause_button => 'Pausar';

  @override
  String get discussion_resume_button => 'Reanudar';

  @override
  String get discussion_players_label => 'Jugadores';

  @override
  String get discussion_skipToVote_button => 'Ir a Votar';

  @override
  String voting_title(String playerName) {
    return 'Voto de $playerName';
  }

  @override
  String get voting_whoIsImposter => '¿Quién es el impostor?';

  @override
  String get voting_confirmVote_button => 'Confirmar Voto';

  @override
  String results_roundOf(int current, int total) {
    return 'Ronda $current de $total';
  }

  @override
  String get results_groupWins => '¡El Grupo Gana!';

  @override
  String get results_imposterWins => '¡El Impostor Gana!';

  @override
  String get results_voteTied => '¡Empate en la votación!';

  @override
  String get results_imposterFound => '¡El impostor fue encontrado!';

  @override
  String get results_imposterEscaped => '¡El impostor escapó!';

  @override
  String get results_wasImposter => 'era el Impostor';

  @override
  String results_hint(String hint) {
    return 'Pista: $hint';
  }

  @override
  String get results_currentStandings => 'Clasificación Actual';

  @override
  String results_points(int points) {
    return '$points pts';
  }

  @override
  String get results_nextRound_button => 'Siguiente Ronda';

  @override
  String get results_endGameEarly_button => 'Terminar Partida';

  @override
  String get results_seeFinalResults_button => 'Ver Resultados Finales';

  @override
  String get results_playAgain_button => 'Jugar de Nuevo';

  @override
  String get finalResults_winner => '¡Ganador!';

  @override
  String get finalResults_tie => '¡Empate!';

  @override
  String get finalResults_gameOver => '¡Juego Terminado!';

  @override
  String get finalResults_noPoints => '¡Nadie anotó puntos!';

  @override
  String finalResults_roundsPlayed(int count) {
    return '$count rondas jugadas';
  }

  @override
  String get finalResults_finalStandings => 'Clasificación Final';

  @override
  String get finalResults_playAgain_button => 'Jugar de Nuevo';

  @override
  String get finalResults_exitToHome_button => 'Volver al Inicio';

  @override
  String get joinRoom_title => 'Unirse a Sala';

  @override
  String get joinRoom_subtitle => 'Ingresa el código de la sala para unirte';

  @override
  String get joinRoom_roomCode_label => 'Código de Sala';

  @override
  String get joinRoom_roomCode_hint => 'ABC123';

  @override
  String get joinRoom_joinGame_button => 'Unirse';

  @override
  String get lobby_title => 'Vestíbulo';

  @override
  String get lobby_roomCode_label => 'Código de Sala';

  @override
  String get lobby_tapToCopy => 'Toca para copiar';

  @override
  String get lobby_host_label => 'Anfitrión';

  @override
  String get lobby_startGame_button => 'Iniciar Partida';

  @override
  String get lobby_needMorePlayers =>
      'Se necesitan al menos 3 jugadores para comenzar';

  @override
  String get lobby_waitingForHost => 'Esperando al anfitrión...';

  @override
  String get store_title => 'Tienda';

  @override
  String get store_unlockPremium => 'Desbloquear Funciones Premium';

  @override
  String get store_supportDevelopment =>
      'Apoya el desarrollo y mejora tu experiencia';

  @override
  String get store_bestValue => 'MEJOR VALOR';

  @override
  String get store_best => 'MEJOR';

  @override
  String get store_oneTime => 'único';

  @override
  String get store_purchase_button => 'Comprar';

  @override
  String get store_owned => 'Adquirido';

  @override
  String get store_restorePurchases_button => 'Restaurar Compras';

  @override
  String get store_purchaseSuccessful => '¡Compra exitosa!';

  @override
  String store_purchasesRestored(int count) {
    return '¡$count compra(s) restaurada(s)!';
  }

  @override
  String get store_noRestore => 'No hay compras para restaurar';

  @override
  String get store_purchaseFailed => 'Compra fallida';

  @override
  String get store_noProducts => 'No hay productos disponibles';

  @override
  String get store_failedToLoadProducts => 'Error al cargar productos';

  @override
  String get store_failedToLoadStore => 'Error al cargar la tienda';

  @override
  String get store_retry_button => 'Reintentar';

  @override
  String get store_whatYouGet => 'Lo que obtienes';

  @override
  String get store_adFree => 'Experiencia sin anuncios';

  @override
  String get store_allWordPacks => 'Todos los paquetes de palabras';

  @override
  String get store_futurePacks => 'Paquetes futuros incluidos';

  @override
  String get store_supportDev => 'Apoyar el desarrollo';

  @override
  String get store_legalApple =>
      'Las compras se procesan a través de la App Store de Apple. Todas las compras son pagos únicos.';

  @override
  String get store_legalGoogle =>
      'Las compras se procesan a través de Google Play. Todas las compras son pagos únicos.';

  @override
  String get premiumPack_title => 'Paquete Premium';

  @override
  String get premiumPack_message =>
      'Este paquete de palabras es parte de la colección premium. ¡Desbloquea todos los paquetes para acceder!';

  @override
  String get premiumPack_cancel_button => 'Cancelar';

  @override
  String get premiumPack_viewStore_button => 'Ver Tienda';

  @override
  String get error_enterName => 'Por favor ingresa tu nombre';

  @override
  String error_createRoom(String error) {
    return 'Error al crear la sala: $error';
  }

  @override
  String get error_allPlayersNeedName =>
      'Todos los jugadores deben tener un nombre';

  @override
  String get error_minPlayers => 'Se requieren al menos 3 jugadores';

  @override
  String get error_loadWords =>
      'No se pudieron cargar las palabras. Verifica tu conexión.';

  @override
  String error_generic(String error) {
    return 'Error: $error';
  }

  @override
  String get error_roomCodeInvalid =>
      'Por favor ingresa un código de sala válido de 6 caracteres';

  @override
  String error_joinRoom(String error) {
    return 'Error al unirse a la sala: $error';
  }

  @override
  String error_startGame(String error) {
    return 'Error al iniciar el juego: $error';
  }

  @override
  String get error_failedToLoadPacks => 'Error al cargar los paquetes';

  @override
  String get snackbar_roomCodeCopied => '¡Código de sala copiado!';

  @override
  String get wordPackSelector_title => 'Elige tu Tema';

  @override
  String get wordPackSelector_viewAll => 'Ver Todo';

  @override
  String get wordPackSelector_random => 'Aleatorio';
}
