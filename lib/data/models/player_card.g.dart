// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerCardImpl _$$PlayerCardImplFromJson(Map<String, dynamic> json) =>
    _$PlayerCardImpl(
      id: json['id'] as String,
      roundId: json['round_id'] as String,
      playerId: json['player_id'] as String,
      cardType: $enumDecode(_$CardTypeEnumMap, json['card_type']),
      payload: json['payload'] as Map<String, dynamic>,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$PlayerCardImplToJson(_$PlayerCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'round_id': instance.roundId,
      'player_id': instance.playerId,
      'card_type': _$CardTypeEnumMap[instance.cardType]!,
      'payload': instance.payload,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$CardTypeEnumMap = {
  CardType.word: 'word',
  CardType.imposter: 'imposter',
};
