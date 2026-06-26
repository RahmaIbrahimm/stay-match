/// property_id : 456
/// property_match_score : 78.2
/// rooms : [{"room_id":123,"room_match_score":85.5},{"room_id":124,"room_match_score":72.3}]
/// error : "validation_error"
/// message : "Invalid request parameters"
/// details : {"field":"property_id","reason":"Must be a valid integer"}

class OnePropertyMatchResponse {
  OnePropertyMatchResponse({
      this.propertyId, 
      this.propertyMatchScore, 
      this.rooms, 
      this.error, 
      this.message, 
      this.details,});

  OnePropertyMatchResponse.fromJson(dynamic json) {
    propertyId = json['property_id'];
    propertyMatchScore = json['property_match_score'];
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(Rooms.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  num? propertyId;
  num? propertyMatchScore;
  List<Rooms>? rooms;
  String? error;
  String? message;
  Details? details;
OnePropertyMatchResponse copyWith({  num? propertyId,
  num? propertyMatchScore,
  List<Rooms>? rooms,
  String? error,
  String? message,
  Details? details,
}) => OnePropertyMatchResponse(  propertyId: propertyId ?? this.propertyId,
  propertyMatchScore: propertyMatchScore ?? this.propertyMatchScore,
  rooms: rooms ?? this.rooms,
  error: error ?? this.error,
  message: message ?? this.message,
  details: details ?? this.details,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_id'] = propertyId;
    map['property_match_score'] = propertyMatchScore;
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    map['error'] = error;
    map['message'] = message;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }

}

/// field : "property_id"
/// reason : "Must be a valid integer"

class Details {
  Details({
      this.field, 
      this.reason,});

  Details.fromJson(dynamic json) {
    field = json['field'];
    reason = json['reason'];
  }
  String? field;
  String? reason;
Details copyWith({  String? field,
  String? reason,
}) => Details(  field: field ?? this.field,
  reason: reason ?? this.reason,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['field'] = field;
    map['reason'] = reason;
    return map;
  }

}

/// room_id : 123
/// room_match_score : 85.5

class Rooms {
  Rooms({
      this.roomId, 
      this.roomMatchScore,});

  Rooms.fromJson(dynamic json) {
    roomId = json['room_id'];
    roomMatchScore = json['room_match_score'];
  }
  num? roomId;
  num? roomMatchScore;
Rooms copyWith({  num? roomId,
  num? roomMatchScore,
}) => Rooms(  roomId: roomId ?? this.roomId,
  roomMatchScore: roomMatchScore ?? this.roomMatchScore,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['room_id'] = roomId;
    map['room_match_score'] = roomMatchScore;
    return map;
  }

}