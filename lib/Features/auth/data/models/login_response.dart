class LoginResponse {
  bool? isSuccess;
  String? message;
  int? status;
  Errors? errors;
  LoginData? data;

  LoginResponse({
    required this.isSuccess,
    this.message,
    this.status,
    this.errors,
    this.data,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
}

class Errors {
  List<String>? email;
  List<String>? password;

  Errors({this.email, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
}

class LoginData {
  final String token;
  final String refreshToken;
  final String? expiration;
  final String? email;
  final String? displayName;
  final String? userId;
  final String? otherUserProfileImageUrl;
  final bool? profileComplete;

  LoginData(
    this.token,
    this.refreshToken, {
    this.expiration,
    this.email,
    this.displayName,
    this.userId,
    this.otherUserProfileImageUrl,
    this.profileComplete,
  });

  LoginData.fromJson(Map<String, dynamic> json)
    : token = json['token'] ?? '',
      expiration = json['expiration'] as String?,
      email = json['email'] as String?,
      displayName = json['displayName'] as String?,
      userId = json['userId'] as String?,
      otherUserProfileImageUrl = json['otherUserProfileImageUrl'] as String?,
      profileComplete = json['profileComplete'] as bool?,
      refreshToken = json['refreshToken'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiration': expiration,
      'email': email,
      'displayName': displayName,
      'userId': userId,
      'refreshToken': refreshToken,
      'otherUserProfileImageUrl': otherUserProfileImageUrl,
      'profileComplete': profileComplete,
    };
  }
}