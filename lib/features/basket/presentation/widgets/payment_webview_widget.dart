import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class PaymentWebviewPage extends StatefulWidget {
  final String url;
  final String? role;

  const PaymentWebviewPage({required this.url, this.role, super.key});

  @override
  State<PaymentWebviewPage> createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebviewPage> {
  WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Оплата',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                context.router.pushAndPopUntil(
                  const LauncherRoute(
                    children: [BasketRoute()],
                  ),
                  predicate: (_) => false,
                );
                //  Navigator.pop(context);
                // if (widget.role == 'shop') {
                //   Get.to(const BaseAdmin(index: 1));
                // } else {
                //   Get.to(const Base(index: 1));
                // }
              }),
        ),
        body: WebViewWidget(
          controller: _webViewController,
        ));
  }
}
