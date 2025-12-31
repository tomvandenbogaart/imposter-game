// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomSettings _$RoomSettingsFromJson(Map<String, dynamic> json) {
  return _RoomSettings.fromJson(json);
}

/// @nodoc
mixin _$RoomSettings {
  int get roundDuration => throw _privateConstructorUsedError;
  int get minPlayers => throw _privateConstructorUsedError;
  int get maxPlayers => throw _privateConstructorUsedError;
  String? get packId => throw _privateConstructorUsedError;

  /// Serializes this RoomSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomSettingsCopyWith<RoomSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomSettingsCopyWith<$Res> {
  factory $RoomSettingsCopyWith(
    RoomSettings value,
    $Res Function(RoomSettings) then,
  ) = _$RoomSettingsCopyWithImpl<$Res, RoomSettings>;
  @useResult
  $Res call({
    int roundDuration,
    int minPlayers,
    int maxPlayers,
    String? packId,
  });
}

/// @nodoc
class _$RoomSettingsCopyWithImpl<$Res, $Val extends RoomSettings>
    implements $RoomSettingsCopyWith<$Res> {
  _$RoomSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundDuration = null,
    Object? minPlayers = null,
    Object? maxPlayers = null,
    Object? packId = freezed,
  }) {
    return _then(
      _value.copyWith(
            roundDuration: null == roundDuration
                ? _value.roundDuration
                : roundDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            minPlayers: null == minPlayers
                ? _value.minPlayers
                : minPlayers // ignore: cast_nullable_to_non_nullable
                      as int,
            maxPlayers: null == maxPlayers
                ? _value.maxPlayers
                : maxPlayers // ignore: cast_nullable_to_non_nullable
                      as int,
            packId: freezed == packId
                ? _value.packId
                : packId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomSettingsImplCopyWith<$Res>
    implements $RoomSettingsCopyWith<$Res> {
  factory _$$RoomSettingsImplCopyWith(
    _$RoomSettingsImpl value,
    $Res Function(_$RoomSettingsImpl) then,
  ) = __$$RoomSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int roundDuration,
    int minPlayers,
    int maxPlayers,
    String? packId,
  });
}

/// @nodoc
class __$$RoomSettingsImplCopyWithImpl<$Res>
    extends _$RoomSettingsCopyWithImpl<$Res, _$RoomSettingsImpl>
    implements _$$RoomSettingsImplCopyWith<$Res> {
  __$$RoomSettingsImplCopyWithImpl(
    _$RoomSettingsImpl _value,
    $Res Function(_$RoomSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roundDuration = null,
    Object? minPlayers = null,
    Object? maxPlayers = null,
    Object? packId = freezed,
  }) {
    return _then(
      _$RoomSettingsImpl(
        roundDuration: null == roundDuration
            ? _value.roundDuration
            : roundDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        minPlayers: null == minPlayers
            ? _value.minPlayers
            : minPlayers // ignore: cast_nullable_to_non_nullable
                  as int,
        maxPlayers: null == maxPlayers
            ? _value.maxPlayers
            : maxPlayers // ignore: cast_nullable_to_non_nullable
                  as int,
        packId: freezed == packId
            ? _value.packId
            : packId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomSettingsImpl implements _RoomSettings {
  const _$RoomSettingsImpl({
    this.roundDuration = 120,
    this.minPlayers = 3,
    this.maxPlayers = 10,
    this.packId,
  });

  factory _$RoomSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomSettingsImplFromJson(json);

  @override
  @JsonKey()
  final int roundDuration;
  @override
  @JsonKey()
  final int minPlayers;
  @override
  @JsonKey()
  final int maxPlayers;
  @override
  final String? packId;

  @override
  String toString() {
    return 'RoomSettings(roundDuration: $roundDuration, minPlayers: $minPlayers, maxPlayers: $maxPlayers, packId: $packId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomSettingsImpl &&
            (identical(other.roundDuration, roundDuration) ||
                other.roundDuration == roundDuration) &&
            (identical(other.minPlayers, minPlayers) ||
                other.minPlayers == minPlayers) &&
            (identical(other.maxPlayers, maxPlayers) ||
                other.maxPlayers == maxPlayers) &&
            (identical(other.packId, packId) || other.packId == packId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, roundDuration, minPlayers, maxPlayers, packId);

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomSettingsImplCopyWith<_$RoomSettingsImpl> get copyWith =>
      __$$RoomSettingsImplCopyWithImpl<_$RoomSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomSettingsImplToJson(this);
  }
}

abstract class _RoomSettings implements RoomSettings {
  const factory _RoomSettings({
    final int roundDuration,
    final int minPlayers,
    final int maxPlayers,
    final String? packId,
  }) = _$RoomSettingsImpl;

  factory _RoomSettings.fromJson(Map<String, dynamic> json) =
      _$RoomSettingsImpl.fromJson;

  @override
  int get roundDuration;
  @override
  int get minPlayers;
  @override
  int get maxPlayers;
  @override
  String? get packId;

  /// Create a copy of RoomSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomSettingsImplCopyWith<_$RoomSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'host_player_id')
  String? get hostPlayerId => throw _privateConstructorUsedError;
  RoomStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_round_id')
  String? get currentRoundId => throw _privateConstructorUsedError;
  RoomSettings get settings => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    String id,
    String code,
    @JsonKey(name: 'host_player_id') String? hostPlayerId,
    RoomStatus status,
    @JsonKey(name: 'current_round_id') String? currentRoundId,
    RoomSettings settings,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });

  $RoomSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? hostPlayerId = freezed,
    Object? status = null,
    Object? currentRoundId = freezed,
    Object? settings = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            hostPlayerId: freezed == hostPlayerId
                ? _value.hostPlayerId
                : hostPlayerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RoomStatus,
            currentRoundId: freezed == currentRoundId
                ? _value.currentRoundId
                : currentRoundId // ignore: cast_nullable_to_non_nullable
                      as String?,
            settings: null == settings
                ? _value.settings
                : settings // ignore: cast_nullable_to_non_nullable
                      as RoomSettings,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomSettingsCopyWith<$Res> get settings {
    return $RoomSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String code,
    @JsonKey(name: 'host_player_id') String? hostPlayerId,
    RoomStatus status,
    @JsonKey(name: 'current_round_id') String? currentRoundId,
    RoomSettings settings,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });

  @override
  $RoomSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? hostPlayerId = freezed,
    Object? status = null,
    Object? currentRoundId = freezed,
    Object? settings = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$RoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        hostPlayerId: freezed == hostPlayerId
            ? _value.hostPlayerId
            : hostPlayerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RoomStatus,
        currentRoundId: freezed == currentRoundId
            ? _value.currentRoundId
            : currentRoundId // ignore: cast_nullable_to_non_nullable
                  as String?,
        settings: null == settings
            ? _value.settings
            : settings // ignore: cast_nullable_to_non_nullable
                  as RoomSettings,
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
class _$RoomImpl implements _Room {
  const _$RoomImpl({
    required this.id,
    required this.code,
    @JsonKey(name: 'host_player_id') this.hostPlayerId,
    this.status = RoomStatus.waiting,
    @JsonKey(name: 'current_round_id') this.currentRoundId,
    this.settings = const RoomSettings(),
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  @JsonKey(name: 'host_player_id')
  final String? hostPlayerId;
  @override
  @JsonKey()
  final RoomStatus status;
  @override
  @JsonKey(name: 'current_round_id')
  final String? currentRoundId;
  @override
  @JsonKey()
  final RoomSettings settings;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Room(id: $id, code: $code, hostPlayerId: $hostPlayerId, status: $status, currentRoundId: $currentRoundId, settings: $settings, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.hostPlayerId, hostPlayerId) ||
                other.hostPlayerId == hostPlayerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentRoundId, currentRoundId) ||
                other.currentRoundId == currentRoundId) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    hostPlayerId,
    status,
    currentRoundId,
    settings,
    createdAt,
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room implements Room {
  const factory _Room({
    required final String id,
    required final String code,
    @JsonKey(name: 'host_player_id') final String? hostPlayerId,
    final RoomStatus status,
    @JsonKey(name: 'current_round_id') final String? currentRoundId,
    final RoomSettings settings,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  @JsonKey(name: 'host_player_id')
  String? get hostPlayerId;
  @override
  RoomStatus get status;
  @override
  @JsonKey(name: 'current_round_id')
  String? get currentRoundId;
  @override
  RoomSettings get settings;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
