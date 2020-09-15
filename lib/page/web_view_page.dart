import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
class WebView extends StatefulWidget {
  final url;
  final title;

  WebView({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.shouldStart:
          print("websu-"+"shouldStart");
        //准备加载
          break;
        case WebViewState.startLoad:
          print("websu-"+"startLoad");
        //开始加载
          break;
        case WebViewState.finishLoad:
          print("websu-"+"finishLoad");
        //加载完成
          break;
        case WebViewState.abortLoad:
          print("websu-"+"abortLoad");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      withZoom: true, //允许网页缩放
      withLocalStorage: true,
      withJavascript: true, //允许执行 js 代码
    );
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}