// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoteImpl _$$VoteImplFromJson(Map<String, dynamic> json) => _$VoteImpl(
  id: json['id'] as String,
  roundId: json['round_id'] as String,
  voterPlayerId: json['voter_player_id'] as String,
  votedPlayerId: json['voted_player_id'] as String,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$VoteImplToJson(_$VoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'round_id': instance.roundId,
      'voter_player_id': instance.voterPlayerId,
      'voted_player_id': instance.votedPlayerId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
