/// success : true
/// message : "Profile picture uploaded successfully"
/// data : {"imageUrl":"https://graduationproject1.runasp.net/images/718ddd83-7799-4d1e-9504-29795466af0b.png"}

class UploadProfilePictureResponse {
  UploadProfilePictureResponse({
      this.success, 
      this.message, 
      this.data,});

  UploadProfilePictureResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
UploadProfilePictureResponse copyWith({  bool? success,
  String? message,
  Data? data,
}) => UploadProfilePictureResponse(  success: success ?? this.success,
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

/// imageUrl : "https://graduationproject1.runasp.net/images/718ddd83-7799-4d1e-9504-29795466af0b.png"

class Data {
  Data({
      this.imageUrl,});

  Data.fromJson(dynamic json) {
    imageUrl = json['imageUrl'];
  }
  String? imageUrl;
Data copyWith({  String? imageUrl,
}) => Data(  imageUrl: imageUrl ?? this.imageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = imageUrl;
    return map;
  }

}