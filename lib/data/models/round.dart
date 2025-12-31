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
class Round with _$Round {
  const factory Round({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'round_number') required int roundNumber,
    @JsonKey(name: 'word_id') String? wordId,
    @JsonKey(name: 'imposter_player_id') String? imposterPlayerId,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    @Default(RoundState.reveal) RoundState state,
  }) = _Round;

  factory Round.fromJson(Map<String, dynamic> json) => _$RoundFromJson(json);
}
