import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/features/basket/presentation/ui/basket_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/drawer_home.dart';
import 'package:haji_market/features/favorite/presentation/ui/favorite_page.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:haji_market/features/tape/presentation/ui/tape_page.dart';

import '../../../bloger/profile_admin/presentation/ui/blogger_tape_profile_page.dart';
import '../../tape/presentation/ui/detail_tape_card_page.dart';

class Base extends StatefulWidget {
  final int? index;
  const Base({this.index, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BaseState createState() => _BaseState();
}

int basePageIndex = 0;

class _BaseState extends State<Base> {
  Future<void> init() async {}

  bool backGroundColor = true;

  @override
  void initState() {
    if (widget.index != null) {
      basePageIndex = widget.index!;
      if (widget.index == 0) {
        BlocProvider.of<NavigationCubit>(context)
            .getNavBarItem(const NavigationState.tape());
      }
      if (basePageIndex == 1) {
        BlocProvider.of<NavigationCubit>(context)
            .getNavBarItem(const NavigationState.home());
      }
      if (basePageIndex == 3) {
        BlocProvider.of<NavigationCubit>(context)
            .getNavBarItem(const NavigationState.basket());
      }

      // } else if (basePageIndex == 3) {
      //   BlocProvider.of<NavigationCubit>(context)
      //       .getNavBarItem(const NavigationState.profile());
      // }
    }
    init();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: basePageIndex != 0 ? Colors.white : null,
      key: _key,
      extendBody: true,
      // drawer: const DrawerHome(),
      // drawer: Container(),
      bottomNavigationBar: BlocConsumer<NavigationCubit, NavigationState>(
        listener: (context, state) {
          if (state is DetailTapeState) {
            basePageIndex = 0;
            setState(() {});
          }
        },
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
            backgroundColor:
                basePageIndex == 0 ? Colors.transparent : Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/tape.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Лента',
                activeIcon: SvgPicture.asset(
                  'assets/icons/tape.svg',
                  color: AppColors.kPrimaryColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/store.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Маркет',
                activeIcon: SvgPicture.asset(
                  'assets/icons/store.svg',
                  color: AppColors.kPrimaryColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/favorite.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Избранное',
                activeIcon: SvgPicture.asset(
                  'assets/icons/heart_fill.svg',
                  color: AppColors.kPrimaryColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/basket.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Корзина',
                activeIcon: SvgPicture.asset(
                  'assets/icons/basket.svg',
                  color: AppColors.kPrimaryColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/ionMenu.svg',
                  color: AppColors.kGray200,
                ),
                label: 'Меню',
                activeIcon: SvgPicture.asset(
                  'assets/icons/ionMenu.svg',
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          );
        },
      ),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is TapeState) {
            return const TapePage();
          } else if (state is HomeState) {
            return HomePage(
              globalKey: _key,
            );
          } else if (state is DetailBloggerTapeState) {
            return ProfileBloggerTapePage(
              bloggerId: state.bloggerId,
              bloggerName: state.bloggerName,
              bloggerAvatar: state.bloggerAvatar,
            );
          } else if (state is DetailTapeState) {
            return DetailTapeCardPage(
              index: state.index,
              shop_name: state.name,
            );
          } else if (state is FavoriteState) {
            return const FavoritePage();
          } else if (state is BasketState) {
            return const BasketPage();
          } else if (state is MyOrderState) {
            // return const MyOrderPage();]
            return const DrawerHome();
          } else if (state is AuthState) {
            return const ViewAuthRegisterPage();
          } else if (state is NotAuthState) {
            return const ViewAuthRegisterPage();
          }
          return Container();
        },
      ),
    );
  }
}
