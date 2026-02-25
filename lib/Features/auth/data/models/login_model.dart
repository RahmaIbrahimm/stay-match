/// email : "string"
/// password : "string"

class LoginModel {
  LoginModel({required this.email, required this.password});
  LoginModel.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }

  late final String email;
  late final String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}