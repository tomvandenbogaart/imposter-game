import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../services/supabase_service.dart';

class WordRepository {
  final SupabaseClient _client = SupabaseService.client;

  Future<List<WordPack>> getWordPacks() async {
    final response = await _client
        .from('word_packs')
        .select()
        .order('name');

    return (response as List).map((e) => WordPack.fromJson(e)).toList();
  }

  Future<WordPack?> getWordPackById(String packId) async {
    final response = await _client
        .from('word_packs')
        .select()
        .eq('id', packId)
        .maybeSingle();

    return response != null ? WordPack.fromJson(response) : null;
  }

  Future<List<Word>> getWordsInPack(String packId) async {
    final response = await _client
        .from('words')
        .select()
        .eq('pack_id', packId);

    return (response as List).map((e) => Word.fromJson(e)).toList();
  }

  Future<Word?> getRandomWord({String? packId, int? maxDifficulty}) async {
    var query = _client.from('words').select();

    if (packId != null) {
      query = query.eq('pack_id', packId);
    }

    if (maxDifficulty != null) {
      query = query.lte('difficulty', maxDifficulty);
    }

    final response = await query;
    final words = (response as List).map((e) => Word.fromJson(e)).toList();

    if (words.isEmpty) return null;

    words.shuffle();
    return words.first;
  }

  Future<Word?> getWordById(String wordId) async {
    final response = await _client
        .from('words')
        .select()
        .eq('id', wordId)
        .maybeSingle();

    return response != null ? Word.fromJson(response) : null;
  }
}
