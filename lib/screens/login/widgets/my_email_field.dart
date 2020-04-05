import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/text_field.dart';

class MyEmailField extends StatelessWidget {
  const MyEmailField(
      {Key key,
      @required this.focusNode,
      @required this.emailController,
      @required this.request,
      this.onChanged})
      : super(key: key);

  final FocusNode focusNode;
  final TextEditingController emailController;
  final AuthRequest request;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      key: const Key('email'),
      focusNode: focusNode,
      maxLength: 30,
      onChanged: onChanged,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      hintText: S.of(context).labelInputFieldEmail,
      validator: (value) {
        try {
          request.validateEmail(value);
        } on FormatException {
          return S.of(context).errorMsgInvalidFormatEmail;
        }
        return null;
      },
      onSaved: (value) => request.setEmail(value),
    );
  }
}
