import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/auth_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/inputs/app_text_field.dart';
import '../../widgets/decorations/party_background.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _nameController = TextEditingController();
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.orange,
          size: 32,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _createRoom() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      // Ensure authenticated
      await ref.read(authNotifierProvider.notifier).ensureAuthenticated();

      // Create room and join as host
      final room = await ref.read(currentRoomProvider.notifier).createRoom(name);

      if (mounted) {
        context.go('/lobby/${room.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating room: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: PartyBackground(
        showConfetti: false,
        showGlowOrbs: true,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    48,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48),

                  // Logo / Title
                  Center(
                    child: Text(
                      'SUS NIGHT',
                      style: AppTypography.display.copyWith(
                        foreground: Paint()
                          ..shader = AppColors.celebrationGradient.createShader(
                            const Rect.fromLTWH(0, 0, 200, 70),
                          ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: -0.2, curve: Curves.easeOut),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      'Find the sus among you',
                      style: AppTypography.bodySmall,
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms),
                  ),

                  const SizedBox(height: 48),

                  // LOCAL MODE SECTION
                  _buildSectionHeader(
                    icon: Icons.phone_android_rounded,
                    title: 'Local Mode',
                    subtitle: 'Pass the phone around',
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 600.ms),

                  const SizedBox(height: 16),

                  PrimaryButton(
                    label: 'Play Local',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () => context.push('/local'),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideX(begin: -0.1),

                  const SizedBox(height: 32),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                AppColors.textMuted.withValues(alpha: 0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.textMuted.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 600.ms),

                  const SizedBox(height: 32),

                  // ONLINE MODE SECTION
                  _buildSectionHeader(
                    icon: Icons.wifi_rounded,
                    title: 'Online Mode',
                    subtitle: 'Play with friends remotely',
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms),

                  const SizedBox(height: 16),

                  // Name input for online mode
                  AppTextField(
                    controller: _nameController,
                    labelText: 'Your Name',
                    hintText: 'Enter your display name',
                    maxLength: 20,
                    textCapitalization: TextCapitalization.words,
                  )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 600.ms),

                  const SizedBox(height: 16),

                  SecondaryButton(
                    label: 'Create Room',
                    icon: Icons.add_rounded,
                    onPressed: _isCreating ? null : _createRoom,
                    isLoading: _isCreating,
                  )
                      .animate()
                      .fadeIn(delay: 800.ms, duration: 600.ms)
                      .slideX(begin: -0.1),

                  const SizedBox(height: 12),

                  SecondaryButton(
                    label: 'Join Room',
                    icon: Icons.login_rounded,
                    onPressed: () => context.push('/join'),
                  )
                      .animate()
                      .fadeIn(delay: 900.ms, duration: 600.ms)
                      .slideX(begin: -0.1),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
