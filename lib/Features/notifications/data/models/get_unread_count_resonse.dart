/// isSuccess : true
/// message : "Request successful"
/// data : {"count":96}

class GetUnreadCountResonse {
  GetUnreadCountResonse({
      this.isSuccess, 
      this.message, 
      this.data,});

  GetUnreadCountResonse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
GetUnreadCountResonse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => GetUnreadCountResonse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// count : 96

class Data {
  Data({
      this.count,});

  Data.fromJson(dynamic json) {
    count = json['count'];
  }
  num? count;
Data copyWith({  num? count,
}) => Data(  count: count ?? this.count,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    return map;
  }

}