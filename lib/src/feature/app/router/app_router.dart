import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/feature/shop/auth/presentation/ui/auth_admin_page.dart';
import 'package:haji_market/src/feature/shop/auth/presentation/ui/change_password.dart';
import 'package:haji_market/src/feature/shop/auth/presentation/ui/forgot_admin_password.dart';
import 'package:haji_market/src/feature/shop/auth/presentation/ui/register_shop_page.dart';
import 'package:haji_market/src/feature/shop/auth/presentation/ui/admin_auth_page.dart';
import 'package:haji_market/src/feature/shop/chat/presentation/chat_admin_page.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/data/models/basket_admin_order_model.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/presentation/ui/my_orders_admin_page.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/presentation/widgets/detail_my_orders_page.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/presentation/ui/my_products_admin_page.dart';
import 'package:haji_market/src/feature/shop/profile_admin/presentation/ui/admin_profile_page.dart';
import 'package:haji_market/src/feature/shop/tape_admin/presentation/ui/tape_admin_page.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/blog_auth_register_page.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/change_blogger_password.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/forgot_blogger_password.dart';
import 'package:haji_market/src/feature/bloger/my_orders_admin/presentation/widgets/blogger_detail_tape_card_page.dart';
import 'package:haji_market/src/feature/bloger/profile_admin/presentation/ui/blogger_profile_page.dart';
import 'package:haji_market/src/feature/bloger/profile_admin/presentation/ui/blogger_tape_profile_page.dart';
import 'package:haji_market/src/feature/bloger/shops/blog_shops_page.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/ui/tape_blogger_page.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/change_password.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/src/feature/basket/data/DTO/map_geo_dto.dart';
import 'package:haji_market/src/feature/basket/presentation/ui/basket_order_address_page.dart';
import 'package:haji_market/src/feature/basket/presentation/ui/basket_order_page.dart';
import 'package:haji_market/src/feature/basket/presentation/ui/basket_page.dart';
import 'package:haji_market/src/feature/basket/presentation/ui/map_picker.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/payment_webview_widget.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/catalog_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/drawer_home.dart';
import 'package:haji_market/src/feature/product/presentation/ui/products_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/shops_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/sub_catalog_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/detail_card_product_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/detailed_store_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/under_catalog_page.dart';
import 'package:haji_market/src/feature/favorite/presentation/ui/favorite_page.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/home/presentation/ui/home_page.dart';
import 'package:haji_market/src/feature/home/presentation/widgets/search_product_page.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/tape/presentation/ui/tape_page.dart';
import 'package:haji_market/src/feature/app/presentaion/launcher.dart';
import 'package:haji_market/src/feature/tape/presentation/ui/detail_tape_card_page.dart';
import '../../auth/presentation/ui/forgot_password.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LauncherRoute.page,
          initial: true,
          children: [
            /// For User
            AutoRoute(
              page: BaseTapeTab.page,
              children: [
                AutoRoute(
                  page: TapeRoute.page,
                  initial: true,
                ),
                AutoRoute(
                  page: DetailTapeCardRoute.page,
                ),
                AutoRoute(
                  page: ProfileBloggerTapeRoute.page,
                ),
              ],
            ),
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: FavoriteRoute.page),
            AutoRoute(page: BasketRoute.page),
            AutoRoute(page: DrawerRoute.page),

            /// For Blogger
            AutoRoute(page: BaseAdminTapeTab.page, children: [
              // AutoRoute(page: TapeAdminRoute.page, initial: true),
              AutoRoute(page: TapeBloggerRoute.page, initial: true),
              AutoRoute(page: BloggerDetailTapeCardRoute.page),
            ]),
            AutoRoute(page: BlogShopsRoute.page),
            AutoRoute(page: ProfileBloggerRoute.page),

            ///For Admin
            AutoRoute(page: MyOrdersAdminRoute.page),
            AutoRoute(page: ChatAdminRoute.page),
            AutoRoute(page: MyProductsAdminRoute.page),
            AutoRoute(page: ProfileAdminRoute.page),
          ],
        ),

        ///Basket Routes
        AutoRoute(page: PaymentWebviewRoute.page),
        AutoRoute(page: BasketOrderAddressRoute.page),
        AutoRoute(page: BasketOrderRoute.page),
        AutoRoute(page: MapPickerRoute.page),

        ///Home Routes
        AutoRoute(page: ShopsRoute.page),
        AutoRoute(page: CatalogRoute.page),
        AutoRoute(page: SubCatalogRoute.page),
        AutoRoute(page: DetailStoreRoute.page),
        AutoRoute(page: UnderCatalogRoute.page),
        AutoRoute(page: ProductsRoute.page),
        AutoRoute(page: SearchProductRoute.page),
        AutoRoute(page: DetailCardProductRoute.page),

        ///Auth Routes
        AutoRoute(page: AuthAdminRoute.page),
        AutoRoute(page: AdminAuthRoute.page),
        AutoRoute(page: ForgotPasswordAdminRoute.page),

        AutoRoute(page: ChangePasswordAdminRoute.page),
        AutoRoute(page: ForgotPasswordBLoggerRoute.page),
        AutoRoute(page: RegisterShopRoute.page),
        AutoRoute(page: BlogAuthRegisterRoute.page),

        AutoRoute(page: ChangePasswordRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
      ];
}

@RoutePage(name: 'BaseTapeTab')
class BaseTapePage extends AutoRouter {
  const BaseTapePage({super.key});
}

@RoutePage(name: 'BaseAdminTapeTab')
class BaseAdminTapePage extends AutoRouter {
  const BaseAdminTapePage({super.key});
}

// @RoutePage(name: 'BaseHomeTab')
// class BaseHomePage extends AutoRouter {
//   const BaseHomePage({super.key});
// }

// @RoutePage(name: 'BaseBasketTab')
// class BaseBasketPage extends AutoRouter {
//   const BaseBasketPage({super.key});
// }

// @RoutePage(name: 'BaseFavoriteTab')
// class BaseFavoritePage extends AutoRouter {
//   const BaseFavoritePage({super.key});
// }

// @RoutePage(name: 'BaseDrawerTab')
// class BaseDrawerPage extends AutoRouter {
//   const BaseDrawerPage({super.key});
// }
