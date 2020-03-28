import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
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
  var _menuTitle = ['账户流水', '资金管理', '提现账号'];
  var _menuImage = ['zhls', 'zjgl', 'txzh'];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '消息',
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
              tooltip: '设置',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gaps.vGap12,
            Consumer<FirebaseUser>(
              builder: (_, provider, __) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: MergeSemantics(
                    child: Stack(
                      children: <Widget>[
                        const SizedBox(width: double.infinity, height: 56.0),
                        const Text(
                          '官方直营店',
                          style: TextStyles.textBold24,
                        ),
                        Positioned(
                            right: 0.0,
                            child: CircleAvatar(
                                radius: 28.0,
                                backgroundColor: Colors.transparent,
                                backgroundImage: ImageUtils.getImageProvider(
                                    provider?.photoUrl,
                                    holderImg: 'account/dummy_profile_pic'))),
                        Positioned(
                          top: 38.0,
                          left: 0.0,
                          child: Row(
                            children: <Widget>[
                              const LoadAssetImage(
                                'shop/zybq',
                                width: 40.0,
                                height: 16.0,
                              ),
                              Gaps.hGap8,
                              const Text('店铺账号:15000000000',
                                  style: TextStyles.textSize12)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Gaps.vGap24,
            Container(
              height: 0.6,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16.0),
              child: Gaps.line,
            ),
            Gaps.vGap24,
            const MergeSemantics(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  '账户',
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
                        LoadAssetImage('shop/${_menuImage[index]}',
                            width: 32.0),
                        Gaps.vGap4,
                        Text(
                          _menuTitle[index],
                          style: TextStyles.textSize12,
                        )
                      ],
                    ),
                    onTap: () {
                      // if (index == 0) {
                      //   NavigatorUtils.push(
                      //       context, AccountRouter.accountRecordListPage);
                      // } else if (index == 1) {
                      //   NavigatorUtils.push(
                      //       context, AccountRouter.accountPage);
                      // } else if (index == 2) {
                      //   NavigatorUtils.push(
                      //       context, AccountRouter.withdrawalAccountPage);
                      // }
                    },
                  );
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
            const MergeSemantics(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const Text(
                  '店铺',
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
                itemCount: 1,
                itemBuilder: (_, index) {
                  return InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        LoadAssetImage('account/setting', width: 32.0),
                        Gaps.vGap4,
                        const Text(
                          '店铺设置',
                          style: TextStyles.textSize12,
                        )
                      ],
                    ),
                    onTap: () =>
                        NavigatorUtils.push(context, AccountRouter.settingPage),
                  );
                },
              ),
            ),
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
