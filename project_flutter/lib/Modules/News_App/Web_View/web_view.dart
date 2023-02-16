import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:js';
class WebViewScreen extends StatelessWidget {

  final String url;
  WebViewScreen({required this.url });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
      initialUrl: url,

      ),
    );
  }
}
