/// success : true
/// message : "Profile picture updated successfully"
/// data : {"imageUrl":"https://graduationproject1.runasp.net/images/ca47d646-553f-4ca1-8677-f5462e36028c.png"}

class UpdateProfilePictureResponse {
  UpdateProfilePictureResponse({
      this.success, 
      this.message, 
      this.data,});

  UpdateProfilePictureResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UpdateProfilePictureResponseData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  UpdateProfilePictureResponseData? data;
UpdateProfilePictureResponse copyWith({  bool? success,
  String? message,
  UpdateProfilePictureResponseData? data,
}) => UpdateProfilePictureResponse(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// imageUrl : "https://graduationproject1.runasp.net/images/ca47d646-553f-4ca1-8677-f5462e36028c.png"

class UpdateProfilePictureResponseData {
  UpdateProfilePictureResponseData({
      this.imageUrl,});

  UpdateProfilePictureResponseData.fromJson(dynamic json) {
    imageUrl = json['imageUrl'];
  }
  String? imageUrl;
UpdateProfilePictureResponseData copyWith({  String? imageUrl,
}) => UpdateProfilePictureResponseData(  imageUrl: imageUrl ?? this.imageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = imageUrl;
    return map;
  }

}