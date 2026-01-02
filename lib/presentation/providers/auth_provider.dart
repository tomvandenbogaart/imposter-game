import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/services/auth_service.dart';
import '../../core/utils/app_logger.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.valueOrNull?.session?.user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    final user = _authService.currentUser;
    state = AsyncValue.data(user);
  }

  Future<User?> signInAnonymously() async {
    AppLogger.i('Signing in anonymously...');
    state = const AsyncValue.loading();
    try {
      final response = await _authService.signInAnonymously();
      AppLogger.i('Anonymous sign-in successful: ${response.user?.id}');
      state = AsyncValue.data(response.user);
      return response.user;
    } catch (e, st) {
      AppLogger.e('Anonymous sign-in failed', e, st);
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> ensureAuthenticated() async {
    AppLogger.i('Ensuring authenticated, current: ${_authService.isAuthenticated}');
    if (!_authService.isAuthenticated) {
      final user = await signInAnonymously();
      if (user == null) {
        throw Exception('Anonymous sign-in failed - no user returned');
      }
      AppLogger.i('Now authenticated: ${user.id}');
    } else {
      AppLogger.i('Already authenticated: ${_authService.currentUserId}');
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const AsyncValue.data(null);
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});
