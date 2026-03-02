/// idToken : "string"

class LoginWithGoogleRequest {
  LoginWithGoogleRequest({
      this.idToken,});

  LoginWithGoogleRequest.fromJson(dynamic json) {
    idToken = json['idToken'];
  }
  String? idToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idToken'] = idToken;
    return map;
  }

}