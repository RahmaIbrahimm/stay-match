/// isSuccess : true
/// message : "Request successful"
/// data : {"saved":true,"message":"Room saved successfully","type":"room","propertyId":138,"roomId":221,"propertyName":"شقة سكنية للطالبات - غرف مشتركة","roomName":"الغرفة الأولى (الزهور)"}

class RoomToggleSavedResponse {
  RoomToggleSavedResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  RoomToggleSavedResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
RoomToggleSavedResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => RoomToggleSavedResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// saved : true
/// message : "Room saved successfully"
/// type : "room"
/// propertyId : 138
/// roomId : 221
/// propertyName : "شقة سكنية للطالبات - غرف مشتركة"
/// roomName : "الغرفة الأولى (الزهور)"

class Data {
  Data({
      this.saved, 
      this.message, 
      this.type, 
      this.propertyId, 
      this.roomId, 
      this.propertyName, 
      this.roomName,});

  Data.fromJson(dynamic json) {
    saved = json['saved'];
    message = json['message'];
    type = json['type'];
    propertyId = json['propertyId'];
    roomId = json['roomId'];
    propertyName = json['propertyName'];
    roomName = json['roomName'];
  }
  bool? saved;
  String? message;
  String? type;
  int? propertyId;
  int? roomId;
  String? propertyName;
  String? roomName;
Data copyWith({  bool? saved,
  String? message,
  String? type,
  int? propertyId,
  int? roomId,
  String? propertyName,
  String? roomName,
}) => Data(  saved: saved ?? this.saved,
  message: message ?? this.message,
  type: type ?? this.type,
  propertyId: propertyId ?? this.propertyId,
  roomId: roomId ?? this.roomId,
  propertyName: propertyName ?? this.propertyName,
  roomName: roomName ?? this.roomName,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['saved'] = saved;
    map['message'] = message;
    map['type'] = type;
    map['propertyId'] = propertyId;
    map['roomId'] = roomId;
    map['propertyName'] = propertyName;
    map['roomName'] = roomName;
    return map;
  }

}