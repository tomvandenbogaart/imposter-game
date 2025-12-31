import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/word_pack_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/local_game/player_name_input.dart';

class LocalSetupScreen extends ConsumerStatefulWidget {
  const LocalSetupScreen({super.key});

  @override
  ConsumerState<LocalSetupScreen> createState() => _LocalSetupScreenState();
}

class _LocalSetupScreenState extends ConsumerState<LocalSetupScreen> {
  bool _isStarting = false;

  @override
  void initState() {
    super.initState();
    // Initialize with 4 default players if empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(localGameProvider);
      if (state.players.isEmpty) {
        ref.read(localGameProvider.notifier).initializeDefaultPlayers(4);
      }
    });
  }

  void _addPlayer() {
    final state = ref.read(localGameProvider);
    if (state.players.length >= 12) return;
    ref.read(localGameProvider.notifier).addPlayer('Player ${state.players.length + 1}');
  }

  void _removePlayer(String playerId) {
    ref.read(localGameProvider.notifier).removePlayer(playerId);
  }

  void _updatePlayerName(String playerId, String name) {
    ref.read(localGameProvider.notifier).updatePlayerName(playerId, name);
  }

  void _reorderPlayers(int oldIndex, int newIndex) {
    ref.read(localGameProvider.notifier).reorderPlayers(oldIndex, newIndex);
  }

  Future<void> _startRound() async {
    final state = ref.read(localGameProvider);

    // Validate all players have names
    for (final player in state.players) {
      if (player.name.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All players must have a name')),
        );
        return;
      }
    }

    if (state.players.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('At least 3 players required')),
      );
      return;
    }

    setState(() => _isStarting = true);

    try {
      final success = await ref.read(localGameProvider.notifier).startRound();
      if (success && mounted) {
        context.go('/local/privacy');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not load words. Check your connection.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(localGameProvider);
    final wordPacksAsync = ref.watch(wordPacksProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            ref.read(localGameProvider.notifier).resetAll();
            context.go('/');
          },
        ),
        title: Text(
          'Local Game',
          style: AppTypography.h2,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Players section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Players',
                          style: AppTypography.h3,
                        ).animate().fadeIn(duration: 400.ms),
                        Text(
                          '${gameState.players.length}/12',
                          style: AppTypography.bodySmall,
                        ).animate().fadeIn(duration: 400.ms),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Player list
                    Theme(
                      data: Theme.of(context).copyWith(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                      ),
                      child: ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: gameState.players.length,
                        onReorder: _reorderPlayers,
                        proxyDecorator: (child, index, animation) {
                          return Material(
                            color: Colors.transparent,
                            elevation: 0,
                            child: child,
                          );
                        },
                        itemBuilder: (context, index) {
                          final player = gameState.players[index];
                          return PlayerNameInput(
                            key: ValueKey(player.id),
                            index: index,
                            name: player.name,
                            onChanged: (name) => _updatePlayerName(player.id, name),
                            onRemove: () => _removePlayer(player.id),
                            canRemove: gameState.players.length > 3,
                          );
                        },
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                    const SizedBox(height: 12),

                    // Add player button
                    if (gameState.players.length < 12)
                      SecondaryButton(
                        label: 'Add Player',
                        icon: Icons.person_add_rounded,
                        onPressed: _addPlayer,
                      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

                    const SizedBox(height: 24),

                    // Settings button
                    _SettingsButton(
                      timerDuration: gameState.settings.timerDuration,
                      packName: wordPacksAsync.whenOrNull(
                        data: (packs) {
                          if (gameState.settings.selectedPackId == null) {
                            return 'Random';
                          }
                          return packs
                              .where((p) => p.id == gameState.settings.selectedPackId)
                              .map((p) => p.name)
                              .firstOrNull ?? 'Random';
                        },
                      ) ?? 'Loading...',
                      numberOfRounds: gameState.settings.numberOfRounds,
                      onTap: () => context.push('/local/settings'),
                    ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Start button
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: 'Start Round',
                icon: Icons.play_arrow_rounded,
                onPressed: _isStarting ? null : _startRound,
                isLoading: _isStarting,
              ).animate().fadeIn(delay: 900.ms, duration: 400.ms),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final int timerDuration;
  final String packName;
  final int numberOfRounds;
  final VoidCallback onTap;

  const _SettingsButton({
    required this.timerDuration,
    required this.packName,
    required this.numberOfRounds,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final timerString = '${timerDuration ~/ 60}:${(timerDuration % 60).toString().padLeft(2, '0')}';
    final roundsText = numberOfRounds == 1 ? '1 round' : '$numberOfRounds rounds';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.surfaceLight,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.settings_rounded,
                color: AppColors.cyan,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Settings', style: AppTypography.playerName),
                  const SizedBox(height: 4),
                  Text(
                    '$roundsText · $timerString timer · $packName',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
