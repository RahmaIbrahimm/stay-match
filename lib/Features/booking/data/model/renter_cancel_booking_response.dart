/// isSuccess : true
/// message : "Request successful"
/// data : {"message":"Booking cancelled successfully","id":91,"status":"Cancelled"}

class RenterCancelBookingResponse {
  RenterCancelBookingResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  RenterCancelBookingResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
RenterCancelBookingResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => RenterCancelBookingResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// message : "Booking cancelled successfully"
/// id : 91
/// status : "Cancelled"

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