import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/setting/res/resources.dart';

/// 封装输入框
class TextFieldItem extends StatelessWidget {
  const TextFieldItem(
      {Key key,
      this.controller,
      @required this.title,
      this.keyboardType: TextInputType.text,
      this.hintText: "",
      this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
        bottom: Divider.createBorderSide(context, width: 0.6),
      )),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(title),
          ),
          Expanded(
            flex: 1,
            child: TextField(
                focusNode: focusNode,
                keyboardType: keyboardType,
                inputFormatters: _getInputFormatters(),
                controller: controller,
                //style: TextStyles.textDark14,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none, //去掉下划线
                  //hintStyle: TextStyles.textGrayC14
                )),
          ),
          Gaps.hGap16
        ],
      ),
    );
  }

  _getInputFormatters() {
    if (keyboardType == TextInputType.number ||
        keyboardType == TextInputType.phone) {
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }
}
