/// isSuccess : true
/// message : "Request successful"
/// data : {"message":"Notification deleted"}
/// title : "Not Found"
/// status : 404

class DeleteNotificationResponse {
  DeleteNotificationResponse({
      this.isSuccess, 
      this.message, 
      this.data, 
      this.title, 
      this.status,});

  DeleteNotificationResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    title = json['title'];
    status = json['status'];
  }
  bool? isSuccess;
  String? message;
  Data? data;
  String? title;
  num? status;
DeleteNotificationResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
  String? title,
  num? status,
}) => DeleteNotificationResponse(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
  data: data ?? this.data,
  title: title ?? this.title,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['title'] = title;
    map['status'] = status;
    return map;
  }

}

/// message : "Notification deleted"

class Data {
  Data({
      this.message,});

  Data.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;
Data copyWith({  String? message,
}) => Data(  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}