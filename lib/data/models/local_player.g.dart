// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalPlayerImpl _$$LocalPlayerImplFromJson(Map<String, dynamic> json) =>
    _$LocalPlayerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      hasRevealedCard: json['hasRevealedCard'] as bool? ?? false,
      hasVoted: json['hasVoted'] as bool? ?? false,
    );

Map<String, dynamic> _$$LocalPlayerImplToJson(_$LocalPlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hasRevealedCard': instance.hasRevealedCard,
      'hasVoted': instance.hasVoted,
    };
