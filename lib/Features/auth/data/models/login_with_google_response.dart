/// isSuccess : false
/// message : "Authentication failed"
/// errors : {"InvalidGoogleToken":["Invalid Google token"],"IdTokenRequired":["IdToken is required"]}

class LoginWithGoogleResponse {
  LoginWithGoogleResponse({this.isSuccess, this.message, this.errors});

  LoginWithGoogleResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? isSuccess;
  String? message;
  Errors? errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    return map;
  }
}

/// InvalidGoogleToken : ["Invalid Google token"]
/// IdTokenRequired : ["IdToken is required"]

class Errors {
  Errors({this.invalidGoogleToken, this.idTokenRequired});

  Errors.fromJson(dynamic json) {
    invalidGoogleToken = json['InvalidGoogleToken'] != null
        ? json['InvalidGoogleToken'].cast<String>()
        : [];
    idTokenRequired = json['IdTokenRequired'] != null
        ? json['IdTokenRequired'].cast<String>()
        : [];
  }
  List<String>? invalidGoogleToken;
  List<String>? idTokenRequired;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['InvalidGoogleToken'] = invalidGoogleToken;
    map['IdTokenRequired'] = idTokenRequired;
    return map;
  }
}