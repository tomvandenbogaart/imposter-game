import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/local_game/vote_card.dart';

class LocalVotingScreen extends ConsumerStatefulWidget {
  const LocalVotingScreen({super.key});

  @override
  ConsumerState<LocalVotingScreen> createState() => _LocalVotingScreenState();
}

class _LocalVotingScreenState extends ConsumerState<LocalVotingScreen> {
  String? _selectedPlayerId;

  void _confirmVote() {
    final gameState = ref.read(localGameProvider);
    final currentPlayer = gameState.currentPlayer;

    if (currentPlayer == null || _selectedPlayerId == null) return;

    if (gameState.settings.hapticFeedback) {
      HapticFeedback.heavyImpact();
    }

    // Submit vote
    ref.read(localGameProvider.notifier).submitVote(
      currentPlayer.id,
      _selectedPlayerId!,
    );

    // Move to next player
    ref.read(localGameProvider.notifier).advanceToNextPlayer();

    // Reset selection
    setState(() => _selectedPlayerId = null);

    // Navigate to privacy screen for next voter
    context.go('/local/privacy');
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(localGameProvider);
    final currentPlayer = gameState.currentPlayer;

    if (currentPlayer == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Get votable players (everyone except current player)
    final votablePlayers = gameState.players
        .where((p) => p.id != currentPlayer.id)
        .toList();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Header
                Text(
                  "${currentPlayer.name}'s Vote",
                  style: AppTypography.h2,
                ).animate().fadeIn(duration: 400.ms),

                const SizedBox(height: 8),

                Text(
                  'Who is the imposter?',
                  style: AppTypography.bodySmall,
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 32),

                // Voting grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: votablePlayers.length,
                    itemBuilder: (context, index) {
                      final player = votablePlayers[index];
                      return VoteCard(
                        player: player,
                        isSelected: _selectedPlayerId == player.id,
                        onTap: () {
                          setState(() => _selectedPlayerId = player.id);
                        },
                      ).animate().fadeIn(
                        delay: Duration(milliseconds: 300 + (index * 100)),
                        duration: 400.ms,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Confirm vote button
                PrimaryButton(
                  label: 'Confirm Vote',
                  icon: Icons.check_rounded,
                  onPressed: _selectedPlayerId != null ? _confirmVote : null,
                ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
