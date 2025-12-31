// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomSettingsImpl _$$RoomSettingsImplFromJson(Map<String, dynamic> json) =>
    _$RoomSettingsImpl(
      roundDuration: (json['roundDuration'] as num?)?.toInt() ?? 120,
      minPlayers: (json['minPlayers'] as num?)?.toInt() ?? 3,
      maxPlayers: (json['maxPlayers'] as num?)?.toInt() ?? 10,
      packId: json['packId'] as String?,
    );

Map<String, dynamic> _$$RoomSettingsImplToJson(_$RoomSettingsImpl instance) =>
    <String, dynamic>{
      'roundDuration': instance.roundDuration,
      'minPlayers': instance.minPlayers,
      'maxPlayers': instance.maxPlayers,
      'packId': instance.packId,
    };

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: json['id'] as String,
  code: json['code'] as String,
  hostPlayerId: json['host_player_id'] as String?,
  status:
      $enumDecodeNullable(_$RoomStatusEnumMap, json['status']) ??
      RoomStatus.waiting,
  currentRoundId: json['current_round_id'] as String?,
  settings: json['settings'] == null
      ? const RoomSettings()
      : RoomSettings.fromJson(json['settings'] as Map<String, dynamic>),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'host_player_id': instance.hostPlayerId,
      'status': _$RoomStatusEnumMap[instance.status]!,
      'current_round_id': instance.currentRoundId,
      'settings': instance.settings,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$RoomStatusEnumMap = {
  RoomStatus.waiting: 'waiting',
  RoomStatus.playing: 'playing',
  RoomStatus.voting: 'voting',
  RoomStatus.results: 'results',
  RoomStatus.finished: 'finished',
};
