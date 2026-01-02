import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/word_pack_provider.dart';
import '../../widgets/dialogs/store_dialog.dart';

class LocalWordPacksScreen extends ConsumerWidget {
  const LocalWordPacksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);
    final wordPacksByCategoryAsync = ref.watch(wordPacksByCategoryProvider);
    final selectedPackId = gameState.settings.selectedPackId;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.wordPackSelector_title,
          style: AppTypography.h2,
        ),
      ),
      body: SafeArea(
        child: wordPacksByCategoryAsync.when(
          data: (packsByCategory) {
            final categories = packsByCategory.keys.toList();
            int itemIndex = 0;

            return ListView.builder(
              padding: EdgeInsets.all(24.w),
              itemCount: categories.length,
              itemBuilder: (context, categoryIndex) {
                final category = categories[categoryIndex];
                final packs = packsByCategory[category]!;
                final categoryName =
                    categoryDisplayNames[category] ?? category.toUpperCase();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (categoryIndex > 0) SizedBox(height: 24.h),
                    _CategoryHeader(name: categoryName),
                    SizedBox(height: 12.h),
                    ...packs.map((packWithAccess) {
                      final isSelected = selectedPackId == packWithAccess.pack.id;
                      final isLocked = !packWithAccess.isUnlocked;
                      final currentIndex = itemIndex++;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _WordPackTile(
                          name: packWithAccess.pack.name,
                          isSelected: isSelected,
                          isLocked: isLocked,
                          isFree: !packWithAccess.pack.isPremium,
                          onTap: () {
                            if (isLocked) {
                              showStoreDialog(context, ref: ref);
                            } else {
                              ref.read(localGameProvider.notifier).setSelectedPack(
                                packWithAccess.pack.id,
                              );
                              context.pop();
                            }
                          },
                        ).animate().fadeIn(
                          delay: Duration(milliseconds: 30 * currentIndex),
                          duration: 300.ms,
                        ),
                      );
                    }),
                  ],
                );
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (e, _) => Center(
            child: Text(
              context.l10n.error_failedToLoadPacks,
              style: AppTypography.body.copyWith(color: AppColors.error),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String name;

  const _CategoryHeader({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        name.toUpperCase(),
        style: AppTypography.caption.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _WordPackTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final bool isLocked;
  final bool isFree;
  final VoidCallback onTap;

  const _WordPackTile({
    required this.name,
    required this.isSelected,
    required this.isLocked,
    required this.isFree,
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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: AppTypography.body.copyWith(
                        color: isLocked ? AppColors.textMuted : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  if (isFree) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'FREE',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (isLocked)
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lock_rounded,
                  size: 16.sp,
                  color: AppColors.gold,
                ),
              ),
            if (isSelected && !isLocked)
              Icon(
                Icons.check_circle_rounded,
                size: 24.sp,
                color: AppColors.orange,
              ),
          ],
        ),
      ),
    );
  }
}
