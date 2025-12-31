import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import '../services/supabase_service.dart';
import '../services/realtime_service.dart';
import '../../core/utils/room_code_generator.dart';

class RoomRepository {
  final SupabaseClient _client = SupabaseService.client;
  final RealtimeService _realtimeService = RealtimeService();

  Future<Room> createRoom() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) throw Exception('User not authenticated');

    final code = generateRoomCode();

    final response = await _client
        .from('rooms')
        .insert({
          'code': code,
          'host_player_id': null, // Will be set after player joins
          'status': 'waiting',
        })
        .select()
        .single();

    return Room.fromJson(response);
  }

  Future<Room?> findByCode(String code) async {
    final response = await _client
        .from('rooms')
        .select()
        .eq('code', code.toUpperCase())
        .maybeSingle();

    return response != null ? Room.fromJson(response) : null;
  }

  Future<Room?> findById(String id) async {
    final response = await _client
        .from('rooms')
        .select()
        .eq('id', id)
        .maybeSingle();

    return response != null ? Room.fromJson(response) : null;
  }

  Future<void> updateHostPlayer(String roomId, String playerId) async {
    await _client
        .from('rooms')
        .update({'host_player_id': playerId})
        .eq('id', roomId);
  }

  Future<void> updateStatus(String roomId, RoomStatus status) async {
    await _client
        .from('rooms')
        .update({'status': status.name})
        .eq('id', roomId);
  }

  Future<void> updateCurrentRound(String roomId, String? roundId) async {
    await _client
        .from('rooms')
        .update({'current_round_id': roundId})
        .eq('id', roomId);
  }

  Future<void> updateSettings(String roomId, RoomSettings settings) async {
    await _client
        .from('rooms')
        .update({'settings': settings.toJson()})
        .eq('id', roomId);
  }

  Stream<Room?> watchRoom(String roomId) {
    return _realtimeService.watchRoom(roomId);
  }

  Future<void> deleteRoom(String roomId) async {
    await _client.from('rooms').delete().eq('id', roomId);
  }
}
