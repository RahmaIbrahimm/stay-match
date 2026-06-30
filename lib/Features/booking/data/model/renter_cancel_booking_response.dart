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
    data = json['data'] != null ? RenterCancelBookingResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  RenterCancelBookingResponseData? data;
RenterCancelBookingResponse copyWith({  bool? isSuccess,
  String? message,
  RenterCancelBookingResponseData? data,
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

class RenterCancelBookingResponseData {
  RenterCancelBookingResponseData({
      this.message, 
      this.id, 
      this.status,});

  RenterCancelBookingResponseData.fromJson(dynamic json) {
    message = json['message'];
    id = json['id'];
    status = json['status'];
  }
  String? message;
  int? id;
  String? status;
RenterCancelBookingResponseData copyWith({  String? message,
  int? id,
  String? status,
}) => RenterCancelBookingResponseData(  message: message ?? this.message,
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