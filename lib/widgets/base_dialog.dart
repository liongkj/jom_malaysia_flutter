import 'package:flutter/material.dart';

import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';

/// 自定义dialog的模板
class BaseDialog extends StatelessWidget {
  const BaseDialog(
      {Key key,
      this.title,
      this.onPressed,
      this.showCancel: false,
      this.hiddenTitle: false,
      @required this.child})
      : super(key: key);

  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;
  final bool showCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(
            decoration: BoxDecoration(
              color: ThemeUtils.getDialogBackgroundColor(context),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 270.0,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      hiddenTitle ? "" : title,
                      style: TextStyles.textBold18,
                    ),
                  ),
                ),
                Flexible(child: child),
                Gaps.vGap8,
                Gaps.line,
                Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 48.0,
                      width: 0.6,
                      child: const VerticalDivider(),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48.0,
                        child: FlatButton(
                          child: Text(
                            S.of(context).labelDialogOkay,
                            style: TextStyle(fontSize: Dimens.font_sp18),
                          ),
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () {
                            onPressed();
                          },
                        ),
                      ),
                    ),
                    if (showCancel)
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: FlatButton(
                            child: Text(
                              S.of(context).labelDialogCancel,
                              style: TextStyle(fontSize: Dimens.font_sp18),
                            ),
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () => NavigatorUtils.goBack(context),
                          ),
                        ),
                      )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
