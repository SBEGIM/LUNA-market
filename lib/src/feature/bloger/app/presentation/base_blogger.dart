import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import '../../../../core/constant/generated/assets.gen.dart';

// ignore: unused_element
const _tag = 'BaseBloggerNew';

class BaseBlogger extends StatefulWidget {
  const BaseBlogger({super.key});

  @override
  _BaseBloggerState createState() => _BaseBloggerState();
}

class _BaseBloggerState extends State<BaseBlogger>
    with TickerProviderStateMixin {
  TabController? tabController;
  int? previousIndex;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  // final activeColorFilter = const ColorFilter.mode(AppColors.kGrey400, BlendMode.srcIn);
  // final disabledColorFilter = const ColorFilter.mode(AppColors.kSecondary100, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // endDrawer: BaseDrawer(),
      routes: const [
        BlogShopsRoute(),
        BaseAdminTapeTab(),
        ProfileBloggerRoute(),
      ],
      backgroundColor: tabController?.index != 1 ? Colors.white : null,
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
          selectedItemColor: AppColors.kLightBlackColor,
          unselectedItemColor: AppColors.kunSelectColor,
          selectedLabelStyle: AppTextStyles.navigationSelectLabelStyle,
          unselectedLabelStyle: AppTextStyles.navigationUnSelectLabelStyle,
          selectedFontSize: 12,
          elevation: 4,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor:
              tabsRouter.activeIndex == 1 ? Colors.white : Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shop1.svg',
                color: AppColors.kGray200,
                height: 19.5,
                width: 19.5,
              ),
              label: 'Магазины',
              activeIcon: SvgPicture.asset(
                'assets/icons/shop1.svg',
                color: AppColors.kLightBlackColor,
                height: 19.5,
                width: 19.5,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/reels.svg',
                color: AppColors.kGray200,
                height: 19.5,
                width: 19.5,
              ),
              label: 'Видео обзоры',
              activeIcon: SvgPicture.asset(
                'assets/icons/reels.svg',
                color: AppColors.kLightBlackColor,
                height: 19.5,
                width: 19.5,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.accountSvg.path,
                height: 19.5,
                width: 19.5,
              ),
              label: 'Профиль',
              activeIcon: SvgPicture.asset(
                Assets.icons.accountSvg.path,
                height: 19.5,
                width: 19.5,
                color: AppColors.kLightBlackColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
