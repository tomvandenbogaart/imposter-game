import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/purchase_state.dart';
import '../../providers/iap_provider.dart';
import '../../providers/entitlement_provider.dart';

/// Shows the store dialog
Future<void> showStoreDialog(BuildContext context, {WidgetRef? ref}) {
  // Reset any stale purchase state before showing the dialog
  ref?.read(purchaseNotifierProvider.notifier).resetState();

  return showDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    builder: (context) => const _StoreDialogContent(),
  );
}

class _StoreDialogContent extends ConsumerStatefulWidget {
  const _StoreDialogContent();

  @override
  ConsumerState<_StoreDialogContent> createState() => _StoreDialogContentState();
}

class _StoreDialogContentState extends ConsumerState<_StoreDialogContent>
    with SingleTickerProviderStateMixin {
  static const _bundleProductId = 'packs_no_ads';
  static const _productOrder = ['packs_no_ads', 'all_packs', 'remove_ads'];

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<ProductDetails> _sortProducts(List<ProductDetails> products) {
    final sorted = <ProductDetails>[];
    for (final id in _productOrder) {
      final product = products.where((p) => p.id == id).firstOrNull;
      if (product != null) {
        sorted.add(product);
      }
    }
    for (final product in products) {
      if (!_productOrder.contains(product.id)) {
        sorted.add(product);
      }
    }
    return sorted;
  }

  bool _isProductOwned(String productId, bool hasNoAds, bool hasAllPacks) {
    switch (productId) {
      case 'remove_ads':
        return hasNoAds;
      case 'all_packs':
        return hasAllPacks;
      case 'packs_no_ads':
        return hasNoAds && hasAllPacks;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(storeProductsProvider);
    final purchaseState = ref.watch(purchaseNotifierProvider);
    final entitlementsAsync = ref.watch(entitlementNotifierProvider);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 32), // Balance the close button
                    Text('Store', style: AppTypography.h3),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textMuted),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Products - wait for both products AND entitlements to load
                entitlementsAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                  error: (_, __) => _buildProductsSection(
                    productsAsync,
                    purchaseState,
                    ref,
                    hasNoAds: false,
                    hasAllPacks: false,
                  ),
                  data: (entitlements) => _buildProductsSection(
                    productsAsync,
                    purchaseState,
                    ref,
                    hasNoAds: entitlements.hasNoAds,
                    hasAllPacks: entitlements.hasAllPacks,
                  ),
                ),
                const SizedBox(height: 16),
                // Restore purchases
                _buildRestoreButton(
                  isLoading: purchaseState.status == AppPurchaseStatus.loading,
                  onPressed: () => ref.read(purchaseNotifierProvider.notifier).restorePurchases(),
                ),
                // Status messages
                _buildStatusMessage(purchaseState),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection(
    AsyncValue<List<ProductDetails>> productsAsync,
    PurchaseState purchaseState,
    WidgetRef ref, {
    required bool hasNoAds,
    required bool hasAllPacks,
  }) {
    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'No products available',
              style: AppTypography.body.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          );
        }
        final sortedProducts = _sortProducts(products);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildProductList(
            sortedProducts,
            purchaseState,
            ref,
            hasNoAds: hasNoAds,
            hasAllPacks: hasAllPacks,
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(24),
        child: CircularProgressIndicator(),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Failed to load products',
          style: AppTypography.body.copyWith(color: AppColors.error),
        ),
      ),
    );
  }

  List<Widget> _buildProductList(
    List<ProductDetails> products,
    PurchaseState purchaseState,
    WidgetRef ref, {
    required bool hasNoAds,
    required bool hasAllPacks,
  }) {
    final widgets = <Widget>[];
    for (int i = 0; i < products.length; i++) {
      final product = products[i];
      final isBundle = product.id == _bundleProductId;
      final isOwned = _isProductOwned(product.id, hasNoAds, hasAllPacks);

      // Add spacing between items, extra space before bundle for the badge
      if (i > 0) {
        widgets.add(SizedBox(height: isBundle ? 16 : 8));
      } else if (isBundle) {
        // First item is bundle, add top padding for badge
        widgets.add(const SizedBox(height: 8));
      }

      final isInProgress = (purchaseState.status == AppPurchaseStatus.loading ||
          purchaseState.status == AppPurchaseStatus.purchasing ||
          purchaseState.status == AppPurchaseStatus.verifying) &&
          purchaseState.currentProductId == product.id;
      widgets.add(
        _buildProductTile(
          context: ref.context,
          product: product,
          displayName: product.title,
          isBundle: isBundle,
          isOwned: isOwned,
          isLoading: isInProgress,
          onPurchase: () => ref.read(purchaseNotifierProvider.notifier).purchase(product),
        ),
      );
    }
    return widgets;
  }

  Widget _buildProductTile({
    required BuildContext context,
    required ProductDetails product,
    required String displayName,
    required bool isBundle,
    required bool isOwned,
    required bool isLoading,
    required VoidCallback onPurchase,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (isLoading || isOwned) ? null : onPurchase,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: isOwned ? AppColors.success.withAlpha(25) : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isOwned
                      ? AppColors.success
                      : (isBundle ? AppColors.gold : AppColors.surfaceLight),
                  width: (isBundle || isOwned) ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  // Product name
                  Expanded(
                    child: Text(
                      displayName,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Price on the right (fixed width to prevent layout shift)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    constraints: const BoxConstraints(minWidth: 70),
                    decoration: BoxDecoration(
                      color: isOwned ? AppColors.success : AppColors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isLoading
                        ? const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            isOwned ? '✓' : product.price,
                            textAlign: TextAlign.center,
                            style: AppTypography.body.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // "Best" badge at the top center for bundle (hide if owned)
        if (isBundle && !isOwned)
          Positioned(
            top: -10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'BEST',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.background,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRestoreButton({
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: isLoading ? null : AppColors.primaryGradient,
        color: isLoading ? AppColors.surfaceLight : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isLoading
            ? null
            : [
                BoxShadow(
                  color: AppColors.orange.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textMuted,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.restore,
                        color: AppColors.background,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Restore Purchases',
                        style: AppTypography.button.copyWith(
                          color: AppColors.background,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusMessage(PurchaseState state) {
    if (state.status == AppPurchaseStatus.success) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          'Purchase successful!',
          style: AppTypography.caption.copyWith(color: AppColors.success),
        ),
      );
    }
    if (state.status == AppPurchaseStatus.restored) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          state.restoredCount > 0
              ? '${state.restoredCount} purchase(s) restored'
              : 'No purchases to restore',
          style: AppTypography.caption.copyWith(color: AppColors.textMuted),
        ),
      );
    }
    if (state.status == AppPurchaseStatus.error) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          state.errorMessage ?? 'Purchase failed',
          style: AppTypography.caption.copyWith(color: AppColors.error),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
