import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:launch_review/launch_review.dart';
import 'package:oktoast/oktoast.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void dispose() {
    super.dispose();
  }

  String appName, packageName, version, buildNumber;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).clickItemSettingAboutTitle,
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap10,
          Jomn9Logo(),
          Gaps.vGap10,
          Text(appName ?? ""),
          GestureDetector(
              onDoubleTap: () => showToast("build no: " + buildNumber ?? ""),
              child: Text(S.of(context).labelVersionNo(version ?? ""))),
          ClickItem(
            title: S.of(context).clickItemSettingShareTitle,
            onTap: () => Share.share("Check out this cool travel app"),
            //TODO firebase share
          ),
          ClickItem(
            title: S.of(context).labelLeaveAReview,
            onTap: () => LaunchReview.launch(),
          ),
        ],
      ),
    );
  }
}

class Jomn9Logo extends StatelessWidget {
  final double size = 50.0;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: AssetImage("assets/icons/JomN9.png"),
    );
  }
}
