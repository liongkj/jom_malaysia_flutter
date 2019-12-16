import 'package:flutter/material.dart';

import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/util/theme_utils.dart';

class MyGridCard extends StatelessWidget {
  const MyGridCard(
      {Key key, @required this.child, this.color, this.shadowColor})
      : super(key: key);

  final Widget child;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;
    Color _shadowColor;
    bool isDark = ThemeUtils.isDark(context);
    if (color == null) {
      _backgroundColor = isDark ? Colours.dark_bg_gray_ : Colors.white;
    } else {
      _backgroundColor = color;
    }

    if (shadowColor == null) {
      _shadowColor = isDark ? Colors.transparent : const Color(0x80DCE7FA);
    } else {
      _shadowColor = isDark ? Colors.transparent : shadowColor;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: _shadowColor,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 8.0,
                  spreadRadius: 0.0),
            ]),
        child: child,
      ),
    );
  }
}