/// isSuccess : false
/// message : "Registration failed"
/// errors : {"PasswordRequiresNonAlphanumeric":["Passwords must have at least one non alphanumeric character."],"PasswordRequiresDigit":["Passwords must have at least one digit ('0'-'9')."],"PasswordRequiresUpper":["Passwords must have at least one uppercase ('A'-'Z')."],"ConfirmPassword":["Passwords do not match"],"DuplicateUserName":["Username 'RahmaIbrahim315@gmail.com' is already taken."],"DuplicateEmail":["Email 'RahmaIbrahim315@gmail.com' is already taken."]}

class RegisterResponse {
  RegisterResponse({this.isSuccess, this.message, this.errors});

  RegisterResponse.fromJson(dynamic json) {
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

/// PasswordRequiresNonAlphanumeric : ["Passwords must have at least one non alphanumeric character."]
/// PasswordRequiresDigit : ["Passwords must have at least one digit ('0'-'9')."]
/// PasswordRequiresUpper : ["Passwords must have at least one uppercase ('A'-'Z')."]
/// ConfirmPassword : ["Passwords do not match"]
/// DuplicateUserName : ["Username 'RahmaIbrahim315@gmail.com' is already taken."]
/// DuplicateEmail : ["Email 'RahmaIbrahim315@gmail.com' is already taken."]

class Errors {
  Errors({
    this.passwordRequiresNonAlphanumeric,
    this.passwordRequiresDigit,
    this.passwordRequiresUpper,
    this.confirmPassword,
    this.duplicateUserName,
    this.duplicateEmail,
  });

  Errors.fromJson(dynamic json) {
    passwordRequiresNonAlphanumeric =
        json['PasswordRequiresNonAlphanumeric'] != null
        ? json['PasswordRequiresNonAlphanumeric'].cast<String>()
        : [];
    passwordRequiresDigit = json['PasswordRequiresDigit'] != null
        ? json['PasswordRequiresDigit'].cast<String>()
        : [];
    passwordRequiresUpper = json['PasswordRequiresUpper'] != null
        ? json['PasswordRequiresUpper'].cast<String>()
        : [];
    confirmPassword = json['ConfirmPassword'] != null
        ? json['ConfirmPassword'].cast<String>()
        : [];
    duplicateUserName = json['DuplicateUserName'] != null
        ? json['DuplicateUserName'].cast<String>()
        : [];
    duplicateEmail = json['DuplicateEmail'] != null
        ? json['DuplicateEmail'].cast<String>()
        : [];
  }

  List<String>? passwordRequiresNonAlphanumeric;
  List<String>? passwordRequiresDigit;
  List<String>? passwordRequiresUpper;
  List<String>? confirmPassword;
  List<String>? duplicateUserName;
  List<String>? duplicateEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PasswordRequiresNonAlphanumeric'] = passwordRequiresNonAlphanumeric;
    map['PasswordRequiresDigit'] = passwordRequiresDigit;
    map['PasswordRequiresUpper'] = passwordRequiresUpper;
    map['ConfirmPassword'] = confirmPassword;
    map['DuplicateUserName'] = duplicateUserName;
    map['DuplicateEmail'] = duplicateEmail;
    return map;
  }
}