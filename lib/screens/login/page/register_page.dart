import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/authentication/firebase_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/i_auth_service.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:jom_malaysia/widgets/text_field.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/// design/1注册登录/index.html#artboard11
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  IAuthenticationService _authService;
  //定义一个controller
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  AuthRequest request;
  @override
  void initState() {
    _authService = Provider.of<FirebaseAuthService>(context, listen: false);
    request = AuthRequest();
    super.initState();
  }

  void _register() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // _authService.signInWithPhoneNumber(
      //   verificationId: request.verificationId,
      //   vCode: request.otpCode,
      // );
    }
    Toast.show("Tap to register");
  }

  // void _onCodeSent(String str, int code) {
  //   showToast("Code sent to ${request.phoneNumber}");
  // }

  // void _onVerified() {
  //   NavigatorUtils.push(
  //     context,
  //     OverviewRouter.overviewPage,
  //     clearStack: false,
  //   );
  // }

  // void _manualSignIn(String verificationCode) {
  //   request.verificationId = verificationCode;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: "注册",
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
          const Text(
            "开启你的账号",
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            validator: (phone) {
              if (phone.isEmpty || phone.length < 1) {}
              return null;
            },
            key: const Key('phone'),
            focusNode: _nodeText1,
            controller: _phoneNoController,
            maxLength: 12,
            keyboardType: TextInputType.phone,
            hintText: "请输入手机号",
            onSaved: (value) => request.setPhone(value),
          ),
          Gaps.vGap8,
          MyTextField(
            validator: (vCode) {
              if (vCode.isEmpty || vCode.length < 6) {}
              return null;
            },
            key: const Key('vcode'),
            focusNode: _nodeText2,
            controller: _vCodeController,
            keyboardType: TextInputType.number,
            onSaved: (value) => request.otpCode = value,
            getVCode: () async {
              _nodeText1.unfocus();
              _formKey.currentState.save();
              if (request.hasValidPhone()) {
                try {
                  // await _authService.getOtp(
                  //   request.phoneNumber,
                  //   onCodeSent: (str, [code]) => _onCodeSent(str, code),
                  //   onVerified: () => _onVerified,
                  //   onCodeRetrievalTimeout: (vId) => _manualSignIn,
                  // );
                } on Exception catch (e) {
                  showToast(e.toString());
                }

                /// 一般可以在这里发送真正的请求，请求成功返回true
                return true;
              } else {
                Toast.show("请输入有效的手机号");
                return false;
              }
            },
            maxLength: 6,
            hintText: "请输入验证码",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('register'),
            onPressed: _register,
            text: "注册",
          )
        ],
      ),
    );
  }
}
