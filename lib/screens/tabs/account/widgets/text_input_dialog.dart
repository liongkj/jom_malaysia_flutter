import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:oktoast/oktoast.dart';

class TextInputDialog extends StatefulWidget {
  TextInputDialog({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Function(String) onPressed;

  @override
  _PriceInputDialog createState() => _PriceInputDialog();
}

class _PriceInputDialog extends State<TextInputDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      showCancel: true,
      child: Container(
        height: 34.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: ThemeUtils.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          key: const Key('name_input'),
          autofocus: true,
          controller: _controller,
          maxLines: 1,
          //style: TextStyles.textDark14,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            border: InputBorder.none,
            hintText:
                S.of(context).labelChangeHintText(widget.title.toLowerCase()),
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty) {
          showToast(
              S.of(context).labelChangeHintText(widget.title.toLowerCase()));
          return;
        }
        NavigatorUtils.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}
