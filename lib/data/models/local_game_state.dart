import 'package:freezed_annotation/freezed_annotation.dart';
import 'local_player.dart';
import 'local_game_settings.dart';
import 'word.dart';

part 'local_game_state.freezed.dart';
part 'local_game_state.g.dart';

enum LocalGamePhase {
  setup,
  revealing,
  allSet,
  discussion,
  voting,
  results,
  finalResults,
}

@freezed
class LocalGameState with _$LocalGameState {
  const LocalGameState._();

  const factory LocalGameState({
    @Default(LocalGamePhase.setup) LocalGamePhase phase,
    @Default([]) List<LocalPlayer> players,
    @Default(LocalGameSettings()) LocalGameSettings settings,
    String? imposterPlayerId,
    Word? selectedWord,
    @Default(0) int currentPlayerIndex,
    @Default({}) Map<String, String> votes,
    @Default(0) int roundNumber,
    @Default({}) Map<String, int> playerScores,
  }) = _LocalGameState;

  factory LocalGameState.fromJson(Map<String, dynamic> json) =>
      _$LocalGameStateFromJson(json);

  LocalPlayer? get currentPlayer {
    if (currentPlayerIndex >= players.length) return null;
    return players[currentPlayerIndex];
  }

  int get remainingPlayers => players.length - currentPlayerIndex;

  double get progress {
    if (players.isEmpty) return 0;
    return currentPlayerIndex / players.length;
  }

  bool get allPlayersRevealed =>
      players.every((p) => p.hasRevealedCard);

  bool get allPlayersVoted =>
      players.every((p) => p.hasVoted);

  Map<String, int> get voteResults {
    final results = <String, int>{};
    for (final votedId in votes.values) {
      results[votedId] = (results[votedId] ?? 0) + 1;
    }
    return results;
  }

  String? get mostVotedPlayerId {
    if (votes.isEmpty) return null;
    final results = voteResults;
    int maxVotes = 0;
    String? mostVoted;
    bool hasTie = false;

    for (final entry in results.entries) {
      if (entry.value > maxVotes) {
        maxVotes = entry.value;
        mostVoted = entry.key;
        hasTie = false;
      } else if (entry.value == maxVotes) {
        hasTie = true;
      }
    }

    return hasTie ? null : mostVoted;
  }

  bool get isTie => votes.isNotEmpty && mostVotedPlayerId == null;

  bool get groupWins =>
      mostVotedPlayerId != null && mostVotedPlayerId == imposterPlayerId;

  bool get imposterWins => !groupWins;

  bool get isFinalRound => roundNumber >= settings.numberOfRounds;

  List<String> get correctVoters {
    if (imposterPlayerId == null) return [];
    return votes.entries
        .where((e) => e.value == imposterPlayerId)
        .map((e) => e.key)
        .toList();
  }

  List<MapEntry<String, int>> get leaderboard {
    final entries = playerScores.entries.toList();
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries;
  }

  List<String> get winners {
    if (playerScores.isEmpty) return [];
    final maxScore = playerScores.values.fold(0, (max, v) => v > max ? v : max);
    return playerScores.entries
        .where((e) => e.value == maxScore)
        .map((e) => e.key)
        .toList();
  }
}
