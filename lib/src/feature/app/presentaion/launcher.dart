import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:haji_market/src/feature/shop/chat/presentation/message_admin_page.dart';
import 'package:haji_market/src/feature/chat/presentation/message.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/shop/admin_app/presentation/base_admin_new.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/data/models/basket_admin_order_model.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/presentation/widgets/detail_my_orders_page.dart';
import 'package:haji_market/src/feature/bloger/admin_app/presentation/base_blogger_new.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:haji_market/src/feature/app/presentaion/base_new.dart';
import 'package:haji_market/src/feature/app/widgets/custom_loading_widget.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/view_auth_register_page.dart';
// import 'package:app_links/app_links.dart';

@RoutePage(name: 'LauncherRoute')
class LauncherApp extends StatefulWidget {
  const LauncherApp({super.key});
  @override
  State<LauncherApp> createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  late final AppLinks _appLinks;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    initAppLinks();
    BlocProvider.of<AppBloc>(context).add(const AppEvent.checkAuth());
    checkInitialMessage();
    FirebaseMessaging.onMessage.listen(_handleFirebaseMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleFirebaseMessageOpened);
  }

  Future<void> initAppLinks() async {
    _appLinks = AppLinks();

    // Get the initial link
    final Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      handleDeepLink(initialLink);
    }

    // Listen to link stream
    // final linkSubscription =
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    });
  }

  void handleDeepLink(Uri uri) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final bloggerId = uri.queryParameters['blogger_id'] ?? '';
    final productId = uri.queryParameters['product_id'] ?? '';
    final shopName = uri.queryParameters['shop_name'] ?? '';
    final index = uri.queryParameters['index'] ?? '';

    if (productId.isNotEmpty && productId != 'null') {
      GetStorage().write('deep_blogger_id', bloggerId);
      GetStorage().write('deep_product_id', productId);
      getProductById(productId);
    }

    if (shopName.isNotEmpty && shopName != 'null') {
      appBloc.state.maybeWhen(
        inAppUserState: (i) {
          context.router.push(DetailTapeCardRoute(
            index: int.parse(index),
            shopName: shopName,
            tapeBloc: BlocProvider.of<TapeCubit>(context),
          ));
        },
        orElse: () {},
      );
    }
  }

  Future<void> checkInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      log('checkInitialMessage: ${initialMessage.data}');
    }
  }

  Future<void> getProductById(String productId) async {
    const baseUrl = 'https://lunamarket.ru/api';
    final authToken = GetStorage().read<String>('token');
    final response = await http.get(
      Uri.parse('$baseUrl/shop/show?id=$productId'),
      headers: {"Authorization": "Bearer $authToken"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final product = ProductModel.fromJson(data['data']);

      BlocProvider.of<AppBloc>(context).state.maybeWhen(
            inAppUserState: (i) {
              context.router.push(DetailCardProductRoute(product: product));
            },
            orElse: () {},
          );
    }
  }

  void _handleFirebaseMessage(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data['type'];

    if (data == 'shop') {
      final basket = BasketAdminOrderModel.fromJson(
        jsonDecode(message.data['basket']),
      );
      Get.snackbar(
        notification?.title ?? '',
        notification?.body ?? '',
        onTap: (_) => Get.to(DetailMyOrdersPage(basket: basket)),
        backgroundColor: Colors.blueAccent,
        duration: const Duration(seconds: 10),
      );
    } else if (data == 'chat') {
      final chat = jsonDecode(message.data['chat']);
      final appBloc = BlocProvider.of<AppBloc>(context);

      Get.snackbar(
        notification?.title ?? '',
        notification?.body ?? '',
        onTap: (_) => appBloc.state.maybeWhen(
          inAppUserState: (i) => Get.to(MessagePage(
            userId: chat['user_id'],
            name: chat['name'],
            avatar: chat['avatar'],
            chatId: chat['chat_id'],
          )),
          orElse: () => Get.to(MessageAdmin(
            userId: chat['user_id'],
            userName: chat['name'],
            chatId: chat['chat_id'],
          )),
        ),
        backgroundColor: Colors.blueAccent,
        duration: const Duration(seconds: 10),
      );
    }
  }

  void _handleFirebaseMessageOpened(RemoteMessage message) {
    _handleFirebaseMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          notAuthorizedState: () => const ViewAuthRegisterPage(),
          loadingState: () => const _Scaffold(child: CustomLoadingWidget()),
          inAppBlogerState: (index) => const BaseBloggerNew(),
          inAppAdminState: (index) => const BaseAdminNew(),
          inAppUserState: (index) => BaseNew(index: index),
          orElse: () => const BaseNew(),
        );
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

class _Scaffold extends StatelessWidget {
  final Widget child;
  const _Scaffold({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: child),
    );
  }
}
