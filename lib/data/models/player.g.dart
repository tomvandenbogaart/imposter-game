// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String,
  isReady: json['is_ready'] as bool? ?? false,
  isConnected: json['is_connected'] as bool? ?? true,
  joinedAt: json['joined_at'] == null
      ? null
      : DateTime.parse(json['joined_at'] as String),
);

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'user_id': instance.userId,
      'display_name': instance.displayName,
      'is_ready': instance.isReady,
      'is_connected': instance.isConnected,
      'joined_at': instance.joinedAt?.toIso8601String(),
    };
