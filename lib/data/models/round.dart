import 'package:freezed_annotation/freezed_annotation.dart';

part 'round.freezed.dart';
part 'round.g.dart';

enum RoundState {
  @JsonValue('reveal')
  reveal,
  @JsonValue('discussion')
  discussion,
  @JsonValue('voting')
  voting,
  @JsonValue('results')
  results,
}

@freezed
class VoteResult with _$VoteResult {
  const factory VoteResult({
    @JsonKey(name: 'player_id') required String playerId,
    @JsonKey(name: 'player_name') required String playerName,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'is_imposter') required bool isImposter,
  }) = _VoteResult;

  factory VoteResult.fromJson(Map<String, dynamic> json) =>
      _$VoteResultFromJson(json);
}

@freezed
class Round with _$Round {
  const factory Round({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'round_number') required int roundNumber,
    @JsonKey(name: 'word_id') String? wordId,
    @JsonKey(name: 'imposter_player_id') String? imposterPlayerId,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'reveal_ends_at') DateTime? revealEndsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @Default(RoundState.reveal) RoundState state,
    @JsonKey(name: 'group_wins') bool? groupWins,
    @JsonKey(name: 'most_voted_player_id') String? mostVotedPlayerId,
    @JsonKey(name: 'imposter_name') String? imposterName,
    @JsonKey(name: 'vote_results') List<VoteResult>? voteResults,
  }) = _Round;

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);
}
