import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CommentModel {
  CommentModel(
    this.id, {
    this.userId,
    this.title,
    this.commentText,
    this.rating = 3,
    this.username,
    this.costPax,
  })  : images = [],
        publishedTime = FieldValue.serverTimestamp(),
        imageAssets = [];
  String id;
  String userId;

  var publishedTime;
  String commentText;
  String title;
  double rating;
  double costPax;
  String username;
  List<String> images;
  //holder
  List<Asset> imageAssets;

  CommentModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        images =
            (snapshot["images"] as List)?.map((i) => i as String)?.toList(),
        costPax = snapshot["costPax"] ?? null,
        title = snapshot['title'] ?? '',
        userId = snapshot['userId'] ?? '',
        commentText = snapshot['commentText'] ?? '',
        username = snapshot['username'] ?? '',
        publishedTime = snapshot['publishedTime'] != null
            ? (snapshot['publishedTime'] as Timestamp).toDate()
            : null,
        rating = snapshot['rating'] ?? null;

  toJson() {
    return {
      "userId": userId,
      "commentText": commentText,
      "publishedTime": publishedTime,
      "username": username,
      "rating": rating,
      "title": title,
      "costPax": costPax,
      "images": images
    };
  }
}
