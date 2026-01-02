import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class WordPackCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onTap;

  const WordPackCard({
    super.key,
    required this.name,
    required this.isSelected,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor;
    if (isSelected) {
      borderColor = AppColors.orange;
    } else if (isLocked) {
      borderColor = AppColors.gold.withValues(alpha: 0.5);
    } else {
      borderColor = AppColors.surfaceLight;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surface : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            // Pack name centered
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  name,
                  style: AppTypography.bodySmall.copyWith(
                    color: isLocked ? AppColors.textMuted : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Lock icon for premium packs
            if (isLocked)
              Positioned(
                top: 6.h,
                right: 6.w,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    size: 12.sp,
                    color: AppColors.gold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
