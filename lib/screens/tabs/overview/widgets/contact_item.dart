import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/util/theme_utils.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key key,
    @required this.onTap,
    @required this.label,
    @required this.icon,
  }) : super(key: key);

  final Widget icon;
  final Function onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              icon,
              Gaps.hGap12,
              Expanded(
                flex: 6,
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Gaps.vLine,
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.navigate_next,
                  size: 24,
                  color: ThemeUtils.getIconColor(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
