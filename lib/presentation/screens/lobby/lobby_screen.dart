import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_logger.dart';
import '../../../data/models/models.dart';
import '../../../data/services/supabase_service.dart';
import '../../providers/room_provider.dart';
import '../../providers/game_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/word_pack/online_word_pack_selector.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  final String roomId;

  const LobbyScreen({super.key, required this.roomId});

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    // Watch room for status changes
    _watchRoomStatus();
  }

  void _watchRoomStatus() {
    ref.listenManual(
      roomStreamProvider(widget.roomId),
      (previous, next) {
        final room = next.valueOrNull;
        if (room != null && room.status == RoomStatus.playing) {
          context.go('/game/${widget.roomId}/reveal');
        }
      },
    );
  }

  Future<void> _copyRoomCode(String code) async {
    await Clipboard.setData(ClipboardData(text: code));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Room code copied!')),
      );
    }
  }

  Future<void> _startGame() async {
    setState(() => _isStarting = true);
    try {
      await startRound(widget.roomId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error starting game: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }

  Future<void> _leaveRoom() async {
    await ref.read(currentRoomProvider.notifier).leaveRoom();
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(roomStreamProvider(widget.roomId));
    final playersAsync = ref.watch(playersStreamProvider(widget.roomId));

    // Determine if current user is host by finding our player in the players list
    final room = roomAsync.valueOrNull;
    final players = playersAsync.valueOrNull ?? [];
    final currentUserId = SupabaseService.currentUserId;
    final currentPlayer = currentUserId != null
        ? players.where((p) => p.userId == currentUserId).firstOrNull
        : null;
    final isHost = room != null &&
        currentPlayer != null &&
        room.hostPlayerId == currentPlayer.id;

    AppLogger.d('LobbyScreen: currentUserId=$currentUserId, players=${players.map((p) => '${p.displayName}(userId:${p.userId})').toList()}, currentPlayer=${currentPlayer?.displayName}, room.hostPlayerId=${room?.hostPlayerId}, isHost=$isHost');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _leaveRoom,
        ),
        title: Text('Lobby', style: AppTypography.h3),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Room Code Display
              roomAsync.when(
                data: (room) => room != null
                    ? _RoomCodeCard(
                        code: room.code,
                        onCopy: () => _copyRoomCode(room.code),
                      ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1)
                    : const SizedBox.shrink(),
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
              ),

              const SizedBox(height: 24),

              // Players List
              Expanded(
                child: playersAsync.when(
                  data: (players) => _PlayersList(
                    players: players,
                    hostPlayerId: roomAsync.valueOrNull?.hostPlayerId,
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ),

              const SizedBox(height: 24),

              // Host controls: Word Pack selector + Start Game Button
              if (isHost)
                playersAsync.when(
                  data: (players) {
                    final minPlayers = roomAsync.valueOrNull?.settings.minPlayers ?? 2;
                    final canStart = players.length >= minPlayers;
                    return Column(
                      children: [
                        // Word Pack Selector
                        OnlineWordPackSelector(
                          selectedPackId: room.settings.packId,
                          onPackSelected: (packId) async {
                            await ref.read(roomRepositoryProvider).updateSettings(
                              widget.roomId,
                              room.settings.copyWith(packId: packId),
                            );
                          },
                        ).animate().fadeIn(delay: 100.ms),
                        SizedBox(height: 16.h),
                        if (!canStart)
                          Text(
                            'Need at least $minPlayers players to start',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ).animate().fadeIn(),
                        const SizedBox(height: 8),
                        PrimaryButton(
                          label: 'Start Game',
                          icon: Icons.play_arrow_rounded,
                          onPressed: canStart && !_isStarting ? _startGame : null,
                          isLoading: _isStarting,
                        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                )
              else
                Text(
                  'Waiting for host to start...',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ).animate().fadeIn().then().shimmer(duration: 2.seconds),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomCodeCard extends StatelessWidget {
  final String code;
  final VoidCallback onCopy;

  const _RoomCodeCard({required this.code, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      onTap: onCopy,
      child: Column(
        children: [
          Text(
            'Room Code',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(code, style: AppTypography.roomCode),
              const SizedBox(width: 12),
              Icon(
                Icons.copy_rounded,
                color: AppColors.cyan,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Tap to copy',
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}

class _PlayersList extends StatelessWidget {
  final List<Player> players;
  final String? hostPlayerId;

  const _PlayersList({required this.players, this.hostPlayerId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        final isHost = player.id == hostPlayerId;

        return _PlayerTile(
          player: player,
          isHost: isHost,
        )
            .animate()
            .fadeIn(delay: (index * 100).ms)
            .slideX(begin: index.isEven ? -0.1 : 0.1);
      },
    );
  }
}

class _PlayerTile extends StatelessWidget {
  final Player player;
  final bool isHost;

  const _PlayerTile({required this.player, required this.isHost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHost ? AppColors.cyan : AppColors.surfaceLight,
          width: isHost ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                player.displayName[0].toUpperCase(),
                style: AppTypography.h2.copyWith(
                  color: AppColors.background,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.displayName,
                  style: AppTypography.playerName,
                ),
                if (isHost)
                  Text(
                    'Host',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.cyan,
                    ),
                  ),
              ],
            ),
          ),

          // Connection status
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: player.isConnected ? AppColors.success : AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
