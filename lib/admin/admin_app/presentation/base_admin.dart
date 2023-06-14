// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/admin/auth/presentation/ui/auth_admin_page.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/ui/my_orders_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/ui/my_products_admin_page.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../chat/presentation/chat_admin_page.dart';
import '../../profile_admin/presentation/ui/admin_profile_page.dart';

class BaseAdmin extends StatefulWidget {
  final int? index;
  const BaseAdmin({this.index, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BaseAdminState createState() => _BaseAdminState();
}

int basePageIndex1 = 0;

class _BaseAdminState extends State<BaseAdmin> {
  @override
  void initState() {
    if (widget.index == 0) {
      BlocProvider.of<AdminNavigationCubit>(context)
          .getNavBarItemAdmin(const AdminNavigationState.homeAdmin());

      basePageIndex1 = 0;
    }
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
            currentIndex: basePageIndex1,
            onTap: (int index) {
              switch (index) {
                // case 0:
                //   BlocProvider.of<AdminNavigationCubit>(context)
                //       .getNavBarItemAdmin(
                //           const AdminNavigationState.tapeAdmin());
                //   break;
                case 0:
                  BlocProvider.of<AdminNavigationCubit>(context)
                      .getNavBarItemAdmin(
                          const AdminNavigationState.homeAdmin());
                  break;
                case 1:
                  BlocProvider.of<AdminNavigationCubit>(context)
                      .getNavBarItemAdmin(
                          const AdminNavigationState.chatAdmin());
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
              setState(() {
                basePageIndex1 = index;
              });
            },
            selectedItemColor: AppColors.kPrimaryColor,
            unselectedItemColor: AppColors.kGray200,
            selectedFontSize: 12,
            elevation: 4,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              // BottomNavigationBarItem(
              //   icon: SvgPicture.asset(
              //     'assets/icons/tape.svg',
              //     color: AppColors.kGray200,
              //   ),
              //   label: 'Лента',
              //   activeIcon: SvgPicture.asset(
              //     'assets/icons/tape.svg',
              //     color: AppColors.kPrimaryColor,
              //   ),
              // ),
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
      ),
      body: BlocBuilder<AdminNavigationCubit, AdminNavigationState>(
        builder: (context, state) {
          // if (state is TapeAdminState) {
          //   return const TapeAdminPage();
          // } else

          if (state is HomeAdminState) {
            return const MyProductsAdminPage();
          } else if (state is MyOrderAdminState) {
            return const MyOrdersAdminPage();
          } else if (state is ChatAdminState) {
            return const ChatAdminPage();
          } else if (state is ProfileState) {
            return const ProfileAdminPage();
          } else if (state is AdminAuthState) {
            return const AuthAdminPage();
          }
          return Container();
        },
      ),
    );
  }
}
