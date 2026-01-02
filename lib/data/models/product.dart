import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

enum ProductType {
  @JsonValue('ads')
  ads,
  @JsonValue('packs')
  packs,
  @JsonValue('bundle')
  bundle,
}

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    @JsonKey(name: 'store_product_id') required String storeProductId,
    required ProductType type,
    required String name,
    String? description,
    @JsonKey(name: 'price_cents') required int priceCents,
    @Default('EUR') String currency,
    @Default(true) bool active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

/// Extended product with store pricing info from native store
@freezed
class StoreProduct with _$StoreProduct {
  const factory StoreProduct({
    required Product product,
    required String localizedPrice,
    required String localizedTitle,
    String? localizedDescription,
    required bool isAvailable,
  }) = _StoreProduct;
}
