import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/app/presentation/base_shop.dart';
import 'package:haji_market/src/feature/seller/order/data/models/basket_order_seller_model.dart';
import 'package:haji_market/src/feature/bloger/app/presentation/base_blogger.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/app/presentation/location_page.dart';
import 'package:http/http.dart' as http;
import 'package:haji_market/src/feature/app/presentation/base.dart';
import 'package:haji_market/src/feature/app/widgets/custom_loading_widget.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/view_auth_register_page.dart';

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
    initAppLinks();
    BlocProvider.of<AppBloc>(context).add(const AppEvent.checkAuth());
    BlocProvider.of<AppBloc>(context).add(const AppEvent.location());

    checkInitialMessage();
    FirebaseMessaging.onMessage.listen(_handleFirebaseMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleFirebaseMessageOpened);
  }

  Future<void> initAppLinks() async {
    // Get the initial link
    _appLinks = AppLinks();

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
          context.router.push(
            DetailTapeCardRoute(
              index: int.parse(index),
              shopName: shopName,
              tapeBloc: BlocProvider.of<TapeCubit>(context),
            ),
          );
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
      final basket = BasketOrderSellerModel.fromJson(jsonDecode(message.data['basket']));
      // TODO: replace snackbar with in-app notification solution
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(notification?.body ?? ''),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: notification?.title ?? '',
            onPressed: () {
              if (!mounted) return;
              context.router.push(DetailOrderSellerRoute(basketOrder: basket));
            },
          ),
        ),
      );
    } else if (data == 'chat') {
      final chat = jsonDecode(message.data['chat']);
      final appBloc = BlocProvider.of<AppBloc>(context);

      // TODO: replace snackbar with in-app notification solution
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(notification?.body ?? ''),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: notification?.title ?? '',
            onPressed: () {
              if (!mounted) return;
              appBloc.state.maybeWhen(
                inAppUserState: (i) => context.router.push(
                  MessageRoute(
                    userId: chat['user_id'],
                    name: chat['name'],
                    avatar: chat['avatar'],
                    chatId: chat['chat_id'],
                    role: chat['role'],
                  ),
                ),
                orElse: () => context.router.push(
                  MessageSellerRoute(
                    userId: chat['user_id'],
                    userName: chat['name'],
                    chatId: chat['chat_id'],
                    role: chat['role'],
                  ),
                ),
              );
            },
          ),
        ),
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
          locationRequiredState: () => const LocationPage(),
          notAuthorizedState: (button) => ViewAuthRegisterPage(backButton: button),
          loadingState: () => const _Scaffold(child: CustomLoadingWidget()),
          inAppBlogerState: (index) => const BaseBlogger(),
          inAppAdminState: (index) => const BaseShop(),
          inAppUserState: (index) => Base(index: index),
          orElse: () => const Base(),
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
