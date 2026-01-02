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
      isPremium: json['is_premium'] as bool? ?? false,
      category: json['category'] as String?,
      iconName: json['icon_name'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
      isSeasonal: json['is_seasonal'] as bool? ?? false,
      availableFrom: json['available_from'] == null
          ? null
          : DateTime.parse(json['available_from'] as String),
      availableUntil: json['available_until'] == null
          ? null
          : DateTime.parse(json['available_until'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$WordPackImplToJson(_$WordPackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'language': instance.language,
      'is_premium': instance.isPremium,
      'category': instance.category,
      'icon_name': instance.iconName,
      'sort_order': instance.sortOrder,
      'is_seasonal': instance.isSeasonal,
      'available_from': instance.availableFrom?.toIso8601String(),
      'available_until': instance.availableUntil?.toIso8601String(),
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
