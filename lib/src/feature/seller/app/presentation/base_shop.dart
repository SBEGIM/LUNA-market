import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

class BaseShop extends StatefulWidget {
  const BaseShop({super.key});

  @override
  State<BaseShop> createState() => _BaseShopState();
}

class _BaseShopState extends State<BaseShop> with TickerProviderStateMixin {
  TabController? tabController;
  int? previousIndex;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // endDrawer: BaseDrawer(),
      routes: const [
        HomeSellerAdminRoute(),
        MyProductsAdminRoute(),
        ChatSellerRoute(),
        MyOrdersSellerRoute(),
        ProfileAdminRoute(),
      ],
      backgroundColor: Colors.white,
      extendBody: true,
      transitionBuilder: (context, child, animation) {
        return SafeArea(bottom: false, child: child);
      },
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          height: 94,
          decoration: const BoxDecoration(
            color: AppColors.kWhite,
            border: Border(
              top: BorderSide(color: Color(0x100F0F0F), width: 1), // stroke сверху
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (int index) {
              if (tabsRouter.activeIndex == index) {
                tabsRouter.popTop();
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
            selectedItemColor: AppColors.kLightBlackColor,
            unselectedItemColor: AppColors.kunSelectColor,
            backgroundColor: AppColors.kWhite,
            selectedFontSize: 12,
            elevation: 4,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: AppTextStyles.navigationSelectLabelStyle,
            unselectedLabelStyle: AppTextStyles.navigationUnSelectLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.sellerHomeNavigationIcon.path,
                  scale: 1.9,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Главная',
                activeIcon: Image.asset(
                  Assets.icons.sellerHomeNavigationFullIcon.path,
                  scale: 1.9,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.sellerMyProductsNavigationIcon.path,
                  scale: 1.9,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Мои товары',
                activeIcon: Image.asset(
                  Assets.icons.sellerNavigationProductFullIcon.path,
                  scale: 1.9,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.sellerNavigationChatIcon.path,
                  scale: 1.9,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Чат',
                activeIcon: SvgPicture.asset(
                  'assets/icons/chat_2.svg',
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.subListIcon.path,
                  color: AppColors.kunSelectColor,
                  scale: 1.9,
                ),
                label: 'Заказы',
                activeIcon: Image.asset(
                  Assets.icons.subListIcon.path,
                  color: AppColors.kLightBlackColor,
                  scale: 1.9,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.sellerNavigationUnfullIcon.path,
                  color: AppColors.kunSelectColor,
                  scale: 1.9,
                ),
                label: 'Профиль',
                activeIcon: Image.asset(
                  Assets.icons.sellerNavigationIcon.path,
                  scale: 1.9,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
