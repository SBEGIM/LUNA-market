import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

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
          selectedItemColor: AppColors.kPrimaryColor,
          unselectedItemColor: AppColors.kGray200,
          selectedFontSize: 12,
          elevation: 4,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor:
              tabsRouter.activeIndex == 1 ? Colors.transparent : Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/tape.svg',
                color: AppColors.kGray200,
              ),
              label: 'Магазины',
              activeIcon: SvgPicture.asset(
                'assets/icons/tape.svg',
                color: AppColors.kPrimaryColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/docs.svg',
                color: AppColors.kGray200,
              ),
              label: 'Видео обзоры',
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
