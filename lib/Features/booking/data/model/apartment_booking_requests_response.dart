/// isSuccess : true
/// message : "Request successful"
/// data : {"id":84,"startDate":"2026-04-30T20:38:01.79Z","endDate":"2026-06-29T20:38:01.79Z","duration":2,"totalPrice":468,"status":"Pending","propertyType":"Entire","propertyName":"asdfasdasdf","message":"Apartment booking request sent successfully"}

class ApartmentBookingRequestResponse {
  ApartmentBookingRequestResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  ApartmentBookingRequestResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? ApartmentBookingRequestResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  ApartmentBookingRequestResponseData? data;
ApartmentBookingRequestResponse copyWith({  bool? isSuccess,
  String? message,
  ApartmentBookingRequestResponseData? data,
}) => ApartmentBookingRequestResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// id : 84
/// startDate : "2026-04-30T20:38:01.79Z"
/// endDate : "2026-06-29T20:38:01.79Z"
/// duration : 2
/// totalPrice : 468
/// status : "Pending"
/// propertyType : "Entire"
/// propertyName : "asdfasdasdf"
/// message : "Apartment booking request sent successfully"

class ApartmentBookingRequestResponseData {
  ApartmentBookingRequestResponseData({
      this.id, 
      this.startDate, 
      this.endDate, 
      this.duration, 
      this.totalPrice, 
      this.status, 
      this.propertyType, 
      this.propertyName, 
      this.message,});

  ApartmentBookingRequestResponseData.fromJson(dynamic json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    propertyType = json['propertyType'];
    propertyName = json['propertyName'];
    message = json['message'];
  }
  int? id;
  String? startDate;
  String? endDate;
  int? duration;
  num? totalPrice;
  String? status;
  String? propertyType;
  String? propertyName;
  String? message;
ApartmentBookingRequestResponseData copyWith({  int? id,
  String? startDate,
  String? endDate,
  int? duration,
  int? totalPrice,
  String? status,
  String? propertyType,
  String? propertyName,
  String? message,
}) => ApartmentBookingRequestResponseData(  id: id ?? this.id,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  duration: duration ?? this.duration,
  totalPrice: totalPrice ?? this.totalPrice,
  status: status ?? this.status,
  propertyType: propertyType ?? this.propertyType,
  propertyName: propertyName ?? this.propertyName,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['duration'] = duration;
    map['totalPrice'] = totalPrice;
    map['status'] = status;
    map['propertyType'] = propertyType;
    map['propertyName'] = propertyName;
    map['message'] = message;
    return map;
  }

}