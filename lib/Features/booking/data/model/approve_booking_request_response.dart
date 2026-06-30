/// isSuccess : true
/// message : "Request successful"
/// data : {"message":"Booking approved successfully","id":103,"status":"Approved","declinedCount":11,"messageDetail":"11 conflicting booking(s) were automatically declined."}

class ApproveBookingRequestResponse {
  ApproveBookingRequestResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  ApproveBookingRequestResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? ApproveBookingRequestResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  ApproveBookingRequestResponseData? data;
ApproveBookingRequestResponse copyWith({  bool? isSuccess,
  String? message,
  ApproveBookingRequestResponseData? data,
}) => ApproveBookingRequestResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// message : "Booking approved successfully"
/// id : 103
/// status : "Approved"
/// declinedCount : 11
/// messageDetail : "11 conflicting booking(s) were automatically declined."

class ApproveBookingRequestResponseData {
  ApproveBookingRequestResponseData({
      this.message, 
      this.id, 
      this.status, 
      this.declinedCount, 
      this.messageDetail,});

  ApproveBookingRequestResponseData.fromJson(dynamic json) {
    message = json['message'];
    id = json['id'];
    status = json['status'];
    declinedCount = json['declinedCount'];
    messageDetail = json['messageDetail'];
  }
  String? message;
  int? id;
  String? status;
  int? declinedCount;
  String? messageDetail;
ApproveBookingRequestResponseData copyWith({  String? message,
  int? id,
  String? status,
  int? declinedCount,
  String? messageDetail,
}) => ApproveBookingRequestResponseData(  message: message ?? this.message,
  id: id ?? this.id,
  status: status ?? this.status,
  declinedCount: declinedCount ?? this.declinedCount,
  messageDetail: messageDetail ?? this.messageDetail,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['id'] = id;
    map['status'] = status;
    map['declinedCount'] = declinedCount;
    map['messageDetail'] = messageDetail;
    return map;
  }

}