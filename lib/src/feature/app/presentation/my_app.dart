import 'package:haji_market/src/core/containers/repository_storage.dart';
import 'package:haji_market/src/core/presentation/scopes/repository_scope.dart';
import 'package:haji_market/src/core/utils/extensions/context_extension.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/upload_video_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/data/repository/upload_video_blogger_repo.dart';
import 'package:haji_market/src/feature/initialization/logic/composition_root.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/register_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/data/repository/register_seller_repository.dart';
import 'package:haji_market/src/feature/seller/order/bloc/order_status_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/bloc/last_articul_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/bloc/size_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/characteristic_seller_repository.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/size_seller_repository.dart';
import 'package:haji_market/src/feature/seller/tape_admin/data/repository/tape_admin_repo.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/sms_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/data/repository/register_blogger_repo.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/presentation/app_router_builder.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/bloc/address_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/data/repository/tape_blogger_repo.dart';
import 'package:haji_market/src/feature/drawer/bloc/bonus_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/order_cubit.dart';
import 'package:haji_market/src/feature/product/cubit/product_ad_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/profit_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/respublic_cubit.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/drawer/data/repository/city_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/country_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/address_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/bonus_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/profit_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/respublic_repo.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/partner_cubit.dart';
import 'package:haji_market/src/feature/home/data/repository/meta_repository..dart';
import 'package:haji_market/src/feature/home/data/repository/partner_repository..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/login_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/data/repository/login_seller_repository.dart';
import 'package:haji_market/src/feature/seller/order/bloc/basket_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/order/data/repository/basket_seller_repository.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/color_seller_repository.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_month_statics_admin_cubit.dart';
import 'package:haji_market/src/feature/seller/profile/data/repository/profile_statics_admin_repo.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/edit_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/login_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/data/repository/login_blogger_repo.dart';
import 'package:haji_market/src/feature/bloger/auth/data/repository/edit_blogger_repo.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_shop_products_cubit.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_statics_blogger_cubit.dart';
import 'package:haji_market/src/feature/app/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:haji_market/src/feature/auth/bloc/login_cubit.dart';
import 'package:haji_market/src/feature/basket/bloc/cdek_office_cubit.dart';
import 'package:haji_market/src/feature/basket/data/repository/cdek_office_repo.dart';
import 'package:haji_market/src/feature/chat/data/cubit/chat_cubit.dart';
import 'package:haji_market/src/feature/chat/data/repository/chat_repo.dart';
import 'package:haji_market/src/feature/chat/data/repository/message_repo.dart';
import 'package:haji_market/src/feature/drawer/bloc/city_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/credit_cubit.dart';
import 'package:haji_market/src/feature/favorite/bloc/favorite_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/shops_drawer_cubit.dart';
import 'package:haji_market/src/feature/drawer/data/repository/brand_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/sub_cats_repo.dart';
import 'package:haji_market/src/feature/basket/data/repository/basket_repo.dart';
import 'package:haji_market/src/feature/drawer/data/repository/credit_repo.dart';
import 'package:haji_market/src/feature/favorite/data/repository/favorite_repository.dart';
import 'package:haji_market/src/feature/drawer/data/repository/shops_drawer_repo.dart';
import 'package:haji_market/src/feature/home/bloc/banners_cubit.dart';
import 'package:haji_market/src/feature/home/data/repository/popular_shops_repository.dart';
import 'package:haji_market/src/feature/tape/bloc/subs_cubit.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/tape/data/repository/sub_repository.dart';
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';
import '../../seller/chat/cubit/chat_seller_cubit.dart';
import '../../seller/chat/cubit/message_seller_cubit.dart';
import '../../seller/chat/data/repository/chat_seller_repository.dart';
import '../../seller/chat/data/repository/message_seller_repository.dart';
import '../../seller/product/bloc/characteristic_seller_cubit.dart';
import '../../seller/product/bloc/color_seller_cubit.dart';
import '../../seller/product/bloc/delete_image_seller_cubit.dart';
import '../../seller/product/bloc/product_seller_cubit.dart';
import '../../seller/product/bloc/statistic_product_seller_cubit.dart';
import '../../seller/product/data/repository/product_seller_repository.dart';
import '../../seller/product/data/repository/statistic_product_seller_repository.dart';
import '../../seller/profile/data/bloc/profile_edit_admin_cubit.dart';
import '../../seller/profile/data/bloc/profile_statics_admin_cubit.dart';
import '../../seller/profile/data/repository/profile_edit_admin_repo.dart';
import '../../seller/profile/data/repository/profile_month_statics_admin_repo.dart';
import '../../seller/tape_admin/data/cubit/tape_admin_cubit.dart';
import '../../bloger/shop/bloc/blogger_product_statistics_cubit.dart';
import '../../bloger/shop/bloc/blogger_tape_upload_cubit.dart';
import '../../bloger/shop/data/repository/blogger_products_statistics_repo.dart';
import '../../bloger/shop/data/repository/blogger_shop_products_repo.dart';
import '../../bloger/shop/data/repository/blogger_tape_upload_repo.dart';
import '../../bloger/profile/bloc/profile_month_statics_blogger_cubit.dart';
import '../../bloger/profile/data/repository/profile_month_statics_blogger_repo.dart';
import '../../bloger/profile/data/repository/profile_statics_blogger_repo.dart';
import '../../auth/bloc/register_cubit.dart';
import '../../auth/bloc/sms_cubit.dart';
import '../../auth/data/repository/login_repository.dart';
import '../../auth/data/repository/register_repo.dart';
import '../../chat/data/cubit/message_cubit.dart';
import '../../basket/bloc/basket_cubit.dart';
import '../../drawer/bloc/brand_cubit.dart';
import '../../drawer/bloc/country_cubit.dart';
import '../../product/cubit/product_cubit.dart';
import '../../drawer/bloc/sub_cats_cubit.dart';
import '../../product/data/repository/product_ad_repo.dart';
import '../../product/data/repository/product_repo.dart';
import '../../drawer/data/repository/review_product_repo.dart';
import '../../home/bloc/cats_cubit.dart';
import '../../home/bloc/popular_shops_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.result});

  final CompositionResult result;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool token = GetStorage().hasData('token');
  ProductModel? product;

  @override
  Widget build(BuildContext context) {
    return RepositoryScope(
      create: (context) => RepositoryStorage(
        sharedPreferences: widget.result.dependencies.sharedPreferences,
        packageInfo: widget.result.dependencies.packageInfo,
        appSettingsDatasource: widget.result.dependencies.appSettingsDatasource,
      ),
      child: MultiBlocWrapper(
        child: GetMaterialApp(
          title: 'Haji Market',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            //  fontFamily: 'Nunito',
            primarySwatch: Colors.blue,
          ),
          home: MediaQuery.withNoTextScaling(
            child: AppRouterBuilder(
              createRouter: (context) => AppRouter(),
              builder: (context, parser, delegate) => MaterialApp.router(
                // builder: (context, child) => SizedBox(),
                // backButtonDispatcher:RootBackButtonDispatcher(),
                // routeInformationProvider: appRouter.routeInfoProvider(),
                // routerConfig: appRouter.config(
                //   deepLinkBuilder: (deepLink) async {
                //     return DeepLink.single(DetailCardProductRoute(product: ProductModel()));
                //     String bloggerId = Uri.parse(deepLink.path.toString()).queryParameters['blogger_id'].toString();
                //     String productId = Uri.parse(deepLink.path.toString()).queryParameters['product_id'].toString();

                //     String shopName = Uri.parse(deepLink.path.toString()).queryParameters['shop_name'].toString();
                //     String index = Uri.parse(deepLink.path.toString()).queryParameters['index'].toString();
                //     print(deepLink.path,);
                //     print(shopName,);
                //     print(index,);
                //     // if (productId != '' && productId != 'null') {
                //     //   print('wwww Success product');
                //     //   GetStorage().write('deep_blogger_id', bloggerId);
                //     //   GetStorage().write('deep_product_id', productId);
                //     //   const baseUrl = 'https://lunamarket.ru/api';

                //     //   final String? authToken = GetStorage().read('token');

                //     //   final response = await http.get(
                //     //     Uri.parse(
                //     //       '$baseUrl/shop/show?id=$productId',
                //     //     ),
                //     //     headers: {"Authorization": "Bearer $authToken"},
                //     //   );

                //     //   if (response.statusCode == 200) {
                //     //     final data = jsonDecode(response.body);

                //     //     product = ProductModel.fromJson(data['data']);
                //     //     return DeepLink([DetailCardProductRoute(product: product!)]);
                //     //     // Get.to(() => DetailCardProductPage(product: product!));

                //     //     // Get.snackbar('Промокод активирован',
                //     //     //     'покупайте товары и получайте скидку от Блогера',
                //     //     //     backgroundColor: Colors.blueAccent);
                //     //   } else {
                //     //     // Get.snackbar('Ошибка промокод', 'продукт или блогер не найден',
                //     //     //     backgroundColor: Colors.redAccent);
                //     //   }
                //     // }
                //     if (shopName != '' && shopName != 'null') {

                //       return const DeepLink([LauncherRoute(children: [BasketRoute()])]);
                //       // return DeepLink([
                //       //   LauncherRoute(children: [
                //       //     BaseTapeTab(children: [DetailTapeCardRoute(index: int.parse(index), shopName: shopName)])
                //       //   ])
                //       // ]);
                //       // BlocProvider.of<NavigationCubit>(context)
                //       //     .emit(DetailTapeState(int.parse(index), shopName));
                //     } else {
                //       return const DeepLink([LauncherRoute(children: [BasketRoute()])]);
                //     }
                //   },
                // ),

                routeInformationParser: parser,
                routerDelegate: delegate,
                // onGenerateTitle: (context) => context.localized.appTitle,
                // theme: ThemeData.light(),
                // darkTheme: ThemeData.dark(),
                // themeMode: themeMode,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc()),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => AdminNavigationCubit()),
        BlocProvider(
          create: (_) => LoginCubit(
            loginRepository: LoginRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => LoginBloggerCubit(
            loginBloggerRepository: LoginBloggerRepository(),
          ),
        ),
        BlocProvider(
            create: (_) => SmsCubit(registerRepository: RegisterRepository())),
        BlocProvider(
            create: (_) =>
                RegisterCubit(registerRepository: RegisterRepository())),
        BlocProvider(
          create: (_) => CatsCubit(
            catsRepository: context.repository.catsRepository,
          ),
        ),
        BlocProvider(
            create: (_) => SubCatsCubit(subCatRepository: SubCatsRepository())),
        BlocProvider(
            create: (_) => BannersCubit(
                  bannersRepository: context.repository.bannersRepository,
                )),
        BlocProvider(
            create: (_) => PopularShopsCubit(
                popularShopsRepository: PopularShopsRepository())),
        BlocProvider(
            create: (_) => ShopsDrawerCubit(
                shopsDrawerRepository: ShopsDrawerRepository())),
        BlocProvider(
            create: (_) =>
                ProductCubit(productRepository: ProductRepository())),
        BlocProvider(
            create: (_) =>
                FavoriteCubit(favoriteRepository: FavoriteRepository())),
        BlocProvider(
            create: (_) => BasketCubit(basketRepository: BasketRepository())),
        BlocProvider(
            create: (_) => OrderCubit(basketRepository: BasketRepository())),
        BlocProvider(
            create: (_) => BrandCubit(brandRepository: BrandsRepository())),
        BlocProvider(
            create: (_) =>
                LastArticulSellerCubit(repository: ProductSellerRepository())),
        BlocProvider(
            create: (_) => LoginSellerCubit(
                loginAdminRepository: LoginSellerRepository())),
        BlocProvider(
            create: (_) => ProductSellerCubit(
                productAdminRepository: ProductSellerRepository())),
        BlocProvider(
            create: (_) =>
                BasketSellerCubit(basketRepository: BasketSellerRepository())),
        BlocProvider(
            create: (_) => OrderStatusSellerCubit(
                basketAdminRepository: BasketSellerRepository(),
                BasketRepository())),
        BlocProvider(
            create: (_) =>
                ColorSellerCubit(colorRepository: ColorSellerRepository())),
        BlocProvider(
            create: (_) => TapeCubit(tapeRepository: TapeRepository())),
        BlocProvider(
            create: (_) => SubsCubit(subsRepository: SubsRepository())),
        BlocProvider(
            create: (_) => ProfileStaticsBloggerCubit(
                profileStaticsBloggerRepository:
                    ProfileStaticsBloggerRepository())),
        BlocProvider(
            create: (_) => ProfileMonthStaticsBloggerCubit(
                profileMonthStaticsBloggerRepository:
                    ProfileMonthStaticsBloggerRepository())),
        BlocProvider(
          create: (_) => EditBloggerCubit(
            editBloggerRepository: EditBloggerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => BloggerProductStatisticsCubit(
            bloggerProductStatisticsRepository:
                BloggerProductsStatisticsRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => BloggerShopProductsCubit(
            bloggerShopProductsRepository: BloggerShopProductsRepository(),
          ),
        ),
        // BlocProvider(
        //     create: (_) => BloggerVideoProductsCubit(
        //         bloggerShopProductsRepository:
        //             BloggerVideoProductsRepository())),
        BlocProvider(
          create: (_) => UploadVideoBLoggerCubit(
            uploadVideoBloggerCubitRepository:
                UploadVideoBloggerCubitRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ChatCubit(
            chatRepository: ChatRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => MessageCubit(
            messageRepository: MessageRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ChatSellerCubit(
            chatRepository: ChatSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => MessageSellerCubit(
            messageRepository: MessageSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileMonthStaticsAdminCubit(
            profileMonthStaticsBloggerRepository:
                ProfileMonthStaticsAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileStaticsAdminCubit(
            profileStaticsBloggerRepository: ProfileStaticsAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ReviewCubit(
            reviewProductRepository: ReviewProductRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CreditCubit(
            creditRepository: CreditRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CdekOfficeCubit(
            cdekRepository: CdekOfficeRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => BloggerTapeUploadCubit(
            bloggerTapeUploadRepository: BloggerTapeUploadRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => RespublicCubit(
            respublicRepository: RespublicRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfileEditAdminCubit(
            profileEditAdminRepository: ProfileEditAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => RegisterSellerCubit(
            registerAdminRepository: RegisterSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => SmsSellerCubit(
            registerRepository: RegisterSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => TapeAdminCubit(
            tapeRepository: TapeAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CityCubit(
            cityRepository: CityRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CountryCubit(
            countryRepository: CountryRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProductAdCubit(
            productAdRepository: ProductAdRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProfitCubit(
            profitRepository: ProfitRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => BonusCubit(
            bonusRepository: BonusRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => AddressCubit(
            addressRepository: AddressRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => TapeBloggerCubit(
            tapeRepository: TapeBloggerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => PartnerCubit(
            partnerRepository: PartnerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => SizeSellerCubit(
            sizeRepository: ProductSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => DeleteImageSellerCubit(
            colorRepository: ProductSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => StatisticsProductSellerCubit(
            statisticsProductAdminRepo: StatisticsProductAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => CharacteristicSellerCubit(
            characteristicRepository: CharacteristicSellerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => SmsBloggerCubit(
            registerRepository: RegisterBloggerRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => MetaCubit(
            metaRepository: MetaRepository(),
          ),
        ),
      ],
      child: child,
    );
  }
}
