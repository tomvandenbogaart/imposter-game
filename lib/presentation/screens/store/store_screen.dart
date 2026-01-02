import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/purchase_state.dart';
import '../../providers/iap_provider.dart';
import '../../providers/entitlement_provider.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(storeProductsProvider);
    final purchaseState = ref.watch(purchaseNotifierProvider);
    final entitlements = ref.watch(entitlementNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Store', style: AppTypography.h2),
      ),
      body: SafeArea(
        child: productsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.orange),
          ),
          error: (e, _) => _buildError(context, ref, e.toString()),
          data: (products) => _buildContent(
            context,
            ref,
            products,
            purchaseState,
            entitlements.valueOrNull,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<ProductDetails> products,
    PurchaseState purchaseState,
    dynamic entitlements,
  ) {
    // Sort products: bundle first (featured), then others
    final sortedProducts = _sortProducts(products);
    final hasNoAds = entitlements?.hasNoAds ?? false;
    final hasAllPacks = entitlements?.hasAllPacks ?? false;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Text(
            'Unlock Premium Features',
            style: AppTypography.h3,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 8),

          Text(
            'Support development and enhance your experience',
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

          const SizedBox(height: 24),

          // Status messages
          if (purchaseState.status == AppPurchaseStatus.error)
            _buildStatusBanner(
              purchaseState.errorMessage ?? 'Purchase failed',
              isError: true,
            ),

          if (purchaseState.status == AppPurchaseStatus.success)
            _buildStatusBanner('Purchase successful!', isError: false),

          if (purchaseState.status == AppPurchaseStatus.restored)
            _buildStatusBanner(
              purchaseState.restoredCount > 0
                  ? '${purchaseState.restoredCount} purchase(s) restored!'
                  : 'No purchases to restore',
              isError: false,
            ),

          if (purchaseState.status != AppPurchaseStatus.idle)
            const SizedBox(height: 16),

          // Product cards
          ...sortedProducts.asMap().entries.map((entry) {
            final index = entry.key;
            final product = entry.value;
            final isBundle = product.id == 'packs_no_ads';
            final isOwned = _isProductOwned(product.id, hasNoAds, hasAllPacks);
            final isLoading = purchaseState.status == AppPurchaseStatus.loading ||
                purchaseState.status == AppPurchaseStatus.purchasing ||
                purchaseState.status == AppPurchaseStatus.verifying;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProductCard(
                product: product,
                isBundle: isBundle,
                isOwned: isOwned,
                isLoading: isLoading,
                onPurchase: () => ref
                    .read(purchaseNotifierProvider.notifier)
                    .purchase(product),
              ).animate().fadeIn(
                    delay: Duration(milliseconds: 200 + (index * 100)),
                    duration: 400.ms,
                  ),
            );
          }),

          const SizedBox(height: 24),

          // Comparison table
          _buildComparisonTable(hasNoAds, hasAllPacks)
              .animate()
              .fadeIn(delay: 500.ms, duration: 400.ms),

          const SizedBox(height: 24),

          // Restore purchases button
          OutlinedButton.icon(
            onPressed: purchaseState.status == AppPurchaseStatus.loading
                ? null
                : () => ref
                    .read(purchaseNotifierProvider.notifier)
                    .restorePurchases(),
            icon: const Icon(Icons.restore, color: AppColors.orange),
            label: Text(
              'Restore Purchases',
              style: AppTypography.button.copyWith(color: AppColors.orange),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.orange),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

          const SizedBox(height: 16),

          // Legal text
          Text(
            'Purchases are processed by ${_storeName}. '
            'All purchases are one-time payments.',
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
        ],
      ),
    );
  }

  List<ProductDetails> _sortProducts(List<ProductDetails> products) {
    final order = {'packs_no_ads': 0, 'all_packs': 1, 'remove_ads': 2};
    return [...products]
      ..sort((a, b) => (order[a.id] ?? 99).compareTo(order[b.id] ?? 99));
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

  String get _storeName {
    return Platform.isIOS ? 'Apple App Store' : 'Google Play';
  }

  Widget _buildError(BuildContext context, WidgetRef ref, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Failed to load store', style: AppTypography.h3),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.invalidate(storeProductsProvider),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orange,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(String message, {required bool isError}) {
    final color = isError ? AppColors.error : AppColors.success;
    final icon = isError ? Icons.error_outline : Icons.check_circle_outline;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: AppTypography.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonTable(bool hasNoAds, bool hasAllPacks) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What you get', style: AppTypography.playerName),
          const SizedBox(height: 16),
          _ComparisonRow(
            feature: 'Ad-free experience',
            removeAds: true,
            allPacks: false,
            bundle: true,
          ),
          _ComparisonRow(
            feature: 'All word packs',
            removeAds: false,
            allPacks: true,
            bundle: true,
          ),
          _ComparisonRow(
            feature: 'Future packs included',
            removeAds: false,
            allPacks: true,
            bundle: true,
          ),
          _ComparisonRow(
            feature: 'Support development',
            removeAds: true,
            allPacks: true,
            bundle: true,
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductDetails product;
  final bool isBundle;
  final bool isOwned;
  final bool isLoading;
  final VoidCallback onPurchase;

  const _ProductCard({
    required this.product,
    required this.isBundle,
    required this.isOwned,
    required this.isLoading,
    required this.onPurchase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isBundle ? AppColors.primaryGradient : null,
        color: isBundle ? null : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isBundle ? Colors.transparent : AppColors.surfaceLight,
          width: isBundle ? 0 : 1,
        ),
        boxShadow: isBundle
            ? [
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isBundle)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'BEST VALUE',
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (isBundle) const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: AppTypography.h3.copyWith(
                          color:
                              isBundle ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.description,
                        style: AppTypography.bodySmall.copyWith(
                          color: isBundle
                              ? Colors.white.withOpacity(0.8)
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product.price,
                      style: AppTypography.h2.copyWith(
                        color: isBundle ? Colors.white : AppColors.gold,
                      ),
                    ),
                    Text(
                      'one-time',
                      style: AppTypography.caption.copyWith(
                        color: isBundle
                            ? Colors.white.withOpacity(0.7)
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: isOwned
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle,
                              color: AppColors.success),
                          const SizedBox(width: 8),
                          Text(
                            'Owned',
                            style: AppTypography.button.copyWith(
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ElevatedButton(
                      onPressed: isLoading ? null : onPurchase,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isBundle ? Colors.white : AppColors.orange,
                        foregroundColor:
                            isBundle ? AppColors.background : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: (isBundle
                                ? Colors.white
                                : AppColors.orange)
                            .withOpacity(0.5),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text('Purchase', style: AppTypography.button),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String feature;
  final bool removeAds;
  final bool allPacks;
  final bool bundle;

  const _ComparisonRow({
    required this.feature,
    required this.removeAds,
    required this.allPacks,
    required this.bundle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(feature, style: AppTypography.bodySmall),
          ),
          _buildCheck(removeAds),
          _buildCheck(allPacks),
          _buildCheck(bundle),
        ],
      ),
    );
  }

  Widget _buildCheck(bool value) {
    return Expanded(
      child: Icon(
        value ? Icons.check_circle : Icons.remove_circle_outline,
        color: value ? AppColors.success : AppColors.textMuted,
        size: 20,
      ),
    );
  }
}
