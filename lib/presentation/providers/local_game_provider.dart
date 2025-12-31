import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/models.dart';
import '../../data/repositories/word_repository.dart';
import 'word_pack_provider.dart';

const _uuid = Uuid();

class LocalGameNotifier extends StateNotifier<LocalGameState> {
  final WordRepository _wordRepository;

  LocalGameNotifier(this._wordRepository) : super(const LocalGameState());

  // Player management
  void addPlayer(String name) {
    if (state.players.length >= 12) return;
    final player = LocalPlayer(
      id: _uuid.v4(),
      name: name.trim(),
    );
    state = state.copyWith(players: [...state.players, player]);
  }

  void removePlayer(String playerId) {
    if (state.players.length <= 3) return;
    state = state.copyWith(
      players: state.players.where((p) => p.id != playerId).toList(),
    );
  }

  void updatePlayerName(String playerId, String name) {
    state = state.copyWith(
      players: state.players.map((p) {
        if (p.id == playerId) {
          return p.copyWith(name: name.trim());
        }
        return p;
      }).toList(),
    );
  }

  void reorderPlayers(int oldIndex, int newIndex) {
    final players = List<LocalPlayer>.from(state.players);
    if (newIndex > oldIndex) newIndex--;
    final player = players.removeAt(oldIndex);
    players.insert(newIndex, player);
    state = state.copyWith(players: players);
  }

  // Settings
  void updateSettings(LocalGameSettings settings) {
    state = state.copyWith(settings: settings);
  }

  void setTimerDuration(int seconds) {
    state = state.copyWith(
      settings: state.settings.copyWith(timerDuration: seconds),
    );
  }

  void setSelectedPack(String? packId) {
    state = state.copyWith(
      settings: state.settings.copyWith(selectedPackId: packId),
    );
  }

  void setRevealProtection(bool enabled) {
    state = state.copyWith(
      settings: state.settings.copyWith(revealProtection: enabled),
    );
  }

  void setHapticFeedback(bool enabled) {
    state = state.copyWith(
      settings: state.settings.copyWith(hapticFeedback: enabled),
    );
  }

  void setAllowPause(bool enabled) {
    state = state.copyWith(
      settings: state.settings.copyWith(allowPause: enabled),
    );
  }

  void setNumberOfRounds(int rounds) {
    final clampedRounds = rounds.clamp(1, 5);
    state = state.copyWith(
      settings: state.settings.copyWith(numberOfRounds: clampedRounds),
    );
  }

  // Game flow
  Future<bool> startRound() async {
    if (state.players.length < 3) return false;

    // Get a random word from the selected pack
    final word = await _wordRepository.getRandomWord(
      packId: state.settings.selectedPackId,
    );

    if (word == null) return false;

    // Select a random imposter
    final random = Random();
    final imposterIndex = random.nextInt(state.players.length);
    final imposterId = state.players[imposterIndex].id;

    // Reset player states
    final resetPlayers = state.players.map((p) {
      return p.copyWith(hasRevealedCard: false, hasVoted: false);
    }).toList();

    // Initialize scores for all players on first round
    final isFirstRound = state.roundNumber == 0;
    final scores = isFirstRound
        ? Map<String, int>.fromEntries(
            state.players.map((p) => MapEntry(p.id, 0)))
        : state.playerScores;

    state = state.copyWith(
      phase: LocalGamePhase.revealing,
      players: resetPlayers,
      imposterPlayerId: imposterId,
      selectedWord: word,
      currentPlayerIndex: 0,
      votes: {},
      roundNumber: state.roundNumber + 1,
      playerScores: scores,
    );

    return true;
  }

  void advanceToNextPlayer() {
    state = state.copyWith(currentPlayerIndex: state.currentPlayerIndex + 1);
  }

  void markCurrentPlayerRevealed() {
    final currentPlayer = state.currentPlayer;
    if (currentPlayer == null) return;

    state = state.copyWith(
      players: state.players.map((p) {
        if (p.id == currentPlayer.id) {
          return p.copyWith(hasRevealedCard: true);
        }
        return p;
      }).toList(),
    );
  }

  void goToAllSet() {
    state = state.copyWith(phase: LocalGamePhase.allSet);
  }

  void startDiscussion() {
    state = state.copyWith(phase: LocalGamePhase.discussion);
  }

  void startVoting() {
    state = state.copyWith(
      phase: LocalGamePhase.voting,
      currentPlayerIndex: 0,
    );
  }

  void submitVote(String voterId, String votedForId) {
    final currentPlayer = state.currentPlayer;
    if (currentPlayer == null || currentPlayer.id != voterId) return;

    // Record the vote
    final newVotes = Map<String, String>.from(state.votes);
    newVotes[voterId] = votedForId;

    // Mark player as voted
    final updatedPlayers = state.players.map((p) {
      if (p.id == voterId) {
        return p.copyWith(hasVoted: true);
      }
      return p;
    }).toList();

    state = state.copyWith(
      votes: newVotes,
      players: updatedPlayers,
    );
  }

  void calculateRoundScores() {
    final correctVoters = state.correctVoters;
    final newScores = Map<String, int>.from(state.playerScores);

    // Award +1 point for each player who correctly voted for the imposter
    for (final voterId in correctVoters) {
      newScores[voterId] = (newScores[voterId] ?? 0) + 1;
    }

    state = state.copyWith(playerScores: newScores);
  }

  void showResults() {
    // Calculate scores before showing results
    calculateRoundScores();
    state = state.copyWith(phase: LocalGamePhase.results);
  }

  void showFinalResults() {
    state = state.copyWith(phase: LocalGamePhase.finalResults);
  }

  void continueToNextRound() {
    // Reset for next round but keep scores
    final resetPlayers = state.players.map((p) {
      return p.copyWith(hasRevealedCard: false, hasVoted: false);
    }).toList();

    state = state.copyWith(
      phase: LocalGamePhase.setup,
      players: resetPlayers,
      imposterPlayerId: null,
      selectedWord: null,
      currentPlayerIndex: 0,
      votes: {},
      // Keep: roundNumber, playerScores, settings
    );
  }

  void resetForNextRound() {
    // Keep players and settings, reset game state completely (new game)
    final resetPlayers = state.players.map((p) {
      return p.copyWith(hasRevealedCard: false, hasVoted: false);
    }).toList();

    state = state.copyWith(
      phase: LocalGamePhase.setup,
      players: resetPlayers,
      imposterPlayerId: null,
      selectedWord: null,
      currentPlayerIndex: 0,
      votes: {},
      roundNumber: 0,
      playerScores: {},
    );
  }

  void resetAll() {
    state = const LocalGameState();
  }

  // Card access
  bool isImposter(String playerId) {
    return playerId == state.imposterPlayerId;
  }

  String? getWordForPlayer(String playerId) {
    if (isImposter(playerId)) return null;
    return state.selectedWord?.word;
  }

  String? getHintForPlayer(String playerId) {
    if (!isImposter(playerId)) return null;
    return state.selectedWord?.hint;
  }

  // Initialize with default players
  void initializeDefaultPlayers(int count) {
    final players = List.generate(count, (i) {
      return LocalPlayer(
        id: _uuid.v4(),
        name: 'Player ${i + 1}',
      );
    });
    state = state.copyWith(players: players);
  }
}

final localGameProvider =
    StateNotifierProvider<LocalGameNotifier, LocalGameState>((ref) {
  final wordRepo = ref.watch(wordRepositoryProvider);
  return LocalGameNotifier(wordRepo);
});

// Derived providers
final currentLocalPlayerProvider = Provider<LocalPlayer?>((ref) {
  final state = ref.watch(localGameProvider);
  return state.currentPlayer;
});

final localGameProgressProvider = Provider<double>((ref) {
  final state = ref.watch(localGameProvider);
  return state.progress;
});

final remainingLocalPlayersProvider = Provider<int>((ref) {
  final state = ref.watch(localGameProvider);
  return state.remainingPlayers;
});

final localGamePhaseProvider = Provider<LocalGamePhase>((ref) {
  final state = ref.watch(localGameProvider);
  return state.phase;
});

final localVoteResultsProvider = Provider<Map<String, int>>((ref) {
  final state = ref.watch(localGameProvider);
  return state.voteResults;
});

final localGameWinnerProvider = Provider<bool>((ref) {
  final state = ref.watch(localGameProvider);
  return state.groupWins;
});
