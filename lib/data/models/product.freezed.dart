// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'store_product_id')
  String get storeProductId => throw _privateConstructorUsedError;
  ProductType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int get priceCents => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'store_product_id') String storeProductId,
    ProductType type,
    String name,
    String? description,
    @JsonKey(name: 'price_cents') int priceCents,
    String currency,
    bool active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeProductId = null,
    Object? type = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceCents = null,
    Object? currency = null,
    Object? active = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            storeProductId: null == storeProductId
                ? _value.storeProductId
                : storeProductId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as ProductType,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            priceCents: null == priceCents
                ? _value.priceCents
                : priceCents // ignore: cast_nullable_to_non_nullable
                      as int,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            active: null == active
                ? _value.active
                : active // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
    _$ProductImpl value,
    $Res Function(_$ProductImpl) then,
  ) = __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'store_product_id') String storeProductId,
    ProductType type,
    String name,
    String? description,
    @JsonKey(name: 'price_cents') int priceCents,
    String currency,
    bool active,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
    _$ProductImpl _value,
    $Res Function(_$ProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeProductId = null,
    Object? type = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceCents = null,
    Object? currency = null,
    Object? active = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ProductImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        storeProductId: null == storeProductId
            ? _value.storeProductId
            : storeProductId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as ProductType,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        priceCents: null == priceCents
            ? _value.priceCents
            : priceCents // ignore: cast_nullable_to_non_nullable
                  as int,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        active: null == active
            ? _value.active
            : active // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl({
    required this.id,
    @JsonKey(name: 'store_product_id') required this.storeProductId,
    required this.type,
    required this.name,
    this.description,
    @JsonKey(name: 'price_cents') required this.priceCents,
    this.currency = 'EUR',
    this.active = true,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
  });

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'store_product_id')
  final String storeProductId;
  @override
  final ProductType type;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'price_cents')
  final int priceCents;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final bool active;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Product(id: $id, storeProductId: $storeProductId, type: $type, name: $name, description: $description, priceCents: $priceCents, currency: $currency, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeProductId, storeProductId) ||
                other.storeProductId == storeProductId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceCents, priceCents) ||
                other.priceCents == priceCents) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    storeProductId,
    type,
    name,
    description,
    priceCents,
    currency,
    active,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(this);
  }
}

abstract class _Product implements Product {
  const factory _Product({
    required final String id,
    @JsonKey(name: 'store_product_id') required final String storeProductId,
    required final ProductType type,
    required final String name,
    final String? description,
    @JsonKey(name: 'price_cents') required final int priceCents,
    final String currency,
    final bool active,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'store_product_id')
  String get storeProductId;
  @override
  ProductType get type;
  @override
  String get name;
  @override
  String? get description;
  @override
  @JsonKey(name: 'price_cents')
  int get priceCents;
  @override
  String get currency;
  @override
  bool get active;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of Product
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StoreProduct {
  Product get product => throw _privateConstructorUsedError;
  String get localizedPrice => throw _privateConstructorUsedError;
  String get localizedTitle => throw _privateConstructorUsedError;
  String? get localizedDescription => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoreProductCopyWith<StoreProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoreProductCopyWith<$Res> {
  factory $StoreProductCopyWith(
    StoreProduct value,
    $Res Function(StoreProduct) then,
  ) = _$StoreProductCopyWithImpl<$Res, StoreProduct>;
  @useResult
  $Res call({
    Product product,
    String localizedPrice,
    String localizedTitle,
    String? localizedDescription,
    bool isAvailable,
  });

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$StoreProductCopyWithImpl<$Res, $Val extends StoreProduct>
    implements $StoreProductCopyWith<$Res> {
  _$StoreProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? localizedPrice = null,
    Object? localizedTitle = null,
    Object? localizedDescription = freezed,
    Object? isAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            product: null == product
                ? _value.product
                : product // ignore: cast_nullable_to_non_nullable
                      as Product,
            localizedPrice: null == localizedPrice
                ? _value.localizedPrice
                : localizedPrice // ignore: cast_nullable_to_non_nullable
                      as String,
            localizedTitle: null == localizedTitle
                ? _value.localizedTitle
                : localizedTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            localizedDescription: freezed == localizedDescription
                ? _value.localizedDescription
                : localizedDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoreProductImplCopyWith<$Res>
    implements $StoreProductCopyWith<$Res> {
  factory _$$StoreProductImplCopyWith(
    _$StoreProductImpl value,
    $Res Function(_$StoreProductImpl) then,
  ) = __$$StoreProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Product product,
    String localizedPrice,
    String localizedTitle,
    String? localizedDescription,
    bool isAvailable,
  });

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$StoreProductImplCopyWithImpl<$Res>
    extends _$StoreProductCopyWithImpl<$Res, _$StoreProductImpl>
    implements _$$StoreProductImplCopyWith<$Res> {
  __$$StoreProductImplCopyWithImpl(
    _$StoreProductImpl _value,
    $Res Function(_$StoreProductImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? localizedPrice = null,
    Object? localizedTitle = null,
    Object? localizedDescription = freezed,
    Object? isAvailable = null,
  }) {
    return _then(
      _$StoreProductImpl(
        product: null == product
            ? _value.product
            : product // ignore: cast_nullable_to_non_nullable
                  as Product,
        localizedPrice: null == localizedPrice
            ? _value.localizedPrice
            : localizedPrice // ignore: cast_nullable_to_non_nullable
                  as String,
        localizedTitle: null == localizedTitle
            ? _value.localizedTitle
            : localizedTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        localizedDescription: freezed == localizedDescription
            ? _value.localizedDescription
            : localizedDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$StoreProductImpl implements _StoreProduct {
  const _$StoreProductImpl({
    required this.product,
    required this.localizedPrice,
    required this.localizedTitle,
    this.localizedDescription,
    required this.isAvailable,
  });

  @override
  final Product product;
  @override
  final String localizedPrice;
  @override
  final String localizedTitle;
  @override
  final String? localizedDescription;
  @override
  final bool isAvailable;

  @override
  String toString() {
    return 'StoreProduct(product: $product, localizedPrice: $localizedPrice, localizedTitle: $localizedTitle, localizedDescription: $localizedDescription, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoreProductImpl &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.localizedPrice, localizedPrice) ||
                other.localizedPrice == localizedPrice) &&
            (identical(other.localizedTitle, localizedTitle) ||
                other.localizedTitle == localizedTitle) &&
            (identical(other.localizedDescription, localizedDescription) ||
                other.localizedDescription == localizedDescription) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    product,
    localizedPrice,
    localizedTitle,
    localizedDescription,
    isAvailable,
  );

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoreProductImplCopyWith<_$StoreProductImpl> get copyWith =>
      __$$StoreProductImplCopyWithImpl<_$StoreProductImpl>(this, _$identity);
}

abstract class _StoreProduct implements StoreProduct {
  const factory _StoreProduct({
    required final Product product,
    required final String localizedPrice,
    required final String localizedTitle,
    final String? localizedDescription,
    required final bool isAvailable,
  }) = _$StoreProductImpl;

  @override
  Product get product;
  @override
  String get localizedPrice;
  @override
  String get localizedTitle;
  @override
  String? get localizedDescription;
  @override
  bool get isAvailable;

  /// Create a copy of StoreProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoreProductImplCopyWith<_$StoreProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
