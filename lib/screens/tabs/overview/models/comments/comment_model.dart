class CommentModel {
  CommentModel(
      {this.id,
      this.userId,
      this.commentText,
      this.rating,
      this.publishedTime,
      this.username,
      this.images,
      this.title});
  String id;
  String userId;
  DateTime publishedTime;
  String commentText;
  String title;
  double rating;
  String username;
  List<String> images;

  CommentModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        images = snapshot["images"] ?? [],
        title = snapshot['title'] ?? '',
        userId = snapshot['userId'] ?? '',
        commentText = snapshot['commentText'] ?? '',
        username = snapshot['username'] ?? '',
        publishedTime = snapshot['publishedTime'] ?? null,
        rating = snapshot['rating'] ?? 0.0;

  toJson() {
    return {
      "userId": userId,
      "commentText": commentText,
      "publishedTime": publishedTime,
      "username": username,
      "rating": rating,
      "title": title,
      "images": images
    };
  }
}
