class UserModel {
  final String token;
  final String tokenType;
  final String username;
  final bool hasPreference;

  UserModel({
    required this.token,
    required this.tokenType,
    required this.username,
    required this.hasPreference,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      tokenType: json['tokenType'] ?? '',
      username: json['username'] ?? '',
      hasPreference: json['hasPreference'] ?? false,
    );
  }
}