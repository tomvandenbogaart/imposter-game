// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalGameStateImpl _$$LocalGameStateImplFromJson(Map<String, dynamic> json) =>
    _$LocalGameStateImpl(
      phase:
          $enumDecodeNullable(_$LocalGamePhaseEnumMap, json['phase']) ??
          LocalGamePhase.setup,
      players:
          (json['players'] as List<dynamic>?)
              ?.map((e) => LocalPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      settings: json['settings'] == null
          ? const LocalGameSettings()
          : LocalGameSettings.fromJson(
              json['settings'] as Map<String, dynamic>,
            ),
      imposterPlayerId: json['imposterPlayerId'] as String?,
      selectedWord: json['selectedWord'] == null
          ? null
          : Word.fromJson(json['selectedWord'] as Map<String, dynamic>),
      currentPlayerIndex: (json['currentPlayerIndex'] as num?)?.toInt() ?? 0,
      votes:
          (json['votes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      roundNumber: (json['roundNumber'] as num?)?.toInt() ?? 0,
      playerScores:
          (json['playerScores'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$LocalGameStateImplToJson(
  _$LocalGameStateImpl instance,
) => <String, dynamic>{
  'phase': _$LocalGamePhaseEnumMap[instance.phase]!,
  'players': instance.players,
  'settings': instance.settings,
  'imposterPlayerId': instance.imposterPlayerId,
  'selectedWord': instance.selectedWord,
  'currentPlayerIndex': instance.currentPlayerIndex,
  'votes': instance.votes,
  'roundNumber': instance.roundNumber,
  'playerScores': instance.playerScores,
};

const _$LocalGamePhaseEnumMap = {
  LocalGamePhase.setup: 'setup',
  LocalGamePhase.revealing: 'revealing',
  LocalGamePhase.allSet: 'allSet',
  LocalGamePhase.discussion: 'discussion',
  LocalGamePhase.voting: 'voting',
  LocalGamePhase.results: 'results',
  LocalGamePhase.finalResults: 'finalResults',
};
