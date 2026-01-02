import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/auth_provider.dart';
import '../../providers/room_provider.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/inputs/app_text_field.dart';
import '../../widgets/decorations/party_background.dart';
import '../../widgets/dialogs/store_dialog.dart';

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
        Icon(icon, color: AppColors.orange, size: 32.sp),
        SizedBox(width: 12.w),
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
                fontSize: 12.sp,
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.error_enterName)));
      return;
    }

    setState(() => _isCreating = true);

    try {
      // Ensure authenticated
      await ref.read(authNotifierProvider.notifier).ensureAuthenticated();

      // Create room and join as host
      final room = await ref
          .read(currentRoomProvider.notifier)
          .createRoom(name);

      if (mounted) {
        context.go('/lobby/${room.id}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.error_createRoom(e.toString()))),
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
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(context.screenPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 48.h),

                    // Logo / Title
                    Center(
                      child:
                          Text(
                                context.l10n.welcome_title,
                                style: AppTypography.display.copyWith(
                                  fontSize: 56.sp,
                                  foreground: Paint()
                                    ..shader = AppColors.celebrationGradient
                                        .createShader(
                                          Rect.fromLTWH(0, 0, 250.w, 80.h),
                                        ),
                                ),
                              )
                              .animate()
                              .fadeIn(duration: 600.ms)
                              .slideY(begin: -0.2, curve: Curves.easeOut),
                    ),

                    SizedBox(height: 8.h),

                    Center(
                      child: Text(
                        context.l10n.welcome_subtitle,
                        style: AppTypography.bodySmall,
                      ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                    ),

                    SizedBox(height: 48.h),

                    // OFFLINE MODE SECTION
                    _buildSectionHeader(
                      icon: Icons.wifi_off_rounded,
                      title: context.l10n.welcome_offlineMode_title,
                      subtitle: context.l10n.welcome_offlineMode_subtitle,
                    ).animate().fadeIn(delay: 300.ms, duration: 600.ms),

                    SizedBox(height: 16.h),

                    PrimaryButton(
                          label: context.l10n.welcome_playOffline_button,
                          icon: Icons.play_arrow_rounded,
                          onPressed: () => context.push('/local'),
                        )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideX(begin: -0.1),

                    SizedBox(height: 32.h),

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
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            context.l10n.welcome_or_divider,
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
                    ).animate().fadeIn(delay: 500.ms, duration: 600.ms),

                    SizedBox(height: 32.h),

                    // ONLINE MODE SECTION
                    _buildSectionHeader(
                      icon: Icons.wifi_rounded,
                      title: context.l10n.welcome_onlineMode_title,
                      subtitle: context.l10n.welcome_onlineMode_subtitle,
                    ).animate().fadeIn(delay: 600.ms, duration: 600.ms),

                    SizedBox(height: 16.h),

                    // Name input for online mode
                    AppTextField(
                      controller: _nameController,
                      labelText: context.l10n.welcome_yourName_label,
                      hintText: context.l10n.welcome_yourName_hint,
                      maxLength: 20,
                      textCapitalization: TextCapitalization.words,
                    ).animate().fadeIn(delay: 700.ms, duration: 600.ms),

                    SizedBox(height: 16.h),

                    SecondaryButton(
                          label: context.l10n.welcome_createRoom_button,
                          icon: Icons.add_rounded,
                          onPressed: _isCreating ? null : _createRoom,
                          isLoading: _isCreating,
                        )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 600.ms)
                        .slideX(begin: -0.1),

                    SizedBox(height: 12.h),

                    SecondaryButton(
                          label: context.l10n.welcome_joinRoom_button,
                          icon: Icons.login_rounded,
                          onPressed: () => context.push('/join'),
                        )
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 600.ms)
                        .slideX(begin: -0.1),

                  SizedBox(height: 48.h),
                ],
              ),
            ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.settings_outlined,
                          color: AppColors.orange,
                        ),
                        onPressed: () => context.push('/local/settings'),
                        tooltip: 'Settings',
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.orange,
                        ),
                        onPressed: () => showStoreDialog(context, ref: ref),
                        tooltip: 'Store',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
