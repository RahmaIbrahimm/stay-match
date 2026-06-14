/// isSuccess : true
/// message : "Request successful"
/// data : {"message":"Booking declined successfully","id":87,"status":"Declined"}

class DeclineBookingRequestResponse {
  DeclineBookingRequestResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  DeclineBookingRequestResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
DeclineBookingRequestResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => DeclineBookingRequestResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// message : "Booking declined successfully"
/// id : 87
/// status : "Declined"

class Data {
  Data({
      this.message, 
      this.id, 
      this.status,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    id = json['id'];
    status = json['status'];
  }
  String? message;
  int? id;
  String? status;
Data copyWith({  String? message,
  int? id,
  String? status,
}) => Data(  message: message ?? this.message,
  id: id ?? this.id,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['id'] = id;
    map['status'] = status;
    return map;
  }

}