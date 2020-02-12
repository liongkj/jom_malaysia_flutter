import 'package:json_annotation/json_annotation.dart';

class CommentModel {
  CommentModel(this.userId, this.comment, this.rating, this.publishedTime,
      this.username);
  String userId;
  DateTime publishedTime;
  String comment;
  double rating;
  String username;

  CommentModel.fromMap(Map snapshot, String id)
      : userId = id ?? '',
        comment = snapshot['comment'] ?? '',
        username = snapshot['username'] ?? '',
        publishedTime = snapshot['publishedTime'] ?? '',
        rating = snapshot['rating'] ?? '';

  toJson() {
    return {
      "userId": userId,
      "comment": comment,
      "publishedTime": publishedTime,
      "username": username,
      "rating": rating,
    };
  }
}
