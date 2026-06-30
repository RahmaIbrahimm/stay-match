/// error : "validation_error"
/// message : "Invalid request body"
/// details : {"field":"age_group","reason":"Value must be between 1 and 4"}
/// status : "ok"
/// user_id : "63a0c0e9-1aa2-415b-81c5-2338ea8fb559"
/// answers_count : 13

class AnswerQuestionsResponse {
  AnswerQuestionsResponse({
      this.error, 
      this.message, 
      this.details, 
      this.status, 
      this.userId, 
      this.answersCount,});

  AnswerQuestionsResponse.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    status = json['status'];
    userId = json['user_id'];
    answersCount = json['answers_count'];
  }
  String? error;
  String? message;
  Details? details;
  String? status;
  String? userId;
  num? answersCount;
AnswerQuestionsResponse copyWith({  String? error,
  String? message,
  Details? details,
  String? status,
  String? userId,
  num? answersCount,
}) => AnswerQuestionsResponse(  error: error ?? this.error,
  message: message ?? this.message,
  details: details ?? this.details,
  status: status ?? this.status,
  userId: userId ?? this.userId,
  answersCount: answersCount ?? this.answersCount,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    map['status'] = status;
    map['user_id'] = userId;
    map['answers_count'] = answersCount;
    return map;
  }

}

/// field : "age_group"
/// reason : "Value must be between 1 and 4"

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