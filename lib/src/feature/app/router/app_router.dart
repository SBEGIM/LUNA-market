import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/register_page.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/success_register_page.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/login_forget_password_modal_bottom.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/login_forget_password_modal_bottom.dart';
import 'package:haji_market/src/feature/bloger/chat/presentation/chat_blogger_page.dart';
import 'package:haji_market/src/feature/bloger/coop_request/presentation/ui/blogger_register_page.dart';
import 'package:haji_market/src/feature/bloger/coop_request/presentation/ui/success_blogger_register_page.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/shop_products_page.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/success_blogger_tape_upload_video_page.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/upload_product_video.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/detail_tape_card_page.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/edit_tape_vidoe.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/tape_card_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/address_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/address_store_page.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/review_order_widget.dart';
import 'package:haji_market/src/feature/product/presentation/ui/products_recently_watched_page.dart';
import 'package:haji_market/src/feature/product/presentation/ui/products_recommend_page.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/search_product_widget.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/change_password_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/forgot_password_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/init_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/auth_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/new_register_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/success_register_seller_page.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/login_forget_password_modal_bottom.dart';
import 'package:haji_market/src/feature/seller/chat/presentation/chat_seller_page.dart';
import 'package:haji_market/src/feature/seller/main/presentation/main_seller_page.dart';
import 'package:haji_market/src/feature/seller/order/data/models/basket_order_seller_model.dart';
import 'package:haji_market/src/feature/seller/order/presentation/ui/my_orders_seller_page.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/detail_order_seller_page.dart';
import 'package:haji_market/src/feature/seller/product/data/models/product_seller_model.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/create_product_seller_page.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/edit_product_seller_page.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/map_seller_picker.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/product_promotion_page.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/products_seller_page.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/success_seller_product_store_page.dart';
import 'package:haji_market/src/feature/seller/promotion/model/seller_promotion.dart';
import 'package:haji_market/src/feature/seller/promotion/presentation/pages/seller_promotion_editor_page.dart';
import 'package:haji_market/src/feature/seller/promotion/presentation/pages/seller_promotions_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/ui/admin_profile_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/ui/tape_seller_page.dart';
import 'package:haji_market/src/feature/seller/tape_admin/presentation/ui/tape_admin_page.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/blog_auth_register_page.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/change_blogger_password.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/forgot_blogger_password.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/ui/blogger_profile_page.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/ui/blogger_tape_profile_page.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/blog_shops_page.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/ui/tape_blogger_page.dart';
import 'package:haji_market/src/feature/app/presentation/geo_position_page.dart';
import 'package:haji_market/src/feature/app/presentation/guest_user_page.dart';
import 'package:haji_market/src/feature/app/presentation/location_page.dart';
import 'package:haji_market/src/feature/chat/presentation/message.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/change_password.dart';
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
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/tape/presentation/ui/seller_tape_profile_page.dart';
import 'package:haji_market/src/feature/tape/presentation/ui/tape_page.dart';
import 'package:haji_market/src/feature/seller/chat/presentation/message_seller_page.dart';
import 'package:haji_market/src/feature/app/presentation/launcher.dart';
import 'package:haji_market/src/feature/tape/presentation/ui/detail_tape_card_page.dart';
import '../../auth/presentation/ui/forgot_password.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: LauncherRoute.page,
      initial: true,
      children: [
        /// For User
        AutoRoute(
          page: BaseTapeTab.page,
          children: [AutoRoute(page: TapeRoute.page, initial: true)],
        ),

        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: FavoriteRoute.page),
        AutoRoute(page: BasketRoute.page),
        AutoRoute(page: DrawerRoute.page),

        /// For Blogger
        AutoRoute(
          page: BaseAdminTapeTab.page,
          children: [
            // AutoRoute(page: TapeAdminRoute.page, initial: true),
            AutoRoute(page: TapeBloggerRoute.page, initial: true),
            AutoRoute(page: BloggerTapeCardRoute.page),
          ],
        ),
        AutoRoute(page: BlogShopsRoute.page),
        AutoRoute(page: ProfileBloggerRoute.page),
        AutoRoute(page: ChatBloggerRoute.page),

        ///For Seller
        AutoRoute(page: HomeSellerAdminRoute.page),
        AutoRoute(page: MyOrdersSellerRoute.page),
        AutoRoute(page: ChatSellerRoute.page),
        AutoRoute(page: MyProductsAdminRoute.page),
        AutoRoute(page: ProfileAdminRoute.page),
      ],
    ),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: BlogRegisterRoute.page),

    /// Location / onboarding
    AutoRoute(page: LocationRoute.page),
    AutoRoute(page: GeoPositionRoute.page),
    AutoRoute(page: GuestUserRoute.page),

    AutoRoute(page: AddressRoute.page),
    AutoRoute(page: AddressStoreRoute.page),

    AutoRoute(page: ViewAuthRegisterRoute.page),
    AutoRoute(page: SuccessBloggerRegisterRoute.page),
    AutoRoute(page: SuccessRegisterRoute.page),

    AutoRoute(page: DetailTapeCardRoute.page),
    AutoRoute(page: ProfileBloggerTapeRoute.page),
    AutoRoute(page: ProfileSellerTapeRoute.page),

    ///Basket Routes
    AutoRoute(page: PaymentWebviewRoute.page),
    AutoRoute(page: BasketOrderAddressRoute.page),
    AutoRoute(page: BasketOrderRoute.page),
    AutoRoute(page: ReviewOrderWidgetRoute.page),
    AutoRoute(page: LoginForgotSellerPasswordRoute.page),

    ///
    /// Home Routes
    ///
    AutoRoute(page: ShopsRoute.page),
    AutoRoute(page: CatalogRoute.page),
    AutoRoute(page: SubCatalogRoute.page),
    AutoRoute(page: DetailStoreRoute.page),
    AutoRoute(page: UnderCatalogRoute.page),
    AutoRoute(page: ProductsRoute.page),
    AutoRoute(page: ProductsRecommendedRoute.page),
    AutoRoute(page: ProductsRecentlyWatchedRoute.page),
    AutoRoute(page: MapPickerRoute.page),
    AutoRoute(page: SearchProductRoute.page),
    AutoRoute(page: DetailCardProductRoute.page),
    AutoRoute(page: DetailOrderSellerRoute.page),
    AutoRoute(page: MessageRoute.page),
    AutoRoute(page: MessageSellerRoute.page),

    ///Auth Routes
    AutoRoute(page: AuthSellerRoute.page),
    AutoRoute(page: InitSellerRoute.page),
    AutoRoute(page: SuccessSellerRegisterRoute.page),
    // AutoRoute(page: AdminAuthRoute.page),
    AutoRoute(page: ForgotPasswordSellerRoute.page),
    AutoRoute(page: LoginForgotBloggerPasswordRoute.page),
    AutoRoute(page: LoginForgotPasswordRoute.page),

    AutoRoute(page: ChangePasswordSellerRoute.page),
    AutoRoute(page: ForgotPasswordBloggerRoute.page),
    AutoRoute(page: ChangePasswordBloggerRoute.page),

    AutoRoute(page: RegisterSellerRoute.page),
    AutoRoute(page: BlogAuthRegisterRoute.page),

    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),

    //Seller pages
    AutoRoute(page: TapeSellerRoute.page),
    AutoRoute(page: EditProductSellerRoute.page),
    AutoRoute(page: CreateProductSellerRoute.page),
    AutoRoute(page: ProductPromotionRoute.page),
    AutoRoute(page: SellerPromotionsRoute.page),
    AutoRoute(page: SellerPromotionEditorRoute.page),
    AutoRoute(page: SuccessSellerProductStoreRoute.page),

    //Blogger pages
    AutoRoute(page: DetailTapeBloggerCardRoute.page),
    AutoRoute(page: EditTapeVideoRoute.page),
    AutoRoute(page: ShopProductsBloggerRoute.page),
    AutoRoute(page: UploadProductVideoRoute.page),
    AutoRoute(page: SuccessBloggerTapeUploadVideoRoute.page),
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
