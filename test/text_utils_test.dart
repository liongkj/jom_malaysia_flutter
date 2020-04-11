import 'package:jom_malaysia/util/text_utils.dart';
import 'package:test/test.dart';

void main() {
  group("test capitalize util", () {
    test('khai return Khai', () {
      var input = "khai";
      var output = TextUtils.capitalize(input);

      expect(output, "Khai");
    });
    test('k return K', () {
      var input = "k";
      var output = TextUtils.capitalize(input);

      expect(output, "K");
    });
    test('凯 return 凯', () {
      var input = "凯";
      var output = TextUtils.capitalize(input);

      expect(output, "凯");
    });
    test('blank return 凯', () {
      var input = "";
      var output = TextUtils.capitalize(input);

      expect(output, "");
    });
  });

  group("Masking email to show asterick(*)", () {
    test('khai', () {
      var input = "khaijiet@hotmail.com";
      var output = TextUtils.mask(input);

      expect(output, "kh*****t@****ail.com");
    });
    test('f@bar.com', () {
      var input = "f@bar.com";
      var output = TextUtils.mask(input);

      expect(output, "f@****com");
    });
  });

  group("test chinese charactoer", () {
    test('凯 return true', () {
      var input = "凯";
      var output = TextUtils.isChinese(input);

      expect(output, true);
    });
    test('kai return false', () {
      var input = "kai";
      var output = TextUtils.isChinese(input);

      expect(output, false);
    });

    test('blank return false', () {
      var input = "";
      var output = TextUtils.isChinese(input);

      expect(output, false);
    });
  });
}
