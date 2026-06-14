/// success : true
/// message : "Account deleted successfully"

class DeleteAccountResponse {
  DeleteAccountResponse({
      this.success, 
      this.message,});

  DeleteAccountResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
DeleteAccountResponse copyWith({  bool? success,
  String? message,
}) => DeleteAccountResponse(  success: success ?? this.success,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}