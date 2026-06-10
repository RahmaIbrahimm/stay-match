/// success : true
/// message : "Profile picture deleted successfully."

class DeleteProfilePictureResponse {
  DeleteProfilePictureResponse({
      this.success, 
      this.message,});

  DeleteProfilePictureResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
DeleteProfilePictureResponse copyWith({  bool? success,
  String? message,
}) => DeleteProfilePictureResponse(  success: success ?? this.success,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}