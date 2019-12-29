import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    icon,
                    Gaps.hGap12,
                    Expanded(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Icon(
                      Icons.navigate_next,
                      color: ThemeUtils.getIconColor(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
