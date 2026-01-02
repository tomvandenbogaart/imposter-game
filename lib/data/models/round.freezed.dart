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

VoteResult _$VoteResultFromJson(Map<String, dynamic> json) {
  return _VoteResult.fromJson(json);
}

/// @nodoc
mixin _$VoteResult {
  @JsonKey(name: 'player_id')
  String get playerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_name')
  String get playerName => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_imposter')
  bool get isImposter => throw _privateConstructorUsedError;

  /// Serializes this VoteResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoteResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteResultCopyWith<VoteResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteResultCopyWith<$Res> {
  factory $VoteResultCopyWith(
    VoteResult value,
    $Res Function(VoteResult) then,
  ) = _$VoteResultCopyWithImpl<$Res, VoteResult>;
  @useResult
  $Res call({
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'player_name') String playerName,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'is_imposter') bool isImposter,
  });
}

/// @nodoc
class _$VoteResultCopyWithImpl<$Res, $Val extends VoteResult>
    implements $VoteResultCopyWith<$Res> {
  _$VoteResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? voteCount = null,
    Object? isImposter = null,
  }) {
    return _then(
      _value.copyWith(
            playerId: null == playerId
                ? _value.playerId
                : playerId // ignore: cast_nullable_to_non_nullable
                      as String,
            playerName: null == playerName
                ? _value.playerName
                : playerName // ignore: cast_nullable_to_non_nullable
                      as String,
            voteCount: null == voteCount
                ? _value.voteCount
                : voteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isImposter: null == isImposter
                ? _value.isImposter
                : isImposter // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VoteResultImplCopyWith<$Res>
    implements $VoteResultCopyWith<$Res> {
  factory _$$VoteResultImplCopyWith(
    _$VoteResultImpl value,
    $Res Function(_$VoteResultImpl) then,
  ) = __$$VoteResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'player_id') String playerId,
    @JsonKey(name: 'player_name') String playerName,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'is_imposter') bool isImposter,
  });
}

/// @nodoc
class __$$VoteResultImplCopyWithImpl<$Res>
    extends _$VoteResultCopyWithImpl<$Res, _$VoteResultImpl>
    implements _$$VoteResultImplCopyWith<$Res> {
  __$$VoteResultImplCopyWithImpl(
    _$VoteResultImpl _value,
    $Res Function(_$VoteResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VoteResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? voteCount = null,
    Object? isImposter = null,
  }) {
    return _then(
      _$VoteResultImpl(
        playerId: null == playerId
            ? _value.playerId
            : playerId // ignore: cast_nullable_to_non_nullable
                  as String,
        playerName: null == playerName
            ? _value.playerName
            : playerName // ignore: cast_nullable_to_non_nullable
                  as String,
        voteCount: null == voteCount
            ? _value.voteCount
            : voteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isImposter: null == isImposter
            ? _value.isImposter
            : isImposter // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteResultImpl implements _VoteResult {
  const _$VoteResultImpl({
    @JsonKey(name: 'player_id') required this.playerId,
    @JsonKey(name: 'player_name') required this.playerName,
    @JsonKey(name: 'vote_count') required this.voteCount,
    @JsonKey(name: 'is_imposter') required this.isImposter,
  });

  factory _$VoteResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteResultImplFromJson(json);

  @override
  @JsonKey(name: 'player_id')
  final String playerId;
  @override
  @JsonKey(name: 'player_name')
  final String playerName;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @override
  @JsonKey(name: 'is_imposter')
  final bool isImposter;

  @override
  String toString() {
    return 'VoteResult(playerId: $playerId, playerName: $playerName, voteCount: $voteCount, isImposter: $isImposter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteResultImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.isImposter, isImposter) ||
                other.isImposter == isImposter));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, playerId, playerName, voteCount, isImposter);

  /// Create a copy of VoteResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteResultImplCopyWith<_$VoteResultImpl> get copyWith =>
      __$$VoteResultImplCopyWithImpl<_$VoteResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteResultImplToJson(this);
  }
}

abstract class _VoteResult implements VoteResult {
  const factory _VoteResult({
    @JsonKey(name: 'player_id') required final String playerId,
    @JsonKey(name: 'player_name') required final String playerName,
    @JsonKey(name: 'vote_count') required final int voteCount,
    @JsonKey(name: 'is_imposter') required final bool isImposter,
  }) = _$VoteResultImpl;

  factory _VoteResult.fromJson(Map<String, dynamic> json) =
      _$VoteResultImpl.fromJson;

  @override
  @JsonKey(name: 'player_id')
  String get playerId;
  @override
  @JsonKey(name: 'player_name')
  String get playerName;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  @JsonKey(name: 'is_imposter')
  bool get isImposter;

  /// Create a copy of VoteResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteResultImplCopyWith<_$VoteResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
  @JsonKey(name: 'reveal_ends_at')
  DateTime? get revealEndsAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ends_at')
  DateTime? get endsAt => throw _privateConstructorUsedError;
  RoundState get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_wins')
  bool? get groupWins => throw _privateConstructorUsedError;
  @JsonKey(name: 'most_voted_player_id')
  String? get mostVotedPlayerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'imposter_name')
  String? get imposterName => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_results')
  List<VoteResult>? get voteResults => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'reveal_ends_at') DateTime? revealEndsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    RoundState state,
    @JsonKey(name: 'group_wins') bool? groupWins,
    @JsonKey(name: 'most_voted_player_id') String? mostVotedPlayerId,
    @JsonKey(name: 'imposter_name') String? imposterName,
    @JsonKey(name: 'vote_results') List<VoteResult>? voteResults,
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
    Object? revealEndsAt = freezed,
    Object? endsAt = freezed,
    Object? state = null,
    Object? groupWins = freezed,
    Object? mostVotedPlayerId = freezed,
    Object? imposterName = freezed,
    Object? voteResults = freezed,
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
            revealEndsAt: freezed == revealEndsAt
                ? _value.revealEndsAt
                : revealEndsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endsAt: freezed == endsAt
                ? _value.endsAt
                : endsAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as RoundState,
            groupWins: freezed == groupWins
                ? _value.groupWins
                : groupWins // ignore: cast_nullable_to_non_nullable
                      as bool?,
            mostVotedPlayerId: freezed == mostVotedPlayerId
                ? _value.mostVotedPlayerId
                : mostVotedPlayerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            imposterName: freezed == imposterName
                ? _value.imposterName
                : imposterName // ignore: cast_nullable_to_non_nullable
                      as String?,
            voteResults: freezed == voteResults
                ? _value.voteResults
                : voteResults // ignore: cast_nullable_to_non_nullable
                      as List<VoteResult>?,
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
    @JsonKey(name: 'reveal_ends_at') DateTime? revealEndsAt,
    @JsonKey(name: 'ends_at') DateTime? endsAt,
    RoundState state,
    @JsonKey(name: 'group_wins') bool? groupWins,
    @JsonKey(name: 'most_voted_player_id') String? mostVotedPlayerId,
    @JsonKey(name: 'imposter_name') String? imposterName,
    @JsonKey(name: 'vote_results') List<VoteResult>? voteResults,
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
    Object? revealEndsAt = freezed,
    Object? endsAt = freezed,
    Object? state = null,
    Object? groupWins = freezed,
    Object? mostVotedPlayerId = freezed,
    Object? imposterName = freezed,
    Object? voteResults = freezed,
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
        revealEndsAt: freezed == revealEndsAt
            ? _value.revealEndsAt
            : revealEndsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endsAt: freezed == endsAt
            ? _value.endsAt
            : endsAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as RoundState,
        groupWins: freezed == groupWins
            ? _value.groupWins
            : groupWins // ignore: cast_nullable_to_non_nullable
                  as bool?,
        mostVotedPlayerId: freezed == mostVotedPlayerId
            ? _value.mostVotedPlayerId
            : mostVotedPlayerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        imposterName: freezed == imposterName
            ? _value.imposterName
            : imposterName // ignore: cast_nullable_to_non_nullable
                  as String?,
        voteResults: freezed == voteResults
            ? _value._voteResults
            : voteResults // ignore: cast_nullable_to_non_nullable
                  as List<VoteResult>?,
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
    @JsonKey(name: 'reveal_ends_at') this.revealEndsAt,
    @JsonKey(name: 'ends_at') this.endsAt,
    this.state = RoundState.reveal,
    @JsonKey(name: 'group_wins') this.groupWins,
    @JsonKey(name: 'most_voted_player_id') this.mostVotedPlayerId,
    @JsonKey(name: 'imposter_name') this.imposterName,
    @JsonKey(name: 'vote_results') final List<VoteResult>? voteResults,
  }) : _voteResults = voteResults;

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
  @JsonKey(name: 'reveal_ends_at')
  final DateTime? revealEndsAt;
  @override
  @JsonKey(name: 'ends_at')
  final DateTime? endsAt;
  @override
  @JsonKey()
  final RoundState state;
  @override
  @JsonKey(name: 'group_wins')
  final bool? groupWins;
  @override
  @JsonKey(name: 'most_voted_player_id')
  final String? mostVotedPlayerId;
  @override
  @JsonKey(name: 'imposter_name')
  final String? imposterName;
  final List<VoteResult>? _voteResults;
  @override
  @JsonKey(name: 'vote_results')
  List<VoteResult>? get voteResults {
    final value = _voteResults;
    if (value == null) return null;
    if (_voteResults is EqualUnmodifiableListView) return _voteResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Round(id: $id, roomId: $roomId, roundNumber: $roundNumber, wordId: $wordId, imposterPlayerId: $imposterPlayerId, startedAt: $startedAt, revealEndsAt: $revealEndsAt, endsAt: $endsAt, state: $state, groupWins: $groupWins, mostVotedPlayerId: $mostVotedPlayerId, imposterName: $imposterName, voteResults: $voteResults)';
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
            (identical(other.revealEndsAt, revealEndsAt) ||
                other.revealEndsAt == revealEndsAt) &&
            (identical(other.endsAt, endsAt) || other.endsAt == endsAt) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.groupWins, groupWins) ||
                other.groupWins == groupWins) &&
            (identical(other.mostVotedPlayerId, mostVotedPlayerId) ||
                other.mostVotedPlayerId == mostVotedPlayerId) &&
            (identical(other.imposterName, imposterName) ||
                other.imposterName == imposterName) &&
            const DeepCollectionEquality().equals(
              other._voteResults,
              _voteResults,
            ));
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
    revealEndsAt,
    endsAt,
    state,
    groupWins,
    mostVotedPlayerId,
    imposterName,
    const DeepCollectionEquality().hash(_voteResults),
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
    @JsonKey(name: 'reveal_ends_at') final DateTime? revealEndsAt,
    @JsonKey(name: 'ends_at') final DateTime? endsAt,
    final RoundState state,
    @JsonKey(name: 'group_wins') final bool? groupWins,
    @JsonKey(name: 'most_voted_player_id') final String? mostVotedPlayerId,
    @JsonKey(name: 'imposter_name') final String? imposterName,
    @JsonKey(name: 'vote_results') final List<VoteResult>? voteResults,
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
  @JsonKey(name: 'reveal_ends_at')
  DateTime? get revealEndsAt;
  @override
  @JsonKey(name: 'ends_at')
  DateTime? get endsAt;
  @override
  RoundState get state;
  @override
  @JsonKey(name: 'group_wins')
  bool? get groupWins;
  @override
  @JsonKey(name: 'most_voted_player_id')
  String? get mostVotedPlayerId;
  @override
  @JsonKey(name: 'imposter_name')
  String? get imposterName;
  @override
  @JsonKey(name: 'vote_results')
  List<VoteResult>? get voteResults;

  /// Create a copy of Round
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoundImplCopyWith<_$RoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
