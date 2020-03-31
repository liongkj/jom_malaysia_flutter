class TextUtils {
  ///format capitalize
  static String capitalize(String text) {
    if (text.length == 0) {
      return text.toUpperCase();
    }
    if (text.codeUnits.where((ch) => ch > 128).toList().length > 0)
      return text[0].toUpperCase() + text.substring(1);
    return text;
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
}
