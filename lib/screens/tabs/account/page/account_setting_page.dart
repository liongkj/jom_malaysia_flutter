import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/gaps.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/models/platform_provider_model.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:provider/provider.dart';

class AccountSettingPage extends StatefulWidget {
  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  List<PlatformProviderModel> _linkedAccounts = [
    PlatformProviderModel(AuthProviderEnum.PASSWORD, "", linked: false),
    PlatformProviderModel(AuthProviderEnum.GOOGLE, "", linked: false)
  ];

  Map<AuthProviderEnum, String> _providerLabels = {};

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    for (PlatformProviderModel acc in authProvider.providerList) {
      int s = _linkedAccounts
          .indexWhere((f) => f.provider.toString() == acc.provider.toString());
      if (s >= 0) _linkedAccounts.removeAt(s);
    }
    _linkedAccounts.insertAll(0, authProvider.providerList);
    _providerLabels.addAll({
      AuthProviderEnum.GOOGLE: S.of(context).labelGoogle,
      AuthProviderEnum.PASSWORD: S.of(context).labelPassword
    });
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).labelAccountSetting,
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: _linkedAccounts.length,
            itemBuilder: (ctx, index) => ClickItem(
              title: _providerLabels[_linkedAccounts[index].provider] ?? "",
              trailing: _linkedAccounts[index].linked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          S.of(context).labelAccountConnected,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: Colours.show_connected),
                        ),
                        Gaps.hGap4,
                        const Icon(
                          Icons.link,
                          color: Colours.show_connected,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          S.of(context).labelAccountLinkNow,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(color: Colours.show_disconnected),
                        ),
                        Gaps.hGap4,
                        const Icon(
                          Icons.link_off,
                          color: Colours.show_disconnected,
                        )
                      ],
                    ),
              onTap: () => _linkedAccounts[index].linked
                  ? _showConnectDialog(_linkedAccounts[index].provider)
                  : _showDisconnectDialog(_linkedAccounts[index].provider),
            ),
          ),
        ],
      ),
    );
  }

  _showDisconnectDialog(AuthProviderEnum provider) {}

  _showConnectDialog(AuthProviderEnum provider) {
    showDialog(
        context: context,
        builder: (_) => BaseDialog(
              showCancel: true,
              title: "Connect your google account?",
              onPressed: () =>
                  Provider.of<AuthProvider>(context).linkAccount(provider),
            ));
    switch (provider) {
      case AuthProviderEnum.GOOGLE:
        // TODO: Handle this case.

        break;
      case AuthProviderEnum.PASSWORD:
        // TODO: Handle this case.
        break;
      case AuthProviderEnum.FACEBOOK:
        // TODO: Handle this case.
        break;
    }
  }
}
