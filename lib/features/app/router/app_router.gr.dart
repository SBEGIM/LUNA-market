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
    AdminAuthRoute.name: (routeData) {
      final args = routeData.argsAs<AdminAuthRouteArgs>(orElse: () => const AdminAuthRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdminAuthPage(
          BackButton: args.BackButton,
          key: args.key,
        ),
      );
    },
    AuthAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthAdminPage(),
      );
    },
    BaseAdminTapeTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BaseAdminTapePage(),
      );
    },
    BaseTapeTab.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BaseTapePage(),
      );
    },
    BasketOrderAddressRoute.name: (routeData) {
      final args = routeData.argsAs<BasketOrderAddressRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BasketOrderAddressPage(
          fulfillment: args.fulfillment,
          deleveryDay: args.deleveryDay,
          office: args.office,
          key: args.key,
        ),
      );
    },
    BasketOrderRoute.name: (routeData) {
      final args = routeData.argsAs<BasketOrderRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BasketOrderPage(
          fbs: args.fbs,
          key: args.key,
          address: args.address,
          fulfillment: args.fulfillment,
        ),
      );
    },
    BasketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasketPage(),
      );
    },
    BlogAuthRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<BlogAuthRegisterRouteArgs>(orElse: () => const BlogAuthRegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BlogAuthRegisterPage(
          BackButton: args.BackButton,
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
    CatalogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CatalogPage(),
      );
    },
    ChangePasswordAdminRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordAdminRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangePasswordAdminPage(
          key: args.key,
          textEditingController: args.textEditingController,
        ),
      );
    },
    ChangePasswordBloggerRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordBloggerRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangePasswordBloggerPage(
          key: args.key,
          textEditingController: args.textEditingController,
        ),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ChangePasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangePasswordPage(
          key: args.key,
          textEditingController: args.textEditingController,
        ),
      );
    },
    ChatAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatAdminPage(),
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
    DetailMyOrdersRoute.name: (routeData) {
      final args = routeData.argsAs<DetailMyOrdersRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DetailMyOrdersPage(
          basket: args.basket,
          key: args.key,
        )),
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
    DetailTapeCardRoute.name: (routeData) {
      final args = routeData.argsAs<DetailTapeCardRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DetailTapeCardPage(
          index: args.index,
          shopName: args.shopName,
          key: args.key,
          tapeBloc: args.tapeBloc,
          tapeId: args.tapeId,
        )),
      );
    },
    DrawerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DrawerPage(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritePage(),
      );
    },
    ForgotPasswordAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordAdminPage(),
      );
    },
    ForgotPasswordBLoggerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordBLoggerPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ForgotPasswordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          globalKey: args.globalKey,
          drawerCallback: args.drawerCallback,
          key: args.key,
        ),
      );
    },
    LauncherRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LauncherApp(),
      );
    },
    MapPickerRoute.name: (routeData) {
      final args = routeData.argsAs<MapPickerRouteArgs>(orElse: () => const MapPickerRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MapPickerPage(
          key: args.key,
          mapGeo: args.mapGeo,
          cc: args.cc,
          lat: args.lat,
          long: args.long,
        ),
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
    ProductsRoute.name: (routeData) {
      final args = routeData.argsAs<ProductsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProductsPage(
          cats: args.cats,
          brandId: args.brandId,
          shopId: args.shopId,
          subCats: args.subCats,
          key: args.key,
        ),
      );
    },
    ProfileAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileAdminPage(),
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
          inSubscribe: args.inSubscribe,
          onSubChanged: args.onSubChanged,
        )),
      );
    },
    RegisterShopRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterShopRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterShopPage(
          shopName: args.shopName,
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
    ShopsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopsPage(),
      );
    },
    SubCatalogRoute.name: (routeData) {
      final args = routeData.argsAs<SubCatalogRouteArgs>(orElse: () => const SubCatalogRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SubCatalogPage(
          key: args.key,
          cats: args.cats,
        ),
      );
    },
    TapeAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapeAdminPage(),
      );
    },
    TapeBloggerRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapeBloggerPage(),
      );
    },
    TapeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TapePage(),
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
    ViewAuthRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<ViewAuthRegisterRouteArgs>(orElse: () => const ViewAuthRegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ViewAuthRegisterPage(
          BackButton: args.BackButton,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [AdminAuthPage]
class AdminAuthRoute extends PageRouteInfo<AdminAuthRouteArgs> {
  AdminAuthRoute({
    bool? BackButton,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AdminAuthRoute.name,
          args: AdminAuthRouteArgs(
            BackButton: BackButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AdminAuthRoute';

  static const PageInfo<AdminAuthRouteArgs> page = PageInfo<AdminAuthRouteArgs>(name);
}

class AdminAuthRouteArgs {
  const AdminAuthRouteArgs({
    this.BackButton,
    this.key,
  });

  final bool? BackButton;

  final Key? key;

  @override
  String toString() {
    return 'AdminAuthRouteArgs{BackButton: $BackButton, key: $key}';
  }
}

/// generated route for
/// [AuthAdminPage]
class AuthAdminRoute extends PageRouteInfo<void> {
  const AuthAdminRoute({List<PageRouteInfo>? children})
      : super(
          AuthAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthAdminRoute';

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
/// [BasketOrderAddressPage]
class BasketOrderAddressRoute extends PageRouteInfo<BasketOrderAddressRouteArgs> {
  BasketOrderAddressRoute({
    required String fulfillment,
    String? deleveryDay,
    String? office,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BasketOrderAddressRoute.name,
          args: BasketOrderAddressRouteArgs(
            fulfillment: fulfillment,
            deleveryDay: deleveryDay,
            office: office,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketOrderAddressRoute';

  static const PageInfo<BasketOrderAddressRouteArgs> page = PageInfo<BasketOrderAddressRouteArgs>(name);
}

class BasketOrderAddressRouteArgs {
  const BasketOrderAddressRouteArgs({
    required this.fulfillment,
    this.deleveryDay,
    this.office,
    this.key,
  });

  final String fulfillment;

  final String? deleveryDay;

  final String? office;

  final Key? key;

  @override
  String toString() {
    return 'BasketOrderAddressRouteArgs{fulfillment: $fulfillment, deleveryDay: $deleveryDay, office: $office, key: $key}';
  }
}

/// generated route for
/// [BasketOrderPage]
class BasketOrderRoute extends PageRouteInfo<BasketOrderRouteArgs> {
  BasketOrderRoute({
    bool? fbs,
    Key? key,
    String? address,
    required String fulfillment,
    List<PageRouteInfo>? children,
  }) : super(
          BasketOrderRoute.name,
          args: BasketOrderRouteArgs(
            fbs: fbs,
            key: key,
            address: address,
            fulfillment: fulfillment,
          ),
          initialChildren: children,
        );

  static const String name = 'BasketOrderRoute';

  static const PageInfo<BasketOrderRouteArgs> page = PageInfo<BasketOrderRouteArgs>(name);
}

class BasketOrderRouteArgs {
  const BasketOrderRouteArgs({
    this.fbs,
    this.key,
    this.address,
    required this.fulfillment,
  });

  final bool? fbs;

  final Key? key;

  final String? address;

  final String fulfillment;

  @override
  String toString() {
    return 'BasketOrderRouteArgs{fbs: $fbs, key: $key, address: $address, fulfillment: $fulfillment}';
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
/// [BlogAuthRegisterPage]
class BlogAuthRegisterRoute extends PageRouteInfo<BlogAuthRegisterRouteArgs> {
  BlogAuthRegisterRoute({
    bool? BackButton,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BlogAuthRegisterRoute.name,
          args: BlogAuthRegisterRouteArgs(
            BackButton: BackButton,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BlogAuthRegisterRoute';

  static const PageInfo<BlogAuthRegisterRouteArgs> page = PageInfo<BlogAuthRegisterRouteArgs>(name);
}

class BlogAuthRegisterRouteArgs {
  const BlogAuthRegisterRouteArgs({
    this.BackButton,
    this.key,
  });

  final bool? BackButton;

  final Key? key;

  @override
  String toString() {
    return 'BlogAuthRegisterRouteArgs{BackButton: $BackButton, key: $key}';
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
/// [BloggerDetailTapeCardPage]
class BloggerDetailTapeCardRoute extends PageRouteInfo<BloggerDetailTapeCardRouteArgs> {
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

  static const PageInfo<BloggerDetailTapeCardRouteArgs> page = PageInfo<BloggerDetailTapeCardRouteArgs>(name);
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
/// [ChangePasswordAdminPage]
class ChangePasswordAdminRoute extends PageRouteInfo<ChangePasswordAdminRouteArgs> {
  ChangePasswordAdminRoute({
    Key? key,
    required String textEditingController,
    List<PageRouteInfo>? children,
  }) : super(
          ChangePasswordAdminRoute.name,
          args: ChangePasswordAdminRouteArgs(
            key: key,
            textEditingController: textEditingController,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordAdminRoute';

  static const PageInfo<ChangePasswordAdminRouteArgs> page = PageInfo<ChangePasswordAdminRouteArgs>(name);
}

class ChangePasswordAdminRouteArgs {
  const ChangePasswordAdminRouteArgs({
    this.key,
    required this.textEditingController,
  });

  final Key? key;

  final String textEditingController;

  @override
  String toString() {
    return 'ChangePasswordAdminRouteArgs{key: $key, textEditingController: $textEditingController}';
  }
}

/// generated route for
/// [ChangePasswordBloggerPage]
class ChangePasswordBloggerRoute extends PageRouteInfo<ChangePasswordBloggerRouteArgs> {
  ChangePasswordBloggerRoute({
    Key? key,
    required String textEditingController,
    List<PageRouteInfo>? children,
  }) : super(
          ChangePasswordBloggerRoute.name,
          args: ChangePasswordBloggerRouteArgs(
            key: key,
            textEditingController: textEditingController,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordBloggerRoute';

  static const PageInfo<ChangePasswordBloggerRouteArgs> page = PageInfo<ChangePasswordBloggerRouteArgs>(name);
}

class ChangePasswordBloggerRouteArgs {
  const ChangePasswordBloggerRouteArgs({
    this.key,
    required this.textEditingController,
  });

  final Key? key;

  final String textEditingController;

  @override
  String toString() {
    return 'ChangePasswordBloggerRouteArgs{key: $key, textEditingController: $textEditingController}';
  }
}

/// generated route for
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    Key? key,
    required String textEditingController,
    List<PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(
            key: key,
            textEditingController: textEditingController,
          ),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const PageInfo<ChangePasswordRouteArgs> page = PageInfo<ChangePasswordRouteArgs>(name);
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({
    this.key,
    required this.textEditingController,
  });

  final Key? key;

  final String textEditingController;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key, textEditingController: $textEditingController}';
  }
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

  static const PageInfo<DetailCardProductRouteArgs> page = PageInfo<DetailCardProductRouteArgs>(name);
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
/// [DetailMyOrdersPage]
class DetailMyOrdersRoute extends PageRouteInfo<DetailMyOrdersRouteArgs> {
  DetailMyOrdersRoute({
    required BasketAdminOrderModel basket,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          DetailMyOrdersRoute.name,
          args: DetailMyOrdersRouteArgs(
            basket: basket,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailMyOrdersRoute';

  static const PageInfo<DetailMyOrdersRouteArgs> page = PageInfo<DetailMyOrdersRouteArgs>(name);
}

class DetailMyOrdersRouteArgs {
  const DetailMyOrdersRouteArgs({
    required this.basket,
    this.key,
  });

  final BasketAdminOrderModel basket;

  final Key? key;

  @override
  String toString() {
    return 'DetailMyOrdersRouteArgs{basket: $basket, key: $key}';
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

  static const PageInfo<DetailStoreRouteArgs> page = PageInfo<DetailStoreRouteArgs>(name);
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
/// [DetailTapeCardPage]
class DetailTapeCardRoute extends PageRouteInfo<DetailTapeCardRouteArgs> {
  DetailTapeCardRoute({
    required int? index,
    required String? shopName,
    Key? key,
    required TapeCubit tapeBloc,
    int? tapeId,
    List<PageRouteInfo>? children,
  }) : super(
          DetailTapeCardRoute.name,
          args: DetailTapeCardRouteArgs(
            index: index,
            shopName: shopName,
            key: key,
            tapeBloc: tapeBloc,
            tapeId: tapeId,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailTapeCardRoute';

  static const PageInfo<DetailTapeCardRouteArgs> page = PageInfo<DetailTapeCardRouteArgs>(name);
}

class DetailTapeCardRouteArgs {
  const DetailTapeCardRouteArgs({
    required this.index,
    required this.shopName,
    this.key,
    required this.tapeBloc,
    this.tapeId,
  });

  final int? index;

  final String? shopName;

  final Key? key;

  final TapeCubit tapeBloc;

  final int? tapeId;

  @override
  String toString() {
    return 'DetailTapeCardRouteArgs{index: $index, shopName: $shopName, key: $key, tapeBloc: $tapeBloc, tapeId: $tapeId}';
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
/// [ForgotPasswordAdminPage]
class ForgotPasswordAdminRoute extends PageRouteInfo<void> {
  const ForgotPasswordAdminRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgotPasswordBLoggerPage]
class ForgotPasswordBLoggerRoute extends PageRouteInfo<void> {
  const ForgotPasswordBLoggerRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordBLoggerRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordBLoggerRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<void> {
  const ForgotPasswordRoute({List<PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

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
/// [MapPickerPage]
class MapPickerRoute extends PageRouteInfo<MapPickerRouteArgs> {
  MapPickerRoute({
    Key? key,
    MapGeo? mapGeo,
    int? cc,
    double? lat,
    double? long,
    List<PageRouteInfo>? children,
  }) : super(
          MapPickerRoute.name,
          args: MapPickerRouteArgs(
            key: key,
            mapGeo: mapGeo,
            cc: cc,
            lat: lat,
            long: long,
          ),
          initialChildren: children,
        );

  static const String name = 'MapPickerRoute';

  static const PageInfo<MapPickerRouteArgs> page = PageInfo<MapPickerRouteArgs>(name);
}

class MapPickerRouteArgs {
  const MapPickerRouteArgs({
    this.key,
    this.mapGeo,
    this.cc,
    this.lat,
    this.long,
  });

  final Key? key;

  final MapGeo? mapGeo;

  final int? cc;

  final double? lat;

  final double? long;

  @override
  String toString() {
    return 'MapPickerRouteArgs{key: $key, mapGeo: $mapGeo, cc: $cc, lat: $lat, long: $long}';
  }
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

  static const PageInfo<PaymentWebviewRouteArgs> page = PageInfo<PaymentWebviewRouteArgs>(name);
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
/// [ProductsPage]
class ProductsRoute extends PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    required Cats cats,
    int? brandId,
    String? shopId,
    Cats? subCats,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            cats: cats,
            brandId: brandId,
            shopId: shopId,
            subCats: subCats,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const PageInfo<ProductsRouteArgs> page = PageInfo<ProductsRouteArgs>(name);
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    required this.cats,
    this.brandId,
    this.shopId,
    this.subCats,
    this.key,
  });

  final Cats cats;

  final int? brandId;

  final String? shopId;

  final Cats? subCats;

  final Key? key;

  @override
  String toString() {
    return 'ProductsRouteArgs{cats: $cats, brandId: $brandId, shopId: $shopId, subCats: $subCats, key: $key}';
  }
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
class ProfileBloggerTapeRoute extends PageRouteInfo<ProfileBloggerTapeRouteArgs> {
  ProfileBloggerTapeRoute({
    required int bloggerId,
    required String bloggerName,
    required String bloggerAvatar,
    Key? key,
    required bool inSubscribe,
    dynamic Function(bool)? onSubChanged,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileBloggerTapeRoute.name,
          args: ProfileBloggerTapeRouteArgs(
            bloggerId: bloggerId,
            bloggerName: bloggerName,
            bloggerAvatar: bloggerAvatar,
            key: key,
            inSubscribe: inSubscribe,
            onSubChanged: onSubChanged,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileBloggerTapeRoute';

  static const PageInfo<ProfileBloggerTapeRouteArgs> page = PageInfo<ProfileBloggerTapeRouteArgs>(name);
}

class ProfileBloggerTapeRouteArgs {
  const ProfileBloggerTapeRouteArgs({
    required this.bloggerId,
    required this.bloggerName,
    required this.bloggerAvatar,
    this.key,
    required this.inSubscribe,
    this.onSubChanged,
  });

  final int bloggerId;

  final String bloggerName;

  final String bloggerAvatar;

  final Key? key;

  final bool inSubscribe;

  final dynamic Function(bool)? onSubChanged;

  @override
  String toString() {
    return 'ProfileBloggerTapeRouteArgs{bloggerId: $bloggerId, bloggerName: $bloggerName, bloggerAvatar: $bloggerAvatar, key: $key, inSubscribe: $inSubscribe, onSubChanged: $onSubChanged}';
  }
}

/// generated route for
/// [RegisterShopPage]
class RegisterShopRoute extends PageRouteInfo<RegisterShopRouteArgs> {
  RegisterShopRoute({
    required String shopName,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterShopRoute.name,
          args: RegisterShopRouteArgs(
            shopName: shopName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterShopRoute';

  static const PageInfo<RegisterShopRouteArgs> page = PageInfo<RegisterShopRouteArgs>(name);
}

class RegisterShopRouteArgs {
  const RegisterShopRouteArgs({
    required this.shopName,
    this.key,
  });

  final String shopName;

  final Key? key;

  @override
  String toString() {
    return 'RegisterShopRouteArgs{shopName: $shopName, key: $key}';
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
    Cats? cats,
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

  static const PageInfo<SubCatalogRouteArgs> page = PageInfo<SubCatalogRouteArgs>(name);
}

class SubCatalogRouteArgs {
  const SubCatalogRouteArgs({
    this.key,
    this.cats,
  });

  final Key? key;

  final Cats? cats;

  @override
  String toString() {
    return 'SubCatalogRouteArgs{key: $key, cats: $cats}';
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

  static const PageInfo<UnderCatalogRouteArgs> page = PageInfo<UnderCatalogRouteArgs>(name);
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

  static const PageInfo<ViewAuthRegisterRouteArgs> page = PageInfo<ViewAuthRegisterRouteArgs>(name);
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
