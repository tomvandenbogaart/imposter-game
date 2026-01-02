import 'package:freezed_annotation/freezed_annotation.dart';

part 'entitlement.freezed.dart';
part 'entitlement.g.dart';

@freezed
class Entitlement with _$Entitlement {
  const factory Entitlement({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'product_id') required String productId,
    @Default('iap') String source,
    @JsonKey(name: 'granted_at') DateTime? grantedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Entitlement;

  factory Entitlement.fromJson(Map<String, dynamic> json) =>
      _$EntitlementFromJson(json);
}

/// User's combined entitlements state
@freezed
class UserEntitlements with _$UserEntitlements {
  const UserEntitlements._();

  const factory UserEntitlements({
    @Default(false) bool hasNoAds,
    @Default(false) bool hasAllPacks,
    @Default([]) List<Entitlement> rawEntitlements,
  }) = _UserEntitlements;

  bool get hasPremium => hasNoAds || hasAllPacks;
  bool get hasBundle => hasNoAds && hasAllPacks;
}
