import 'package:flutter/material.dart';

class MySectionDivider extends StatelessWidget {
  MySectionDivider(this.title);
  final String title;
  static const double externalSpacing = 80;
  static const double internalSpacing = 10;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        const Expanded(
            child: Divider(
          endIndent: internalSpacing,
          indent: externalSpacing,
        )),
        Text(title),
        const Expanded(
            child: Divider(
          indent: internalSpacing,
          endIndent: externalSpacing,
        )),
      ]),
    );
  }
}
