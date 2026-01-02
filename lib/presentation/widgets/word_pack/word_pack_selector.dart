import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/local_game_provider.dart';
import '../../providers/word_pack_provider.dart';
import '../dialogs/store_dialog.dart';
import 'word_pack_card.dart';

class WordPackSelector extends ConsumerWidget {
  final VoidCallback onViewAll;

  const WordPackSelector({
    super.key,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(localGameProvider);
    final wordPacksAsync = ref.watch(wordPacksWithAccessProvider);
    final selectedPackId = gameState.settings.selectedPackId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.wordPackSelector_title,
              style: AppTypography.h3,
            ),
            GestureDetector(
              onTap: onViewAll,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.wordPackSelector_viewAll,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.orange,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 18.sp,
                    color: AppColors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Pack cards horizontal list
        SizedBox(
          height: 88.h,
          child: wordPacksAsync.when(
            data: (packsWithAccess) {
              // Sort packs: unlocked first, then locked
              final sortedPacks = [...packsWithAccess]
                ..sort((a, b) {
                  if (a.isUnlocked && !b.isUnlocked) return -1;
                  if (!a.isUnlocked && b.isUnlocked) return 1;
                  return 0;
                });

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sortedPacks.length,
                itemBuilder: (context, index) {
                  final packWithAccess = sortedPacks[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: WordPackCard(
                      name: packWithAccess.pack.name,
                      isSelected: selectedPackId == packWithAccess.pack.id,
                      isLocked: !packWithAccess.isUnlocked,
                      onTap: () {
                        if (!packWithAccess.isUnlocked) {
                          // Show store dialog for locked packs
                          showStoreDialog(context, ref: ref);
                        } else {
                          ref.read(localGameProvider.notifier).setSelectedPack(
                            packWithAccess.pack.id,
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
            loading: () => Center(
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (e, _) => Center(
              child: Text(
                context.l10n.error_failedToLoadPacks,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
