import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../services/supabase_service.dart';
import '../services/realtime_service.dart';

class VoteRepository {
  final SupabaseClient _client = SupabaseService.client;
  final RealtimeService _realtimeService = RealtimeService();

  Future<Vote> submitVote(String roundId, String votedPlayerId) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    // Get current player ID
    final round = await _client
        .from('rounds')
        .select('room_id')
        .eq('id', roundId)
        .single();

    final player = await _client
        .from('players')
        .select('id')
        .eq('room_id', round['room_id'])
        .eq('user_id', userId)
        .single();

    final response = await _client
        .from('votes')
        .insert({
          'round_id': roundId,
          'voter_player_id': player['id'],
          'voted_player_id': votedPlayerId,
        })
        .select()
        .single();

    return Vote.fromJson(response);
  }

  Future<Vote?> getMyVote(String roundId) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) return null;

    // Get current player ID
    final round = await _client
        .from('rounds')
        .select('room_id')
        .eq('id', roundId)
        .maybeSingle();

    if (round == null) return null;

    final player = await _client
        .from('players')
        .select('id')
        .eq('room_id', round['room_id'])
        .eq('user_id', userId)
        .maybeSingle();

    if (player == null) return null;

    final response = await _client
        .from('votes')
        .select()
        .eq('round_id', roundId)
        .eq('voter_player_id', player['id'])
        .maybeSingle();

    return response != null ? Vote.fromJson(response) : null;
  }

  Future<List<Vote>> getVotesForRound(String roundId) async {
    final response = await _client
        .from('votes')
        .select()
        .eq('round_id', roundId);

    return (response as List).map((e) => Vote.fromJson(e)).toList();
  }

  Future<int> getVoteCount(String roundId) async {
    final response = await _client
        .from('votes')
        .select('id')
        .eq('round_id', roundId);

    return (response as List).length;
  }

  Stream<List<Vote>> watchVotes(String roundId) {
    return _realtimeService.watchVotes(roundId);
  }

  Map<String, int> calculateVoteResults(List<Vote> votes) {
    final results = <String, int>{};
    for (final vote in votes) {
      results[vote.votedPlayerId] = (results[vote.votedPlayerId] ?? 0) + 1;
    }
    return results;
  }

  String? getMostVotedPlayer(List<Vote> votes) {
    final results = calculateVoteResults(votes);
    if (results.isEmpty) return null;

    String? mostVoted;
    int maxVotes = 0;
    for (final entry in results.entries) {
      if (entry.value > maxVotes) {
        maxVotes = entry.value;
        mostVoted = entry.key;
      }
    }
    return mostVoted;
  }
}
