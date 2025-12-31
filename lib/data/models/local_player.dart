import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_player.freezed.dart';
part 'local_player.g.dart';

@freezed
class LocalPlayer with _$LocalPlayer {
  const factory LocalPlayer({
    required String id,
    required String name,
    @Default(false) bool hasRevealedCard,
    @Default(false) bool hasVoted,
  }) = _LocalPlayer;

  factory LocalPlayer.fromJson(Map<String, dynamic> json) =>
      _$LocalPlayerFromJson(json);
}
