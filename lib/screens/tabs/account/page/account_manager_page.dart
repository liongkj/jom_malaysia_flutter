import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/exception/account_in_use_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/operation_cancel_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/require_reauth_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/providers/platform_provider.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/bottom_nav_button.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/destroy_acc_dialog.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/password_prompt_dialog.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../account_router.dart';

class AccountManagerPage extends StatefulWidget {
  @override
  _AccountManagerPageState createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {
  Map<AuthProviderEnum, String> _providerLabels = {};

  @override
  void initState() {
    super.initState();
    platformProvider = Provider.of<PlatformProvider>(context, listen: false);
  }

  PlatformProvider platformProvider;

  @override
  Widget build(BuildContext context) {
    _providerLabels = {
      AuthProviderEnum.GOOGLE: S.of(context).labelGoogle,
      AuthProviderEnum.PASSWORD: S.of(context).labelPassword
    };
    return Scaffold(
      appBar: MyAppBar(
        isBack: true,
        centerTitle: S.of(context).labelAccountSetting,
      ),
      bottomNavigationBar: BottomNavButton(
        danger: true,
        title: "Destroy Account",
        logOut: _showDeleteAccount,
      ),
      body: Column(
        children: <Widget>[
          Consumer<PlatformProvider>(
            builder: (ctx, provider, __) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.list.length,
                  itemBuilder: (ctx, index) {
                    bool isConnected = provider.list[index].linked;
                    return ClickItem(
                      leading: isConnected
                          ? const Icon(
                              Icons.link,
                              color: Colours.show_connected,
                            )
                          : const Icon(
                              Icons.link_off,
                              color: Colours.show_disconnected,
                            ),
                      nextLineContent: provider.list[index]?.email ?? "",
                      title:
                          _providerLabels[provider.list[index].provider] ?? "",
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          isConnected
                              ? Text(
                                  S.of(context).labelAccountDisconnect,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .copyWith(
                                          color: Colours.show_disconnected),
                                )
                              : Text(
                                  S.of(context).labelAccountLinkNow,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle
                                      .copyWith(color: Colours.text_gray),
                                ),
                        ],
                      ),
                      onTap: () => isConnected
                          ? _showDisconnectDialog(provider.list[index].provider)
                          : _showConnectDialog(
                              provider.list[index].provider,
                            ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  _showDisconnectDialog(AuthProviderEnum provider) {
    if (platformProvider.list.length > 1) {
      String providerLabel = _providerLabels[provider];
      if (provider != AuthProviderEnum.PASSWORD) {
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text("Disconnect $providerLabel from your account?",
                        style: TextStyles.textSize16),
                  ),
                ));
      } else {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return Builder(builder: (ctx) {
                return PasswordPromptDialog();
              });
            });
      }
    } else {
      showToast(
        S.of(context).msgMustHaveAtLeastOneAccount,
      );
    }
  }

  _showConnectDialog(AuthProviderEnum provider) {
    String providerLabel = _providerLabels[provider];
    if (provider != AuthProviderEnum.PASSWORD) {
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text("Connect with $providerLabel?",
                      style: TextStyles.textSize16),
                ),
              ));
    } else {
      debugPrint("");
      NavigatorUtils.push(
        context,
        AccountRouter.emailSignIn,
      );
    }
  }

  FutureOr errorHandler(err, String providerLabel) async {
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
      case RequireReauthException:
        msg = S.of(context).errorMsgRequireRelog;
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
