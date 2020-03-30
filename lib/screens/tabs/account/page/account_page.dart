import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/exit_dialog.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    Key key,
    this.isAccessibilityTest: false,
  }) : super(key: key);

  final bool isAccessibilityTest;

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<AccountPage>
    with AutomaticKeepAliveClientMixin<AccountPage> {
  void _showExitDialog() {
    showDialog(context: context, builder: (_) => ExitDialog());
  }

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = ThemeUtils.getBackgroundColor(context);

    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return Scaffold(
      bottomNavigationBar: Consumer<FirebaseUser>(builder: (_, provider, __) {
        if (provider != null)
          return Container(
            padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 48),
            child: MyButton(
              onPressed: () => _showExitDialog(),
              text: S.of(context).labelLogout,
            ),
          );
        else
          return Container(
            width: 0,
            height: 0,
          );
      }),
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        actions: <Widget>[
          IconButton(
            tooltip: S.of(context).appBarTitleNotification,
            onPressed: () {
              NavigatorUtils.push(context, AccountRouter.notificationPage);
            },
            icon: LoadAssetImage(
              'account/message',
              key: const Key('message'),
              width: 24.0,
              height: 24.0,
              color: _iconColor,
            ),
          ),
          IconButton(
            tooltip: S.of(context).appBarTitleSetting,
            onPressed: () {
              NavigatorUtils.push(context, AccountRouter.settingPage);
            },
            icon: LoadAssetImage(
              'account/setting',
              key: const Key('setting'),
              width: 24.0,
              height: 24.0,
              color: _iconColor,
            ),
          )
        ],
      ),
      body: Consumer<FirebaseUser>(
        builder: (_, loggedUser, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gaps.vGap12,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MergeSemantics(
                      child: Stack(
                    children: <Widget>[
                      const SizedBox(width: double.infinity, height: 56.0),
                      if (loggedUser == null)
                        GestureDetector(
                          onTap: () => NavigatorUtils.push(
                              context, LoginRouter.loginPage),
                          child: Text(
                            S.of(context).labelLogIn,
                            style: TextStyles.textBold24,
                          ),
                        )
                      else
                        Text(
                          S.of(context).labelWelcomeUser,
                          style: TextStyles.textBold24,
                        ),
                      Positioned(
                          right: 0.0,
                          child: CircleAvatar(
                              radius: 28.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: ImageUtils.getImageProvider(
                                  loggedUser?.photoUrl,
                                  holderImg: 'account/dummy_profile_pic'))),
                      Text(loggedUser?.displayName ?? "",
                          style: TextStyles.textSize12),
                    ],
                  ))),
              Gaps.vGap24,
              Container(
                height: 0.6,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 16.0),
                child: Gaps.line,
              ),
              if (loggedUser != null) _UserSettings(),
              _AppSettings(),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _AppSettings extends StatelessWidget {
  final _menuImage = [
    'profile'
    // 'credit'
  ];
  @override
  Widget build(BuildContext context) {
    var _menuTitle = [
      S.of(context).labelProfileManager,
      // S.of(context).labelCreditManager
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Gaps.vGap24,
        MergeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              S.of(context).labelAccount,
              style: TextStyles.textBold18,
            ),
          ),
        ),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.18),
            itemCount: _menuTitle.length,
            itemBuilder: (_, index) {
              return InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LoadAssetImage('account/${_menuImage[index]}',
                          width: 32.0),
                      Gaps.vGap4,
                      Text(
                        _menuTitle[index],
                        style: TextStyles.textSize12,
                      )
                    ],
                  ),
                  onTap: () {
                    if (index == 0) {
                      NavigatorUtils.push(
                          context, AccountRouter.accountManagerPage);
                    }
                  });
            },
          ),
        ),
        Container(
          height: 0.6,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16.0),
          child: Gaps.line,
        ),
        Gaps.vGap24,
      ],
    );
  }
}

class _UserSettings extends StatelessWidget {
  final _menuImage = [
    'profile'
    // 'credit'
  ];
  @override
  Widget build(BuildContext context) {
    var _menuTitle = [
      S.of(context).labelProfileManager,
      // S.of(context).labelCreditManager
    ];
    return Column(
      children: <Widget>[
        Gaps.vGap24,
        MergeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              S.of(context).labelAccount,
              style: TextStyles.textBold18,
            ),
          ),
        ),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.18),
            itemCount: _menuTitle.length,
            itemBuilder: (_, index) {
              return InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LoadAssetImage('account/${_menuImage[index]}',
                          width: 32.0),
                      Gaps.vGap4,
                      Text(
                        _menuTitle[index],
                        style: TextStyles.textSize12,
                      )
                    ],
                  ),
                  onTap: () {
                    if (index == 0) {
                      NavigatorUtils.push(
                          context, AccountRouter.accountManagerPage);
                    }
                  });
            },
          ),
        ),
        Container(
          height: 0.6,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16.0),
          child: Gaps.line,
        ),
        Gaps.vGap24,
      ],
    );
  }
}
