class TextUtils {
  ///format capitalize
  static String capitalize(String text) {
    if (text.length == 0) {
      return text.toUpperCase();
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
