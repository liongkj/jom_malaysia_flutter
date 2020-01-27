import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/explore/widgets/attraction_card.dart';
import 'package:provider/provider.dart';

class TodoTab extends StatelessWidget {
  const TodoTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AttractionCard(
              name: "Port Dickson",
              description:
                  "Malaysia coastal town known for Tanjung Tuan wildlife reserve, beaches & Lukut Musuem",
              image: "",
            ),
            AttractionCard(
              name: "Seremban",
              description: "Dim sum, burgers, golf, museums and shopping",
              image: "",
            ),
            AttractionCard(
              name: "Teluk Kemang",
              description: "Beaches, observatories and chalets",
              image: "",
            )
          ],
        ),
      ),
    );
  }
}
