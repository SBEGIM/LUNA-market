import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewWigdet extends StatefulWidget {
  String url;
  PaymentWebviewWigdet({required this.url, super.key});

  @override
  State<PaymentWebviewWigdet> createState() => _PaymentWebviewWigdetState();
}

class _PaymentWebviewWigdetState extends State<PaymentWebviewWigdet> {
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
                //  Navigator.pop(context);
                Get.to(const Base(index: 1));
              }),
        ),
        body: WebViewWidget(
          controller: _webViewController,
        ));
  }
}
