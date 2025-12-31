// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_game_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalGameSettingsImpl _$$LocalGameSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$LocalGameSettingsImpl(
  timerDuration: (json['timerDuration'] as num?)?.toInt() ?? 120,
  selectedPackId: json['selectedPackId'] as String?,
  revealProtection: json['revealProtection'] as bool? ?? true,
  hapticFeedback: json['hapticFeedback'] as bool? ?? true,
  allowPause: json['allowPause'] as bool? ?? false,
  numberOfRounds: (json['numberOfRounds'] as num?)?.toInt() ?? 3,
);

Map<String, dynamic> _$$LocalGameSettingsImplToJson(
  _$LocalGameSettingsImpl instance,
) => <String, dynamic>{
  'timerDuration': instance.timerDuration,
  'selectedPackId': instance.selectedPackId,
  'revealProtection': instance.revealProtection,
  'hapticFeedback': instance.hapticFeedback,
  'allowPause': instance.allowPause,
  'numberOfRounds': instance.numberOfRounds,
};
