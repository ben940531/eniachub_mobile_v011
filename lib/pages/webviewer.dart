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
  var _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web viewer'),
      ),
      body: IndexedStack(
        index: _stackToView,
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            onPageFinished: _handleLoad,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          ),
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
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
