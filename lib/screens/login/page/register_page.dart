import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/duplicate_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:jom_malaysia/widgets/text_field.dart';
import 'package:provider/provider.dart';

/// design/1注册登录/index.html#artboard11
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  AuthProvider _authService;
  //定义一个controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  AuthRequest request;
  int _PASSWORD_LENGTH_POLICY = 8;

  @override
  void initState() {
    _authService = Provider.of<AuthProvider>(context, listen: false);
    request = AuthRequest();
    super.initState();
  }

  Future errorHandler(err) async {
    String msg;
    switch (err.runtimeType) {
      case InvalidCredentialException:
        msg = S.of(context).errorMsgPasswordTooWeak;
        break;
      case DuplicateException:
        msg = S.of(context).errorMsgAccountExist;
        break;
      default:
        msg = S.of(context).errorMsgUnknownError;
    }
    Toast.show(msg);
  }

  void _register() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var reg = AuthUtils.getSignInFunction(
          type: SignInTypeEnum.SIGNUP,
          errorHandler: (err) => errorHandler(err),
          loginProvider: _authService,
          request: request,
          context: context);
      reg();

      Toast.show(S.of(context).msgRegistrationSuccess);
    } else {
      Toast.show(S.of(context).msgPleaseFillRequiredField);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: S.of(context).labelRegister,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: _buildBody(),
          ),
        ));
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            S.of(context).labelRegisterYourAccount,
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('email'),
            focusNode: _nodeText1,
            maxLength: 30,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: S.of(context).labelInputFieldEmail,
            validator: (value) {
              try {
                request.validateEmail(value);
              } on FormatException catch (e) {
                return S.of(context).errorMsgInvalidFormatEmail;
              }
              return null;
            },
            onSaved: (value) => request.setEmail(value),
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            isInputPwd: true,
            controller: _passwordController,
            maxLength: 16,
            hintText: S.of(context).labelInputFieldPassword,
            validator: (value) {
              try {
                request.validatePassword(value, _PASSWORD_LENGTH_POLICY);
              } on FormatException catch (e) {
                return S
                    .of(context)
                    .errorMsgPasswordPolicy(_PASSWORD_LENGTH_POLICY);
              }
              return null;
            },
            onSaved: (value) => request.setPassword(value),
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('register'),
            onPressed: _register,
            text: S.of(context).labelRegister,
          )
        ],
      ),
    );
  }
}
