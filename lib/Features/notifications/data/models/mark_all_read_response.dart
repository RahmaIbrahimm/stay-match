/// isSuccess : true
/// message : "Request successful"
/// data : {"message":"All notifications marked as read"}

class MarkAllReadResponse {
  MarkAllReadResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  MarkAllReadResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
MarkAllReadResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => MarkAllReadResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// message : "All notifications marked as read"

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