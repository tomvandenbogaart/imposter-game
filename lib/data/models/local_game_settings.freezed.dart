// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_game_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalGameSettings _$LocalGameSettingsFromJson(Map<String, dynamic> json) {
  return _LocalGameSettings.fromJson(json);
}

/// @nodoc
mixin _$LocalGameSettings {
  int get timerDuration => throw _privateConstructorUsedError;
  String? get selectedPackId => throw _privateConstructorUsedError;
  bool get revealProtection => throw _privateConstructorUsedError;
  bool get hapticFeedback => throw _privateConstructorUsedError;
  bool get allowPause => throw _privateConstructorUsedError;
  int get numberOfRounds => throw _privateConstructorUsedError;

  /// Serializes this LocalGameSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalGameSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalGameSettingsCopyWith<LocalGameSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalGameSettingsCopyWith<$Res> {
  factory $LocalGameSettingsCopyWith(
    LocalGameSettings value,
    $Res Function(LocalGameSettings) then,
  ) = _$LocalGameSettingsCopyWithImpl<$Res, LocalGameSettings>;
  @useResult
  $Res call({
    int timerDuration,
    String? selectedPackId,
    bool revealProtection,
    bool hapticFeedback,
    bool allowPause,
    int numberOfRounds,
  });
}

/// @nodoc
class _$LocalGameSettingsCopyWithImpl<$Res, $Val extends LocalGameSettings>
    implements $LocalGameSettingsCopyWith<$Res> {
  _$LocalGameSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalGameSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerDuration = null,
    Object? selectedPackId = freezed,
    Object? revealProtection = null,
    Object? hapticFeedback = null,
    Object? allowPause = null,
    Object? numberOfRounds = null,
  }) {
    return _then(
      _value.copyWith(
            timerDuration: null == timerDuration
                ? _value.timerDuration
                : timerDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedPackId: freezed == selectedPackId
                ? _value.selectedPackId
                : selectedPackId // ignore: cast_nullable_to_non_nullable
                      as String?,
            revealProtection: null == revealProtection
                ? _value.revealProtection
                : revealProtection // ignore: cast_nullable_to_non_nullable
                      as bool,
            hapticFeedback: null == hapticFeedback
                ? _value.hapticFeedback
                : hapticFeedback // ignore: cast_nullable_to_non_nullable
                      as bool,
            allowPause: null == allowPause
                ? _value.allowPause
                : allowPause // ignore: cast_nullable_to_non_nullable
                      as bool,
            numberOfRounds: null == numberOfRounds
                ? _value.numberOfRounds
                : numberOfRounds // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalGameSettingsImplCopyWith<$Res>
    implements $LocalGameSettingsCopyWith<$Res> {
  factory _$$LocalGameSettingsImplCopyWith(
    _$LocalGameSettingsImpl value,
    $Res Function(_$LocalGameSettingsImpl) then,
  ) = __$$LocalGameSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int timerDuration,
    String? selectedPackId,
    bool revealProtection,
    bool hapticFeedback,
    bool allowPause,
    int numberOfRounds,
  });
}

/// @nodoc
class __$$LocalGameSettingsImplCopyWithImpl<$Res>
    extends _$LocalGameSettingsCopyWithImpl<$Res, _$LocalGameSettingsImpl>
    implements _$$LocalGameSettingsImplCopyWith<$Res> {
  __$$LocalGameSettingsImplCopyWithImpl(
    _$LocalGameSettingsImpl _value,
    $Res Function(_$LocalGameSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalGameSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerDuration = null,
    Object? selectedPackId = freezed,
    Object? revealProtection = null,
    Object? hapticFeedback = null,
    Object? allowPause = null,
    Object? numberOfRounds = null,
  }) {
    return _then(
      _$LocalGameSettingsImpl(
        timerDuration: null == timerDuration
            ? _value.timerDuration
            : timerDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedPackId: freezed == selectedPackId
            ? _value.selectedPackId
            : selectedPackId // ignore: cast_nullable_to_non_nullable
                  as String?,
        revealProtection: null == revealProtection
            ? _value.revealProtection
            : revealProtection // ignore: cast_nullable_to_non_nullable
                  as bool,
        hapticFeedback: null == hapticFeedback
            ? _value.hapticFeedback
            : hapticFeedback // ignore: cast_nullable_to_non_nullable
                  as bool,
        allowPause: null == allowPause
            ? _value.allowPause
            : allowPause // ignore: cast_nullable_to_non_nullable
                  as bool,
        numberOfRounds: null == numberOfRounds
            ? _value.numberOfRounds
            : numberOfRounds // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalGameSettingsImpl implements _LocalGameSettings {
  const _$LocalGameSettingsImpl({
    this.timerDuration = 120,
    this.selectedPackId,
    this.revealProtection = true,
    this.hapticFeedback = true,
    this.allowPause = false,
    this.numberOfRounds = 3,
  });

  factory _$LocalGameSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalGameSettingsImplFromJson(json);

  @override
  @JsonKey()
  final int timerDuration;
  @override
  final String? selectedPackId;
  @override
  @JsonKey()
  final bool revealProtection;
  @override
  @JsonKey()
  final bool hapticFeedback;
  @override
  @JsonKey()
  final bool allowPause;
  @override
  @JsonKey()
  final int numberOfRounds;

  @override
  String toString() {
    return 'LocalGameSettings(timerDuration: $timerDuration, selectedPackId: $selectedPackId, revealProtection: $revealProtection, hapticFeedback: $hapticFeedback, allowPause: $allowPause, numberOfRounds: $numberOfRounds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalGameSettingsImpl &&
            (identical(other.timerDuration, timerDuration) ||
                other.timerDuration == timerDuration) &&
            (identical(other.selectedPackId, selectedPackId) ||
                other.selectedPackId == selectedPackId) &&
            (identical(other.revealProtection, revealProtection) ||
                other.revealProtection == revealProtection) &&
            (identical(other.hapticFeedback, hapticFeedback) ||
                other.hapticFeedback == hapticFeedback) &&
            (identical(other.allowPause, allowPause) ||
                other.allowPause == allowPause) &&
            (identical(other.numberOfRounds, numberOfRounds) ||
                other.numberOfRounds == numberOfRounds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    timerDuration,
    selectedPackId,
    revealProtection,
    hapticFeedback,
    allowPause,
    numberOfRounds,
  );

  /// Create a copy of LocalGameSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalGameSettingsImplCopyWith<_$LocalGameSettingsImpl> get copyWith =>
      __$$LocalGameSettingsImplCopyWithImpl<_$LocalGameSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalGameSettingsImplToJson(this);
  }
}

abstract class _LocalGameSettings implements LocalGameSettings {
  const factory _LocalGameSettings({
    final int timerDuration,
    final String? selectedPackId,
    final bool revealProtection,
    final bool hapticFeedback,
    final bool allowPause,
    final int numberOfRounds,
  }) = _$LocalGameSettingsImpl;

  factory _LocalGameSettings.fromJson(Map<String, dynamic> json) =
      _$LocalGameSettingsImpl.fromJson;

  @override
  int get timerDuration;
  @override
  String? get selectedPackId;
  @override
  bool get revealProtection;
  @override
  bool get hapticFeedback;
  @override
  bool get allowPause;
  @override
  int get numberOfRounds;

  /// Create a copy of LocalGameSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalGameSettingsImplCopyWith<_$LocalGameSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
