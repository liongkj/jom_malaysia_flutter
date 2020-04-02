import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

/// 搜索页的AppBar
class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchBar(
      {Key key,
      this.hintText: "",
      this.backImg: "assets/images/ic_back_black.png",
      this.onPressed,
      this.onTap,
      this.showBack = true})
      : super(key: key);
  final bool showBack;
  final String backImg;
  final String hintText;
  final Function onTap;
  final Function(String) onPressed;

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}

class _SearchBarState extends State<SearchBar> {
  SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light;
  TextEditingController _controller = TextEditingController();

  Color getColor() {
    return overlayStyle == SystemUiOverlayStyle.light
        ? Colours.dark_text
        : Colours.text;
  }

  @override
  Widget build(BuildContext context) {
    overlayStyle = SystemUiOverlayStyle.dark;
    Color iconColor = Colours.text_gray_c;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Material(
        color: widget.showBack
            ? ThemeUtils.getBackgroundColor(context)
            : Colors.transparent,
        child: SafeArea(
          child: Container(
              child: Row(
            children: <Widget>[
              if (widget.showBack) _showBackButton(),
              Expanded(
                child: Container(
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: Colours.bg_gray,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    enabled: widget.showBack,
                    onSubmitted: (text) => widget.onPressed(text),
                    key: const Key('search_text_field'),
                    autofocus: widget.showBack,
                    controller: _controller,
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          top: 6.0, left: -8.0, right: -16.0, bottom: 13),
                      border: InputBorder.none,
                      icon: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: LoadAssetImage(
                          "place/place_search",
                          color: iconColor,
                        ),
                      ),
                      hintText: widget.hintText,
                      suffixIcon: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8.0, bottom: 8.0),
                          child: LoadAssetImage("place/place_delete",
                              color: iconColor),
                        ),
                        onTap: () {
                          /// https://github.com/flutter/flutter/issues/35909
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            _controller.text = "";
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Gaps.hGap8,
              if (widget.showBack)
                Theme(
                  data: Theme.of(context).copyWith(
                    buttonTheme: ButtonThemeData(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: 32.0,
                        minWidth: 44.0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        // 距顶部距离为0
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        )),
                  ),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colours.app_main,
                    onPressed: () => widget.onPressed(_controller.text),
                    child: Text(S.of(context).labelSearch,
                        style: TextStyle(fontSize: Dimens.font_sp14)),
                  ),
                ),
              Gaps.hGap16,
            ],
          )),
        ),
      ),
    );
  }

  Widget _showBackButton() {
    return SizedBox(
      width: 48.0,
      height: 48.0,
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.maybePop(context);
        },
        borderRadius: BorderRadius.circular(24.0),
        child: Padding(
          key: const Key('search_back'),
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            widget.backImg,
            color: getColor(),
          ),
        ),
      ),
    );
  }
}
