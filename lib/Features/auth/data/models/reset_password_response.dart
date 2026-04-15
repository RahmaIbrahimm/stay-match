/// isSuccess : false
/// message : "Password reset failed"
/// errors : {"PasswordTooShort":["Passwords must be at least 6 characters."],"PasswordRequiresNonAlphanumeric":["Passwords must have at least one non alphanumeric character."],"PasswordRequiresDigit":["Passwords must have at least one digit ('0'-'9')."],"InvalidUser":["Something went wrong."],"ConfirmPassword":["Passwords do not match."]}

class ResetPasswordResponse {
  ResetPasswordResponse({this.isSuccess, this.message, this.errors});

  ResetPasswordResponse.fromJson(dynamic json) {
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

/// PasswordTooShort : ["Passwords must be at least 6 characters."]
/// PasswordRequiresNonAlphanumeric : ["Passwords must have at least one non alphanumeric character."]
/// PasswordRequiresDigit : ["Passwords must have at least one digit ('0'-'9')."]
/// InvalidUser : ["Something went wrong."]
/// ConfirmPassword : ["Passwords do not match."]

class Errors {
  Errors({
    this.passwordTooShort,
    this.passwordRequiresNonAlphanumeric,
    this.passwordRequiresDigit,
    this.invalidUser,
    this.confirmPassword,
  });

  Errors.fromJson(dynamic json) {
    passwordTooShort = json['PasswordTooShort'] != null
        ? json['PasswordTooShort'].cast<String>()
        : [];
    passwordRequiresNonAlphanumeric =
        json['PasswordRequiresNonAlphanumeric'] != null
        ? json['PasswordRequiresNonAlphanumeric'].cast<String>()
        : [];
    passwordRequiresDigit = json['PasswordRequiresDigit'] != null
        ? json['PasswordRequiresDigit'].cast<String>()
        : [];
    invalidUser = json['InvalidUser'] != null
        ? json['InvalidUser'].cast<String>()
        : [];
    confirmPassword = json['ConfirmPassword'] != null
        ? json['ConfirmPassword'].cast<String>()
        : [];
  }
  List<String>? passwordTooShort;
  List<String>? passwordRequiresNonAlphanumeric;
  List<String>? passwordRequiresDigit;
  List<String>? invalidUser;
  List<String>? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PasswordTooShort'] = passwordTooShort;
    map['PasswordRequiresNonAlphanumeric'] = passwordRequiresNonAlphanumeric;
    map['PasswordRequiresDigit'] = passwordRequiresDigit;
    map['InvalidUser'] = invalidUser;
    map['ConfirmPassword'] = confirmPassword;
    return map;
  }
}