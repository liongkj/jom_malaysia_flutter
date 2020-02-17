import 'package:common_utils/common_utils.dart';

enum RmMoneyUnit {
  NORMAL, // 6.00
  RINGGIT, // RM6.00
  RINGGIT_ZH, // 6.00令吉
  DOLLAR, // $6.00
}
enum RmMoneyFormat {
  NORMAL, //保留两位小数(6.00令吉)
  END_INTEGER, //去掉末尾'0'(6.00令吉 -> 6令吉, 6.60令吉 -> 6.6令吉)
  RINGGIT_INTEGER, //整令吉(6.00令吉 -> 6令吉)
}
/**
 * @Author: Khaijiet (Took from Sky24n)
 * @GitHub: https://github.com/Sky24n
 * @Description: Money Util localized to RM
 * @Date: 2020/2/17
 */

///
class RinggitMoneyUtil {
  static const String RINGGIT = 'RM';
  static const String RINGGIT_ZH = '令吉';
  static const String DOLLAR = '\$';

  /// fen to ringgit, format output.
  /// 分 转 令吉, format格式输出.
  static String changeSenToRm(int amount,
      {RmMoneyFormat format = RmMoneyFormat.NORMAL}) {
    if (amount == null) return null;
    String moneyTxt;
    double ringgit = NumUtil.divide(amount, 100);
    switch (format) {
      case RmMoneyFormat.NORMAL:
        moneyTxt = ringgit.toStringAsFixed(2);
        break;
      case RmMoneyFormat.END_INTEGER:
        if (amount % 100 == 0) {
          moneyTxt = ringgit.toInt().toString();
        } else if (amount % 10 == 0) {
          moneyTxt = ringgit.toStringAsFixed(1);
        } else {
          moneyTxt = ringgit.toStringAsFixed(2);
        }
        break;
      case RmMoneyFormat.RINGGIT_INTEGER:
        moneyTxt = (amount % 100 == 0)
            ? ringgit.toInt().toString()
            : ringgit.toStringAsFixed(2);
        break;
    }
    return moneyTxt;
  }

  /// 分字符串 转 令吉, format 与 unit 格式 输出.
  static String changeFStr2YWithUnit(String amountStr,
      {RmMoneyFormat format = RmMoneyFormat.NORMAL,
      RmMoneyUnit unit = RmMoneyUnit.NORMAL}) {
    int amount;
    if (amountStr != null) {
      double value = double.tryParse(amountStr);
      amount = (value == null ? null : value.toInt());
    }
    return changeSenToRmWithUnit(amount, format: format, unit: unit);
  }

  /// 仙 转 令吉, format 与 unit 格式 输出.
  static String changeSenToRmWithUnit(int amount,
      {RmMoneyFormat format = RmMoneyFormat.NORMAL,
      RmMoneyUnit unit = RmMoneyUnit.NORMAL}) {
    return _withUnit(changeSenToRm(amount, format: format), unit);
  }

  /// 令吉, format 与 unit 格式 输出.
  static String changeRmWithUnit(Object ringgit, RmMoneyUnit unit,
      {RmMoneyFormat format}) {
    if (ringgit == null) return null;
    String ringgitTxt = ringgit.toString();
    if (format != null) {
      int amount = changeRmtoSen(ringgit);
      ringgitTxt = changeSenToRm(amount.toInt(), format: format);
    }
    return _withUnit(ringgitTxt, unit);
  }

  /// ringgit to sen.
  /// 令吉 转 仙，
  static int changeRmtoSen(Object ringgit) {
    if (ringgit == null) return null;
    return NumUtil.multiplyDecStr(ringgit.toString(), '100').toInt();
  }

  /// with unit.
  /// 拼接单位.
  static String _withUnit(String moneyTxt, RmMoneyUnit unit) {
    if (moneyTxt == null || moneyTxt.isEmpty) return null;
    switch (unit) {
      case RmMoneyUnit.RINGGIT:
        moneyTxt = RINGGIT + moneyTxt;
        break;
      case RmMoneyUnit.RINGGIT_ZH:
        moneyTxt = moneyTxt + RINGGIT_ZH;
        break;
      case RmMoneyUnit.DOLLAR:
        moneyTxt = DOLLAR + moneyTxt;
        break;
      default:
        break;
    }
    return moneyTxt;
  }
}
