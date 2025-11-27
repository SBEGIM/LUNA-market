import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
// import 'package:haji_market/src/feature/drawer/bloc/country_cubit.dart'
//     as countryCubit;

// ignore: unused_element
const _tag = 'Base';

class Base extends StatefulWidget {
  final int? index;
  const Base({super.key, this.index});

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> with TickerProviderStateMixin {
  int? previousIndex;
  String? address;
  bool _appliedInitialIndex = false;

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
      backgroundColor: Colors.white,
      extendBody: true,
      homeIndex: widget.index ?? 0,
      transitionBuilder: (context, child, animation) {
        return child;
      },
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
          height: 96,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0x100F0F0F), width: 1), // stroke сверху
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (int index) {
              if (tabsRouter.activeIndex == index) {
                tabsRouter.pop();
              } else {
                tabsRouter.setActiveIndex(index);
              }
            },
            selectedItemColor: AppColors.kLightBlackColor,
            unselectedItemColor: AppColors.kGray200,
            selectedFontSize: 12,
            elevation: 4,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: AppTextStyles.size13Weight400,
            unselectedLabelStyle: AppTextStyles.size13Weight400,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.rollsBottomIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Roolls',
                activeIcon: Image.asset(
                  Assets.icons.rollsBotoomFullIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.sellerNavigationUnfullIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Маркет',
                activeIcon: Image.asset(
                  Assets.icons.sellerNavigationIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.favoriteBottomIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Избранное',
                activeIcon: Image.asset(
                  Assets.icons.favoriteBottomFullIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.basketBottomIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Корзина',
                activeIcon: Image.asset(
                  Assets.icons.basketBottomFullIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  Assets.icons.accountBottomIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
                  color: AppColors.kunSelectColor,
                ),
                label: 'Профиль',
                activeIcon: Image.asset(
                  Assets.icons.accountBottomFullIcon.path,
                  scale: 2.1,
                  height: 24,
                  width: 24,
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
