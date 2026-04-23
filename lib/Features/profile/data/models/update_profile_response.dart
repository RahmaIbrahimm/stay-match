/// success : true
/// message : "Profile updated successfully"

class UpdateProfileResponse {
  UpdateProfileResponse({
      this.success, 
      this.message,});

  UpdateProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
UpdateProfileResponse copyWith({  bool? success,
  String? message,
}) => UpdateProfileResponse(  success: success ?? this.success,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}