/// firstName : "string"
/// lastName : "string"
/// email : "user@example.com"
/// password : "string"
/// confirmPassword : "string"
/// genderType : "Male"
/// birthDate : "2026-03-05"
/// city : "string"

class RegisterRequest {
  RegisterRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.genderType,
    this.birthDate,
    this.city,
  });

  RegisterRequest.fromJson(dynamic json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    genderType = json['genderType'];
    birthDate = json['birthDate'];
    city = json['city'];
  }
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  String? genderType;
  String? birthDate;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['password'] = password;
    map['confirmPassword'] = confirmPassword;
    map['genderType'] = genderType;
    map['birthDate'] = birthDate;
    map['city'] = city;
    return map;
  }
}