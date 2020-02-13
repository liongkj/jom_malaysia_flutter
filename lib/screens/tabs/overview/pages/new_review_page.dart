import 'package:flutter/material.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';

class NewReviewPage extends StatelessWidget {
  NewReviewPage({@required this.placeId, @required this.userId});
  final String placeId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backImg: "assets/images/ic_close.png",
      ),
      body: Container(
        child: Text("Review for: " + placeId),
      ),
    );
  }
}
