/// isSuccess : true
/// message : "Request successful"
/// data : {"message":"Booking deleted successfully","id":100}

class DeleteBookingRequestResponse {
  DeleteBookingRequestResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  DeleteBookingRequestResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? DeleteBookingRequestResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  DeleteBookingRequestResponseData? data;
DeleteBookingRequestResponse copyWith({  bool? isSuccess,
  String? message,
  DeleteBookingRequestResponseData? data,
}) => DeleteBookingRequestResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// message : "Booking deleted successfully"
/// id : 100

class DeleteBookingRequestResponseData {
  DeleteBookingRequestResponseData({
      this.message, 
      this.id,});

  DeleteBookingRequestResponseData.fromJson(dynamic json) {
    message = json['message'];
    id = json['id'];
  }
  String? message;
  int? id;
DeleteBookingRequestResponseData copyWith({  String? message,
  int? id,
}) => DeleteBookingRequestResponseData(  message: message ?? this.message,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['id'] = id;
    return map;
  }

}