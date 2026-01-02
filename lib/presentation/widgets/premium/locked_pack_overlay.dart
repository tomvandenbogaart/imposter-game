import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class LockedPackOverlay extends StatelessWidget {
  final VoidCallback? onUnlockPressed;

  const LockedPackOverlay({
    super.key,
    this.onUnlockPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.lock_outline,
            color: AppColors.gold,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Premium Pack',
            style: AppTypography.playerName.copyWith(
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onUnlockPressed ?? () => context.push('/store'),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.gold.withValues(alpha: 0.2),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Unlock All Packs',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
