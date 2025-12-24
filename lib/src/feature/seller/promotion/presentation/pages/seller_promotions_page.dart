import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/seller/promotion/model/seller_promotion.dart';
import 'package:haji_market/src/feature/seller/promotion/presentation/widgets/promotion_card.dart';

@RoutePage()
class SellerPromotionsPage extends StatefulWidget {
  const SellerPromotionsPage({super.key});

  @override
  State<SellerPromotionsPage> createState() => _SellerPromotionsPageState();
}

class _SellerPromotionsPageState extends State<SellerPromotionsPage> {
  late List<SellerPromotion> _promotions;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _promotions = <SellerPromotion>[
      SellerPromotion(
        id: 'summer-sale',
        title: 'Летняя распродажа',
        scope: PromotionScope.allProducts,
        discountPercent: 10,
        startDate: now.subtract(const Duration(days: 1)),
        endDate: now.add(const Duration(days: 12)),
      ),
      SellerPromotion(
        id: 'new-collection',
        title: 'Скидка на новую коллекцию',
        scope: PromotionScope.manual,
        discountPercent: 15,
        startDate: now.add(const Duration(days: 3)),
        endDate: now.add(const Duration(days: 20)),
      ),
    ];
  }

  Future<void> _openEditor({SellerPromotion? promotion}) async {
    final result = await context.pushRoute<SellerPromotion?>(
      SellerPromotionEditorRoute(initialPromotion: promotion),
    );

    if (!mounted || result == null) return;

    setState(() {
      final index = _promotions.indexWhere((p) => p.id == result.id);
      if (index >= 0) {
        _promotions[index] = result;
      } else {
        _promotions.insert(0, result);
      }
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.icons.framePromotion.path, width: 120),
            const SizedBox(height: 24),
            const Text(
              'Пока здесь пусто',
              style: AppTextStyles.defaultButtonTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Добавьте первую акцию, чтобы выделить товары и привлечь покупателей.',
              style: AppTextStyles.size14Weight400.copyWith(color: AppColors.kGray600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final promotion = _promotions[index];
        return PromotionCard(
          promotion: promotion,
          onTap: () => _openEditor(promotion: promotion),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: _promotions.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray1,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CustomBackButton(onTap: () => context.router.pop()),
        ),
        title: const Text('Акции', style: AppTextStyles.appBarTextStyle),
      ),
      body: _promotions.isEmpty ? _buildEmptyState() : _buildList(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainPurpleColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: () => _openEditor(),
            child: const Text('Добавить новую акцию', style: AppTextStyles.defButtonTextStyle),
          ),
        ),
      ),
    );
  }
}
