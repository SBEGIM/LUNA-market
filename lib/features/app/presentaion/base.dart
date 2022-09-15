// ignore_for_file: avoid_print
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/core/router/app_router.dart';
import 'package:haji_market/features/app/bloc/navigation_cubit/navigation_cubit.dart';

import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/features/basket/presentation/ui/basket_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/drawer_home.dart';
import 'package:haji_market/features/favorite/presentation/ui/favorite_page.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:haji_market/features/my_order/presentation/ui/my_order_page.dart';
import 'package:haji_market/features/tape/presentation/ui/tape_page.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BaseState createState() => _BaseState();
}

int basePageIndex = 0;

class _BaseState extends State<Base> {
  Future<void> init() async {}

  @override
  void initState() {
    init();
    super.initState();
  }


  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return   
     Scaffold(
      backgroundColor: Colors.white,
      key: _key,
      drawer: const DrawerHome(),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: basePageIndex,
            onTap: (int index) {
              switch (index) {
                case 0:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.tape());
                  break;

                case 1:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.home());
                  break;
                case 2:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.favorite());
                  break;
                case 3:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.basket());
                  break;
                case 4:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.myOrder());
                  break;
              }
              print(index);
              setState(() {
                basePageIndex = index;
              });
            },
            selectedItemColor: AppColors.kPrimaryColor,
            unselectedItemColor: AppColors.kGray200,
            selectedFontSize: 12,
            elevation: 4,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/tape.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Лента',
                activeIcon: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/icons/tape.svg',
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/store.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Маркет',
                activeIcon: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/icons/store.svg',
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Избранное',
                activeIcon: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/icons/favorite.svg',
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/basket.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Корзина',
                activeIcon: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/icons/basket.svg',
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/my_orders.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Мои заказы',
                activeIcon: ClipOval(
                  child: Material(
                    color: Colors.white, // Button color
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: SvgPicture.asset(
                        'assets/icons/my_orders.svg',
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is TapeState) {
            return TapePage();
          } else if (state is HomeState) {
            return HomePage(
              globalKey: _key,
            );
          } else if (state is FavoriteState) {
            return FavoritePage();
          } else if (state is BasketState) {
            return const BasketPage();
          } else if (state is MyOrderState) {
            return const MyOrderPage();
          } else if (state is AuthState) {
            return const ViewAuthRegisterPage();
          }
          return Container();
        },
      ),
    );
    // AutoTabsScaffold(
    //   key: _key,
    //   drawer: const DrawerHome(),
    //   routes: [
    //     BaseHomeRouter(
    //       children: [
    //         HomePageRoute(
    //           drawerCallback: () {
    //             _key.currentState!.openDrawer();
    //           },
    //         )
    //       ],
    //     ), // globalKey: _key
    //     TapePageRoute(),
    //     FavoritePageRoute(),
    //     const BasketPageRoute(),
    //     const MyOrderPageRoute(),
    //   ],
    //   bottomNavigationBuilder: (_, tabsRouter) {
    //     return SizedBox(
    //       child: BottomNavigationBar(
    //         currentIndex: tabsRouter.activeIndex,
    //         selectedItemColor: AppColors.kPrimaryColor,
    //         unselectedItemColor: AppColors.kGray200,
    //         selectedFontSize: 12,
    //         elevation: 4,
    //         showSelectedLabels: true,
    //         showUnselectedLabels: true,
    //         onTap: (int index) {
    //           // log('Before ontap ${context.router.stack}', name: _tag);

    //           if (tabsRouter.activeIndex == index) {
    //             // log('${tabsRouter.canPopSelfOrChildren}');
    //             // context
    //             //     .innerRouterOf<TabsRouter>(LauncherRoute.name)
    //             //     ?.root
    //             //     .popUntil((route) => route.isFirst);
    //             tabsRouter.popTop();
    //             // tabsRouter.popTop();

    //             // context.router.replace(LauncherRoute());
    //             // context.router.po((route) {
    //             //   log('', name: _tag);
    //             //   return route.isFirst;
    //             // });
    //           } else {
    //             tabsRouter.setActiveIndex(index);
    //           }
    //         },
    //         items: [
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset(
    //               'assets/icons/tape.svg',
    //               color: AppColors.kGray200,
    //             ),
    //             label: 'Лента',
    //             activeIcon: ClipOval(
    //               child: Material(
    //                 color: Colors.white, // Button color
    //                 child: SizedBox(
    //                   width: 42,
    //                   height: 42,
    //                   child: SvgPicture.asset(
    //                     'assets/icons/tape.svg',
    //                     color: AppColors.kPrimaryColor,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset(
    //               'assets/icons/store.svg',
    //               color: AppColors.kGray200,
    //             ),
    //             label: 'Маркет',
    //             activeIcon: ClipOval(
    //               child: Material(
    //                 color: Colors.white, // Button color
    //                 child: SizedBox(
    //                   width: 42,
    //                   height: 42,
    //                   child: SvgPicture.asset(
    //                     'assets/icons/store.svg',
    //                     color: AppColors.kPrimaryColor,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset(
    //               'assets/icons/favorite.svg',
    //               color: AppColors.kGray200,
    //             ),
    //             label: 'Избранное',
    //             activeIcon: ClipOval(
    //               child: Material(
    //                 color: Colors.white, // Button color
    //                 child: SizedBox(
    //                   width: 42,
    //                   height: 42,
    //                   child: SvgPicture.asset(
    //                     'assets/icons/favorite.svg',
    //                     color: AppColors.kPrimaryColor,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset(
    //               'assets/icons/basket.svg',
    //               color: AppColors.kGray200,
    //             ),
    //             label: 'Корзина',
    //             activeIcon: ClipOval(
    //               child: Material(
    //                 color: Colors.white, // Button color
    //                 child: SizedBox(
    //                   width: 42,
    //                   height: 42,
    //                   child: SvgPicture.asset(
    //                     'assets/icons/basket.svg',
    //                     color: AppColors.kPrimaryColor,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           BottomNavigationBarItem(
    //             icon: SvgPicture.asset(
    //               'assets/icons/my_orders.svg',
    //               color: AppColors.kGray200,
    //             ),
    //             label: 'Мои заказы',
    //             activeIcon: ClipOval(
    //               child: Material(
    //                 color: Colors.white, // Button color
    //                 child: SizedBox(
    //                   width: 42,
    //                   height: 42,
    //                   child: SvgPicture.asset(
    //                     'assets/icons/my_orders.svg',
    //                     color: AppColors.kPrimaryColor,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  
  }
}
