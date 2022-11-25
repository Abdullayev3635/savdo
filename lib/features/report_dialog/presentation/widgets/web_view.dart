import 'dart:async';
import 'package:flutter/material.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/utils/app_constants.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key, this.cookieManager}) : super(key: key);

  final CookieManager? cookieManager;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  SharedPreferences sharedPreferences = di.get();
  @override
  void initState() {
    super.initState();
      WebView.platform = SurfaceAndroidWebView();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: WebView(
        initialUrl: 'http://192.168.30.14:3000/reports/product-residue-reports',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          webViewController.loadUrl(
            'http://192.168.30.12:3000/mobile-product-residue',
          );
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}