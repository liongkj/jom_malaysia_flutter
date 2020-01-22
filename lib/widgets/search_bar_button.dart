import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/util/theme_utils.dart';

import 'load_image.dart';

/// 搜索页的AppBar
class SearchBarButton extends StatefulWidget implements PreferredSizeWidget {
  const SearchBarButton({
    Key key,
    this.hintText: "",
    this.onTap,
  }) : super(key: key);
  final String hintText;
  final Function onTap;

  @override
  _SearchBarButtonState createState() => _SearchBarButtonState();

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}

class _SearchBarButtonState extends State<SearchBarButton> {
  SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light;

  Color getColor() {
    return overlayStyle == SystemUiOverlayStyle.light
        ? Colours.dark_text
        : Colours.text;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    overlayStyle =
        isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    Color iconColor = isDark ? Colours.dark_text_gray : Colours.text_gray_c;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colours.dark_material_bg
                              : Colours.bg_gray,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: LoadAssetImage(
                                  "place/place_search",
                                  color: Colors.black,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  widget.hintText,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                              Expanded(
                                child: LoadAssetImage(
                                  "place/place_delete",
                                  color: iconColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Gaps.hGap8,
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
