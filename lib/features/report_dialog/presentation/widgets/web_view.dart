import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savdo_agnet_client/di/dependency_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/utils/api_path.dart';
import '../../../../core/utils/app_constants.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample(
      {Key? key, this.cookieManager, required this.url, required this.params})
      : super(key: key);

  final CookieManager? cookieManager;
  final String url;
  final params;

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  SharedPreferences sharedPreferences = di.get();
  String url = "";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
    url = baseUrlReport +
        widget.url +
        "?branch_id=" +
        widget.params["branch_id"].toString() +
        "&worker_id=" +
        widget.params["worker_id"].toString() +
        "&sana1=" +
        widget.params["sana1"].toString() +
        "&sana2=" +
        widget.params["sana2"].toString() +
        "&customer_id=" +
        widget.params["customer_id"].toString() +
        "&store_id=" +
        widget.params["store_id"].toString() +
        "&product_id=" +
        widget.params["product_id"].toString() +
        "&yuk_beruvchi=" +
        widget.params["yuk_beruvchi"].toString();
    print(url.toString());
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: WebView(
        initialUrl: url,
        zoomEnabled: true,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
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
        backgroundColor: const Color(0x00ffffff),
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
