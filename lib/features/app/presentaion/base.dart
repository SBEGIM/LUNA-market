// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/bloc/navigation_cubit/navigation_cubit.dart';

import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/features/basket/presentation/ui/basket_page.dart';
import 'package:haji_market/features/favorite/presentation/ui/favorite_page.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:haji_market/features/my_order/presentation/ui/my_order_page.dart';
import 'package:haji_market/features/tape/presentation/ui/tape_page.dart';

class Base extends StatefulWidget {
  final int? index;
  const Base({this.index, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BaseState createState() => _BaseState();
}

int basePageIndex = 0;

class _BaseState extends State<Base> {
  @override
  void initState() {
    // if (widget.index != null) {
    //   basePageIndex = widget.index!;

    //   if (basePageIndex == 0) {
    //     BlocProvider.of<NavigationCubit>(context)
    //         .getNavBarItem(const NavigationState.home());
    //   } else if (basePageIndex == 3) {
    //     BlocProvider.of<NavigationCubit>(context)
    //         .getNavBarItem(const NavigationState.profile());
    //   }
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: basePageIndex,
            onTap: (int index) {
              switch (index) {
                case 0:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.home());
                  break;
                case 1:
                  BlocProvider.of<NavigationCubit>(context)
                      .getNavBarItem(const NavigationState.tape());
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
            selectedItemColor: AppColors.kPinkColor,
            unselectedItemColor: const Color(0xFF99A2AD),
            selectedFontSize: 12,
            elevation: 4,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/store.svg',
                  color: Colors.grey.shade600,
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
                  'assets/icons/tape.svg',
                  color: Colors.grey.shade600,
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
                  'assets/icons/favorite.svg',
                  color: Colors.grey.shade600,
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
                  color: Colors.grey.shade600,
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
                  color: Colors.grey.shade600,
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
          if (state is HomeState) {
            return const HomePage();
          } else if (state is TapeState) {
            return TapePage();
          } else if (state is FavoriteState) {
            return FavoritePage();
          } else if (state is BasketState) {
            return const BasketPage();
          } else if (state is MyOrderState) {
            return MyOrderPage();
          } else if (state is AuthState) {
            return const ViewAuthRegisterPage();
          }
          return Container();
        },
      ),
    );
  }
}
