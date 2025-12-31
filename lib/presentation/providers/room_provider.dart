import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import '../../data/repositories/room_repository.dart';
import '../../data/repositories/player_repository.dart';
import '../../core/utils/app_logger.dart';

final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  return RoomRepository();
});

final playerRepositoryProvider = Provider<PlayerRepository>((ref) {
  return PlayerRepository();
});

// Watch a specific room by ID
final roomStreamProvider = StreamProvider.family<Room?, String>((ref, roomId) {
  final repository = ref.watch(roomRepositoryProvider);
  return repository.watchRoom(roomId);
});

// Watch players in a room
final playersStreamProvider = StreamProvider.family<List<Player>, String>((ref, roomId) {
  final repository = ref.watch(playerRepositoryProvider);
  return repository.watchPlayers(roomId);
});

// Current room state
class CurrentRoomNotifier extends StateNotifier<Room?> {
  final RoomRepository _roomRepository;
  final PlayerRepository _playerRepository;

  CurrentRoomNotifier(this._roomRepository, this._playerRepository) : super(null);

  void setRoom(Room room) {
    state = room;
  }

  void clearRoom() {
    state = null;
  }

  Future<Room> createRoom(String hostName) async {
    AppLogger.i('Creating room with host: $hostName');
    try {
      final room = await _roomRepository.createRoom();
      AppLogger.i('Room created: ${room.id}, code: ${room.code}');

      final player = await _playerRepository.joinRoom(room.id, hostName);
      AppLogger.i('Player joined: ${player.id}');

      await _roomRepository.updateHostPlayer(room.id, player.id);
      AppLogger.i('Host player set');

      final updatedRoom = await _roomRepository.findById(room.id);
      state = updatedRoom;
      AppLogger.i('Room creation complete');
      return updatedRoom!;
    } catch (e, stack) {
      AppLogger.e('Failed to create room', e, stack);
      rethrow;
    }
  }

  Future<Room> joinRoom(String code, String playerName) async {
    final room = await _roomRepository.findByCode(code);
    if (room == null) {
      throw Exception('Room not found');
    }

    await _playerRepository.joinRoom(room.id, playerName);
    state = room;
    return room;
  }

  Future<void> leaveRoom() async {
    if (state == null) return;

    final player = await _playerRepository.getCurrentPlayer(state!.id);
    if (player != null) {
      await _playerRepository.leaveRoom(player.id);
    }
    state = null;
  }

  Future<void> updateStatus(RoomStatus status) async {
    if (state == null) return;
    await _roomRepository.updateStatus(state!.id, status);
  }
}

final currentRoomProvider = StateNotifierProvider<CurrentRoomNotifier, Room?>((ref) {
  final roomRepo = ref.watch(roomRepositoryProvider);
  final playerRepo = ref.watch(playerRepositoryProvider);
  return CurrentRoomNotifier(roomRepo, playerRepo);
});

// Current player in the room
final currentPlayerProvider = FutureProvider<Player?>((ref) async {
  final room = ref.watch(currentRoomProvider);
  if (room == null) return null;

  final playerRepo = ref.watch(playerRepositoryProvider);
  return playerRepo.getCurrentPlayer(room.id);
});

// Is current user the host
final isHostProvider = Provider<bool>((ref) {
  final room = ref.watch(currentRoomProvider);
  final playerAsync = ref.watch(currentPlayerProvider);

  if (room == null) return false;
  final player = playerAsync.valueOrNull;
  if (player == null) return false;

  return room.hostPlayerId == player.id;
});
