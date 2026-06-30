/// isSuccess : true
/// message : "Request successful"
/// data : {"isCompleted":false}

class CheckIfPaidResponse {
  CheckIfPaidResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  CheckIfPaidResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
CheckIfPaidResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => CheckIfPaidResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// isCompleted : false

class Data {
  Data({
      this.isCompleted,});

  Data.fromJson(dynamic json) {
    isCompleted = json['isCompleted'];
  }
  bool? isCompleted;
Data copyWith({  bool? isCompleted,
}) => Data(  isCompleted: isCompleted ?? this.isCompleted,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isCompleted'] = isCompleted;
    return map;
  }

}