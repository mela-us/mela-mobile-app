class User {
  String accessToken;
  String? avatarPath;
  String username;
  String password;
  User({
    required this.accessToken,
    this.avatarPath,
    required this.username,
    required this.password,
  });
}