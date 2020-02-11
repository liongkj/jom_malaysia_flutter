import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Timer _countdownTimer;

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 2s定时器
    _countdownTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      // https://www.jianshu.com/p/e4106b829bff
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).clickItemSettingAboutTitle,
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap50,
          Jomn9Logo(),
          // FlutterLogo(
          //   size: 100.0,
          //   colors: _colors[Random.secure().nextInt(7)],
          //   textColor: _randomColor(),
          //   style: _styles[Random.secure().nextInt(3)],
          //   curve: _curves[Random.secure().nextInt(12)],
          // ),
          Gaps.vGap10,
          ClickItem(
            title: S.of(context).clickItemSettingShareTitle,
            onTap: () => {},
          ),
          // .goWebViewPage(context, "Flutter Deer",
          //     "https://github.com/simplezhli/flutter_deer")),
          ClickItem(
              title: S.of(context).clickItemSettingRecommendPlaceTitle,
              onTap: () => NavigatorUtils.goWebViewPage(
                  context, "作者博客", "https://weilu.blog.csdn.net")),
        ],
      ),
    );
  }
}

class Jomn9Logo extends StatelessWidget {
  final double size = 100.0;
  final Duration duration = const Duration(milliseconds: 750);
  final Curve curve = Curves.fastOutSlowIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      child: LoadAssetImage('../icons/JomN9'),
    );
  }
}
