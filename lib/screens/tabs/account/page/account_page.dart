import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/exit_dialog.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/logout_button.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/text_input_dialog.dart';

import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:oktoast/oktoast.dart';
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
  Future errorHandler(err) async {
    String msg;
    switch (err.runtimeType) {
      case NotFoundException:
        msg = "Please sign in again";
        break;

      default:
        msg = 'Unknown error try again later';
    }
    showToast(msg);
  }

  void _showExitDialog() {
    showDialog(context: context, builder: (_) => ExitDialog());
  }

  void _editDisplayNameDialog(String displayName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TextInputDialog(
            title: S.of(context).labelUsernameTitle,
            onPressed: (value) {
              authProvider.changeDisplayName(value).catchError(errorHandler);
              setState(() {
                _displayName = value;
              });
            },
          );
        });
  }

  String _displayName;
  AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    _displayName =
        Provider.of<FirebaseUser>(context, listen: false)?.displayName;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Color _backgroundColor = ThemeUtils.getBackgroundColor(context);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return Scaffold(
      bottomNavigationBar: LogOutButton(
        logOut: _showExitDialog,
      ),
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
        ],
      ),
      body: Consumer2<FirebaseUser, AuthProvider>(
        builder: (_, loggedUser, authProvider, __) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                S.of(context).labelWelcomeUser,
                                style: TextStyles.textBold24,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      _displayName ??
                                          S.of(context).labelStranger,
                                      style: TextStyles.textSize16),
                                  FlatButton(
                                      child: Text(
                                        S.of(context).labelEdit,
                                        style: TextStyles.textSize12.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () =>
                                          _editDisplayNameDialog(_displayName)),
                                ],
                              ),
                            ],
                          ),
                        Positioned(
                            right: 0.0,
                            child: CircleAvatar(
                                radius: 28.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: ImageUtils.getImageProvider(
                                    loggedUser?.photoUrl,
                                    holderImg: 'account/dummy_profile_pic'))),
                      ],
                    ))),
                if (loggedUser != null) _UserSettings(),
                _AppSettings(),
              ],
            ),
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
    'setting'
    // 'credit'
  ];
  @override
  Widget build(BuildContext context) {
    var _menuTitle = [
      S.of(context).labelAppSettings,
      // S.of(context).labelCreditManager
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MergeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              S.of(context).appBarTitleSetting,
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
                      NavigatorUtils.push(context, AccountRouter.settingPage);
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
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
