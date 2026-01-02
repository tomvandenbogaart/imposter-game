// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoteResultImpl _$$VoteResultImplFromJson(Map<String, dynamic> json) =>
    _$VoteResultImpl(
      playerId: json['player_id'] as String,
      playerName: json['player_name'] as String,
      voteCount: (json['vote_count'] as num).toInt(),
      isImposter: json['is_imposter'] as bool,
    );

Map<String, dynamic> _$$VoteResultImplToJson(_$VoteResultImpl instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'player_name': instance.playerName,
      'vote_count': instance.voteCount,
      'is_imposter': instance.isImposter,
    };

_$RoundImpl _$$RoundImplFromJson(Map<String, dynamic> json) => _$RoundImpl(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  roundNumber: (json['round_number'] as num).toInt(),
  wordId: json['word_id'] as String?,
  imposterPlayerId: json['imposter_player_id'] as String?,
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  revealEndsAt: json['reveal_ends_at'] == null
      ? null
      : DateTime.parse(json['reveal_ends_at'] as String),
  endsAt: json['ends_at'] == null
      ? null
      : DateTime.parse(json['ends_at'] as String),
  state:
      $enumDecodeNullable(_$RoundStateEnumMap, json['state']) ??
      RoundState.reveal,
  groupWins: json['group_wins'] as bool?,
  mostVotedPlayerId: json['most_voted_player_id'] as String?,
  imposterName: json['imposter_name'] as String?,
  voteResults: (json['vote_results'] as List<dynamic>?)
      ?.map((e) => VoteResult.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$RoundImplToJson(_$RoundImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'round_number': instance.roundNumber,
      'word_id': instance.wordId,
      'imposter_player_id': instance.imposterPlayerId,
      'started_at': instance.startedAt?.toIso8601String(),
      'reveal_ends_at': instance.revealEndsAt?.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'state': _$RoundStateEnumMap[instance.state]!,
      'group_wins': instance.groupWins,
      'most_voted_player_id': instance.mostVotedPlayerId,
      'imposter_name': instance.imposterName,
      'vote_results': instance.voteResults,
    };

const _$RoundStateEnumMap = {
  RoundState.reveal: 'reveal',
  RoundState.discussion: 'discussion',
  RoundState.voting: 'voting',
  RoundState.results: 'results',
};
