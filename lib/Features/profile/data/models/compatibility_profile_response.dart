/// error : "unauthorized"
/// message : "Authentication required"
/// completed : true
/// can_match : true
/// can_edit : true
/// needs_questionnaire : false
/// answered_questions : 13
/// total_questions : 13
/// completion_percentage : 100
/// missing_question_ids : []
/// last_updated : "2024-01-15T10:30:00Z"
/// about_me : "Software engineer who enjoys hiking and coffee"
/// compatibility_preferences : {"smoker":false,"night_owl":true}
/// housing_preferences : {"governorate":"Capital","budget":450}
/// vibe_check : {"cleanliness_level":{"value":3,"label":"Moderate"},"cultural_importance":{"value":2,"label":"Somewhat important"}}

class CompatibilityProfileResponse {
  CompatibilityProfileResponse({
      this.error, 
      this.message, 
      this.completed, 
      this.canMatch, 
      this.canEdit, 
      this.needsQuestionnaire, 
      this.answeredQuestions, 
      this.totalQuestions, 
      this.completionPercentage, 
      this.missingQuestionIds, 
      this.lastUpdated, 
      this.aboutMe, 
      this.compatibilityPreferences, 
      this.housingPreferences, 
      this.vibeCheck,});

  CompatibilityProfileResponse.fromJson(dynamic json) {
    error = json['error'];
    message = json['message'];
    completed = json['completed'];
    canMatch = json['can_match'];
    canEdit = json['can_edit'];
    needsQuestionnaire = json['needs_questionnaire'];
    answeredQuestions = json['answered_questions'];
    totalQuestions = json['total_questions'];
    completionPercentage = json['completion_percentage'];
    // todo:if (json['missing_question_ids'] != null) {
    //   missingQuestionIds = [];
    //   json['missing_question_ids'].forEach((v) {
    //     missingQuestionIds?.add(Dynamic.fromJson(v));
    //   });
    // }
    lastUpdated = json['last_updated'];
    aboutMe = json['about_me'];
    compatibilityPreferences = json['compatibility_preferences'] != null ? CompatibilityPreferences.fromJson(json['compatibility_preferences']) : null;
    housingPreferences = json['housing_preferences'] != null ? HousingPreferences.fromJson(json['housing_preferences']) : null;
    vibeCheck = json['vibe_check'] != null ? VibeCheck.fromJson(json['vibe_check']) : null;
  }
  String? error;
  String? message;
  bool? completed;
  bool? canMatch;
  bool? canEdit;
  bool? needsQuestionnaire;
  num? answeredQuestions;
  num? totalQuestions;
  num? completionPercentage;
  List<dynamic>? missingQuestionIds;
  String? lastUpdated;
  String? aboutMe;
  CompatibilityPreferences? compatibilityPreferences;
  HousingPreferences? housingPreferences;
  VibeCheck? vibeCheck;
CompatibilityProfileResponse copyWith({  String? error,
  String? message,
  bool? completed,
  bool? canMatch,
  bool? canEdit,
  bool? needsQuestionnaire,
  num? answeredQuestions,
  num? totalQuestions,
  num? completionPercentage,
  List<dynamic>? missingQuestionIds,
  String? lastUpdated,
  String? aboutMe,
  CompatibilityPreferences? compatibilityPreferences,
  HousingPreferences? housingPreferences,
  VibeCheck? vibeCheck,
}) => CompatibilityProfileResponse(  error: error ?? this.error,
  message: message ?? this.message,
  completed: completed ?? this.completed,
  canMatch: canMatch ?? this.canMatch,
  canEdit: canEdit ?? this.canEdit,
  needsQuestionnaire: needsQuestionnaire ?? this.needsQuestionnaire,
  answeredQuestions: answeredQuestions ?? this.answeredQuestions,
  totalQuestions: totalQuestions ?? this.totalQuestions,
  completionPercentage: completionPercentage ?? this.completionPercentage,
  missingQuestionIds: missingQuestionIds ?? this.missingQuestionIds,
  lastUpdated: lastUpdated ?? this.lastUpdated,
  aboutMe: aboutMe ?? this.aboutMe,
  compatibilityPreferences: compatibilityPreferences ?? this.compatibilityPreferences,
  housingPreferences: housingPreferences ?? this.housingPreferences,
  vibeCheck: vibeCheck ?? this.vibeCheck,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['message'] = message;
    map['completed'] = completed;
    map['can_match'] = canMatch;
    map['can_edit'] = canEdit;
    map['needs_questionnaire'] = needsQuestionnaire;
    map['answered_questions'] = answeredQuestions;
    map['total_questions'] = totalQuestions;
    map['completion_percentage'] = completionPercentage;
    if (missingQuestionIds != null) {
      map['missing_question_ids'] = missingQuestionIds?.map((v) => v.toJson()).toList();
    }
    map['last_updated'] = lastUpdated;
    map['about_me'] = aboutMe;
    if (compatibilityPreferences != null) {
      map['compatibility_preferences'] = compatibilityPreferences?.toJson();
    }
    if (housingPreferences != null) {
      map['housing_preferences'] = housingPreferences?.toJson();
    }
    if (vibeCheck != null) {
      map['vibe_check'] = vibeCheck?.toJson();
    }
    return map;
  }

}

/// cleanliness_level : {"value":3,"label":"Moderate"}
/// cultural_importance : {"value":2,"label":"Somewhat important"}

class VibeCheck {
  VibeCheck({
      this.cleanlinessLevel, 
      this.culturalImportance,});

  VibeCheck.fromJson(dynamic json) {
    cleanlinessLevel = json['cleanliness_level'] != null ? CleanlinessLevel.fromJson(json['cleanliness_level']) : null;
    culturalImportance = json['cultural_importance'] != null ? CulturalImportance.fromJson(json['cultural_importance']) : null;
  }
  CleanlinessLevel? cleanlinessLevel;
  CulturalImportance? culturalImportance;
VibeCheck copyWith({  CleanlinessLevel? cleanlinessLevel,
  CulturalImportance? culturalImportance,
}) => VibeCheck(  cleanlinessLevel: cleanlinessLevel ?? this.cleanlinessLevel,
  culturalImportance: culturalImportance ?? this.culturalImportance,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cleanlinessLevel != null) {
      map['cleanliness_level'] = cleanlinessLevel?.toJson();
    }
    if (culturalImportance != null) {
      map['cultural_importance'] = culturalImportance?.toJson();
    }
    return map;
  }

}

/// value : 2
/// label : "Somewhat important"

class CulturalImportance {
  CulturalImportance({
      this.value, 
      this.label,});

  CulturalImportance.fromJson(dynamic json) {
    value = json['value'];
    label = json['label'];
  }
  num? value;
  String? label;
CulturalImportance copyWith({  num? value,
  String? label,
}) => CulturalImportance(  value: value ?? this.value,
  label: label ?? this.label,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['label'] = label;
    return map;
  }

}

/// value : 3
/// label : "Moderate"

class CleanlinessLevel {
  CleanlinessLevel({
      this.value, 
      this.label,});

  CleanlinessLevel.fromJson(dynamic json) {
    value = json['value'];
    label = json['label'];
  }
  num? value;
  String? label;
CleanlinessLevel copyWith({  num? value,
  String? label,
}) => CleanlinessLevel(  value: value ?? this.value,
  label: label ?? this.label,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['label'] = label;
    return map;
  }

}

/// governorate : "Capital"
/// budget : 450

class HousingPreferences {
  HousingPreferences({
      this.governorate, 
      this.budget,});

  HousingPreferences.fromJson(dynamic json) {
    governorate = json['governorate'];
    budget = json['budget'];
  }
  String? governorate;
  num? budget;
HousingPreferences copyWith({  String? governorate,
  num? budget,
}) => HousingPreferences(  governorate: governorate ?? this.governorate,
  budget: budget ?? this.budget,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['governorate'] = governorate;
    map['budget'] = budget;
    return map;
  }

}

/// smoker : false
/// night_owl : true

class CompatibilityPreferences {
  CompatibilityPreferences({
      this.smoker, 
      this.nightOwl,
      this.hasPets,
  });

  CompatibilityPreferences.fromJson(dynamic json) {
    smoker = json['smoker'];
    nightOwl = json['night_owl'];
    hasPets = json['has_pets'];
  }
  bool? smoker;
  bool? nightOwl;
  bool? hasPets;
CompatibilityPreferences copyWith({  bool? smoker,
  bool? nightOwl,
}) => CompatibilityPreferences(  smoker: smoker ?? this.smoker,
  nightOwl: nightOwl ?? this.nightOwl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['smoker'] = smoker;
    map['night_owl'] = nightOwl;
    map['has_pets'] = hasPets;
    return map;
  }

}