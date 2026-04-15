/// email : "RahmaIbrahim315@gmail.com"
/// code : "600"

class VerifyCodeRequest {
  VerifyCodeRequest({this.email, this.code});

  VerifyCodeRequest.fromJson(dynamic json) {
    email = json['email'];
    code = json['code'];
  }
  String? email;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['code'] = code;
    return map;
  }
}