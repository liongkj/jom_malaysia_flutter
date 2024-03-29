import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';

class SelectedImage extends StatelessWidget {
  const SelectedImage({Key key, this.size: 80.0, this.onTap, this.image})
      : super(key: key);

  final double size;
  final GestureTapCallback onTap;
  final File image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          // 图片圆角展示
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
              image: image == null
                  ? ImageUtils.getAssetImage("comment/icon_add_image")
                  : FileImage(image),
              fit: BoxFit.cover,
              colorFilter: image == null
                  ? ColorFilter.mode(
                      ThemeUtils.getDarkColor(
                          context, Colours.dark_unselected_item_color),
                      BlendMode.srcIn)
                  : null),
        ),
      ),
    );
  }
}
