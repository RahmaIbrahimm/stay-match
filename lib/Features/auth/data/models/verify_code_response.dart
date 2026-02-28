/// isSuccess : false
/// message : "Verification failed"
/// errors : {"InvalidCode":["Invalid code."]}

class VerifyEmailResponse {
  VerifyEmailResponse({
      this.isSuccess, 
      this.message, 
      this.errors,});

  VerifyEmailResponse.fromJson(dynamic json) {
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

/// InvalidCode : ["Invalid code."]
/// "Email": ["The Email field is not a valid e-mail address."]
class Errors {
  Errors({
      this.invalidCode,
      this.email,
  });

  Errors.fromJson(dynamic json) {
    invalidCode = json['InvalidCode'] != null ? json['InvalidCode'].cast<String>() : [];
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