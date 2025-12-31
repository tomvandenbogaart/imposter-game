import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

@freezed
class WordPack with _$WordPack {
  const factory WordPack({
    required String id,
    required String name,
    @Default('en') String language,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _WordPack;

  factory WordPack.fromJson(Map<String, dynamic> json) =>
      _$WordPackFromJson(json);
}

@freezed
class Word with _$Word {
  const factory Word({
    required String id,
    @JsonKey(name: 'pack_id') required String packId,
    required String word,
    String? hint,
    @Default(1) int difficulty,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}
