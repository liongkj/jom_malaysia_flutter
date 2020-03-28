import 'package:flustars/flustars.dart' as sp;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/gaps.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/invalid_credential_exception.dart';
import 'package:jom_malaysia/core/services/gateway/exception/not_found_exception.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/screens/login/widgets/third_party_providers.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/auth_utils.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:jom_malaysia/widgets/my_checkbox.dart';
import 'package:jom_malaysia/widgets/text_field.dart';
import 'package:provider/provider.dart';

/// design/1注册登录/index.html
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //定义一个controller
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  AuthRequest request;
  final _formKey = GlobalKey<FormState>();
  var _autovalidate = false;
  AuthProvider _loginProvider;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.text = sp.SpUtil.getString(Constant.phone);
    request = new AuthRequest();
    _loginProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  Future errorHandler(err) async {
    String msg;
    switch (err.runtimeType) {
      case InvalidCredentialException:
        msg = "Email / Password is incorrect";
        break;
      case NotFoundException:
        msg = "User not registered";
        break;
      default:
        msg = 'Unknown error try agian later';
    }
    Toast.show(msg);
  }

  void _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (request.rememberMe)
        sp.SpUtil.putString(Constant.email, request.email);
      else
        sp.SpUtil.remove(Constant.email);
      var login = AuthUtils.getSignInFunction(
          type: SignInTypeEnum.EMAIL,
          errorHandler: (err) => errorHandler(err),
          loginProvider: _loginProvider,
          request: request,
          context: context);
      login();
    } else {
      _autovalidate = true;
    }

    // NavigatorUtils.push(context, OverviewRouter.overviewPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
        actionName: '验证码登录',
        onPressed: () => NavigatorUtils.push(context, LoginRouter.smsLoginPage),
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autovalidate,
        child: SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: ThirdPartyProviders(
        errorHandler: (error) => errorHandler(error),
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
          const Text(
            "密码登录",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('email'),
            focusNode: _nodeText1,
            maxLength: 30,
            controller: _nameController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email Address",
            validator: (value) {
              try {
                request.validateEmail(value);
              } on FormatException catch (e) {
                return "Email Invalid";
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
            hintText: "请输入密码",
            onSaved: (value) => request.setPassword(value),
          ),
          Container(
            width: 200,
            child: MyCheckbox(
              initialValue: false,
              title: Text('remember me'),
              context: context,
              onSaved: (value) => request.setRememberMe(value),
            ),
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _login,
            text: "登录",
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                '忘记密码',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () =>
                  NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
            ),
          ),
          Gaps.vGap16,
          Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  '还没账号？快去注册',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onTap: () =>
                    NavigatorUtils.push(context, LoginRouter.registerPage),
              )),
        ],
      ),
    );
  }
}
