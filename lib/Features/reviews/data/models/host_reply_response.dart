/// success : false
/// message : "An error occurred while adding response"
/// error : "Review not found"

class HostReplyResponse {
  HostReplyResponse({
      this.success, 
      this.message, 
      this.error,});

  HostReplyResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    error = json['error'];
  }
  bool? success;
  String? message;
  String? error;
HostReplyResponse copyWith({  bool? success,
  String? message,
  String? error,
}) => HostReplyResponse(  success: success ?? this.success,
  message: message ?? this.message,
  error: error ?? this.error,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}