import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/text_field.dart';

class MyPasswordField extends StatelessWidget {
  const MyPasswordField({
    Key key,
    @required this.focusNode,
    @required this.passwordController,
    @required this.request,
    this.onSave,
    this.hintText,
  }) : super(key: key);

  final FocusNode focusNode;
  final String hintText;
  final Function onSave;
  final TextEditingController passwordController;
  final AuthRequest request;

  static const int _PASSWORD_LENGTH_POLICY = 8;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      key: const Key('password'),
      keyName: 'password',
      focusNode: focusNode,
      isInputPwd: true,
      controller: passwordController,
      maxLength: 16,
      hintText: hintText ?? S.of(context).labelInputFieldPassword,
      onSaved: onSave ?? (value) => request.setPassword(value),
      validator: (value) {
        try {
          request.validatePassword(value, _PASSWORD_LENGTH_POLICY);
        } on FormatException {
          return S.of(context).errorMsgPasswordPolicy(_PASSWORD_LENGTH_POLICY);
        }
        return null;
      },
    );
  }
}