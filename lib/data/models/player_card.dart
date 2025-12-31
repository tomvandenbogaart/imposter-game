import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_card.freezed.dart';
part 'player_card.g.dart';

enum CardType {
  @JsonValue('word')
  word,
  @JsonValue('imposter')
  imposter,
}

@freezed
class PlayerCard with _$PlayerCard {
  const factory PlayerCard({
    required String id,
    @JsonKey(name: 'round_id') required String roundId,
    @JsonKey(name: 'player_id') required String playerId,
    @JsonKey(name: 'card_type') required CardType cardType,
    required Map<String, dynamic> payload,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _PlayerCard;

  factory PlayerCard.fromJson(Map<String, dynamic> json) =>
      _$PlayerCardFromJson(json);
}

extension PlayerCardExtension on PlayerCard {
  String? get word => cardType == CardType.word ? payload['word'] as String? : null;
  String? get hint => cardType == CardType.imposter ? payload['hint'] as String? : null;
  bool get isImposter => cardType == CardType.imposter;
}
