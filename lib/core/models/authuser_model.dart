class AuthUser {
  AuthUser(
    this.userId,
    this.username,
    this.profileImage,
  );

  String userId;
  String username;
  String profileImage;

  AuthUser.fromMap(Map snapshot, String id)
      : userId = snapshot['userId'] ?? '',
        username = snapshot['username'] ?? '';

  toJson() {
    return {
      "userId": userId,
      "username": username,
    };
  }
}
