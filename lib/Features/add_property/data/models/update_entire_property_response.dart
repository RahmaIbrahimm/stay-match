/// isSuccess : true
/// message : "Request successful"
/// data : {"propertyId":183,"message":"Property updated successfully!"}

class UpdateEntirePropertyResponse {
  UpdateEntirePropertyResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  UpdateEntirePropertyResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? UpdateEntirePropertyResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  UpdateEntirePropertyResponseData? data;
UpdateEntirePropertyResponse copyWith({  bool? isSuccess,
  String? message,
  UpdateEntirePropertyResponseData? data,
}) => UpdateEntirePropertyResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// propertyId : 183
/// message : "Property updated successfully!"

class UpdateEntirePropertyResponseData {
  UpdateEntirePropertyResponseData({
      this.propertyId, 
      this.message,});

  UpdateEntirePropertyResponseData.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    message = json['message'];
  }
  int? propertyId;
  String? message;
UpdateEntirePropertyResponseData copyWith({  int? propertyId,
  String? message,
}) => UpdateEntirePropertyResponseData(  propertyId: propertyId ?? this.propertyId,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['message'] = message;
    return map;
  }

}