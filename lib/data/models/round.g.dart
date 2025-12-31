// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoundImpl _$$RoundImplFromJson(Map<String, dynamic> json) => _$RoundImpl(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  roundNumber: (json['round_number'] as num).toInt(),
  wordId: json['word_id'] as String?,
  imposterPlayerId: json['imposter_player_id'] as String?,
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  endsAt: json['ends_at'] == null
      ? null
      : DateTime.parse(json['ends_at'] as String),
  state:
      $enumDecodeNullable(_$RoundStateEnumMap, json['state']) ??
      RoundState.reveal,
);

Map<String, dynamic> _$$RoundImplToJson(_$RoundImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'round_number': instance.roundNumber,
      'word_id': instance.wordId,
      'imposter_player_id': instance.imposterPlayerId,
      'started_at': instance.startedAt?.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'state': _$RoundStateEnumMap[instance.state]!,
    };

const _$RoundStateEnumMap = {
  RoundState.reveal: 'reveal',
  RoundState.discussion: 'discussion',
  RoundState.voting: 'voting',
  RoundState.results: 'results',
};
