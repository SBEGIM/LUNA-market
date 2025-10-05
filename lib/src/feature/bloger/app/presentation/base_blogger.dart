import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import '../../../../core/constant/generated/assets.gen.dart';

// ignore: unused_element
const _tag = 'BaseBloggerNew';

class BaseBlogger extends StatefulWidget {
  final int? index;

  const BaseBlogger({super.key, this.index});

  @override
  _BaseBloggerState createState() => _BaseBloggerState();
}

class _BaseBloggerState extends State<BaseBlogger>
    with TickerProviderStateMixin {
  TabController? tabController;
  int? previousIndex;
  bool _appliedInitialIndex = false;

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
        ChatBloggerRoute(),
        ProfileBloggerRoute(),
      ],
      backgroundColor: tabController?.index != 1 ? Colors.white : null,
      extendBody: true,
      homeIndex: widget.index ?? 0,

      transitionBuilder: (context, child, animation) {
        return child;
      },
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   AutoTabsRouter.of(context).setActiveIndex(2);
      // }),
      bottomNavigationBuilder: (_, tabsRouter) {
        if (!_appliedInitialIndex) {
          _appliedInitialIndex = true;
          final idx = widget.index ?? 0;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (idx >= 0 && idx < tabsRouter.pageCount) {
              tabsRouter.setActiveIndex(idx);
            }
          });
        }
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
                tabsRouter.setActiveIndex(index);
              }
            },
            selectedItemColor: AppColors.kLightBlackColor,
            unselectedItemColor: AppColors.kunSelectColor,
            selectedLabelStyle: AppTextStyles.navigationSelectLabelStyle,
            unselectedLabelStyle: AppTextStyles.navigationUnSelectLabelStyle,
            selectedFontSize: 19,
            elevation: 4,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor:
                tabsRouter.activeIndex == 1 ? Colors.white : Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.sellerNavigationUnfullIcon.path,
                  scale: 1.9,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Магазины',
                activeIcon: Image.asset(
                  Assets.icons.sellerNavigationIcon.path,
                  scale: 1.9,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.bottomListIcon.path,
                  scale: 1.9,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Мои обзоры',
                activeIcon: Image.asset(
                  Assets.icons.bottomListFullIcon.path,
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
          ),
        );
      },
    );
  }
}
