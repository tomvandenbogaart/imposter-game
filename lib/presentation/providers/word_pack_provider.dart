import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/repositories/word_repository.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return WordRepository();
});

final wordPacksProvider = FutureProvider<List<WordPack>>((ref) async {
  final repo = ref.watch(wordRepositoryProvider);
  return repo.getWordPacks();
});

final selectedWordPackProvider = StateProvider<String?>((ref) => null);

final wordsForPackProvider =
    FutureProvider.family<List<Word>, String>((ref, packId) async {
  final repo = ref.watch(wordRepositoryProvider);
  return repo.getWordsInPack(packId);
});
