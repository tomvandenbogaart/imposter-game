// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skip_vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkipVoteImpl _$$SkipVoteImplFromJson(Map<String, dynamic> json) =>
    _$SkipVoteImpl(
      id: json['id'] as String,
      roundId: json['round_id'] as String,
      playerId: json['player_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$SkipVoteImplToJson(_$SkipVoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'round_id': instance.roundId,
      'player_id': instance.playerId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
