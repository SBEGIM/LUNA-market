import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';

// ignore: unused_element
const _tag = 'BaseNew';

class BaseAdminNew extends StatefulWidget {
  const BaseAdminNew({super.key});

  @override
  _BaseAdminNewState createState() => _BaseAdminNewState();
}

class _BaseAdminNewState extends State<BaseAdminNew> with TickerProviderStateMixin {
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
        MyProductsAdminRoute(),
        ChatAdminRoute(),
        MyOrdersAdminRoute(),
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
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/date.svg',
                color: AppColors.kGray200,
              ),
              label: 'Мои товары',
              activeIcon: SvgPicture.asset(
                'assets/icons/date.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/chat_2.svg',
                color: AppColors.kGray200,
              ),
              label: 'Чат',
              activeIcon: SvgPicture.asset(
                'assets/icons/chat_2.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/docs.svg',
                color: AppColors.kGray200,
              ),
              label: 'Заказы',
              activeIcon: SvgPicture.asset(
                'assets/icons/docs.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/account.svg',
                color: AppColors.kGray200,
              ),
              label: 'Профиль',
              activeIcon: SvgPicture.asset(
                'assets/icons/account.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
