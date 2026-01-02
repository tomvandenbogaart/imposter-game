import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/word_pack_provider.dart';
import '../dialogs/store_dialog.dart';
import 'word_pack_card.dart';

/// Word pack selector for online multiplayer lobby.
/// Unlike [WordPackSelector], this takes a selectedPackId and callback
/// instead of using local game provider.
class OnlineWordPackSelector extends ConsumerWidget {
  final String? selectedPackId;
  final ValueChanged<String?> onPackSelected;

  const OnlineWordPackSelector({
    super.key,
    required this.selectedPackId,
    required this.onPackSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordPacksAsync = ref.watch(wordPacksWithAccessProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Word Pack',
          style: AppTypography.h3,
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
                          onPackSelected(packWithAccess.pack.id);
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
                'Failed to load packs',
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
