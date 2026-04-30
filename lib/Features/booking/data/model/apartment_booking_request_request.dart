/// propertyId : 0
/// startDate : "2026-04-29T20:38:01.790Z"
/// duration : 0
/// message : "string"

class ApartmentBookingRequestRequest {
  ApartmentBookingRequestRequest({
      this.propertyId, 
      this.startDate, 
      this.duration, 
      this.message,});

  ApartmentBookingRequestRequest.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    startDate = json['startDate'];
    duration = json['duration'];
    message = json['message'];
  }
  int? propertyId;
  String? startDate;
  int? duration;
  String? message;
ApartmentBookingRequestRequest copyWith({  int? propertyId,
  String? startDate,
  int? duration,
  String? message,
}) => ApartmentBookingRequestRequest(  propertyId: propertyId ?? this.propertyId,
  startDate: startDate ?? this.startDate,
  duration: duration ?? this.duration,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['startDate'] = startDate;
    map['duration'] = duration;
    map['message'] = message;
    return map;
  }

}