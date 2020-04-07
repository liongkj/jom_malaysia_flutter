import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/gaps.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/exception/account_in_use_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/operation_cancel_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/models/platform_provider_model.dart';
import 'package:jom_malaysia/screens/tabs/account/providers/platform_provider.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/bottom_nav_button.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/destroy_acc_dialog.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:oktoast/oktoast.dart';
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
    platformProvider = Provider.of<PlatformProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  PlatformProvider platformProvider;

  @override
  Widget build(BuildContext context) {
//    _linkedAccounts.insertAll(0, authProvider.providerList);
    _providerLabels = {
      AuthProviderEnum.GOOGLE: S.of(context).labelGoogle,
      AuthProviderEnum.PASSWORD: S.of(context).labelPassword
    };
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).labelAccountSetting,
      ),
      bottomNavigationBar: BottomNavButton(
        danger: true,
        title: "Destroy Account",
        logOut: _showDeleteAccount,
      ),
      body: Column(
        children: <Widget>[
          Consumer<PlatformProvider>(builder: (ctx, provider, __) {
            for (PlatformProviderModel acc in platformProvider.list) {
              int s = _linkedAccounts.indexWhere(
                  (f) => f.provider.toString() == acc.provider.toString());
              if (s >= 0) _linkedAccounts.removeAt(s);
              _linkedAccounts.insert(s, acc);
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _linkedAccounts.length,
                itemBuilder: (ctx, index) {
                  bool isConnected = _linkedAccounts[index].linked;
                  return ClickItem(
                    nextLineContent: _linkedAccounts[index]?.email ?? "",
                    title:
                        _providerLabels[_linkedAccounts[index].provider] ?? "",
                    trailing: isConnected
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
                    onTap: () => isConnected
                        ? _showDisconnectDialog(_linkedAccounts[index].provider)
                        : _showConnectDialog(
                            _linkedAccounts[index].provider,
                          ),
                  );
                });
          }),
        ],
      ),
    );
  }

  _showDisconnectDialog(AuthProviderEnum provider) {
    String providerLabel = _providerLabels[provider];
    var unlink = AuthUtils.getUnlinkFunction(
      type: provider,
      errorHandler: (err) => errorHandler(err, providerLabel),
      provider: platformProvider,
      label: providerLabel,
      context: context,
    );
    showDialog(
        context: context,
        builder: (_) => BaseDialog(
              showCancel: true,
              title: "Unlink Account",
              onPressed: () => unlink(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Disconnect $providerLabel from your account?",
                    style: TextStyles.textSize16),
              ),
            ));
  }

  _showConnectDialog(AuthProviderEnum provider) {
    String providerLabel = _providerLabels[provider];
    var link = AuthUtils.getLinkFunction(
      type: provider,
      errorHandler: (err) => errorHandler(err, providerLabel),
      provider: platformProvider,
      context: context,
      label: providerLabel,
    );
    showDialog(
        context: context,
        builder: (_) => BaseDialog(
              showCancel: true,
              title: "Link Account",
              onPressed: () => link(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text("Connect with $providerLabel?",
                    style: TextStyles.textSize16),
              ),
            ));
  }

  Future errorHandler(err, String providerLabel) async {
    String msg;
    debugPrint(msg);
    switch (err.runtimeType) {
      case AccountInUseException:
        msg =
            "This account already link. Please unlink or delete that account before linking";
        break;
      case OperationCancelledException:
        msg = S.of(context).errorMsgLinkOperationCancelled(providerLabel);
        break;

      default:
        msg = S.of(context).errorMsgUnknownError;
    }
    showToast(msg);
    NavigatorUtils.goBack(context);
  }

  void _showDeleteAccount() {
    showDialog(context: context, builder: (_) => DestroyAccountDialog());
  }
}
