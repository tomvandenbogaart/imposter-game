// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Vote _$VoteFromJson(Map<String, dynamic> json) {
  return _Vote.fromJson(json);
}

/// @nodoc
mixin _$Vote {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'round_id')
  String get roundId => throw _privateConstructorUsedError;
  @JsonKey(name: 'voter_player_id')
  String get voterPlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'voted_player_id')
  String get votedPlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Vote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteCopyWith<Vote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteCopyWith<$Res> {
  factory $VoteCopyWith(Vote value, $Res Function(Vote) then) =
      _$VoteCopyWithImpl<$Res, Vote>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'round_id') String roundId,
    @JsonKey(name: 'voter_player_id') String voterPlayerId,
    @JsonKey(name: 'voted_player_id') String votedPlayerId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$VoteCopyWithImpl<$Res, $Val extends Vote>
    implements $VoteCopyWith<$Res> {
  _$VoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? voterPlayerId = null,
    Object? votedPlayerId = null,
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
            voterPlayerId: null == voterPlayerId
                ? _value.voterPlayerId
                : voterPlayerId // ignore: cast_nullable_to_non_nullable
                      as String,
            votedPlayerId: null == votedPlayerId
                ? _value.votedPlayerId
                : votedPlayerId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$VoteImplCopyWith<$Res> implements $VoteCopyWith<$Res> {
  factory _$$VoteImplCopyWith(
    _$VoteImpl value,
    $Res Function(_$VoteImpl) then,
  ) = __$$VoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'round_id') String roundId,
    @JsonKey(name: 'voter_player_id') String voterPlayerId,
    @JsonKey(name: 'voted_player_id') String votedPlayerId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$VoteImplCopyWithImpl<$Res>
    extends _$VoteCopyWithImpl<$Res, _$VoteImpl>
    implements _$$VoteImplCopyWith<$Res> {
  __$$VoteImplCopyWithImpl(_$VoteImpl _value, $Res Function(_$VoteImpl) _then)
    : super(_value, _then);

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roundId = null,
    Object? voterPlayerId = null,
    Object? votedPlayerId = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$VoteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roundId: null == roundId
            ? _value.roundId
            : roundId // ignore: cast_nullable_to_non_nullable
                  as String,
        voterPlayerId: null == voterPlayerId
            ? _value.voterPlayerId
            : voterPlayerId // ignore: cast_nullable_to_non_nullable
                  as String,
        votedPlayerId: null == votedPlayerId
            ? _value.votedPlayerId
            : votedPlayerId // ignore: cast_nullable_to_non_nullable
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
class _$VoteImpl implements _Vote {
  const _$VoteImpl({
    required this.id,
    @JsonKey(name: 'round_id') required this.roundId,
    @JsonKey(name: 'voter_player_id') required this.voterPlayerId,
    @JsonKey(name: 'voted_player_id') required this.votedPlayerId,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$VoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'round_id')
  final String roundId;
  @override
  @JsonKey(name: 'voter_player_id')
  final String voterPlayerId;
  @override
  @JsonKey(name: 'voted_player_id')
  final String votedPlayerId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Vote(id: $id, roundId: $roundId, voterPlayerId: $voterPlayerId, votedPlayerId: $votedPlayerId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roundId, roundId) || other.roundId == roundId) &&
            (identical(other.voterPlayerId, voterPlayerId) ||
                other.voterPlayerId == voterPlayerId) &&
            (identical(other.votedPlayerId, votedPlayerId) ||
                other.votedPlayerId == votedPlayerId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roundId,
    voterPlayerId,
    votedPlayerId,
    createdAt,
  );

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteImplCopyWith<_$VoteImpl> get copyWith =>
      __$$VoteImplCopyWithImpl<_$VoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteImplToJson(this);
  }
}

abstract class _Vote implements Vote {
  const factory _Vote({
    required final String id,
    @JsonKey(name: 'round_id') required final String roundId,
    @JsonKey(name: 'voter_player_id') required final String voterPlayerId,
    @JsonKey(name: 'voted_player_id') required final String votedPlayerId,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$VoteImpl;

  factory _Vote.fromJson(Map<String, dynamic> json) = _$VoteImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'round_id')
  String get roundId;
  @override
  @JsonKey(name: 'voter_player_id')
  String get voterPlayerId;
  @override
  @JsonKey(name: 'voted_player_id')
  String get votedPlayerId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Vote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteImplCopyWith<_$VoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
