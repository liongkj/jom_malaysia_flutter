import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/util/image_utils.dart';

/// design/9暂无状态页面/index.html#artboard3
class StateLayout extends StatefulWidget {
  const StateLayout({Key key, @required this.type, this.hintText})
      : super(key: key);

  final StateType type;
  final String hintText;

  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {
  String _img;
  String _hintText;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case StateType.places:
        _img = "coming_soon";
        _hintText = S.of(context).stateTypePlace;
        break;
      case StateType.goods:
        _img = "not_found";
        _hintText = S.of(context).stateTypeNotFound;
        break;
      case StateType.network:
        _img = "network_error";
        _hintText = S.of(context).stateTypeNoNetwork;
        break;
      case StateType.message:
        _img = "zwxx";
        _hintText = S.of(context).stateTypeNotification;
        break;
      case StateType.account:
        _img = "zwzh";
        _hintText = "马上添加提现账号吧";
        break;
      case StateType.loading:
        _img = "";
        _hintText = "";
        break;
      case StateType.empty:
        _img = "";
        _hintText = "";
        break;
    }
    return Center(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 16),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.type == StateType.loading
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 60,
                      width: 60,
                      child: const CupertinoActivityIndicator(
                        radius: 18.0,
                      ),
                    )
                  : (widget.type == StateType.empty
                      ? Gaps.empty
                      : Opacity(
                          opacity: 1,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: 120.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ImageUtils.getAssetImage("state/$_img"),
                              ),
                            ),
                          ))),
              Gaps.vGap16,
              Text(
                widget.hintText ?? _hintText,
                style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: Dimens.font_sp14, color: Colours.text_gray),
              ),
              Gaps.vGap50,
            ],
          ),
        ),
      ),
    );
  }
}

enum LocationState {
  init,

  ///found location
  found,

  ///show rejected state
  noPermit,

  ///  loading state
  loading,

  ///  loading empty state
  granted,
}
enum StateType {
  /// show no place found state
  places,

  ///  show no goods found state
  goods,

  ///  show network error state
  network,

  ///  load message state
  message,

  ///  loading account state
  account,

  ///  loading state
  loading,

  ///  loading empty state
  empty
}
