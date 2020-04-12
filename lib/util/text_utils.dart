class TextUtils {
  ///format capitalize
  static String capitalize(String text) {
    if (text.length == 0) return "";
    if (text.length == 1) {
      return text.toUpperCase();
    }
    if (!isChinese(text)) return text[0].toUpperCase() + text.substring(1);
    return text;
  }

  static bool isChinese(String text) {
    if (text.codeUnits.where((ch) => ch > 128).toList().length > 0) {
      return true;
    }
    return false;
  }

  ///shorten city name -> Port dickson to P.Dickson
  static String shorten(String text) {
    var words = text.split(" ");
    if (words.length > 1) {
      var processed = "";
      for (var i = 0; i < words.length - 1; i++) {
        processed += words[i].substring(0, 1).toUpperCase();
        processed += '. ';
      }
      processed += capitalize(words.last);
      return processed;
    } else
      return text;
  }

  static String mask(String text) {
//   https://regex101.com/r/qg72Rm/8

    RegExp regExp = new RegExp(
        r'(?<=..)[^@\n](?=[^@\n]*[^@\n]@)|(?:(?<=@.{0,3})|(?!^)\G(?=[^@]*$)).(?!$)');
    var masked = text.replaceAll(regExp, '*');
    return masked;
  }
}
