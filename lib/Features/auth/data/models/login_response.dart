class LoginResponse {
  bool? isSuccess;
  String? message;
  int? status;
  Errors? errors;
  Data? data;

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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  final String token;
  final String? expiration;
  final String? email;
  final String? displayName;
  final String? userId;

  Data(
    this.token, {
    this.expiration,
    this.email,
    this.displayName,
    this.userId,
  });

  Data.fromJson(Map<String, dynamic> json)
    : token = json['token'] ?? '',
      expiration = json['expiration'] as String?,
      email = json['email'] as String?,
      displayName = json['displayName'] as String?,
      userId = json['userId'] as String?;

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiration': expiration,
      'email': email,
      'displayName': displayName,
      'userId': userId,
    };
  }
}