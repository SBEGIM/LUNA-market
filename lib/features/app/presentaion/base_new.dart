import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';

// ignore: unused_element
const _tag = 'BaseNew';

class BaseNew extends StatefulWidget {
  final int? index;
  const BaseNew({super.key, this.index});

  @override
  _BaseNewState createState() => _BaseNewState();
}

class _BaseNewState extends State<BaseNew> with TickerProviderStateMixin {
  TabController? tabController;
  int? previousIndex;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this,initialIndex: 2);
    if(widget.index!=null){
      tabController?.animateTo(widget.index!,duration: const Duration(milliseconds: 500));
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
      homeIndex: widget.index??-1,
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
              tabsRouter.popTop();
            } else {
              tabsRouter.setActiveIndex(index);
            }
          },
          selectedItemColor: AppColors.kPrimaryColor,
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
              icon: SvgPicture.asset(
                'assets/icons/tape.svg',
                color: AppColors.kGray200,
              ),
              label: 'Лента',
              activeIcon: SvgPicture.asset(
                'assets/icons/tape.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/store.svg',
                color: AppColors.kGray200,
              ),
              label: 'Маркет',
              activeIcon: SvgPicture.asset(
                'assets/icons/store.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/favorite.svg',
                color: AppColors.kGray200,
              ),
              label: 'Избранное',
              activeIcon: SvgPicture.asset(
                'assets/icons/heart_fill.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/basket.svg',
                color: AppColors.kGray200,
              ),
              label: 'Корзина',
              activeIcon: SvgPicture.asset(
                'assets/icons/basket.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/ionMenu.svg',
                color: AppColors.kGray200,
              ),
              label: 'Меню',
              activeIcon: SvgPicture.asset(
                'assets/icons/ionMenu.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
