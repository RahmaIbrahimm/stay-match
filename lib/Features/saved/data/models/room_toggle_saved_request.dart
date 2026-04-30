/// propertyId : 0
/// roomId : 0

class RoomToggleSavedRequest {
  RoomToggleSavedRequest({
      this.propertyId, 
      this.roomId,});

  RoomToggleSavedRequest.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    roomId = json['roomId'];
  }
  int? propertyId;
  int? roomId;
RoomToggleSavedRequest copyWith({  int? propertyId,
  int? roomId,
}) => RoomToggleSavedRequest(  propertyId: propertyId ?? this.propertyId,
  roomId: roomId ?? this.roomId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['roomId'] = roomId;
    return map;
  }

}