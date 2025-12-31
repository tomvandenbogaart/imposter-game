// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'round.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Round _$RoundFromJson(Map<String, dynamic> json) {
  return _Round.fromJson(json);
}

/// @nodoc
mixin _$Round {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'room_id')
  String get roomId => throw _privateConstructorUsedError;
  @JsonKey(name: 'round_number')
  int get roundNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_id')
  String? get wordId => throw _privateConstructorUsedError;
  @JsonKey(name: 'imposter_player_id')
  String? get imposterPlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime? get endsAt => throw _privateConstructorUsedError;
  RoundState get state => throw _privateConstructorUsedError;

  /// Serializes this Round to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoundCopyWith<Round> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoundCopyWith<$Res> {
  factory $RoundCopyWith(Round value, $Res Function(Round) then) =
      _$RoundCopyWithImpl<$Res, Round>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'round_number') int roundNumber,
    @JsonKey(name: 'word_id') String? wordId,
    @JsonKey(name: 'imposter_player_id') String? imposterPlayerId,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    RoundState state,
  });
}

/// @nodoc
class _$RoundCopyWithImpl<$Res, $Val extends Round>
    implements $RoundCopyWith<$Res> {
  _$RoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? roundNumber = null,
    Object? wordId = freezed,
    Object? imposterPlayerId = freezed,
    Object? startedAt = freezed,
    Object? endsAt = freezed,
    Object? state = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            roundNumber: null == roundNumber
                ? _value.roundNumber
                : roundNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            wordId: freezed == wordId
                ? _value.wordId
                : wordId // ignore: cast_nullable_to_non_nullable
                      as String?,
            imposterPlayerId: freezed == imposterPlayerId
                ? _value.imposterPlayerId
                : imposterPlayerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as RoundState,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoundImplCopyWith<$Res> implements $RoundCopyWith<$Res> {
  factory _$$RoundImplCopyWith(
    _$RoundImpl value,
    $Res Function(_$RoundImpl) then,
  ) = __$$RoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'room_id') String roomId,
    @JsonKey(name: 'round_number') int roundNumber,
    @JsonKey(name: 'word_id') String? wordId,
    @JsonKey(name: 'imposter_player_id') String? imposterPlayerId,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    RoundState state,
  });
}

/// @nodoc
class __$$RoundImplCopyWithImpl<$Res>
    extends _$RoundCopyWithImpl<$Res, _$RoundImpl>
    implements _$$RoundImplCopyWith<$Res> {
  __$$RoundImplCopyWithImpl(
    _$RoundImpl _value,
    $Res Function(_$RoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? roundNumber = null,
    Object? wordId = freezed,
    Object? imposterPlayerId = freezed,
    Object? startedAt = freezed,
    Object? endsAt = freezed,
    Object? state = null,
  }) {
    return _then(
      _$RoundImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        roundNumber: null == roundNumber
            ? _value.roundNumber
            : roundNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        wordId: freezed == wordId
            ? _value.wordId
            : wordId // ignore: cast_nullable_to_non_nullable
                  as String?,
        imposterPlayerId: freezed == imposterPlayerId
            ? _value.imposterPlayerId
            : imposterPlayerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as RoundState,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoundImpl implements _Round {
  const _$RoundImpl({
    required this.id,
    @JsonKey(name: 'room_id') required this.roomId,
    @JsonKey(name: 'round_number') required this.roundNumber,
    @JsonKey(name: 'word_id') this.wordId,
    @JsonKey(name: 'imposter_player_id') this.imposterPlayerId,
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'ends_at') this.endsAt,
    this.state = RoundState.reveal,
  });

  factory _$RoundImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoundImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'room_id')
  final String roomId;
  @override
  @JsonKey(name: 'round_number')
  final int roundNumber;
  @override
  @JsonKey(name: 'word_id')
  final String? wordId;
  @override
  @JsonKey(name: 'imposter_player_id')
  final String? imposterPlayerId;
  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @override
  @JsonKey(name: 'ends_at')
  final DateTime? endsAt;
  @override
  @JsonKey()
  final RoundState state;

  @override
  String toString() {
    return 'Round(id: $id, roomId: $roomId, roundNumber: $roundNumber, wordId: $wordId, imposterPlayerId: $imposterPlayerId, startedAt: $startedAt, endsAt: $endsAt, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoundImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.imposterPlayerId, imposterPlayerId) ||
                other.imposterPlayerId == imposterPlayerId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    roundNumber,
    wordId,
    imposterPlayerId,
    startedAt,
    endsAt,
    state,
  );

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoundImplCopyWith<_$RoundImpl> get copyWith =>
      __$$RoundImplCopyWithImpl<_$RoundImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoundImplToJson(this);
  }
}

abstract class _Round implements Round {
  const factory _Round({
    required final String id,
    @JsonKey(name: 'room_id') required final String roomId,
    @JsonKey(name: 'round_number') required final int roundNumber,
    @JsonKey(name: 'word_id') final String? wordId,
    @JsonKey(name: 'imposter_player_id') final String? imposterPlayerId,
    @JsonKey(name: 'started_at') final DateTime? startedAt,
    @JsonKey(name: 'ends_at') final DateTime? endsAt,
    final RoundState state,
  }) = _$RoundImpl;

  factory _Round.fromJson(Map<String, dynamic> json) = _$RoundImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'room_id')
  String get roomId;
  @override
  @JsonKey(name: 'round_number')
  int get roundNumber;
  @override
  @JsonKey(name: 'word_id')
  String? get wordId;
  @override
  @JsonKey(name: 'imposter_player_id')
  String? get imposterPlayerId;
  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;
  @override
  @JsonKey(name: 'ends_at')
  DateTime? get endsAt;
  @override
  RoundState get state;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoundImplCopyWith<_$RoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
