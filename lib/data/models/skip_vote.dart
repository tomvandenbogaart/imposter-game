import 'package:freezed_annotation/freezed_annotation.dart';

part 'skip_vote.freezed.dart';
part 'skip_vote.g.dart';

@freezed
class SkipVote with _$SkipVote {
  const factory SkipVote({
    required String id,
    @JsonKey(name: 'round_id') required String roundId,
    @JsonKey(name: 'player_id') required String playerId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _SkipVote;

  factory SkipVote.fromJson(Map<String, dynamic> json) => _$SkipVoteFromJson(json);
}
