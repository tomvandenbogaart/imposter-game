import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/repositories/word_repository.dart';
import 'entitlement_provider.dart';

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return WordRepository();
});

final wordPacksProvider = FutureProvider<List<WordPack>>((ref) async {
  final repo = ref.watch(wordRepositoryProvider);
  final packs = await repo.getWordPacks();
  // Sort by sort_order
  packs.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  return packs;
});

final selectedWordPackProvider = StateProvider<String?>((ref) => null);

final wordsForPackProvider =
    FutureProvider.family<List<Word>, String>((ref, packId) async {
  final repo = ref.watch(wordRepositoryProvider);
  return repo.getWordsInPack(packId);
});

/// Helper class combining a word pack with its unlock status
class WordPackWithAccess {
  final WordPack pack;
  final bool isUnlocked;

  WordPackWithAccess({required this.pack, required this.isUnlocked});
}

/// Category display names
const categoryDisplayNames = {
  'free': 'Free Packs',
  'entertainment': 'Entertainment',
  'lifestyle': 'Lifestyle',
  'knowledge': 'Knowledge',
  'trending': 'Trending',
};

/// Word packs with premium status awareness
final wordPacksWithAccessProvider =
    Provider<AsyncValue<List<WordPackWithAccess>>>((ref) {
  final packsAsync = ref.watch(wordPacksProvider);
  final hasAllPacks = ref.watch(hasAllPacksProvider);

  return packsAsync.whenData((packs) {
    return packs.map((pack) {
      return WordPackWithAccess(
        pack: pack,
        // Pack is unlocked if it's not premium OR user has all packs
        isUnlocked: !pack.isPremium || hasAllPacks,
      );
    }).toList();
  });
});

/// Word packs grouped by category
final wordPacksByCategoryProvider =
    Provider<AsyncValue<Map<String, List<WordPackWithAccess>>>>((ref) {
  final packsAsync = ref.watch(wordPacksWithAccessProvider);

  return packsAsync.whenData((packs) {
    final grouped = <String, List<WordPackWithAccess>>{};

    for (final pack in packs) {
      final category = pack.pack.category ?? 'other';
      grouped.putIfAbsent(category, () => []);
      grouped[category]!.add(pack);
    }

    // Sort categories: free first, then by alphabetical order
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        if (a == 'free') return -1;
        if (b == 'free') return 1;
        return a.compareTo(b);
      });

    return {for (final key in sortedKeys) key: grouped[key]!};
  });
});

/// Check if user can start game with selected pack
final canUseSelectedPackProvider =
    Provider.family<bool, String?>((ref, packId) {
  // Random pack (null) is always allowed
  if (packId == null) return true;

  final packsAsync = ref.watch(wordPacksProvider);
  final hasAllPacks = ref.watch(hasAllPacksProvider);

  return packsAsync.maybeWhen(
    data: (packs) {
      final pack = packs.where((p) => p.id == packId).firstOrNull;
      if (pack == null) return false;
      return !pack.isPremium || hasAllPacks;
    },
    orElse: () => false,
  );
});
