import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/models.dart';

class VoteCard extends StatelessWidget {
  final LocalPlayer player;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;
  final int? voteCount;
  final bool isImposter;
  final bool showResult;

  const VoteCard({
    super.key,
    required this.player,
    this.isSelected = false,
    this.isDisabled = false,
    this.onTap,
    this.voteCount,
    this.isImposter = false,
    this.showResult = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = showResult && isImposter
        ? AppColors.imposterGradient
        : isSelected
            ? AppColors.primaryGradient
            : AppColors.surfaceGradient;

    final borderColor = showResult && isImposter
        ? AppColors.imposterRed
        : isSelected
            ? AppColors.gold
            : AppColors.surfaceLight;

    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: isSelected || (showResult && isImposter) ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.orange.withValues(alpha: 0.4),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                player.name,
                style: AppTypography.h3.copyWith(
                  color: isDisabled
                      ? AppColors.textMuted
                      : isSelected
                          ? AppColors.background
                          : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (showResult && isImposter) ...[
                SizedBox(height: 8.h),
                Text(
                  '😈',
                  style: TextStyle(fontSize: 24.sp),
                ),
              ],
              if (voteCount != null) ...[
                SizedBox(height: 8.h),
                Text(
                  '$voteCount vote${voteCount == 1 ? '' : 's'}',
                  style: AppTypography.caption.copyWith(
                    color: isSelected ? AppColors.background : AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
