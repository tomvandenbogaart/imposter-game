import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/repositories/round_repository.dart';
import '../../data/repositories/vote_repository.dart';
import '../../data/services/supabase_service.dart';

final roundRepositoryProvider = Provider<RoundRepository>((ref) {
  return RoundRepository();
});

final voteRepositoryProvider = Provider<VoteRepository>((ref) {
  return VoteRepository();
});

// Game phases
enum GamePhase {
  welcome,
  lobby,
  reveal,
  discussion,
  voting,
  results,
}

// Current round stream
final roundStreamProvider = StreamProvider.family<Round?, String>((ref, roundId) {
  final repository = ref.watch(roundRepositoryProvider);
  return repository.watchRound(roundId);
});

// Votes for a round
final votesStreamProvider = StreamProvider.family<List<Vote>, String>((ref, roundId) {
  final repository = ref.watch(voteRepositoryProvider);
  return repository.watchVotes(roundId);
});

// My card for current round
final myCardProvider = FutureProvider.family<PlayerCard?, String>((ref, roundId) async {
  final repository = ref.watch(roundRepositoryProvider);
  return repository.getMyCard(roundId);
});

// Game state notifier
class GameStateNotifier extends StateNotifier<GamePhase> {
  GameStateNotifier() : super(GamePhase.welcome);

  void setPhase(GamePhase phase) {
    state = phase;
  }

  void syncWithRoomState(Room? room, Round? round) {
    if (room == null) {
      state = GamePhase.welcome;
      return;
    }

    switch (room.status) {
      case RoomStatus.waiting:
        state = GamePhase.lobby;
      case RoomStatus.playing:
        if (round != null) {
          switch (round.state) {
            case RoundState.reveal:
              state = GamePhase.reveal;
            case RoundState.discussion:
              state = GamePhase.discussion;
            case RoundState.voting:
              state = GamePhase.voting;
            case RoundState.results:
              state = GamePhase.results;
          }
        }
      case RoomStatus.voting:
        state = GamePhase.voting;
      case RoomStatus.results:
        state = GamePhase.results;
      case RoomStatus.finished:
        state = GamePhase.results;
    }
  }
}

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GamePhase>((ref) {
  return GameStateNotifier();
});

// Timer provider for discussion phase
class TimerNotifier extends StateNotifier<Duration> {
  Timer? _timer;
  DateTime? _endsAt;

  TimerNotifier() : super(Duration.zero);

  void startTimer(DateTime endsAt) {
    _endsAt = endsAt;
    _timer?.cancel();

    _updateRemaining();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemaining();
    });
  }

  void _updateRemaining() {
    if (_endsAt == null) {
      state = Duration.zero;
      return;
    }

    final remaining = _endsAt!.difference(DateTime.now());
    if (remaining.isNegative) {
      state = Duration.zero;
      _timer?.cancel();
    } else {
      state = remaining;
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    state = Duration.zero;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Duration>((ref) {
  return TimerNotifier();
});

// Vote state
class VoteNotifier extends StateNotifier<AsyncValue<Vote?>> {
  final VoteRepository _repository;

  VoteNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> submitVote(String roundId, String votedPlayerId) async {
    state = const AsyncValue.loading();
    try {
      final vote = await _repository.submitVote(roundId, votedPlayerId);
      state = AsyncValue.data(vote);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final voteNotifierProvider = StateNotifierProvider<VoteNotifier, AsyncValue<Vote?>>((ref) {
  final repository = ref.watch(voteRepositoryProvider);
  return VoteNotifier(repository);
});

// Start round via edge function
Future<void> startRound(String roomId) async {
  await SupabaseService.client.functions.invoke(
    'start-round',
    body: {'room_id': roomId},
  );
}
