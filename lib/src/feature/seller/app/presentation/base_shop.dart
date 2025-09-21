import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import '../../../basket/presentation/widgets/show_alert_country_widget.dart';
import '../../../drawer/bloc/country_cubit.dart' as countryCubit;

// ignore: unused_element
const _tag = 'BaseNew';

class BaseShop extends StatefulWidget {
  const BaseShop({super.key});

  @override
  _BaseShopState createState() => _BaseShopState();
}

class _BaseShopState extends State<BaseShop> with TickerProviderStateMixin {
  TabController? tabController;
  int? previousIndex;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  // final activeColorFilter = const ColorFilter.mode(AppColors.kGrey400, BlendMode.srcIn);
  // final disabledColorFilter = const ColorFilter.mode(AppColors.kSecondary100, BlendMode.srcIn);

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
        return SafeArea(
          bottom: false,
          child: child,
        );
      },
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   AutoTabsRouter.of(context).setActiveIndex(2);
      // }),
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
          height: 94,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: Color(0x100F0F0F), width: 1), // stroke сверху
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (int index) {
              if (tabsRouter.activeIndex == index) {
                tabsRouter.popTop();
              } else {
                // bool exists = GetStorage().hasData('shop_location_code');
                // String? city = GetStorage().read('city_shop');

                // if (!exists && (index != 1)) {
                //   // Get.showSnackbar(
                //   // Get.closeCurrentSnackbar();
                //   Get.snackbar(
                //     'СДЕК магазин',
                //     city != null
                //         ? 'Ваш город $city?'
                //         : 'Ваш город неизвестен для cрока доставки!',
                //     icon: const Icon(Icons.add_location_sharp),
                //     duration: const Duration(seconds: 30),
                //     backgroundColor: Colors.orangeAccent,
                //     onTap: (snack) {
                //       Get.closeCurrentSnackbar();

                //       Future.wait([
                //         BlocProvider.of<countryCubit.CountryCubit>(context)
                //             .country()
                //       ]);
                //       showAlertCountryWidget(context, () {
                //         // context.router.pop();
                //         // setState(() {});
                //       }, true);
                //     },
                //   );
                //   //  / );

                // }
                tabsRouter.setActiveIndex(index);
              }
            },
            selectedItemColor: AppColors.kLightBlackColor,
            unselectedItemColor: AppColors.kunSelectColor,
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
                  color: Colors.black,
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
