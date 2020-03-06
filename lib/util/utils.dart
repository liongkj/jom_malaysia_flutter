import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/map_type.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/util/money_utils.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  ///launch send email with default email client
  static void launchEmailURL(String email) async {
    String url = 'mailto:' + email;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Failed opening email client');
    }
  }

  ///launch website in default browser
  static void launchWebURL(String web) async {
    String url = 'https:' + web;
    if (await canLaunch(url)) {
      await launch(
        url,
        // forceWebView: true,
      );
    } else {
      Toast.show('Failed opening web address');
    }
  }

  /// launch T9 dialler
  static void launchTelURL(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Failed opening dialer');
    }
  }

  /// launch WhatsApp Intent
  static void launchWhatsAppURL(String phone) async {
    var url = "whatsapp://send?phone=$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Failed opening whatsapp');
    }
  }

  static Future<void> launchMap(CoordinatesModel coordinates, MapType s) async {
    final double lat = coordinates.latitude;
    final double lng = coordinates.longitude;

    final String googleMapsUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";
    final String wazeMapsUrl =
        "https://www.waze.com/ul?ll=$lat,$lng&navigation=yes";

    if (s == MapType.google) {
      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
        return;
      }
    } else if (s == MapType.waze) {
      if (await canLaunch(wazeMapsUrl)) {
        await launch(wazeMapsUrl);
        return;
      }
    } else if (s == MapType.apple) {
      if (await canLaunch(appleMapsUrl)) {
        await launch(appleMapsUrl, forceSafariVC: false);
        return;
      }
    } else {
      throw "Couldn't launch URL";
    }
  }

  static String formatPrice(String price, {format: RmMoneyFormat.END_INTEGER}) {
    return RinggitMoneyUtil.changeRmWithUnit(
        NumUtil.getDoubleByValueStr(price), RmMoneyUnit.RINGGIT,
        format: format);
  }
}

/// 默认dialog背景色为半透明黑色，这里修改源码改为透明
Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

Future<T> showElasticDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 550),
    transitionBuilder: _buildDialogTransitions,
  );
}

Widget _buildDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero)
          .animate(CurvedAnimation(
        parent: animation,
        curve: animation.status != AnimationStatus.forward
            ? Curves.easeOutBack
            : ElasticOutCurve(0.85),
      )),
      child: child,
    ),
  );
}
