import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';

class EmailSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthRequest req = AuthRequest();
    req.email = "khaijiet@hotmail.com";
//    platformProvider.sendSignInWithEmailLink(req);
    //TODO switch between sign in passwordless or with password

    return Container();
  }
}
