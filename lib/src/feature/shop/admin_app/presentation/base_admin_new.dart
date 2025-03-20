import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import '../../../basket/presentation/widgets/show_alert_country_widget.dart';
import '../../../drawer/data/bloc/country_cubit.dart' as countryCubit;

// ignore: unused_element
const _tag = 'BaseNew';

class BaseAdminNew extends StatefulWidget {
  const BaseAdminNew({super.key});

  @override
  _BaseAdminNewState createState() => _BaseAdminNewState();
}

class _BaseAdminNewState extends State<BaseAdminNew>
    with TickerProviderStateMixin {
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
              bool exists = GetStorage().hasData('shop_location_code');
              String? city = GetStorage().read('city_shop');

              if (!exists && (index != 1)) {
                // Get.showSnackbar(
                // Get.closeCurrentSnackbar();
                Get.snackbar(
                  'СДЕК магазин',
                  city != null
                      ? 'Ваш город $city?'
                      : 'Ваш город неизвестен для cрока доставки!',
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
                      // setState(() {});
                    }, true);
                  },
                );
                //  / );
              }
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
