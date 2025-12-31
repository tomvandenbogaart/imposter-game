// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalGameState _$LocalGameStateFromJson(Map<String, dynamic> json) {
  return _LocalGameState.fromJson(json);
}

/// @nodoc
mixin _$LocalGameState {
  LocalGamePhase get phase => throw _privateConstructorUsedError;
  List<LocalPlayer> get players => throw _privateConstructorUsedError;
  LocalGameSettings get settings => throw _privateConstructorUsedError;
  String? get imposterPlayerId => throw _privateConstructorUsedError;
  Word? get selectedWord => throw _privateConstructorUsedError;
  int get currentPlayerIndex => throw _privateConstructorUsedError;
  Map<String, String> get votes => throw _privateConstructorUsedError;
  int get roundNumber => throw _privateConstructorUsedError;
  Map<String, int> get playerScores => throw _privateConstructorUsedError;

  /// Serializes this LocalGameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalGameStateCopyWith<LocalGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalGameStateCopyWith<$Res> {
  factory $LocalGameStateCopyWith(
    LocalGameState value,
    $Res Function(LocalGameState) then,
  ) = _$LocalGameStateCopyWithImpl<$Res, LocalGameState>;
  @useResult
  $Res call({
    LocalGamePhase phase,
    List<LocalPlayer> players,
    LocalGameSettings settings,
    String? imposterPlayerId,
    Word? selectedWord,
    int currentPlayerIndex,
    Map<String, String> votes,
    int roundNumber,
    Map<String, int> playerScores,
  });

  $LocalGameSettingsCopyWith<$Res> get settings;
  $WordCopyWith<$Res>? get selectedWord;
}

/// @nodoc
class _$LocalGameStateCopyWithImpl<$Res, $Val extends LocalGameState>
    implements $LocalGameStateCopyWith<$Res> {
  _$LocalGameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? players = null,
    Object? settings = null,
    Object? imposterPlayerId = freezed,
    Object? selectedWord = freezed,
    Object? currentPlayerIndex = null,
    Object? votes = null,
    Object? roundNumber = null,
    Object? playerScores = null,
  }) {
    return _then(
      _value.copyWith(
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as LocalGamePhase,
            players: null == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as List<LocalPlayer>,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as LocalGameSettings,
            imposterPlayerId: freezed == imposterPlayerId
                ? _value.imposterPlayerId
                : imposterPlayerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedWord: freezed == selectedWord
                ? _value.selectedWord
                : selectedWord // ignore: cast_nullable_to_non_nullable
                      as Word?,
            currentPlayerIndex: null == currentPlayerIndex
                ? _value.currentPlayerIndex
                : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            votes: null == votes
                ? _value.votes
                : votes // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
            roundNumber: null == roundNumber
                ? _value.roundNumber
                : roundNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            playerScores: null == playerScores
                ? _value.playerScores
                : playerScores // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
          )
          as $Val,
    );
  }

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocalGameSettingsCopyWith<$Res> get settings {
    return $LocalGameSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WordCopyWith<$Res>? get selectedWord {
    if (_value.selectedWord == null) {
      return null;
    }

    return $WordCopyWith<$Res>(_value.selectedWord!, (value) {
      return _then(_value.copyWith(selectedWord: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocalGameStateImplCopyWith<$Res>
    implements $LocalGameStateCopyWith<$Res> {
  factory _$$LocalGameStateImplCopyWith(
    _$LocalGameStateImpl value,
    $Res Function(_$LocalGameStateImpl) then,
  ) = __$$LocalGameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    LocalGamePhase phase,
    List<LocalPlayer> players,
    LocalGameSettings settings,
    String? imposterPlayerId,
    Word? selectedWord,
    int currentPlayerIndex,
    Map<String, String> votes,
    int roundNumber,
    Map<String, int> playerScores,
  });

  @override
  $LocalGameSettingsCopyWith<$Res> get settings;
  @override
  $WordCopyWith<$Res>? get selectedWord;
}

/// @nodoc
class __$$LocalGameStateImplCopyWithImpl<$Res>
    extends _$LocalGameStateCopyWithImpl<$Res, _$LocalGameStateImpl>
    implements _$$LocalGameStateImplCopyWith<$Res> {
  __$$LocalGameStateImplCopyWithImpl(
    _$LocalGameStateImpl _value,
    $Res Function(_$LocalGameStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phase = null,
    Object? players = null,
    Object? settings = null,
    Object? imposterPlayerId = freezed,
    Object? selectedWord = freezed,
    Object? currentPlayerIndex = null,
    Object? votes = null,
    Object? roundNumber = null,
    Object? playerScores = null,
  }) {
    return _then(
      _$LocalGameStateImpl(
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as LocalGamePhase,
        players: null == players
            ? _value._players
            : players // ignore: cast_nullable_to_non_nullable
                  as List<LocalPlayer>,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as LocalGameSettings,
        imposterPlayerId: freezed == imposterPlayerId
            ? _value.imposterPlayerId
            : imposterPlayerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedWord: freezed == selectedWord
            ? _value.selectedWord
            : selectedWord // ignore: cast_nullable_to_non_nullable
                  as Word?,
        currentPlayerIndex: null == currentPlayerIndex
            ? _value.currentPlayerIndex
            : currentPlayerIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        votes: null == votes
            ? _value._votes
            : votes // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
        roundNumber: null == roundNumber
            ? _value.roundNumber
            : roundNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        playerScores: null == playerScores
            ? _value._playerScores
            : playerScores // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalGameStateImpl extends _LocalGameState {
  const _$LocalGameStateImpl({
    this.phase = LocalGamePhase.setup,
    final List<LocalPlayer> players = const [],
    this.settings = const LocalGameSettings(),
    this.imposterPlayerId,
    this.selectedWord,
    this.currentPlayerIndex = 0,
    final Map<String, String> votes = const {},
    this.roundNumber = 0,
    final Map<String, int> playerScores = const {},
  }) : _players = players,
       _votes = votes,
       _playerScores = playerScores,
       super._();

  factory _$LocalGameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalGameStateImplFromJson(json);

  @override
  @JsonKey()
  final LocalGamePhase phase;
  final List<LocalPlayer> _players;
  @override
  @JsonKey()
  List<LocalPlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  @JsonKey()
  final LocalGameSettings settings;
  @override
  final String? imposterPlayerId;
  @override
  final Word? selectedWord;
  @override
  @JsonKey()
  final int currentPlayerIndex;
  final Map<String, String> _votes;
  @override
  @JsonKey()
  Map<String, String> get votes {
    if (_votes is EqualUnmodifiableMapView) return _votes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_votes);
  }

  @override
  @JsonKey()
  final int roundNumber;
  final Map<String, int> _playerScores;
  @override
  @JsonKey()
  Map<String, int> get playerScores {
    if (_playerScores is EqualUnmodifiableMapView) return _playerScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_playerScores);
  }

  @override
  String toString() {
    return 'LocalGameState(phase: $phase, players: $players, settings: $settings, imposterPlayerId: $imposterPlayerId, selectedWord: $selectedWord, currentPlayerIndex: $currentPlayerIndex, votes: $votes, roundNumber: $roundNumber, playerScores: $playerScores)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalGameStateImpl &&
            (identical(other.phase, phase) || other.phase == phase) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.imposterPlayerId, imposterPlayerId) ||
                other.imposterPlayerId == imposterPlayerId) &&
            (identical(other.selectedWord, selectedWord) ||
                other.selectedWord == selectedWord) &&
            (identical(other.currentPlayerIndex, currentPlayerIndex) ||
                other.currentPlayerIndex == currentPlayerIndex) &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            (identical(other.roundNumber, roundNumber) ||
                other.roundNumber == roundNumber) &&
            const DeepCollectionEquality().equals(
              other._playerScores,
              _playerScores,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    phase,
    const DeepCollectionEquality().hash(_players),
    settings,
    imposterPlayerId,
    selectedWord,
    currentPlayerIndex,
    const DeepCollectionEquality().hash(_votes),
    roundNumber,
    const DeepCollectionEquality().hash(_playerScores),
  );

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalGameStateImplCopyWith<_$LocalGameStateImpl> get copyWith =>
      __$$LocalGameStateImplCopyWithImpl<_$LocalGameStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalGameStateImplToJson(this);
  }
}

abstract class _LocalGameState extends LocalGameState {
  const factory _LocalGameState({
    final LocalGamePhase phase,
    final List<LocalPlayer> players,
    final LocalGameSettings settings,
    final String? imposterPlayerId,
    final Word? selectedWord,
    final int currentPlayerIndex,
    final Map<String, String> votes,
    final int roundNumber,
    final Map<String, int> playerScores,
  }) = _$LocalGameStateImpl;
  const _LocalGameState._() : super._();

  factory _LocalGameState.fromJson(Map<String, dynamic> json) =
      _$LocalGameStateImpl.fromJson;

  @override
  LocalGamePhase get phase;
  @override
  List<LocalPlayer> get players;
  @override
  LocalGameSettings get settings;
  @override
  String? get imposterPlayerId;
  @override
  Word? get selectedWord;
  @override
  int get currentPlayerIndex;
  @override
  Map<String, String> get votes;
  @override
  int get roundNumber;
  @override
  Map<String, int> get playerScores;

  /// Create a copy of LocalGameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalGameStateImplCopyWith<_$LocalGameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
