import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../services/supabase_service.dart';
import '../services/realtime_service.dart';

class PlayerRepository {
  final SupabaseClient _client = SupabaseService.client;
  final RealtimeService _realtimeService = RealtimeService();

  Future<Player> joinRoom(String roomId, String displayName) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _client
        .from('players')
        .insert({
          'room_id': roomId,
          'user_id': userId,
          'display_name': displayName,
          'is_ready': false,
          'is_connected': true,
        })
        .select()
        .single();

    return Player.fromJson(response);
  }

  Future<Player?> getCurrentPlayer(String roomId) async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) return null;

    final response = await _client
        .from('players')
        .select()
        .eq('room_id', roomId)
        .eq('user_id', userId)
        .maybeSingle();

    return response != null ? Player.fromJson(response) : null;
  }

  Future<Player?> getPlayerById(String playerId) async {
    final response = await _client
        .from('players')
        .select()
        .eq('id', playerId)
        .maybeSingle();

    return response != null ? Player.fromJson(response) : null;
  }

  Future<List<Player>> getPlayersInRoom(String roomId) async {
    final response = await _client
        .from('players')
        .select()
        .eq('room_id', roomId)
        .order('joined_at');

    return (response as List).map((e) => Player.fromJson(e)).toList();
  }

  Future<void> updateReadyStatus(String playerId, bool isReady) async {
    await _client
        .from('players')
        .update({'is_ready': isReady})
        .eq('id', playerId);
  }

  Future<void> updateConnectionStatus(String playerId, bool isConnected) async {
    await _client
        .from('players')
        .update({'is_connected': isConnected})
        .eq('id', playerId);
  }

  Future<void> leaveRoom(String playerId) async {
    // Try to delete votes first (may fail due to RLS, that's ok)
    try {
      await _client.from('votes').delete().eq('voter_player_id', playerId);
    } catch (_) {}
    try {
      await _client.from('votes').delete().eq('voted_player_id', playerId);
    } catch (_) {}
    try {
      await _client.from('skip_votes').delete().eq('player_id', playerId);
    } catch (_) {}
    // Now delete the player
    await _client.from('players').delete().eq('id', playerId);
  }

  Stream<List<Player>> watchPlayers(String roomId) {
    return _realtimeService.watchPlayers(roomId);
  }
}
