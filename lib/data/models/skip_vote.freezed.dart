// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skip_vote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SkipVote _$SkipVoteFromJson(Map<String, dynamic> json) {
  return _SkipVote.fromJson(json);
}

/// @nodoc
mixin _$SkipVote {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'round_id')
  String get roundId => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_id')
  String get playerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SkipVote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SkipVote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SkipVoteCopyWith<SkipVote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkipVoteCopyWith<$Res> {
  factory $SkipVoteCopyWith(SkipVote value, $Res Function(SkipVote) then) =
      _$SkipVoteCopyWithImpl<$Res, SkipVote>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'round_id') String roundId,
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$SkipVoteCopyWithImpl<$Res, $Val extends SkipVote>
    implements $SkipVoteCopyWith<$Res> {
  _$SkipVoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SkipVote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? playerId = null,
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
abstract class _$$SkipVoteImplCopyWith<$Res>
    implements $SkipVoteCopyWith<$Res> {
  factory _$$SkipVoteImplCopyWith(
    _$SkipVoteImpl value,
    $Res Function(_$SkipVoteImpl) then,
  ) = __$$SkipVoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'round_id') String roundId,
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$SkipVoteImplCopyWithImpl<$Res>
    extends _$SkipVoteCopyWithImpl<$Res, _$SkipVoteImpl>
    implements _$$SkipVoteImplCopyWith<$Res> {
  __$$SkipVoteImplCopyWithImpl(
    _$SkipVoteImpl _value,
    $Res Function(_$SkipVoteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SkipVote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? playerId = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$SkipVoteImpl(
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
class _$SkipVoteImpl implements _SkipVote {
  const _$SkipVoteImpl({
    required this.id,
    @JsonKey(name: 'round_id') required this.roundId,
    @JsonKey(name: 'player_id') required this.playerId,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$SkipVoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkipVoteImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'round_id')
  final String roundId;
  @override
  @JsonKey(name: 'player_id')
  final String playerId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SkipVote(id: $id, roundId: $roundId, playerId: $playerId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkipVoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, roundId, playerId, createdAt);

  /// Create a copy of SkipVote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SkipVoteImplCopyWith<_$SkipVoteImpl> get copyWith =>
      __$$SkipVoteImplCopyWithImpl<_$SkipVoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkipVoteImplToJson(this);
  }
}

abstract class _SkipVote implements SkipVote {
  const factory _SkipVote({
    required final String id,
    @JsonKey(name: 'round_id') required final String roundId,
    @JsonKey(name: 'player_id') required final String playerId,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$SkipVoteImpl;

  factory _SkipVote.fromJson(Map<String, dynamic> json) =
      _$SkipVoteImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'round_id')
  String get roundId;
  @override
  @JsonKey(name: 'player_id')
  String get playerId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of SkipVote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SkipVoteImplCopyWith<_$SkipVoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
