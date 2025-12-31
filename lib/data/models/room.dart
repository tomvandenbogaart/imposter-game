import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

enum RoomStatus {
  @JsonValue('waiting')
  waiting,
  @JsonValue('playing')
  playing,
  @JsonValue('voting')
  voting,
  @JsonValue('results')
  results,
  @JsonValue('finished')
  finished,
}

@freezed
class RoomSettings with _$RoomSettings {
  const factory RoomSettings({
    @Default(120) int roundDuration,
    @Default(3) int minPlayers,
    @Default(10) int maxPlayers,
    String? packId,
  }) = _RoomSettings;

  factory RoomSettings.fromJson(Map<String, dynamic> json) =>
      _$RoomSettingsFromJson(json);
}

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String code,
    @JsonKey(name: 'host_player_id') String? hostPlayerId,
    @Default(RoomStatus.waiting) RoomStatus status,
    @JsonKey(name: 'current_round_id') String? currentRoundId,
    @Default(RoomSettings()) RoomSettings settings,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
