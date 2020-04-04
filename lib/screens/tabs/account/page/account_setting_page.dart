import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/models/platform_provider_model.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:provider/provider.dart';

class AccountSettingPage extends StatefulWidget {
  @override
  _AccountSettingPageState createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  List<PlatformProviderModel> _linkedAccounts = [
    PlatformProviderModel("password", "", linked: false),
    PlatformProviderModel("google", "", linked: false)
  ];

  AuthProvider authProvider;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (PlatformProviderModel acc in authProvider.providerList) {
      int s = _linkedAccounts.indexWhere((f) => f.providerId == acc.providerId);
      debugPrint(acc.providerId + " at " + s.toString());
      _linkedAccounts.removeAt(s);
    }
    _linkedAccounts.insertAll(0, authProvider.providerList);
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
              title: _linkedAccounts[index].providerId,
              content: _linkedAccounts[index].linked.toString(),
              onTap: () => Provider.of<AuthProvider>(context, listen: false)
                  .linkAccount(AuthOperationEnum.GOOGLE),
            ),
          ),
        ],
      ),
    );
  }
}
