/// Roomid : 0
/// PropertyId : 0

class ApartmentDetailsRequest {
  ApartmentDetailsRequest({this.roomid, this.propertyId});

  ApartmentDetailsRequest.fromJson(dynamic json) {
    roomid = json['Roomid'];
    propertyId = json['PropertyId'];
  }
  int? roomid;
  int? propertyId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Roomid'] = roomid;
    map['PropertyId'] = propertyId;
    return map;
  }
}