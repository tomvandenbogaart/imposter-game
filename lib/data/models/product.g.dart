// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      storeProductId: json['store_product_id'] as String,
      type: $enumDecode(_$ProductTypeEnumMap, json['type']),
      name: json['name'] as String,
      description: json['description'] as String?,
      priceCents: (json['price_cents'] as num).toInt(),
      currency: json['currency'] as String? ?? 'EUR',
      active: json['active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_product_id': instance.storeProductId,
      'type': _$ProductTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'price_cents': instance.priceCents,
      'currency': instance.currency,
      'active': instance.active,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ProductTypeEnumMap = {
  ProductType.ads: 'ads',
  ProductType.packs: 'packs',
  ProductType.bundle: 'bundle',
};
