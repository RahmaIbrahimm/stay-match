/// isSuccess : true
/// message : "Request successful"
/// data : {"propertyId":176,"message":"Property updated successfully!"}

class UpdateSharedSpaceResponse {
  UpdateSharedSpaceResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  UpdateSharedSpaceResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? UpdateSharedSpaceResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  UpdateSharedSpaceResponseData? data;
UpdateSharedSpaceResponse copyWith({  bool? isSuccess,
  String? message,
  UpdateSharedSpaceResponseData? data,
}) => UpdateSharedSpaceResponse(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// propertyId : 176
/// message : "Property updated successfully!"

class UpdateSharedSpaceResponseData {
  UpdateSharedSpaceResponseData({
      this.propertyId, 
      this.message,});

  UpdateSharedSpaceResponseData.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    message = json['message'];
  }
  int? propertyId;
  String? message;
UpdateSharedSpaceResponseData copyWith({  int? propertyId,
  String? message,
}) => UpdateSharedSpaceResponseData(  propertyId: propertyId ?? this.propertyId,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['message'] = message;
    return map;
  }

}