import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/providers/timer_provider.dart';
import 'package:jom_malaysia/screens/login/widgets/my_email_field.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:provider/provider.dart';

class ResetPasswordViaEmailPage extends StatefulWidget {
  @override
  _ResetPasswordViaEmailPageState createState() =>
      _ResetPasswordViaEmailPageState();
}

class _ResetPasswordViaEmailPageState extends State<ResetPasswordViaEmailPage> {
  //定义一个controller
  TextEditingController _emailController;
  FocusNode _focusNode;

  final _formKey = GlobalKey<FormState>();
  AuthProvider _authProvider;
  AuthRequest _request;
  String _emailText = "";

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _emailController = TextEditingController();
    _focusNode = FocusNode();
    _request = new AuthRequest();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  Future errorHandler(err) async {
    String msg;
    switch (err.runtimeType) {
      case InvalidCredentialException:
        msg = S.of(context).errorMsgEmailPasswordIncorrect;
        break;
      case NotFoundException:
        msg = S.of(context).errorMsgUserNotRegistered;
        break;
      default:
        msg = S.of(context).errorMsgUnknownError;
    }
    Toast.show(msg);
  }

  void _confirm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var changePass = AuthUtils.getSignInFunction(
          type: AuthOperationEnum.CHANGEPASS,
          errorHandler: (err) => errorHandler(err),
          loginProvider: _authProvider,
          request: _request,
          context: context);
      changePass();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).clickItemUpdatePassword,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                S.of(context).labelResetLoginPassword,
                style: TextStyles.textBold26,
              ),
              Gaps.vGap8,
              Text(
                S.of(context).clickItemUpdatePasswordHint(_emailText),
                textAlign: TextAlign.center,
                key: Key("email-help-text"),
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontSize: Dimens.font_sp12),
              ),
              Gaps.vGap16,
              Gaps.vGap16,
              MyEmailField(
                onChanged: (value) {
                  setState(() {
                    _emailText = value;
                  });
                },
                request: _request,
                focusNode: _focusNode,
                emailController: _emailController,
              ),
              Gaps.vGap10,
              Gaps.vGap15,
              Consumer<TimerProvider>(
                builder: (_, provider, __) => MyButton(
                  onPressed: provider.enable ? _confirm : null,
                  text: provider.enable
                      ? S.of(context).labelSendEmail
                      : S.of(context).labelResendEmail(provider.ticks),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
