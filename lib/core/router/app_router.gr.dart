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

class _$$AppRouter extends RootStackRouter {
  _$$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomePage());
    },
    TapeRoute.name: (routeData) {
      final args =
          routeData.argsAs<TapeRouteArgs>(orElse: () => const TapeRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: TapePage(key: args.key));
    },
    FavoriteRoute.name: (routeData) {
      final args = routeData.argsAs<FavoriteRouteArgs>(
          orElse: () => const FavoriteRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: FavoritePage(key: args.key));
    },
    BasketRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const BasketPage());
    },
    MyOrderRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MyOrderPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/home-page'),
        RouteConfig(TapeRoute.name, path: '/tape-page'),
        RouteConfig(FavoriteRoute.name, path: '/favorite-page'),
        RouteConfig(BasketRoute.name, path: '/basket-page'),
        RouteConfig(MyOrderRoute.name, path: '/my-order-page')
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [TapePage]
class TapeRoute extends PageRouteInfo<TapeRouteArgs> {
  TapeRoute({Key? key})
      : super(TapeRoute.name,
            path: '/tape-page', args: TapeRouteArgs(key: key));

  static const String name = 'TapeRoute';
}

class TapeRouteArgs {
  const TapeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'TapeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [FavoritePage]
class FavoriteRoute extends PageRouteInfo<FavoriteRouteArgs> {
  FavoriteRoute({Key? key})
      : super(FavoriteRoute.name,
            path: '/favorite-page', args: FavoriteRouteArgs(key: key));

  static const String name = 'FavoriteRoute';
}

class FavoriteRouteArgs {
  const FavoriteRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'FavoriteRouteArgs{key: $key}';
  }
}

/// generated route for
/// [BasketPage]
class BasketRoute extends PageRouteInfo<void> {
  const BasketRoute() : super(BasketRoute.name, path: '/basket-page');

  static const String name = 'BasketRoute';
}

/// generated route for
/// [MyOrderPage]
class MyOrderRoute extends PageRouteInfo<void> {
  const MyOrderRoute() : super(MyOrderRoute.name, path: '/my-order-page');

  static const String name = 'MyOrderRoute';
}
