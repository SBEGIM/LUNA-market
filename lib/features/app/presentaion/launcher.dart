import 'dart:async';
import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/admin_app/presentation/base_admin_new.dart';
import 'package:haji_market/bloger/admin_app/presentation/base_blogger_new.dart';
import 'package:haji_market/features/app/bloc/app_bloc.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/drawer/presentation/widgets/detail_card_product_page.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:haji_market/features/app/presentaion/base_new.dart';
import 'package:haji_market/features/app/widgets/custom_loading_widget.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:uni_links/uni_links.dart';

@RoutePage(name: 'LauncherRoute')
class LauncherApp extends StatefulWidget {
  const LauncherApp({super.key});
  @override
  State<LauncherApp> createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  @override
  void initState() {
    initUniLinks();
    initUniLinkss();
    BlocProvider.of<AppBloc>(context).add(const AppEvent.checkAuth());
    super.initState();
  }

  final bool token = GetStorage().hasData('token');
  ProductModel? product;
  Future<void> initUniLinks() async {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    try {
      final initialLink = await getInitialLink();

      print('$initialLink deeplink');

      if (initialLink != null) {
        // print(bloggerId + '222');
        // print(productId + 'wwww');

        String bloggerId = Uri.parse(initialLink.toString()).queryParameters['blogger_id'].toString();
        String productId = Uri.parse(initialLink.toString()).queryParameters['product_id'].toString();

        String shopName = Uri.parse(initialLink.toString()).queryParameters['shop_name'].toString();
        String index = Uri.parse(initialLink.toString()).queryParameters['index'].toString();

        if (productId != '' && productId != 'null') {
          print('wwww Success product');

          GetStorage().write('deep_blogger_id', bloggerId);
          GetStorage().write('deep_product_id', productId);
          getProductById(productId);
        }
        if (shopName != '' && shopName != 'null') {
          appBloc.state.maybeWhen(
            inAppUserState: (i) {
              context.router.push(DetailTapeCardRoute(index: int.parse(index), shopName: shopName,tapeBloc: BlocProvider.of<TapeCubit>(context)));
            },
            orElse: () {},
          );
          // BlocProvider.of<NavigationCubit>(context).emit(DetailTapeState(int.parse(index), shopName));
        }
      }
    } on PlatformException {}
  }

  late StreamSubscription _sub;

  Future<void> initUniLinkss() async {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    _sub = linkStream.listen((String? link) async {
      if (link != null) {
        String bloggerId = Uri.parse(link).queryParameters['blogger_id'].toString();
        String productId = Uri.parse(link).queryParameters['product_id'].toString();
        String shopName = Uri.parse(link).queryParameters['shop_name'].toString();
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

          appBloc.state.maybeWhen(
            inAppUserState: (i) {
              context.router.push(DetailTapeCardRoute(index: int.parse(index), shopName: shopName,tapeBloc: BlocProvider.of<TapeCubit>(context)));
            },
            orElse: () {},
          );
          // BlocProvider.of<NavigationCubit>(context).emit(DetailTapeState(int.parse(index), shopName));
        }
      }
    }, onError: (err) {});
  }

  Future<void> getProductById(
    productId,
  ) async {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
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

      appBloc.state.maybeWhen(
        inAppUserState: (i) {
          context.router.push(DetailCardProductRoute(product: product!));
        },
        orElse: () {},
      );
      // Get.to(() => DetailCardProductPage(product: product!));

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
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        state.whenOrNull(
            // inAppState: () {
            //   BlocProvider.of<ProfileBLoC>(context).add(const ProfileEvent.getProfile());
            //   BlocProvider.of<AppBloc>(context).add(const AppEvent.sendDeviceToken());
            // },
            // errorState: (message) {
            //   buildErrorCustomSnackBar(context, 'AppBloc => $message');
            // },
            );
      },
      builder: (context, state) {
        return state.maybeWhen(
          notAuthorizedState: () => const ViewAuthRegisterPage(),
          loadingState: () => const _Scaffold(child: CustomLoadingWidget()),
          inAppBlogerState: (index) => const BaseBloggerNew(),
          inAppAdminState: (index) => const BaseAdminNew(),
          inAppUserState: (index) => BaseNew(
            index: index,
          ),
          orElse: () => const BaseNew(),
        );
      },
    ); // OnBoardingPage();
  }
}

class _Scaffold extends StatelessWidget {
  final Widget child;
  const _Scaffold({
    required this.child,
    // super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: child),
    );
  }
}
