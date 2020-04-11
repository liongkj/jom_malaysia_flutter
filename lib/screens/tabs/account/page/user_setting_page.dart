import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class UserSettings extends StatelessWidget {
  final _menuImage = ['profile'];

  @override
  Widget build(BuildContext context) {
    var _menuTitle = [
      S.of(context).labelProfileManager,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Gaps.vGap24,
        MergeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              S.of(context).labelAccount,
              style: TextStyles.textBold18,
            ),
          ),
        ),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.18),
            itemCount: _menuTitle.length,
            itemBuilder: (_, index) {
              return InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LoadAssetImage('account/${_menuImage[index]}',
                          width: 32.0),
                      Gaps.vGap4,
                      Text(
                        _menuTitle[index],
                        style: TextStyles.textSize12,
                      )
                    ],
                  ),
                  onTap: () {
                    if (index == 0) {
                      NavigatorUtils.push(
                          context, AccountRouter.accountManagerPage);
                    }
                  });
            },
          ),
        ),
        Container(
          height: 0.6,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16.0),
          child: Gaps.line,
        ),
        Gaps.vGap24,
      ],
    );
  }
}
