/// isSuccess : false
/// message : "Some required fields are missing"
/// data : {"imageUrl":"https://graduationproject1.runasp.net/images/properties/e3361d17-c73b-4aad-9b72-4a671cd0665d_Screenshot 2023-10-12 205255.png","isCover":false}
/// errors : {"file":["The file field is required."]}

class UploadImageResponse {
  UploadImageResponse({
      this.isSuccess, 
      this.message, 
      this.data, 
      this.errors,});

  UploadImageResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? UploadImageData.fromJson(json['data']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }
  bool? isSuccess;
  String? message;
  UploadImageData? data;
  Errors? errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    return map;
  }

}

/// file : ["The file field is required."]

class Errors {
  Errors({
      this.file,});

  Errors.fromJson(dynamic json) {
    file = json['file'] != null ? json['file'].cast<String>() : [];
  }
  List<String>? file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['file'] = file;
    return map;
  }

}

/// imageUrl : "https://graduationproject1.runasp.net/images/properties/e3361d17-c73b-4aad-9b72-4a671cd0665d_Screenshot 2023-10-12 205255.png"
/// isCover : false

class UploadImageData {
  UploadImageData({
      this.imageUrl, 
      this.isCover,});

  UploadImageData.fromJson(dynamic json) {
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  String? imageUrl;
  bool? isCover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['imageUrl'] = imageUrl;
    map['isCover'] = isCover;
    return map;
  }

}