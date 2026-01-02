import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/local_game/player_name_input.dart';
import '../../widgets/word_pack/word_pack_selector.dart';

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
    ref.read(localGameProvider.notifier).addPlayer(context.l10n.localSetup_defaultPlayerName(state.players.length + 1));
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
          SnackBar(content: Text(context.l10n.error_allPlayersNeedName)),
        );
        return;
      }
    }

    if (state.players.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.error_minPlayers)),
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
          SnackBar(content: Text(context.l10n.error_loadWords)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.error_generic(e.toString()))),
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
          context.l10n.localSetup_title,
          style: AppTypography.h2,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: AppColors.textPrimary),
            onPressed: () => context.push('/local/settings'),
          ),
        ],
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
                          context.l10n.localSetup_players_header,
                          style: AppTypography.h3,
                        ).animate().fadeIn(duration: 400.ms),
                        Text(
                          context.l10n.localSetup_playerCount(gameState.players.length),
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
                            showDragHandle: false,
                          );
                        },
                      ),
                    ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                    const SizedBox(height: 12),

                    // Add player button
                    if (gameState.players.length < 12)
                      SecondaryButton(
                        label: context.l10n.localSetup_addPlayer_button,
                        icon: Icons.person_add_rounded,
                        onPressed: _addPlayer,
                      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

                    const SizedBox(height: 24),

                    // Word pack selector
                    WordPackSelector(
                      onViewAll: () => context.push('/local/packs'),
                    ).animate().fadeIn(delay: 350.ms, duration: 400.ms),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Start button
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: context.l10n.localSetup_startRound_button,
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
