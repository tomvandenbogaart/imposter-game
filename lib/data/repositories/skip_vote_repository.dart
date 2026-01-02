import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../services/supabase_service.dart';
import '../services/realtime_service.dart';

class SkipVoteRepository {
  final SupabaseClient _client = SupabaseService.client;
  final RealtimeService _realtimeService = RealtimeService();

  Future<SkipVote> submitSkipVote(String roundId, String playerId) async {
    final response = await _client
        .from('skip_votes')
        .insert({
          'round_id': roundId,
          'player_id': playerId,
        })
        .select()
        .single();

    return SkipVote.fromJson(response);
  }

  Future<void> removeSkipVote(String roundId, String playerId) async {
    await _client
        .from('skip_votes')
        .delete()
        .eq('round_id', roundId)
        .eq('player_id', playerId);
  }

  Future<bool> hasSkipVoted(String roundId, String playerId) async {
    final response = await _client
        .from('skip_votes')
        .select('id')
        .eq('round_id', roundId)
        .eq('player_id', playerId)
        .maybeSingle();

    return response != null;
  }

  Future<List<SkipVote>> getSkipVotesForRound(String roundId) async {
    final response = await _client
        .from('skip_votes')
        .select()
        .eq('round_id', roundId);

    return (response as List).map((e) => SkipVote.fromJson(e)).toList();
  }

  Stream<List<SkipVote>> watchSkipVotes(String roundId) {
    return _realtimeService.watchSkipVotes(roundId);
  }
}
