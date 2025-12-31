import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_game_settings.freezed.dart';
part 'local_game_settings.g.dart';

@freezed
class LocalGameSettings with _$LocalGameSettings {
  const factory LocalGameSettings({
    @Default(120) int timerDuration,
    String? selectedPackId,
    @Default(true) bool revealProtection,
    @Default(true) bool hapticFeedback,
    @Default(false) bool allowPause,
    @Default(3) int numberOfRounds,
  }) = _LocalGameSettings;

  factory LocalGameSettings.fromJson(Map<String, dynamic> json) =>
      _$LocalGameSettingsFromJson(json);
}
