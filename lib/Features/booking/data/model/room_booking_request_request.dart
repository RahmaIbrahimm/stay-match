/// propertyId : 138
/// roomId : 221
/// startDate : "2026-04-30T21:05:26.040Z"
/// duration : 3
/// message : "string"

class RoomBookingRequestRequest {
  RoomBookingRequestRequest({
      this.propertyId, 
      this.roomId, 
      this.startDate, 
      this.duration, 
      this.message,});

  RoomBookingRequestRequest.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    roomId = json['roomId'];
    startDate = json['startDate'];
    duration = json['duration'];
    message = json['message'];
  }
  int? propertyId;
  int? roomId;
  String? startDate;
  int? duration;
  String? message;
RoomBookingRequestRequest copyWith({  int? propertyId,
  int? roomId,
  String? startDate,
  int? duration,
  String? message,
}) => RoomBookingRequestRequest(  propertyId: propertyId ?? this.propertyId,
  roomId: roomId ?? this.roomId,
  startDate: startDate ?? this.startDate,
  duration: duration ?? this.duration,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['roomId'] = roomId;
    map['startDate'] = startDate;
    map['duration'] = duration;
    map['message'] = message;
    return map;
  }

}