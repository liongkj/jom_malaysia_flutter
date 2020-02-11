import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WebviewNativePage extends StatefulWidget {
  @override
  _WebviewNativePageState createState() => _WebviewNativePageState();

  WebviewNativePage({@required this.url, @required this.title});
  final String url;
  final String title;
}

class _WebviewNativePageState extends State<WebviewNativePage>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    FlutterWebviewPlugin().dispose();
    FlutterWebviewPlugin().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitSquareCircle(
      color: Colors.yellow,
      size: 80.0,
      controller: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      ),
    );
    return WebviewScaffold(
      withLocalStorage: true,
      appCacheEnabled: true,
      resizeToAvoidBottomInset: true,
      url: widget.url,
      //"https://www.jomn9.com/feedback",
      hidden: true,
      initialChild: Container(
        child: Center(child: spinkit),
      ),
      appBar: MyAppBar(
        backImg: "assets/images/ic_close.png", centerTitle: widget.title,
        //S.of(context).clickItemSettingFeedbackTitle,
      ),
    );
  }
}
