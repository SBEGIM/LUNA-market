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
    ChatAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatAdminPage(),
      );
    },
    MyOrdersAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyOrdersAdminPage(),
      );
    },
    MyProductsAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyProductsAdminPage(),
      );
    },
    ProfileAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileAdminPage(),
      );
    },
    TapeAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapeAdminPage(),
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
    ProfileBloggerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileBloggerPage(),
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
    BlogShopsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BlogShopsPage(),
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
    BasketOrderAddressRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasketOrderAddressPage(),
      );
    },
    BasketOrderRoute.name: (routeData) {
      final args = routeData.argsAs<BasketOrderRouteArgs>(
          orElse: () => const BasketOrderRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BasketOrderPage(
          fbs: args.fbs,
          key: args.key,
        ),
      );
    },
    BasketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasketPage(),
      );
    },
    PaymentWebviewRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentWebviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaymentWebviewPage(
          url: args.url,
          role: args.role,
          key: args.key,
        ),
      );
    },
    CatalogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CatalogPage(),
      );
    },
    DrawerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DrawerPage(),
      );
    },
    ProductsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductsPage(
          cats: args.cats,
          shopId: args.shopId,
          key: args.key,
        ),
      );
    },
    ShopsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopsPage(),
      );
    },
    SubCatalogRoute.name: (routeData) {
      final args = routeData.argsAs<SubCatalogRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SubCatalogPage(
          key: args.key,
          cats: args.cats,
        ),
      );
    },
    DetailStoreRoute.name: (routeData) {
      final args = routeData.argsAs<DetailStoreRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailStorePage(
          shop: args.shop,
          key: args.key,
        ),
      );
    },
    DetailCardProductRoute.name: (routeData) {
      final args = routeData.argsAs<DetailCardProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailCardProductPage(
          product: args.product,
          key: args.key,
        ),
      );
    },
    UnderCatalogRoute.name: (routeData) {
      final args = routeData.argsAs<UnderCatalogRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UnderCatalogPage(
          cats: args.cats,
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
    SearchProductRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchProductPage(),
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
    TapeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapePage(),
      );
    },
    TapeBloggerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapeBloggerPage(),
      );
    },
  };
}

/// generated route for
/// [ChatAdminPage]
class ChatAdminRoute extends PageRouteInfo<void> {
  const ChatAdminRoute({List<PageRouteInfo>? children})
      : super(
          ChatAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyOrdersAdminPage]
class MyOrdersAdminRoute extends PageRouteInfo<void> {
  const MyOrdersAdminRoute({List<PageRouteInfo>? children})
      : super(
          MyOrdersAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyOrdersAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyProductsAdminPage]
class MyProductsAdminRoute extends PageRouteInfo<void> {
  const MyProductsAdminRoute({List<PageRouteInfo>? children})
      : super(
          MyProductsAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProductsAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileAdminPage]
class ProfileAdminRoute extends PageRouteInfo<void> {
  const ProfileAdminRoute({List<PageRouteInfo>? children})
      : super(
          ProfileAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [BasketOrderAddressPage]
class BasketOrderAddressRoute extends PageRouteInfo<void> {
  const BasketOrderAddressRoute({List<PageRouteInfo>? children})
      : super(
          BasketOrderAddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketOrderAddressRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BasketOrderPage]
class BasketOrderRoute extends PageRouteInfo<BasketOrderRouteArgs> {
  BasketOrderRoute({
    bool? fbs,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BasketOrderRoute.name,
          args: BasketOrderRouteArgs(
            fbs: fbs,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketOrderRoute';

  static const PageInfo<BasketOrderRouteArgs> page =
      PageInfo<BasketOrderRouteArgs>(name);
}

class BasketOrderRouteArgs {
  const BasketOrderRouteArgs({
    this.fbs,
    this.key,
  });

  final bool? fbs;

  final Key? key;

  @override
  String toString() {
    return 'BasketOrderRouteArgs{fbs: $fbs, key: $key}';
  }
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
/// [PaymentWebviewPage]
class PaymentWebviewRoute extends PageRouteInfo<PaymentWebviewRouteArgs> {
  PaymentWebviewRoute({
    required String url,
    String? role,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentWebviewRoute.name,
          args: PaymentWebviewRouteArgs(
            url: url,
            role: role,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentWebviewRoute';

  static const PageInfo<PaymentWebviewRouteArgs> page =
      PageInfo<PaymentWebviewRouteArgs>(name);
}

class PaymentWebviewRouteArgs {
  const PaymentWebviewRouteArgs({
    required this.url,
    this.role,
    this.key,
  });

  final String url;

  final String? role;

  final Key? key;

  @override
  String toString() {
    return 'PaymentWebviewRouteArgs{url: $url, role: $role, key: $key}';
  }
}

/// generated route for
/// [CatalogPage]
class CatalogRoute extends PageRouteInfo<void> {
  const CatalogRoute({List<PageRouteInfo>? children})
      : super(
          CatalogRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [ProductsPage]
class ProductsRoute extends PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    required Cats cats,
    String? shopId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            cats: cats,
            shopId: shopId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const PageInfo<ProductsRouteArgs> page =
      PageInfo<ProductsRouteArgs>(name);
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    required this.cats,
    this.shopId,
    this.key,
  });

  final Cats cats;

  final String? shopId;

  final Key? key;

  @override
  String toString() {
    return 'ProductsRouteArgs{cats: $cats, shopId: $shopId, key: $key}';
  }
}

/// generated route for
/// [ShopsPage]
class ShopsRoute extends PageRouteInfo<void> {
  const ShopsRoute({List<PageRouteInfo>? children})
      : super(
          ShopsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SubCatalogPage]
class SubCatalogRoute extends PageRouteInfo<SubCatalogRouteArgs> {
  SubCatalogRoute({
    Key? key,
    required Cats cats,
    List<PageRouteInfo>? children,
  }) : super(
          SubCatalogRoute.name,
          args: SubCatalogRouteArgs(
            key: key,
            cats: cats,
          ),
          initialChildren: children,
        );

  static const String name = 'SubCatalogRoute';

  static const PageInfo<SubCatalogRouteArgs> page =
      PageInfo<SubCatalogRouteArgs>(name);
}

class SubCatalogRouteArgs {
  const SubCatalogRouteArgs({
    this.key,
    required this.cats,
  });

  final Key? key;

  final Cats cats;

  @override
  String toString() {
    return 'SubCatalogRouteArgs{key: $key, cats: $cats}';
  }
}

/// generated route for
/// [DetailStorePage]
class DetailStoreRoute extends PageRouteInfo<DetailStoreRouteArgs> {
  DetailStoreRoute({
    required Shops shop,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DetailStoreRoute.name,
          args: DetailStoreRouteArgs(
            shop: shop,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailStoreRoute';

  static const PageInfo<DetailStoreRouteArgs> page =
      PageInfo<DetailStoreRouteArgs>(name);
}

class DetailStoreRouteArgs {
  const DetailStoreRouteArgs({
    required this.shop,
    this.key,
  });

  final Shops shop;

  final Key? key;

  @override
  String toString() {
    return 'DetailStoreRouteArgs{shop: $shop, key: $key}';
  }
}

/// generated route for
/// [DetailCardProductPage]
class DetailCardProductRoute extends PageRouteInfo<DetailCardProductRouteArgs> {
  DetailCardProductRoute({
    required ProductModel product,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DetailCardProductRoute.name,
          args: DetailCardProductRouteArgs(
            product: product,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailCardProductRoute';

  static const PageInfo<DetailCardProductRouteArgs> page =
      PageInfo<DetailCardProductRouteArgs>(name);
}

class DetailCardProductRouteArgs {
  const DetailCardProductRouteArgs({
    required this.product,
    this.key,
  });

  final ProductModel product;

  final Key? key;

  @override
  String toString() {
    return 'DetailCardProductRouteArgs{product: $product, key: $key}';
  }
}

/// generated route for
/// [UnderCatalogPage]
class UnderCatalogRoute extends PageRouteInfo<UnderCatalogRouteArgs> {
  UnderCatalogRoute({
    required Cats cats,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          UnderCatalogRoute.name,
          args: UnderCatalogRouteArgs(
            cats: cats,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'UnderCatalogRoute';

  static const PageInfo<UnderCatalogRouteArgs> page =
      PageInfo<UnderCatalogRouteArgs>(name);
}

class UnderCatalogRouteArgs {
  const UnderCatalogRouteArgs({
    required this.cats,
    this.key,
  });

  final Cats cats;

  final Key? key;

  @override
  String toString() {
    return 'UnderCatalogRouteArgs{cats: $cats, key: $key}';
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
/// [SearchProductPage]
class SearchProductRoute extends PageRouteInfo<void> {
  const SearchProductRoute({List<PageRouteInfo>? children})
      : super(
          SearchProductRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchProductRoute';

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
/// [TapeBloggerPage]
class TapeBloggerRoute extends PageRouteInfo<void> {
  const TapeBloggerRoute({List<PageRouteInfo>? children})
      : super(
          TapeBloggerRoute.name,
          initialChildren: children,
        );

  static const String name = 'TapeBloggerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
