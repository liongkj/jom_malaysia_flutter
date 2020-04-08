import 'package:flutter_test/flutter_test.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';

void main() {
  group("Test email format from Flustars RegexUtil", () {
    AuthRequest req = AuthRequest();
    test('khaijiet@hotmail.com', () {
      var email = "khaijiet@hotmail.com";
      var output = req.validateEmail(email);

      expect(output, null);
    });
    test('khaijiet@hotmail', () {
      var email = "khaijiet@hotmail";

      expect(
        () => req.validateEmail(email),
        throwsException,
      );
    });

    test('khaijieotmail.com', () {
      var email = "khaijieotmail.com";

      expect(
        () => req.validateEmail(email),
        throwsException,
      );
    });
  });
}
