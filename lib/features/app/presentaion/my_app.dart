import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:haji_market/admin/auth/data/bloc/register_admin_cubit.dart';
import 'package:haji_market/admin/auth/data/bloc/sms_admin_cubit.dart';
import 'package:haji_market/admin/auth/data/repository/registerAdminRepo.dart';
import 'package:haji_market/admin/tape_admin/data/repository/tape_admin_repo.dart';
import 'package:haji_market/bloger/tape/data/cubit/tape_blogger_cubit.dart';
import 'package:haji_market/bloger/tape/data/repository/tape_blogger_repo.dart';
import 'package:haji_market/features/drawer/data/bloc/address_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/bonus_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/product_ad_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/profit_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/respublic_cubit.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/drawer/data/repository/CityRepo.dart';
import 'package:haji_market/features/drawer/data/repository/CountryRepo.dart';
import 'package:haji_market/features/drawer/data/repository/address_repo.dart';
import 'package:haji_market/features/drawer/data/repository/bonus_repo.dart';
import 'package:haji_market/features/drawer/data/repository/profit_repo.dart';
import 'package:haji_market/features/drawer/data/repository/respublic_repo.dart';
import 'package:haji_market/features/tape/presentation/ui/detail_tape_card_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/admin/auth/data/bloc/login_admin_cubit.dart';
import 'package:haji_market/admin/auth/data/repository/LoginAdminRepo.dart';
import 'package:haji_market/admin/my_orders_admin/data/bloc/basket_admin_cubit.dart';
import 'package:haji_market/admin/my_orders_admin/data/repository/basket_admin_repo.dart';
import 'package:haji_market/admin/my_products_admin/data/repository/ColorAdminRepo.dart';
import 'package:haji_market/admin/profile_admin/data/bloc/profile_month_statics_admin_cubit.dart';
import 'package:haji_market/admin/profile_admin/data/repository/profile_statics_admin_repo.dart';
import 'package:haji_market/bloger/auth/data/bloc/edit_blogger_cubit.dart';
import 'package:haji_market/bloger/auth/data/bloc/login_blogger_cubit.dart';
import 'package:haji_market/bloger/auth/data/repository/LoginBloggerRepo.dart';
import 'package:haji_market/bloger/auth/data/repository/editBloggerRepo.dart';
import 'package:haji_market/bloger/my_products_admin/data/bloc/blogger_shop_products_cubit.dart';
import 'package:haji_market/bloger/profile_admin/presentation/data/bloc/profile_statics_blogger_cubit.dart';
import 'package:haji_market/features/app/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/auth/data/bloc/login_cubit.dart';
import 'package:haji_market/features/basket/data/bloc/cdek_office_cubit.dart';
import 'package:haji_market/features/basket/data/repository/CdekOfficeRepo.dart';
import 'package:haji_market/features/chat/data/cubit/chat_cubit.dart';
import 'package:haji_market/features/chat/data/repository/chat_repo.dart';
import 'package:haji_market/features/chat/data/repository/message_repo.dart';
import 'package:haji_market/features/drawer/data/bloc/city_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/credit_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/review_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/shops_drawer_cubit.dart';
import 'package:haji_market/features/drawer/data/repository/BrandRepo.dart';
import 'package:haji_market/features/drawer/data/repository/SubCatsRepo.dart';
import 'package:haji_market/features/drawer/data/repository/basket_repo.dart';
import 'package:haji_market/features/drawer/data/repository/credit_repo.dart';
import 'package:haji_market/features/drawer/data/repository/favorite_repo.dart';
import 'package:haji_market/features/drawer/data/repository/shops_drawer_repo.dart';
import 'package:haji_market/features/home/data/bloc/banners_cubit.dart';
import 'package:haji_market/features/home/data/repository/CatsRepo.dart';
import 'package:haji_market/features/home/data/repository/Popular_shops_repo.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/subs_cubit.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_cubit.dart';
import 'package:haji_market/features/tape/presentation/data/repository/sub_repo.dart';
import 'package:haji_market/features/tape/presentation/data/repository/tape_repo.dart';
import 'package:uni_links/uni_links.dart';

import '../../../admin/chat/data/cubit/chat_admin_cubit.dart';
import '../../../admin/chat/data/cubit/message_admin_cubit.dart';
import '../../../admin/chat/data/repository/chat_admin_repo.dart';
import '../../../admin/chat/data/repository/message_admin_repo.dart';
import '../../../admin/my_products_admin/data/bloc/color_cubit.dart';
import '../../../admin/my_products_admin/data/bloc/product_admin_cubit.dart';
import '../../../admin/my_products_admin/data/repository/ProductAdminRepo.dart';
import '../../../admin/profile_admin/data/bloc/profile_edit_admin_cubit.dart';
import '../../../admin/profile_admin/data/bloc/profile_statics_admin_cubit.dart';
import '../../../admin/profile_admin/data/repository/profile_edit_admin_repo.dart';
import '../../../admin/profile_admin/data/repository/profile_month_statics_admin_repo.dart';
import '../../../admin/tape_admin/data/cubit/tape_admin_cubit.dart';
import '../../../bloger/my_orders_admin/data/bloc/blogger_video_products_cubit.dart';
import '../../../bloger/my_orders_admin/data/bloc/upload_video_blogger_cubit.dart';
import '../../../bloger/my_orders_admin/data/repository/blogger_video_products_repo.dart';
import '../../../bloger/my_orders_admin/data/repository/upload_video_blogger_repo.dart';
import '../../../bloger/my_products_admin/data/bloc/blogger_product_statistics_cubit.dart';
import '../../../bloger/my_products_admin/data/bloc/blogger_tape_upload_cubit.dart';
import '../../../bloger/my_products_admin/data/repository/blogger_products_statistics_repo.dart';
import '../../../bloger/my_products_admin/data/repository/blogger_shop_products_repo.dart';
import '../../../bloger/my_products_admin/data/repository/blogger_tape_upload_repo.dart';
import '../../../bloger/profile_admin/presentation/data/bloc/profile_month_statics_blogger_cubit.dart';
import '../../../bloger/profile_admin/presentation/data/repository/profile_month_statics_blogger_repo.dart';
import '../../../bloger/profile_admin/presentation/data/repository/profile_statics_blogger_repo.dart';
import '../../../main.dart';
import '../../auth/data/bloc/register_cubit.dart';
import '../../auth/data/bloc/sms_cubit.dart';
import '../../auth/data/repository/LoginRepo.dart';
import '../../auth/data/repository/registerRepo.dart';
import '../../auth/presentation/ui/view_auth_register_page.dart';
import '../../chat/data/cubit/message_cubit.dart';
import '../../drawer/data/bloc/basket_cubit.dart';
import '../../drawer/data/bloc/brand_cubit.dart';
import '../../drawer/data/bloc/country_cubit.dart';
import '../../drawer/data/bloc/product_cubit.dart';
import '../../drawer/data/bloc/sub_cats_cubit.dart';
import '../../drawer/data/repository/product_ad_repo.dart';
import '../../drawer/data/repository/product_repo.dart';
import '../../drawer/data/repository/review_product_repo.dart';
import '../../drawer/presentation/widgets/detail_card_product_page.dart';
import '../../home/data/bloc/cats_cubit.dart';
import '../../home/data/bloc/popular_shops_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool token = GetStorage().hasData('token');
  ProductModel? product;

  Future<void> checkInitialMessage() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      final RemoteMessage message = initialMessage;
      log('checkInitialMessage:: ${initialMessage.data}');
    }
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
    initUniLinkss();

    checkInitialMessage();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      print(notification!.title.toString());

      if (notification != null && Platform.isAndroid) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/launcher_icon',
            ),
          ),
        );
      }
    });
  }

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();

      print('$initialLink deeplink');

      if (initialLink != null) {
        // print(bloggerId + '222');
        // print(productId + 'wwww');

        String bloggerId = Uri.parse(initialLink.toString())
            .queryParameters['blogger_id']
            .toString();
        String productId = Uri.parse(initialLink.toString())
            .queryParameters['product_id']
            .toString();

        String shopName = Uri.parse(initialLink.toString())
            .queryParameters['shop_name']
            .toString();
        String index = Uri.parse(initialLink.toString())
            .queryParameters['index']
            .toString();

        if (productId != '' && productId != 'null') {
          print('wwww Success product');

          GetStorage().write('deep_blogger_id', bloggerId);
          GetStorage().write('deep_product_id', productId);
          getProductById(productId);
        }
        if (shopName != '' && shopName != 'null') {
          BlocProvider.of<NavigationCubit>(context)
              .emit(DetailTapeState(int.parse(index), shopName));
        }
      }
    } on PlatformException {}
  }

  late StreamSubscription _sub;

  Future<void> initUniLinkss() async {
    _sub = linkStream.listen((String? link) async {
      if (link != null) {
        String bloggerId =
            Uri.parse(link).queryParameters['blogger_id'].toString();
        String productId =
            Uri.parse(link).queryParameters['product_id'].toString();
        String shopName =
            Uri.parse(link).queryParameters['shop_name'].toString();
        String index = Uri.parse(link).queryParameters['index'].toString();

        if (productId != '' && productId != 'null') {
          GetStorage().write('deep_blogger_id', bloggerId);
          GetStorage().write('deep_product_id', productId);

          getProductById(productId);
        }

        if (shopName != '' && shopName != 'null') {
          // BlocProvider.of<NavigationCubit>(context)
          //     .getNavBarItem(NavigationState.tape())
          //     .whenComplete(
          //   () {
          //     Get.to(() => DetailTapeCardPage(
          //           index: int.parse(index),
          //           shop_name: shopName,
          //         ));
          //   },
          // );

          BlocProvider.of<NavigationCubit>(context)
              .emit(DetailTapeState(int.parse(index), shopName));
        }
      }
    }, onError: (err) {});
  }

  Future<void> getProductById(productId) async {
    const baseUrl = 'http://185.116.193.73/api';

    final String? authToken = GetStorage().read('token');

    final response = await http.get(
      Uri.parse(
        '$baseUrl/shop/show?id=$productId',
      ),
      headers: {"Authorization": "Bearer $authToken"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      product = ProductModel.fromJson(data['data']);

      Get.to(() => DetailCardProductPage(product: product!));

      // Get.snackbar('Промокод активирован',
      //     'покупайте товары и получайте скидку от Блогера',
      //     backgroundColor: Colors.blueAccent);
    } else {
      // Get.snackbar('Ошибка промокод', 'продукт или блогер не найден',
      //     backgroundColor: Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Haji Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //  fontFamily: 'Nunito',
        primarySwatch: Colors.blue,
      ),
      home: token != true ? const ViewAuthRegisterPage() : const Base(index: 0),
// const BaseAdmin()
      // const SelectCountryPage()
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
            create: (_) => CatsCubit(listRepository: ListRepository())),
        BlocProvider(
            create: (_) => SubCatsCubit(subCatRepository: SubCatsRepository())),
        BlocProvider(
            create: (_) => BannersCubit(listRepository: ListRepository())),
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
            create: (_) => BrandCubit(brandRepository: BrandsRepository())),
        BlocProvider(
            create: (_) =>
                LoginAdminCubit(loginAdminRepository: LoginAdminRepository())),
        BlocProvider(
            create: (_) => ProductAdminCubit(
                productAdminRepository: ProductAdminRepository())),
        BlocProvider(
            create: (_) =>
                BasketAdminCubit(basketRepository: BasketAdminRepository())),
        BlocProvider(
            create: (_) => ColorCubit(colorRepository: ColorAdminRepository())),
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
        BlocProvider(
            create: (_) => BloggerVideoProductsCubit(
                bloggerShopProductsRepository:
                    BloggerVideoProductsRepository())),
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
          create: (_) => ChatAdminCubit(
            chatRepository: ChatAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => MessageAdminCubit(
            messageRepository: MessageAdminRepository(),
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
          create: (_) => RegisterAdminCubit(
            registerAdminRepository: RegisterAdminRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => SmsAdminCubit(
            registerRepository: RegisterAdminRepository(),
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
      ],
      child: child,
    );
  }
}
