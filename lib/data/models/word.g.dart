// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordPackImpl _$$WordPackImplFromJson(Map<String, dynamic> json) =>
    _$WordPackImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      language: json['language'] as String? ?? 'en',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$WordPackImplToJson(_$WordPackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'language': instance.language,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$WordImpl _$$WordImplFromJson(Map<String, dynamic> json) => _$WordImpl(
  id: json['id'] as String,
  packId: json['pack_id'] as String,
  word: json['word'] as String,
  hint: json['hint'] as String?,
  difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$WordImplToJson(_$WordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pack_id': instance.packId,
      'word': instance.word,
      'hint': instance.hint,
      'difficulty': instance.difficulty,
    };
