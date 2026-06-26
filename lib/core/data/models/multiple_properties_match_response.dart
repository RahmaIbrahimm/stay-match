/// matches : [{"property_id":456,"property_match_score":78.2},{"property_id":457,"property_match_score":65.4},{"property_id":458,"property_match_score":82.1}]
/// error : "validation_error"
/// message : "Invalid request body"
/// details : {"field":"property_ids","reason":"Must be a non-empty list of integers"}

class MultiplePropertiesMatchResponse {
  MultiplePropertiesMatchResponse({
      this.matches, 
      this.error, 
      this.message, 
      this.details,});

  MultiplePropertiesMatchResponse.fromJson(dynamic json) {
    if (json['matches'] != null) {
      matches = [];
      json['matches'].forEach((v) {
        matches?.add(Matches.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  List<Matches>? matches;
  String? error;
  String? message;
  Details? details;
MultiplePropertiesMatchResponse copyWith({  List<Matches>? matches,
  String? error,
  String? message,
  Details? details,
}) => MultiplePropertiesMatchResponse(  matches: matches ?? this.matches,
  error: error ?? this.error,
  message: message ?? this.message,
  details: details ?? this.details,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (matches != null) {
      map['matches'] = matches?.map((v) => v.toJson()).toList();
    }
    map['error'] = error;
    map['message'] = message;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }

}

/// field : "property_ids"
/// reason : "Must be a non-empty list of integers"

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

/// property_id : 456
/// property_match_score : 78.2

class Matches {
  Matches({
      this.propertyId, 
      this.propertyMatchScore,});

  Matches.fromJson(dynamic json) {
    propertyId = json['property_id'];
    propertyMatchScore = json['property_match_score'];
  }
  num? propertyId;
  num? propertyMatchScore;
Matches copyWith({  num? propertyId,
  num? propertyMatchScore,
}) => Matches(  propertyId: propertyId ?? this.propertyId,
  propertyMatchScore: propertyMatchScore ?? this.propertyMatchScore,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_id'] = propertyId;
    map['property_match_score'] = propertyMatchScore;
    return map;
  }

}