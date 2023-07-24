// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          globalKey: args.globalKey,
          drawerCallback: args.drawerCallback,
          key: args.key,
        ),
      );
    },
    DrawerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DrawerPage(),
      );
    },
    BasketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasketPage(),
      );
    },
    LauncherRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LauncherApp(),
      );
    },
    BaseTapeTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BaseTapePage(),
      );
    },
    BaseAdminTapeTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BaseAdminTapePage(),
      );
    },
    ViewAuthRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<ViewAuthRegisterRouteArgs>(
          orElse: () => const ViewAuthRegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewAuthRegisterPage(
          BackButton: args.BackButton,
          key: args.key,
        ),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritePage(),
      );
    },
    TapeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapePage(),
      );
    },
    DetailTapeCardRoute.name: (routeData) {
      final args = routeData.argsAs<DetailTapeCardRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailTapeCardPage(
          index: args.index,
          shopName: args.shopName,
          key: args.key,
        ),
      );
    },
    TapeAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapeAdminPage(),
      );
    },
    ProfileBloggerTapeRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileBloggerTapeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ProfileBloggerTapePage(
          bloggerId: args.bloggerId,
          bloggerName: args.bloggerName,
          bloggerAvatar: args.bloggerAvatar,
          key: args.key,
        )),
      );
    },
    ProfileBloggerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileBloggerPage(),
      );
    },
    BloggerDetailTapeCardRoute.name: (routeData) {
      final args = routeData.argsAs<BloggerDetailTapeCardRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BloggerDetailTapeCardPage(
          index: args.index,
          shopName: args.shopName,
          key: args.key,
        ),
      );
    },
    BlogShopsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlogShopsPage(),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    GlobalKey<ScaffoldState>? globalKey,
    void Function()? drawerCallback,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            globalKey: globalKey,
            drawerCallback: drawerCallback,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.globalKey,
    this.drawerCallback,
    this.key,
  });

  final GlobalKey<ScaffoldState>? globalKey;

  final void Function()? drawerCallback;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{globalKey: $globalKey, drawerCallback: $drawerCallback, key: $key}';
  }
}

/// generated route for
/// [DrawerPage]
class DrawerRoute extends PageRouteInfo<void> {
  const DrawerRoute({List<PageRouteInfo>? children})
      : super(
          DrawerRoute.name,
          initialChildren: children,
        );

  static const String name = 'DrawerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BasketPage]
class BasketRoute extends PageRouteInfo<void> {
  const BasketRoute({List<PageRouteInfo>? children})
      : super(
          BasketRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LauncherApp]
class LauncherRoute extends PageRouteInfo<void> {
  const LauncherRoute({List<PageRouteInfo>? children})
      : super(
          LauncherRoute.name,
          initialChildren: children,
        );

  static const String name = 'LauncherRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BaseTapePage]
class BaseTapeTab extends PageRouteInfo<void> {
  const BaseTapeTab({List<PageRouteInfo>? children})
      : super(
          BaseTapeTab.name,
          initialChildren: children,
        );

  static const String name = 'BaseTapeTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BaseAdminTapePage]
class BaseAdminTapeTab extends PageRouteInfo<void> {
  const BaseAdminTapeTab({List<PageRouteInfo>? children})
      : super(
          BaseAdminTapeTab.name,
          initialChildren: children,
        );

  static const String name = 'BaseAdminTapeTab';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ViewAuthRegisterPage]
class ViewAuthRegisterRoute extends PageRouteInfo<ViewAuthRegisterRouteArgs> {
  ViewAuthRegisterRoute({
    bool? BackButton,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ViewAuthRegisterRoute.name,
          args: ViewAuthRegisterRouteArgs(
            BackButton: BackButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewAuthRegisterRoute';

  static const PageInfo<ViewAuthRegisterRouteArgs> page =
      PageInfo<ViewAuthRegisterRouteArgs>(name);
}

class ViewAuthRegisterRouteArgs {
  const ViewAuthRegisterRouteArgs({
    this.BackButton,
    this.key,
  });

  final bool? BackButton;

  final Key? key;

  @override
  String toString() {
    return 'ViewAuthRegisterRouteArgs{BackButton: $BackButton, key: $key}';
  }
}

/// generated route for
/// [FavoritePage]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TapePage]
class TapeRoute extends PageRouteInfo<void> {
  const TapeRoute({List<PageRouteInfo>? children})
      : super(
          TapeRoute.name,
          initialChildren: children,
        );

  static const String name = 'TapeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailTapeCardPage]
class DetailTapeCardRoute extends PageRouteInfo<DetailTapeCardRouteArgs> {
  DetailTapeCardRoute({
    required int? index,
    required String? shopName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DetailTapeCardRoute.name,
          args: DetailTapeCardRouteArgs(
            index: index,
            shopName: shopName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailTapeCardRoute';

  static const PageInfo<DetailTapeCardRouteArgs> page =
      PageInfo<DetailTapeCardRouteArgs>(name);
}

class DetailTapeCardRouteArgs {
  const DetailTapeCardRouteArgs({
    required this.index,
    required this.shopName,
    this.key,
  });

  final int? index;

  final String? shopName;

  final Key? key;

  @override
  String toString() {
    return 'DetailTapeCardRouteArgs{index: $index, shopName: $shopName, key: $key}';
  }
}

/// generated route for
/// [TapeAdminPage]
class TapeAdminRoute extends PageRouteInfo<void> {
  const TapeAdminRoute({List<PageRouteInfo>? children})
      : super(
          TapeAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'TapeAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileBloggerTapePage]
class ProfileBloggerTapeRoute
    extends PageRouteInfo<ProfileBloggerTapeRouteArgs> {
  ProfileBloggerTapeRoute({
    required int bloggerId,
    required String bloggerName,
    required String bloggerAvatar,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileBloggerTapeRoute.name,
          args: ProfileBloggerTapeRouteArgs(
            bloggerId: bloggerId,
            bloggerName: bloggerName,
            bloggerAvatar: bloggerAvatar,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileBloggerTapeRoute';

  static const PageInfo<ProfileBloggerTapeRouteArgs> page =
      PageInfo<ProfileBloggerTapeRouteArgs>(name);
}

class ProfileBloggerTapeRouteArgs {
  const ProfileBloggerTapeRouteArgs({
    required this.bloggerId,
    required this.bloggerName,
    required this.bloggerAvatar,
    this.key,
  });

  final int bloggerId;

  final String bloggerName;

  final String bloggerAvatar;

  final Key? key;

  @override
  String toString() {
    return 'ProfileBloggerTapeRouteArgs{bloggerId: $bloggerId, bloggerName: $bloggerName, bloggerAvatar: $bloggerAvatar, key: $key}';
  }
}

/// generated route for
/// [ProfileBloggerPage]
class ProfileBloggerRoute extends PageRouteInfo<void> {
  const ProfileBloggerRoute({List<PageRouteInfo>? children})
      : super(
          ProfileBloggerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileBloggerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BloggerDetailTapeCardPage]
class BloggerDetailTapeCardRoute
    extends PageRouteInfo<BloggerDetailTapeCardRouteArgs> {
  BloggerDetailTapeCardRoute({
    required int? index,
    required String? shopName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BloggerDetailTapeCardRoute.name,
          args: BloggerDetailTapeCardRouteArgs(
            index: index,
            shopName: shopName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BloggerDetailTapeCardRoute';

  static const PageInfo<BloggerDetailTapeCardRouteArgs> page =
      PageInfo<BloggerDetailTapeCardRouteArgs>(name);
}

class BloggerDetailTapeCardRouteArgs {
  const BloggerDetailTapeCardRouteArgs({
    required this.index,
    required this.shopName,
    this.key,
  });

  final int? index;

  final String? shopName;

  final Key? key;

  @override
  String toString() {
    return 'BloggerDetailTapeCardRouteArgs{index: $index, shopName: $shopName, key: $key}';
  }
}

/// generated route for
/// [BlogShopsPage]
class BlogShopsRoute extends PageRouteInfo<void> {
  const BlogShopsRoute({List<PageRouteInfo>? children})
      : super(
          BlogShopsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BlogShopsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
