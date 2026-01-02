// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PurchaseState {
  AppPurchaseStatus get status => throw _privateConstructorUsedError;
  String? get currentProductId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int get restoredCount => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseStateCopyWith<PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseStateCopyWith<$Res> {
  factory $PurchaseStateCopyWith(
    PurchaseState value,
    $Res Function(PurchaseState) then,
  ) = _$PurchaseStateCopyWithImpl<$Res, PurchaseState>;
  @useResult
  $Res call({
    AppPurchaseStatus status,
    String? currentProductId,
    String? errorMessage,
    int restoredCount,
  });
}

/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res, $Val extends PurchaseState>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentProductId = freezed,
    Object? errorMessage = freezed,
    Object? restoredCount = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AppPurchaseStatus,
            currentProductId: freezed == currentProductId
                ? _value.currentProductId
                : currentProductId // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            restoredCount: null == restoredCount
                ? _value.restoredCount
                : restoredCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchaseStateImplCopyWith<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  factory _$$PurchaseStateImplCopyWith(
    _$PurchaseStateImpl value,
    $Res Function(_$PurchaseStateImpl) then,
  ) = __$$PurchaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AppPurchaseStatus status,
    String? currentProductId,
    String? errorMessage,
    int restoredCount,
  });
}

/// @nodoc
class __$$PurchaseStateImplCopyWithImpl<$Res>
    extends _$PurchaseStateCopyWithImpl<$Res, _$PurchaseStateImpl>
    implements _$$PurchaseStateImplCopyWith<$Res> {
  __$$PurchaseStateImplCopyWithImpl(
    _$PurchaseStateImpl _value,
    $Res Function(_$PurchaseStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentProductId = freezed,
    Object? errorMessage = freezed,
    Object? restoredCount = null,
  }) {
    return _then(
      _$PurchaseStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AppPurchaseStatus,
        currentProductId: freezed == currentProductId
            ? _value.currentProductId
            : currentProductId // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        restoredCount: null == restoredCount
            ? _value.restoredCount
            : restoredCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$PurchaseStateImpl implements _PurchaseState {
  const _$PurchaseStateImpl({
    this.status = AppPurchaseStatus.idle,
    this.currentProductId,
    this.errorMessage,
    this.restoredCount = 0,
  });

  @override
  @JsonKey()
  final AppPurchaseStatus status;
  @override
  final String? currentProductId;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final int restoredCount;

  @override
  String toString() {
    return 'PurchaseState(status: $status, currentProductId: $currentProductId, errorMessage: $errorMessage, restoredCount: $restoredCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentProductId, currentProductId) ||
                other.currentProductId == currentProductId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.restoredCount, restoredCount) ||
                other.restoredCount == restoredCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    currentProductId,
    errorMessage,
    restoredCount,
  );

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseStateImplCopyWith<_$PurchaseStateImpl> get copyWith =>
      __$$PurchaseStateImplCopyWithImpl<_$PurchaseStateImpl>(this, _$identity);
}

abstract class _PurchaseState implements PurchaseState {
  const factory _PurchaseState({
    final AppPurchaseStatus status,
    final String? currentProductId,
    final String? errorMessage,
    final int restoredCount,
  }) = _$PurchaseStateImpl;

  @override
  AppPurchaseStatus get status;
  @override
  String? get currentProductId;
  @override
  String? get errorMessage;
  @override
  int get restoredCount;

  /// Create a copy of PurchaseState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseStateImplCopyWith<_$PurchaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
