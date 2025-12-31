import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote.freezed.dart';
part 'vote.g.dart';

@freezed
class Vote with _$Vote {
  const factory Vote({
    required String id,
    @JsonKey(name: 'round_id') required String roundId,
    @JsonKey(name: 'voter_player_id') required String voterPlayerId,
    @JsonKey(name: 'voted_player_id') required String votedPlayerId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Vote;

  factory Vote.fromJson(Map<String, dynamic> json) => _$VoteFromJson(json);
}
