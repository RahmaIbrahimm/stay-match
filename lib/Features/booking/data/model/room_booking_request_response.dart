/// isSuccess : true
/// message : "Request successful"
/// data : {"id":85,"startDate":"2026-04-30T21:05:26.04Z","endDate":"2026-07-29T21:05:26.04Z","duration":3,"totalPrice":9000,"status":"Pending","roomName":"الغرفة الأولى (الزهور)","propertyName":"شقة سكنية للطالبات - غرف مشتركة","message":"Room booking request sent successfully"}

class RoomBookingRequestResponse {
  RoomBookingRequestResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  RoomBookingRequestResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
RoomBookingRequestResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => RoomBookingRequestResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// id : 85
/// startDate : "2026-04-30T21:05:26.04Z"
/// endDate : "2026-07-29T21:05:26.04Z"
/// duration : 3
/// totalPrice : 9000
/// status : "Pending"
/// roomName : "الغرفة الأولى (الزهور)"
/// propertyName : "شقة سكنية للطالبات - غرف مشتركة"
/// message : "Room booking request sent successfully"

class Data {
  Data({
      this.id, 
      this.startDate, 
      this.endDate, 
      this.duration, 
      this.totalPrice, 
      this.status, 
      this.roomName, 
      this.propertyName, 
      this.message,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    roomName = json['roomName'];
    propertyName = json['propertyName'];
    message = json['message'];
  }
  int? id;
  String? startDate;
  String? endDate;
  int? duration;
  int? totalPrice;
  String? status;
  String? roomName;
  String? propertyName;
  String? message;
Data copyWith({  int? id,
  String? startDate,
  String? endDate,
  int? duration,
  int? totalPrice,
  String? status,
  String? roomName,
  String? propertyName,
  String? message,
}) => Data(  id: id ?? this.id,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  duration: duration ?? this.duration,
  totalPrice: totalPrice ?? this.totalPrice,
  status: status ?? this.status,
  roomName: roomName ?? this.roomName,
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
    map['roomName'] = roomName;
    map['propertyName'] = propertyName;
    map['message'] = message;
    return map;
  }

}