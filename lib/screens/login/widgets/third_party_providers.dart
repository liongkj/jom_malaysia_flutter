import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/widgets/sign_in_icon.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:provider/provider.dart';

class ThirdPartyProviders extends StatelessWidget {
  ThirdPartyProviders({@required this.errorHandler});
  final Function errorHandler;
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(S.of(context).labelThirdPartyLogin),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SignInIcon(
                iconString: 'icon_google',
                signInAction: AuthUtils.getSignInFunction(
                  type: AuthOperationEnum.GOOGLE,
                  errorHandler: errorHandler,
                  loginProvider: loginProvider,
                  context: context,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
