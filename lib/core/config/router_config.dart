import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/welcome/welcome_screen.dart';
import '../../presentation/screens/join_room/join_room_screen.dart';
import '../../presentation/screens/lobby/lobby_screen.dart';
import '../../presentation/screens/round_reveal/round_reveal_screen.dart';
import '../../presentation/screens/discussion/discussion_screen.dart';
import '../../presentation/screens/voting/voting_screen.dart';
import '../../presentation/screens/results/results_screen.dart';
import '../../presentation/screens/local_game/local_setup_screen.dart';
import '../../presentation/screens/local_game/local_privacy_screen.dart';
import '../../presentation/screens/local_game/local_card_reveal_screen.dart';
import '../../presentation/screens/local_game/local_all_set_screen.dart';
import '../../presentation/screens/local_game/local_discussion_screen.dart';
import '../../presentation/screens/local_game/local_voting_screen.dart';
import '../../presentation/screens/local_game/local_results_screen.dart';
import '../../presentation/screens/local_game/local_final_results_screen.dart';
import '../../presentation/screens/local_game/local_settings_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/join',
        name: 'join',
        builder: (context, state) => const JoinRoomScreen(),
      ),
      GoRoute(
        path: '/join/:code',
        name: 'joinWithCode',
        builder: (context, state) {
          final code = state.pathParameters['code'] ?? '';
          return JoinRoomScreen(initialCode: code);
        },
      ),
      GoRoute(
        path: '/lobby/:roomId',
        name: 'lobby',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return LobbyScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/game/:roomId/reveal',
        name: 'reveal',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return RoundRevealScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/game/:roomId/discussion',
        name: 'discussion',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return DiscussionScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/game/:roomId/voting',
        name: 'voting',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return VotingScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/game/:roomId/results',
        name: 'results',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return ResultsScreen(roomId: roomId);
        },
      ),
      // Local game routes
      GoRoute(
        path: '/local',
        name: 'localSetup',
        builder: (context, state) => const LocalSetupScreen(),
      ),
      GoRoute(
        path: '/local/settings',
        name: 'localSettings',
        builder: (context, state) => const LocalSettingsScreen(),
      ),
      GoRoute(
        path: '/local/privacy',
        name: 'localPrivacy',
        builder: (context, state) => const LocalPrivacyScreen(),
      ),
      GoRoute(
        path: '/local/reveal',
        name: 'localReveal',
        builder: (context, state) => const LocalCardRevealScreen(),
      ),
      GoRoute(
        path: '/local/allset',
        name: 'localAllSet',
        builder: (context, state) => const LocalAllSetScreen(),
      ),
      GoRoute(
        path: '/local/discussion',
        name: 'localDiscussion',
        builder: (context, state) => const LocalDiscussionScreen(),
      ),
      GoRoute(
        path: '/local/voting',
        name: 'localVoting',
        builder: (context, state) => const LocalVotingScreen(),
      ),
      GoRoute(
        path: '/local/results',
        name: 'localResults',
        builder: (context, state) => const LocalResultsScreen(),
      ),
      GoRoute(
        path: '/local/final-results',
        name: 'localFinalResults',
        builder: (context, state) => const LocalFinalResultsScreen(),
      ),
    ],
  );
}
