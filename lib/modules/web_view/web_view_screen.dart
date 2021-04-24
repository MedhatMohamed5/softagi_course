import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({Key key, this.url, this.title}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  var _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (_progress != 100) ...[
                SizedBox(
                  width: 12,
                ),
                CircularProgressIndicator(),
              ]
            ],
          ),
        ),
        body: WebView(
          initialUrl: widget.url,
          onProgress: (val) {
            print(val);
            print(widget.url);
            setState(() {
              _progress = val;
            });
          },
        ),
      ),
    );
  }
}
