import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jom_malaysia/core/models/authuser_model.dart';
import 'package:jom_malaysia/util/date_utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CommentModel {
  CommentModel(
    this.id, {
    this.title,
    this.commentText,
    this.rating = 3,
    this.costPax,
  })  : images = [],
        publishedTime = FieldValue.serverTimestamp(),
        imageAssets = [];
  String id;
  var publishedTime;
  String commentText;
  String title;
  double rating;
  double costPax;

  List<String> images;
  //holder
  List<Asset> imageAssets;
  AuthUser user;

  String get formattedPublishTime {
    var formatted = DateUtils.apiFullFormat(publishedTime);
    return formatted;
  }

  CommentModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        images = snapshot["images"] != null
            ? (snapshot["images"] as List)?.map((i) => i as String)?.toList()
            : [],
        costPax = snapshot["costPax"] ?? null,
        title = snapshot['title'] ?? '',
        commentText = snapshot['commentText'] ?? '',
        publishedTime = snapshot['publishedTime'] != null
            ? (snapshot['publishedTime'] as Timestamp).toDate()
            : null,
        rating = snapshot['rating'] ?? null;

  toJson() {
    return {
      "commentText": commentText,
      "publishedTime": publishedTime,
      "rating": rating,
      "title": title,
      "costPax": costPax,
      "images": images
    };
  }
}
