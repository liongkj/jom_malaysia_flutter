import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/screens/login/widgets/my_email_field.dart';
import 'package:jom_malaysia/screens/login/widgets/my_password_field.dart';
import 'package:jom_malaysia/screens/tabs/account/providers/platform_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class EmailSignIn extends StatefulWidget {
  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  AuthRequest request;
  final _formKey = GlobalKey<FormState>();

  var _autovalidate = false;
  PlatformProvider _platformProvider;

  @override
  void initState() {
    super.initState();
    //监听输入改变
//    _nameController.text = sp.SpUtil.getString(Constant.email);
    request = new AuthRequest();
    _platformProvider = Provider.of<PlatformProvider>(context, listen: false);
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      var login = AuthUtils.getLinkFunction(
          label: S.of(context).labelEmailSignIn,
          type: AuthProviderEnum.PASSWORD,
          errorHandler: (err) => errorHandler(err),
          provider: _platformProvider,
          request: request,
          context: context);
      login();
    } else {
      _autovalidate = true;
    }
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
      case SignInCancelledException:
        msg = S.of(context).errorMsgSignInCancelled;
        break;
      default:
        msg = S.of(context).errorMsgUnknownError;
    }
    showToast(msg);
  }

  @override
  Widget build(BuildContext context) {
    AuthRequest req = AuthRequest();
    req.email = "khaijiet@hotmail.com";
//    platformProvider.sendSignInWithEmailLink(req);
    //TODO switch between sign in passwordless or with password

    return Scaffold(
      appBar: MyAppBar(
        backImg: "assets/images/ic_close.png",
        actionName: S.of(context).labelPasswordlessSignIn,
        onPressed: () => NavigatorUtils.push(context, LoginRouter.smsLoginPage),
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context).labelEmailSignIn,
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyEmailField(
            focusNode: _nodeText1,
            emailController: _nameController,
            request: request,
          ),
          Gaps.vGap8,
          MyPasswordField(
            focusNode: _nodeText2,
            passwordController: _passwordController,
            request: request,
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _login,
            text: S.of(context).labelAccountLinkNow,
          ),
        ],
      ),
    );
  }
}
