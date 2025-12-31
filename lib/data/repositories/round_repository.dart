import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../services/supabase_service.dart';
import '../services/realtime_service.dart';

class RoundRepository {
  final SupabaseClient _client = SupabaseService.client;
  final RealtimeService _realtimeService = RealtimeService();

  Future<Round?> getRoundById(String roundId) async {
    final response = await _client
        .from('rounds')
        .select()
        .eq('id', roundId)
        .maybeSingle();

    return response != null ? Round.fromJson(response) : null;
  }

  Future<Round?> getCurrentRound(String roomId) async {
    final response = await _client
        .from('rounds')
        .select()
        .eq('room_id', roomId)
        .order('round_number', ascending: false)
        .limit(1)
        .maybeSingle();

    return response != null ? Round.fromJson(response) : null;
  }

  Future<int> getRoundCount(String roomId) async {
    final response = await _client
        .from('rounds')
        .select('id')
        .eq('room_id', roomId);

    return (response as List).length;
  }

  Future<void> updateRoundState(String roundId, RoundState state) async {
    await _client
        .from('rounds')
        .update({'state': state.name})
        .eq('id', roundId);
  }

  Future<void> updateEndsAt(String roundId, DateTime endsAt) async {
    await _client
        .from('rounds')
        .update({'ends_at': endsAt.toIso8601String()})
        .eq('id', roundId);
  }

  Stream<Round?> watchRound(String roundId) {
    return _realtimeService.watchRound(roundId);
  }

  Future<PlayerCard?> getMyCard(String roundId) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) return null;

    // First get the player ID for this user in this round's room
    final round = await getRoundById(roundId);
    if (round == null) return null;

    final playerResponse = await _client
        .from('players')
        .select('id')
        .eq('room_id', round.roomId)
        .eq('user_id', userId)
        .maybeSingle();

    if (playerResponse == null) return null;

    final playerId = playerResponse['id'] as String;

    final cardResponse = await _client
        .from('player_cards')
        .select()
        .eq('round_id', roundId)
        .eq('player_id', playerId)
        .maybeSingle();

    return cardResponse != null ? PlayerCard.fromJson(cardResponse) : null;
  }
}
