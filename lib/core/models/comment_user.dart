import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/util/text_utils.dart';

class CommentUser extends AuthUser {
  CommentUser(String userId, String username, String profileImage, String email,
      {bool isVerified = false})
      : super(
            userId, username, profileImage, TextUtils.mask(email), isVerified);
}
