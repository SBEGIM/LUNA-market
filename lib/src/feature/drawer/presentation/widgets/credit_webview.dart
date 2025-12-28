import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditWebviewPage extends StatefulWidget {
  final String url;
  final String? title;

  const CreditWebviewPage({this.title, required this.url, super.key});

  @override
  State<CreditWebviewPage> createState() => _CreditWebviewPageState();
}

class _CreditWebviewPageState extends State<CreditWebviewPage> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    controller = WebViewController()
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
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title ?? 'Рассрочка', style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
