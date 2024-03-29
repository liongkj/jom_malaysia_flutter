import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';

class ClickItem extends StatelessWidget {
  const ClickItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content: "",
    this.textAlign: TextAlign.start,
    this.trailing,
    this.maxLines: 1,
    this.nextLineContent = "",
    this.leading,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;
  final Widget trailing;
  final String nextLineContent;
  final Icon leading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 15.0),
        padding: const EdgeInsets.fromLTRB(0, 15.0, 15.0, 15.0),
        constraints:
            BoxConstraints(maxHeight: double.infinity, minHeight: 50.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6),
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              //为了数字类文字居中
              crossAxisAlignment: maxLines == 1
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: <Widget>[
                if (leading != null) leading,
                Gaps.hGap16,
                Text(
                  title,
                ),
                const Spacer(),
                if (content != "")
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                      child: Text(content,
                          maxLines: maxLines,
                          textAlign:
                              maxLines == 1 ? TextAlign.right : textAlign,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle
                              .copyWith(fontSize: Dimens.font_sp14)),
                    ),
                  ),
                if (trailing != null)
                  Expanded(
                    flex: 4,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                        child: trailing),
                  ),
                Opacity(
                  // 无点击事件时，隐藏箭头图标
                  opacity: onTap == null ? 0 : 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: maxLines == 1 ? 0.0 : 2.0),
                    child: Images.arrowRight,
                  ),
                )
              ],
            ),
            if (nextLineContent != "")
              Padding(
                padding: const EdgeInsets.only(left: 40.0, top: 8.0),
                child: Text(
                  nextLineContent,
                  style:
                      TextStyles.subtitle.copyWith(fontSize: Dimens.font_sp10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
