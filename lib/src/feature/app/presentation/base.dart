import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/bloc/country_cubit.dart'
    as countryCubit;
import '../../basket/presentation/widgets/show_alert_country_widget.dart';

// ignore: unused_element
const _tag = 'Base';

class Base extends StatefulWidget {
  final int? index;
  const Base({super.key, this.index});

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> with TickerProviderStateMixin {
  TabController? tabController;
  int? previousIndex;
  String? address;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 2);
    if (widget.index != null) {
      tabController?.animateTo(widget.index!,
          duration: const Duration(milliseconds: 500));
      log('message');
    }
    super.initState();
  }

  // final activeColorFilter = const ColorFilter.mode(AppColors.kGrey400, BlendMode.srcIn);
  // final disabledColorFilter = const ColorFilter.mode(AppColors.kSecondary100, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // endDrawer: BaseDrawer(),
      routes: [
        const BaseTapeTab(),
        HomeRoute(),
        const FavoriteRoute(),
        const BasketRoute(),
        const DrawerRoute(),
      ],
      // homeIndex: widget.index ?? -1,
      backgroundColor: tabController?.index != 0 ? Colors.white : null,
      extendBody: true,
      transitionBuilder: (context, child, animation) {
        return child;
      },
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   AutoTabsRouter.of(context).setActiveIndex(2);
      // }),
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (int index) {
            if (tabsRouter.activeIndex == index) {
              tabsRouter.pop();
            } else {
              tabsRouter.setActiveIndex(index);

              bool exists = GetStorage().hasData('user_location_code');
              String? city = GetStorage().read('city');

              if (!exists && (index == 1 || index == 3)) {
                // Get.showSnackbar(

                Get.snackbar(
                  'СДЕК',
                  city != null
                      ? 'Ваш город $city?'
                      : 'Ваш город неизвестен для доставки!',
                  icon: const Icon(Icons.add_location_sharp),
                  duration: const Duration(seconds: 30),
                  backgroundColor: Colors.orangeAccent,
                  onTap: (snack) {
                    Get.closeCurrentSnackbar();

                    Future.wait([
                      BlocProvider.of<countryCubit.CountryCubit>(context)
                          .country()
                    ]);
                    showAlertCountryWidget(context, () {
                      // context.router.pop();
                      //  setState(() {});
                    }, false);
                  },
                );
                //  / );
              }
            }
          },
          selectedItemColor: AppColors.kLightBlackColor,
          unselectedItemColor: AppColors.kGray200,
          selectedFontSize: 12,
          elevation: 4,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor:
              tabsRouter.activeIndex == 0 ? Colors.transparent : Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.icons.rollsBottomIcon.path,
                scale: 1.9,
                color: AppColors.kunSelectColor,
              ),
              label: 'Roolls',
              activeIcon: Image.asset(
                Assets.icons.rollsBotoomFullIcon.path,
                scale: 1.9,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.icons.sellerNavigationIcon.path,
                scale: 1.9,
                color: AppColors.kunSelectColor,
              ),
              label: 'Маркет',
              activeIcon: Image.asset(
                Assets.icons.sellerNavigationIcon.path,
                scale: 1.9,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.icons.favoriteBottomIcon.path,
                scale: 1.9,
                color: AppColors.kunSelectColor,
              ),
              label: 'Избранное',
              activeIcon: Image.asset(
                Assets.icons.favoriteBottomIcon.path,
                scale: 1.9,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.icons.basketBottomIcon.path,
                scale: 1.9,
                color: AppColors.kunSelectColor,
              ),
              label: 'Корзина',
              activeIcon: Image.asset(
                Assets.icons.basketBottomIcon.path,
                scale: 1.9,
                color: Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.icons.accountBottomIcon.path,
                scale: 1.9,
                color: AppColors.kunSelectColor,
              ),
              label: 'Профиль',
              activeIcon: Image.asset(
                Assets.icons.accountBottomFullIcon.path,
                scale: 1.9,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
