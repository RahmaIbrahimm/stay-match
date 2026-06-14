/// isSuccess : true
/// message : "Logged out from all devices"

class LogoutResponse {
  LogoutResponse({
      this.isSuccess, 
      this.message,});

  LogoutResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }
  bool? isSuccess;
  String? message;
LogoutResponse copyWith({  bool? isSuccess,
  String? message,
}) => LogoutResponse(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    return map;
  }

}