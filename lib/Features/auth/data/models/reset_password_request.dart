/// userId : "string"
/// newPassword : "string"
/// confirmPassword : "string"

class ResetPasswordRequest {
  ResetPasswordRequest({
      this.userId, 
      this.newPassword, 
      this.confirmPassword,});

  ResetPasswordRequest.fromJson(dynamic json) {
    userId = json['userId'];
    newPassword = json['newPassword'];
    confirmPassword = json['confirmPassword'];
  }
  String? userId;
  String? newPassword;
  String? confirmPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['newPassword'] = newPassword;
    map['confirmPassword'] = confirmPassword;
    return map;
  }

}