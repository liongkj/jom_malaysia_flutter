import 'package:jom_malaysia/util/text_utils.dart';
import 'package:test/test.dart';

void main() {
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
}
