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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
DeleteBookingRequestResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
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

class Data {
  Data({
      this.message, 
      this.id,});

  Data.fromJson(dynamic json) {
    message = json['message'];
    id = json['id'];
  }
  String? message;
  int? id;
Data copyWith({  String? message,
  int? id,
}) => Data(  message: message ?? this.message,
  id: id ?? this.id,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['id'] = id;
    return map;
  }

}