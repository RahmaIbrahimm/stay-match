/// isSuccess : false
/// message : "Verification failed"
/// errors : {"InvalidCode":["Invalid code."]}

class VerifyCodeResponse {
  VerifyCodeResponse({this.isSuccess, this.message, this.errors});

  VerifyCodeResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? isSuccess;
  String? message;
  Errors? errors;
  Data? data;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['data'] = data;
    map['message'] = message;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// InvalidCode : ["Invalid code."]
/// "Email": ["The Email field is not a valid e-mail address."]
class Errors {
  Errors({this.invalidCode, this.email});

  Errors.fromJson(dynamic json) {
    invalidCode = json['InvalidCode'] != null
        ? json['InvalidCode'].cast<String>()
        : [];
    email = json['Email'] != null ? json['Email'].cast<String>() : [];
  }

  List<String>? invalidCode;
  List<String>? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['InvalidCode'] = invalidCode;
    map['Email'] = email;
    return map;
  }
}

class Data {
  String? userId;

  Data({required this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }
  Map<String,dynamic> toJson() {
    return {
      'userId' : userId
    };
  }
}