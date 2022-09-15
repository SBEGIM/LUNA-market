// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    LauncherAppRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const LauncherApp());
    },
    BaseHomeRouter.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    TapePageRoute.name: (routeData) {
      final args = routeData.argsAs<TapePageRouteArgs>(
          orElse: () => const TapePageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TapePage(key: args.key));
    },
    FavoritePageRoute.name: (routeData) {
      final args = routeData.argsAs<FavoritePageRouteArgs>(
          orElse: () => const FavoritePageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: FavoritePage(key: args.key));
    },
    BasketPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const BasketPage());
    },
    MyOrderPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MyOrderPage());
    },
    HomePageRoute.name: (routeData) {
      final args = routeData.argsAs<HomePageRouteArgs>(
          orElse: () => const HomePageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: HomePage(
              globalKey: args.globalKey,
              drawerCallback: args.drawerCallback,
              key: args.key));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(LauncherAppRoute.name, path: '/', children: [
          RouteConfig(BaseHomeRouter.name,
              path: 'empty-router-page',
              parent: LauncherAppRoute.name,
              children: [
                RouteConfig(HomePageRoute.name,
                    path: '', parent: BaseHomeRouter.name)
              ]),
          RouteConfig(TapePageRoute.name,
              path: 'tape-page', parent: LauncherAppRoute.name),
          RouteConfig(FavoritePageRoute.name,
              path: 'favorite-page', parent: LauncherAppRoute.name),
          RouteConfig(BasketPageRoute.name,
              path: 'basket-page', parent: LauncherAppRoute.name),
          RouteConfig(MyOrderPageRoute.name,
              path: 'my-order-page', parent: LauncherAppRoute.name)
        ])
      ];
}

/// generated route for
/// [LauncherApp]
class LauncherAppRoute extends PageRouteInfo<void> {
  const LauncherAppRoute({List<PageRouteInfo>? children})
      : super(LauncherAppRoute.name, path: '/', initialChildren: children);

  static const String name = 'LauncherAppRoute';
}

/// generated route for
/// [EmptyRouterPage]
class BaseHomeRouter extends PageRouteInfo<void> {
  const BaseHomeRouter({List<PageRouteInfo>? children})
      : super(BaseHomeRouter.name,
            path: 'empty-router-page', initialChildren: children);

  static const String name = 'BaseHomeRouter';
}

/// generated route for
/// [TapePage]
class TapePageRoute extends PageRouteInfo<TapePageRouteArgs> {
  TapePageRoute({Key? key})
      : super(TapePageRoute.name,
            path: 'tape-page', args: TapePageRouteArgs(key: key));

  static const String name = 'TapePageRoute';
}

class TapePageRouteArgs {
  const TapePageRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'TapePageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [FavoritePage]
class FavoritePageRoute extends PageRouteInfo<FavoritePageRouteArgs> {
  FavoritePageRoute({Key? key})
      : super(FavoritePageRoute.name,
            path: 'favorite-page', args: FavoritePageRouteArgs(key: key));

  static const String name = 'FavoritePageRoute';
}

class FavoritePageRouteArgs {
  const FavoritePageRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'FavoritePageRouteArgs{key: $key}';
  }
}

/// generated route for
/// [BasketPage]
class BasketPageRoute extends PageRouteInfo<void> {
  const BasketPageRoute() : super(BasketPageRoute.name, path: 'basket-page');

  static const String name = 'BasketPageRoute';
}

/// generated route for
/// [MyOrderPage]
class MyOrderPageRoute extends PageRouteInfo<void> {
  const MyOrderPageRoute()
      : super(MyOrderPageRoute.name, path: 'my-order-page');

  static const String name = 'MyOrderPageRoute';
}

/// generated route for
/// [HomePage]
class HomePageRoute extends PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute(
      {GlobalKey<ScaffoldState>? globalKey,
      void Function()? drawerCallback,
      Key? key})
      : super(HomePageRoute.name,
            path: '',
            args: HomePageRouteArgs(
                globalKey: globalKey,
                drawerCallback: drawerCallback,
                key: key));

  static const String name = 'HomePageRoute';
}

class HomePageRouteArgs {
  const HomePageRouteArgs({this.globalKey, this.drawerCallback, this.key});

  final GlobalKey<ScaffoldState>? globalKey;

  final void Function()? drawerCallback;

  final Key? key;

  @override
  String toString() {
    return 'HomePageRouteArgs{globalKey: $globalKey, drawerCallback: $drawerCallback, key: $key}';
  }
}
