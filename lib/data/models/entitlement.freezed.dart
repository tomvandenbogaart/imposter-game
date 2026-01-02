// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entitlement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Entitlement _$EntitlementFromJson(Map<String, dynamic> json) {
  return _Entitlement.fromJson(json);
}

/// @nodoc
mixin _$Entitlement {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String get productId => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  @JsonKey(name: 'granted_at')
  DateTime? get grantedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Entitlement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Entitlement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntitlementCopyWith<Entitlement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntitlementCopyWith<$Res> {
  factory $EntitlementCopyWith(
    Entitlement value,
    $Res Function(Entitlement) then,
  ) = _$EntitlementCopyWithImpl<$Res, Entitlement>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'product_id') String productId,
    String source,
    @JsonKey(name: 'granted_at') DateTime? grantedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$EntitlementCopyWithImpl<$Res, $Val extends Entitlement>
    implements $EntitlementCopyWith<$Res> {
  _$EntitlementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Entitlement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? source = null,
    Object? grantedAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            grantedAt: freezed == grantedAt
                ? _value.grantedAt
                : grantedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EntitlementImplCopyWith<$Res>
    implements $EntitlementCopyWith<$Res> {
  factory _$$EntitlementImplCopyWith(
    _$EntitlementImpl value,
    $Res Function(_$EntitlementImpl) then,
  ) = __$$EntitlementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'product_id') String productId,
    String source,
    @JsonKey(name: 'granted_at') DateTime? grantedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$EntitlementImplCopyWithImpl<$Res>
    extends _$EntitlementCopyWithImpl<$Res, _$EntitlementImpl>
    implements _$$EntitlementImplCopyWith<$Res> {
  __$$EntitlementImplCopyWithImpl(
    _$EntitlementImpl _value,
    $Res Function(_$EntitlementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Entitlement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? source = null,
    Object? grantedAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$EntitlementImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        grantedAt: freezed == grantedAt
            ? _value.grantedAt
            : grantedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EntitlementImpl implements _Entitlement {
  const _$EntitlementImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'product_id') required this.productId,
    this.source = 'iap',
    @JsonKey(name: 'granted_at') this.grantedAt,
    @JsonKey(name: 'expires_at') this.expiresAt,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$EntitlementImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntitlementImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'product_id')
  final String productId;
  @override
  @JsonKey()
  final String source;
  @override
  @JsonKey(name: 'granted_at')
  final DateTime? grantedAt;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Entitlement(id: $id, userId: $userId, productId: $productId, source: $source, grantedAt: $grantedAt, expiresAt: $expiresAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntitlementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.grantedAt, grantedAt) ||
                other.grantedAt == grantedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    productId,
    source,
    grantedAt,
    expiresAt,
    createdAt,
  );

  /// Create a copy of Entitlement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntitlementImplCopyWith<_$EntitlementImpl> get copyWith =>
      __$$EntitlementImplCopyWithImpl<_$EntitlementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntitlementImplToJson(this);
  }
}

abstract class _Entitlement implements Entitlement {
  const factory _Entitlement({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'product_id') required final String productId,
    final String source,
    @JsonKey(name: 'granted_at') final DateTime? grantedAt,
    @JsonKey(name: 'expires_at') final DateTime? expiresAt,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$EntitlementImpl;

  factory _Entitlement.fromJson(Map<String, dynamic> json) =
      _$EntitlementImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'product_id')
  String get productId;
  @override
  String get source;
  @override
  @JsonKey(name: 'granted_at')
  DateTime? get grantedAt;
  @override
  @JsonKey(name: 'expires_at')
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Entitlement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntitlementImplCopyWith<_$EntitlementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserEntitlements {
  bool get hasNoAds => throw _privateConstructorUsedError;
  bool get hasAllPacks => throw _privateConstructorUsedError;
  List<Entitlement> get rawEntitlements => throw _privateConstructorUsedError;

  /// Create a copy of UserEntitlements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserEntitlementsCopyWith<UserEntitlements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntitlementsCopyWith<$Res> {
  factory $UserEntitlementsCopyWith(
    UserEntitlements value,
    $Res Function(UserEntitlements) then,
  ) = _$UserEntitlementsCopyWithImpl<$Res, UserEntitlements>;
  @useResult
  $Res call({
    bool hasNoAds,
    bool hasAllPacks,
    List<Entitlement> rawEntitlements,
  });
}

/// @nodoc
class _$UserEntitlementsCopyWithImpl<$Res, $Val extends UserEntitlements>
    implements $UserEntitlementsCopyWith<$Res> {
  _$UserEntitlementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEntitlements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasNoAds = null,
    Object? hasAllPacks = null,
    Object? rawEntitlements = null,
  }) {
    return _then(
      _value.copyWith(
            hasNoAds: null == hasNoAds
                ? _value.hasNoAds
                : hasNoAds // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasAllPacks: null == hasAllPacks
                ? _value.hasAllPacks
                : hasAllPacks // ignore: cast_nullable_to_non_nullable
                      as bool,
            rawEntitlements: null == rawEntitlements
                ? _value.rawEntitlements
                : rawEntitlements // ignore: cast_nullable_to_non_nullable
                      as List<Entitlement>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserEntitlementsImplCopyWith<$Res>
    implements $UserEntitlementsCopyWith<$Res> {
  factory _$$UserEntitlementsImplCopyWith(
    _$UserEntitlementsImpl value,
    $Res Function(_$UserEntitlementsImpl) then,
  ) = __$$UserEntitlementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool hasNoAds,
    bool hasAllPacks,
    List<Entitlement> rawEntitlements,
  });
}

/// @nodoc
class __$$UserEntitlementsImplCopyWithImpl<$Res>
    extends _$UserEntitlementsCopyWithImpl<$Res, _$UserEntitlementsImpl>
    implements _$$UserEntitlementsImplCopyWith<$Res> {
  __$$UserEntitlementsImplCopyWithImpl(
    _$UserEntitlementsImpl _value,
    $Res Function(_$UserEntitlementsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserEntitlements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasNoAds = null,
    Object? hasAllPacks = null,
    Object? rawEntitlements = null,
  }) {
    return _then(
      _$UserEntitlementsImpl(
        hasNoAds: null == hasNoAds
            ? _value.hasNoAds
            : hasNoAds // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasAllPacks: null == hasAllPacks
            ? _value.hasAllPacks
            : hasAllPacks // ignore: cast_nullable_to_non_nullable
                  as bool,
        rawEntitlements: null == rawEntitlements
            ? _value._rawEntitlements
            : rawEntitlements // ignore: cast_nullable_to_non_nullable
                  as List<Entitlement>,
      ),
    );
  }
}

/// @nodoc

class _$UserEntitlementsImpl extends _UserEntitlements {
  const _$UserEntitlementsImpl({
    this.hasNoAds = false,
    this.hasAllPacks = false,
    final List<Entitlement> rawEntitlements = const [],
  }) : _rawEntitlements = rawEntitlements,
       super._();

  @override
  @JsonKey()
  final bool hasNoAds;
  @override
  @JsonKey()
  final bool hasAllPacks;
  final List<Entitlement> _rawEntitlements;
  @override
  @JsonKey()
  List<Entitlement> get rawEntitlements {
    if (_rawEntitlements is EqualUnmodifiableListView) return _rawEntitlements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rawEntitlements);
  }

  @override
  String toString() {
    return 'UserEntitlements(hasNoAds: $hasNoAds, hasAllPacks: $hasAllPacks, rawEntitlements: $rawEntitlements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEntitlementsImpl &&
            (identical(other.hasNoAds, hasNoAds) ||
                other.hasNoAds == hasNoAds) &&
            (identical(other.hasAllPacks, hasAllPacks) ||
                other.hasAllPacks == hasAllPacks) &&
            const DeepCollectionEquality().equals(
              other._rawEntitlements,
              _rawEntitlements,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    hasNoAds,
    hasAllPacks,
    const DeepCollectionEquality().hash(_rawEntitlements),
  );

  /// Create a copy of UserEntitlements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEntitlementsImplCopyWith<_$UserEntitlementsImpl> get copyWith =>
      __$$UserEntitlementsImplCopyWithImpl<_$UserEntitlementsImpl>(
        this,
        _$identity,
      );
}

abstract class _UserEntitlements extends UserEntitlements {
  const factory _UserEntitlements({
    final bool hasNoAds,
    final bool hasAllPacks,
    final List<Entitlement> rawEntitlements,
  }) = _$UserEntitlementsImpl;
  const _UserEntitlements._() : super._();

  @override
  bool get hasNoAds;
  @override
  bool get hasAllPacks;
  @override
  List<Entitlement> get rawEntitlements;

  /// Create a copy of UserEntitlements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserEntitlementsImplCopyWith<_$UserEntitlementsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
