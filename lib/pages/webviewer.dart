import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewerPage extends StatefulWidget {
  final String url;

  WebViewerPage(this.url);

  @override
  _WebViewerPageState createState() => _WebViewerPageState();
}
//https://www.youtube.com/watch?v=Wo0o0wSkn4k
class _WebViewerPageState extends State<WebViewerPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web viewer'),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
      // floatingActionButton: FutureBuilder<WebViewController>(
      //   future: _controller.future,
      //   builder: (BuildContext context,
      //       AsyncSnapshot<WebViewController> controller) {
      //     if (controller.hasData) {
      //       return FloatingActionButton(
      //         child: Icon(Icons.ac_unit),
      //         onPressed: () {
      //           controller.data.loadUrl("https://eniachub.com");
      //         },
      //       );
      //     }
      //     return Container();
      //   },
      // ),
    );
  }
}
