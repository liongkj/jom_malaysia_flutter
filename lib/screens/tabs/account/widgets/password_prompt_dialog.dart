import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/too_many_request_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/widgets/my_password_field.dart';
import 'package:jom_malaysia/screens/tabs/account/providers/platform_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/util/text_utils.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/// design/7店铺-店铺配置/index.html#artboard3
class PasswordPromptDialog extends StatefulWidget {
  PasswordPromptDialog({
    Key key,
  }) : super(key: key);

  @override
  _PriceInputDialog createState() => _PriceInputDialog();
}

class _PriceInputDialog extends State<PasswordPromptDialog> {
  TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode;
  AuthRequest request = AuthRequest();
  PlatformProvider _platformProvider;
  String _email;

  @override
  void initState() {
    _platformProvider = Provider.of<PlatformProvider>(context, listen: false);
    _email = SpUtil.getString(Constant.loggedInEmail);
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_focusNode != null) FocusScope.of(context).requestFocus(_focusNode);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      showCancel: true,
      title: S.of(context).labelVerifyEmail,
//      hiddenTitle: true,
      child: Form(
        key: _formKey,
        child: Container(
          height: 34.0,
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: MyPasswordField(
            showError: false,
            request: request,
            key: const Key('password_input'),
            focusNode: _focusNode,
            passwordController: _controller,
            hintText: S.of(context).labelInputFieldPassword,
          ),
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty) {
          showToast(S.of(context).errorMsgFieldCannotEmpty(
              TextUtils.capitalize(S.of(context).password)));
          return;
        } else if (_controller.text.length < 8) {
          showToast(S.of(context).errorMsgPasswordPolicy(8));
          return;
        } else {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            request.email = _email;
            var unlink = AuthUtils.getUnlinkFunction(
              request: request,
              type: AuthProviderEnum.PASSWORD,
              errorHandler: (err) => errorHandler(err),
              provider: _platformProvider,
              label: S.of(context).labelEmailSignIn,
              context: context,
            );
            unlink();
            //remove from logged
          }
        }
      },
    );
  }

  FutureOr<Null> errorHandler(err) async {
    String msg;
    switch (err.runtimeType) {
      case TooManyRequestException:
        msg = S.of(context).errorMsgTooManyRequest;
        NavigatorUtils.goBack(context);
        break;
      case InvalidCredentialException:
        msg = S.of(context).errorMsgEmailPasswordIncorrect;
        _controller.clear();
        break;
      case NotFoundException:
        msg = S.of(context).errorMsgUserNotRegistered;
        break;
      case SignInCancelledException:
        msg = S.of(context).errorMsgSignInCancelled;
        break;
      default:
        msg = S.of(context).errorMsgUnknownError;
        debugPrint(err.toString());
    }
    showToast(msg);
  }
}
