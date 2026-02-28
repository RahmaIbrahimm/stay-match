/// isSuccess : false
/// message : "Invalid data"
/// errors : {"Email":["The Email field is not a valid e-mail address."]}

class ForgetPasswordResponse {
  ForgetPasswordResponse({
      this.isSuccess, 
      this.message, 
      this.errors,});

  ForgetPasswordResponse.fromJson(dynamic json) {
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

/// Email : ["The Email field is not a valid e-mail address."]

class Errors {
  Errors({
      this.email,});

  Errors.fromJson(dynamic json) {
    email = json['Email'] != null ? json['Email'].cast<String>() : [];
  }
  List<String>? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Email'] = email;
    return map;
  }

}