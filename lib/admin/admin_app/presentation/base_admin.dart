// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/admin/auth/presentation/ui/auth_admin_page.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/ui/my_orders_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/ui/my_products_admin_page.dart';
import 'package:haji_market/admin/tape_admin/presentation/ui/tape_admin_page.dart';
import 'package:haji_market/core/common/constants.dart';


import '../../profile_admin/presentation/ui/admin_profile_page.dart';

class BaseAdmin extends StatefulWidget {
  final int? index;
  const BaseAdmin({this.index, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BaseAdminState createState() => _BaseAdminState();
}

int basePageIndex = 0;

class _BaseAdminState extends State<BaseAdmin> {
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
      bottomNavigationBar:
          BlocBuilder<AdminNavigationCubit, AdminNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: basePageIndex,
            onTap: (int index) {
              switch (index) {
                case 0:
                  BlocProvider.of<AdminNavigationCubit>(context)
                      .getNavBarItemAdmin(
                          const AdminNavigationState.homeAdmin());
                  break;
                case 1:
                  BlocProvider.of<AdminNavigationCubit>(context)
                      .getNavBarItemAdmin(
                          const AdminNavigationState.tapeAdmin());
                  break;
                case 2:
                  BlocProvider.of<AdminNavigationCubit>(context)
                      .getNavBarItemAdmin(
                          const AdminNavigationState.myOrderAdmin());
                  break;
                case 3:
                  BlocProvider.of<AdminNavigationCubit>(context)
                      .getNavBarItemAdmin(const AdminNavigationState.profile());
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
                label: 'Избранное',
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
                  'assets/icons/user.svg',
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
                        'assets/icons/user.svg',
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
      body: BlocBuilder<AdminNavigationCubit, AdminNavigationState>(
        builder: (context, state) {
          if (state is HomeAdminState) {
            return MyProductsAdminPage();
          } else if (state is TapeAdminState) {
            return TapeAdminPage();
          } else if (state is MyOrderAdminState) {
            return MyOrdersAdminPage();
          } else if (state is ProfileState) {
            return ProfileAdminPage();
          } else if (state is AdminAuthState) {
            return AuthAdminPage();
          }
          return Container();
        },
      ),
    );
  }
}
