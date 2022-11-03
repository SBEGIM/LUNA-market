// // import 'package:auto_route/auto_route.dart';
// import 'package:auto_route/empty_router_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:haji_market/features/app/presentaion/launcher.dart';
// import 'package:haji_market/features/basket/presentation/ui/basket_page.dart';
// import 'package:haji_market/features/favorite/presentation/ui/favorite_page.dart';
// import 'package:haji_market/features/home/presentation/ui/home_page.dart';
// import 'package:haji_market/features/my_order/presentation/ui/my_order_page.dart';
// import 'package:haji_market/features/tape/presentation/ui/tape_page.dart';
//
// part 'app_router.gr.dart';
//
// @MaterialAutoRouter(
//   // replaceInRouteName: 'Page,Route',
//   routes: <AutoRoute>[
//     AutoRoute(page: LauncherApp, initial: true, children: [
//       AutoRoute(
//         page: EmptyRouterPage,
//         name: 'BaseHomeRouter',
//         children: [
//           AutoRoute(page: HomePage, initial: true),
//         ],
//       ),
//       AutoRoute(page: TapePage),
//       AutoRoute(page: FavoritePage),
//       AutoRoute(page: BasketPage),
//       AutoRoute(page: MyOrderPage),
//     ])
//     // AutoRoute(
//     //   path: '/dashboard',
//     //   page: DashboardPage,
//     //   children: [
//     //     AutoRoute(path: 'users', page: UsersPage),
//     //     AutoRoute(path: 'posts', page: PostsPage),
//     //     AutoRoute(path: 'settings', page: SettingsPage),
//     //   ],
//     // ),
//   ],
// )
// class AppRouter extends _$AppRouter {}
