// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlayerCard _$PlayerCardFromJson(Map<String, dynamic> json) {
  return _PlayerCard.fromJson(json);
}

/// @nodoc
mixin _$PlayerCard {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'round_id')
  String get roundId => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_id')
  String get playerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'card_type')
  CardType get cardType => throw _privateConstructorUsedError;
  Map<String, dynamic> get payload => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PlayerCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCardCopyWith<PlayerCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCardCopyWith<$Res> {
  factory $PlayerCardCopyWith(
    PlayerCard value,
    $Res Function(PlayerCard) then,
  ) = _$PlayerCardCopyWithImpl<$Res, PlayerCard>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'round_id') String roundId,
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'card_type') CardType cardType,
    Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$PlayerCardCopyWithImpl<$Res, $Val extends PlayerCard>
    implements $PlayerCardCopyWith<$Res> {
  _$PlayerCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? playerId = null,
    Object? cardType = null,
    Object? payload = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roundId: null == roundId
                ? _value.roundId
                : roundId // ignore: cast_nullable_to_non_nullable
                      as String,
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            cardType: null == cardType
                ? _value.cardType
                : cardType // ignore: cast_nullable_to_non_nullable
                      as CardType,
            payload: null == payload
                ? _value.payload
                : payload // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
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
abstract class _$$PlayerCardImplCopyWith<$Res>
    implements $PlayerCardCopyWith<$Res> {
  factory _$$PlayerCardImplCopyWith(
    _$PlayerCardImpl value,
    $Res Function(_$PlayerCardImpl) then,
  ) = __$$PlayerCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'round_id') String roundId,
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'card_type') CardType cardType,
    Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$PlayerCardImplCopyWithImpl<$Res>
    extends _$PlayerCardCopyWithImpl<$Res, _$PlayerCardImpl>
    implements _$$PlayerCardImplCopyWith<$Res> {
  __$$PlayerCardImplCopyWithImpl(
    _$PlayerCardImpl _value,
    $Res Function(_$PlayerCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? playerId = null,
    Object? cardType = null,
    Object? payload = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$PlayerCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roundId: null == roundId
            ? _value.roundId
            : roundId // ignore: cast_nullable_to_non_nullable
                  as String,
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        cardType: null == cardType
            ? _value.cardType
            : cardType // ignore: cast_nullable_to_non_nullable
                  as CardType,
        payload: null == payload
            ? _value._payload
            : payload // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
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
class _$PlayerCardImpl implements _PlayerCard {
  const _$PlayerCardImpl({
    required this.id,
    @JsonKey(name: 'round_id') required this.roundId,
    @JsonKey(name: 'player_id') required this.playerId,
    @JsonKey(name: 'card_type') required this.cardType,
    required final Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') this.createdAt,
  }) : _payload = payload;

  factory _$PlayerCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerCardImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'round_id')
  final String roundId;
  @override
  @JsonKey(name: 'player_id')
  final String playerId;
  @override
  @JsonKey(name: 'card_type')
  final CardType cardType;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PlayerCard(id: $id, roundId: $roundId, playerId: $playerId, cardType: $cardType, payload: $payload, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.cardType, cardType) ||
                other.cardType == cardType) &&
            const DeepCollectionEquality().equals(other._payload, _payload) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roundId,
    playerId,
    cardType,
    const DeepCollectionEquality().hash(_payload),
    createdAt,
  );

  /// Create a copy of PlayerCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerCardImplCopyWith<_$PlayerCardImpl> get copyWith =>
      __$$PlayerCardImplCopyWithImpl<_$PlayerCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerCardImplToJson(this);
  }
}

abstract class _PlayerCard implements PlayerCard {
  const factory _PlayerCard({
    required final String id,
    @JsonKey(name: 'round_id') required final String roundId,
    @JsonKey(name: 'player_id') required final String playerId,
    @JsonKey(name: 'card_type') required final CardType cardType,
    required final Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$PlayerCardImpl;

  factory _PlayerCard.fromJson(Map<String, dynamic> json) =
      _$PlayerCardImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'round_id')
  String get roundId;
  @override
  @JsonKey(name: 'player_id')
  String get playerId;
  @override
  @JsonKey(name: 'card_type')
  CardType get cardType;
  @override
  Map<String, dynamic> get payload;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of PlayerCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerCardImplCopyWith<_$PlayerCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
