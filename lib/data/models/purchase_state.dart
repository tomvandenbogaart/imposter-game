import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_state.freezed.dart';

enum AppPurchaseStatus {
  idle,
  loading,
  purchasing,
  verifying,
  success,
  error,
  restored,
}

@freezed
class PurchaseState with _$PurchaseState {
  const factory PurchaseState({
    @Default(AppPurchaseStatus.idle) AppPurchaseStatus status,
    String? currentProductId,
    String? errorMessage,
    @Default(0) int restoredCount,
  }) = _PurchaseState;
}
