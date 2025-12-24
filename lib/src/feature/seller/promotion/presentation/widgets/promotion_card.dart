import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/promotion/model/seller_promotion.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({
    super.key,
    required this.promotion,
    this.onTap,
  });

  final SellerPromotion promotion;
  final VoidCallback? onTap;

  Color _statusColor(PromotionLifecycle lifecycle) {
    switch (lifecycle) {
      case PromotionLifecycle.active:
        return AppColors.mainGreenColor;
      case PromotionLifecycle.upcoming:
        return AppColors.kGray400;
      case PromotionLifecycle.finished:
        return AppColors.kGray4;
    }
  }

  String _statusLabel(PromotionLifecycle lifecycle) {
    switch (lifecycle) {
      case PromotionLifecycle.active:
        return 'Активна';
      case PromotionLifecycle.upcoming:
        return 'Запланирована';
      case PromotionLifecycle.finished:
        return 'Завершена';
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = promotion.lifecycle;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.kGray2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A0F0F0F),
              offset: Offset(0, 6),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    promotion.title,
                    style: AppTextStyles.size16Weight600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.mainBackgroundPurpleColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '-${promotion.discountPercent}%',
                    style: AppTextStyles.size16Weight600.copyWith(color: AppColors.mainPurpleColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _statusColor(status).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _statusLabel(status),
                    style: AppTextStyles.size13Weight500.copyWith(color: _statusColor(status)),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.kGray4,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    promotion.scopeLabel,
                    style: AppTextStyles.size14Weight400.copyWith(color: AppColors.kGray700),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              promotion.periodLabel,
              style: AppTextStyles.size14Weight400.copyWith(color: AppColors.kGray600),
            ),
          ],
        ),
      ),
    );
  }
}
