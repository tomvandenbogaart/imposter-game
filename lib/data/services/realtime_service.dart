import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/models.dart';
import 'supabase_service.dart';

class RealtimeService {
  final SupabaseClient _client = SupabaseService.client;
  final Map<String, RealtimeChannel> _channels = {};

  Stream<Room?> watchRoom(String roomId) {
    final controller = StreamController<Room?>.broadcast();

    final channel = _client.channel('room:$roomId');
    _channels['room:$roomId'] = channel;

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'rooms',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: roomId,
          ),
          callback: (payload) {
            if (!controller.isClosed) {
              if (payload.eventType == PostgresChangeEvent.delete) {
                controller.add(null);
              } else {
                final room = Room.fromJson(payload.newRecord);
                controller.add(room);
              }
            }
          },
        )
        .subscribe((status, [error]) {
      if (status == RealtimeSubscribeStatus.subscribed) {
        // Fetch initial data
        _fetchRoom(roomId).then((room) {
          if (!controller.isClosed) {
            controller.add(room);
          }
        });
      }
    });

    controller.onCancel = () {
      channel.unsubscribe();
      _channels.remove('room:$roomId');
    };

    return controller.stream;
  }

  Stream<List<Player>> watchPlayers(String roomId) {
    final controller = StreamController<List<Player>>.broadcast();

    final channel = _client.channel('players:$roomId');
    _channels['players:$roomId'] = channel;

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'players',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'room_id',
            value: roomId,
          ),
          callback: (payload) {
            // Refetch all players on any change
            _fetchPlayers(roomId).then((players) {
              if (!controller.isClosed) {
                controller.add(players);
              }
            });
          },
        )
        .subscribe((status, [error]) {
      if (status == RealtimeSubscribeStatus.subscribed) {
        _fetchPlayers(roomId).then((players) {
          if (!controller.isClosed) {
            controller.add(players);
          }
        });
      }
    });

    controller.onCancel = () {
      channel.unsubscribe();
      _channels.remove('players:$roomId');
    };

    return controller.stream;
  }

  Stream<Round?> watchRound(String roundId) {
    final controller = StreamController<Round?>.broadcast();

    final channel = _client.channel('round:$roundId');
    _channels['round:$roundId'] = channel;

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'rounds',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: roundId,
          ),
          callback: (payload) {
            if (!controller.isClosed) {
              if (payload.eventType == PostgresChangeEvent.delete) {
                controller.add(null);
              } else {
                final round = Round.fromJson(payload.newRecord);
                controller.add(round);
              }
            }
          },
        )
        .subscribe((status, [error]) {
      if (status == RealtimeSubscribeStatus.subscribed) {
        _fetchRound(roundId).then((round) {
          if (!controller.isClosed) {
            controller.add(round);
          }
        });
      }
    });

    controller.onCancel = () {
      channel.unsubscribe();
      _channels.remove('round:$roundId');
    };

    return controller.stream;
  }

  Stream<List<Vote>> watchVotes(String roundId) {
    final controller = StreamController<List<Vote>>.broadcast();

    final channel = _client.channel('votes:$roundId');
    _channels['votes:$roundId'] = channel;

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'votes',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'round_id',
            value: roundId,
          ),
          callback: (payload) {
            _fetchVotes(roundId).then((votes) {
              if (!controller.isClosed) {
                controller.add(votes);
              }
            });
          },
        )
        .subscribe((status, [error]) {
      if (status == RealtimeSubscribeStatus.subscribed) {
        _fetchVotes(roundId).then((votes) {
          if (!controller.isClosed) {
            controller.add(votes);
          }
        });
      }
    });

    controller.onCancel = () {
      channel.unsubscribe();
      _channels.remove('votes:$roundId');
    };

    return controller.stream;
  }

  Future<Room?> _fetchRoom(String roomId) async {
    final response = await _client
        .from('rooms')
        .select()
        .eq('id', roomId)
        .maybeSingle();
    return response != null ? Room.fromJson(response) : null;
  }

  Future<List<Player>> _fetchPlayers(String roomId) async {
    final response = await _client
        .from('players')
        .select()
        .eq('room_id', roomId)
        .order('joined_at');
    return (response as List).map((e) => Player.fromJson(e)).toList();
  }

  Future<Round?> _fetchRound(String roundId) async {
    final response = await _client
        .from('rounds')
        .select()
        .eq('id', roundId)
        .maybeSingle();
    return response != null ? Round.fromJson(response) : null;
  }

  Future<List<Vote>> _fetchVotes(String roundId) async {
    final response = await _client
        .from('votes')
        .select()
        .eq('round_id', roundId);
    return (response as List).map((e) => Vote.fromJson(e)).toList();
  }

  void dispose() {
    for (final channel in _channels.values) {
      channel.unsubscribe();
    }
    _channels.clear();
  }
}
