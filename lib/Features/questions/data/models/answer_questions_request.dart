/// age_group : 2
/// biggest_shared_living_issue : 2
/// busiest_time : 2
/// first_activity_home : 2
/// flexibility_level : 3
/// free_day_style : 2
/// group_activity_preference : 3
/// mess_tolerance : 3
/// occupation_status : 1
/// sleep_time : 3
/// smoking_preference : 1
/// study_environment : 2
/// study_or_work_field : 3

class AnswerQuestionsRequest {
  AnswerQuestionsRequest({
      this.ageGroup, 
      this.biggestSharedLivingIssue, 
      this.busiestTime, 
      this.firstActivityHome, 
      this.flexibilityLevel, 
      this.freeDayStyle, 
      this.groupActivityPreference, 
      this.messTolerance, 
      this.occupationStatus, 
      this.sleepTime, 
      this.smokingPreference, 
      this.studyEnvironment, 
      this.studyOrWorkField,});

  AnswerQuestionsRequest.fromJson(dynamic json) {
    ageGroup = json['age_group'];
    biggestSharedLivingIssue = json['biggest_shared_living_issue'];
    busiestTime = json['busiest_time'];
    firstActivityHome = json['first_activity_home'];
    flexibilityLevel = json['flexibility_level'];
    freeDayStyle = json['free_day_style'];
    groupActivityPreference = json['group_activity_preference'];
    messTolerance = json['mess_tolerance'];
    occupationStatus = json['occupation_status'];
    sleepTime = json['sleep_time'];
    smokingPreference = json['smoking_preference'];
    studyEnvironment = json['study_environment'];
    studyOrWorkField = json['study_or_work_field'];
  }
  num? ageGroup;
  num? biggestSharedLivingIssue;
  num? busiestTime;
  num? firstActivityHome;
  num? flexibilityLevel;
  num? freeDayStyle;
  num? groupActivityPreference;
  num? messTolerance;
  num? occupationStatus;
  num? sleepTime;
  num? smokingPreference;
  num? studyEnvironment;
  num? studyOrWorkField;
AnswerQuestionsRequest copyWith({  num? ageGroup,
  num? biggestSharedLivingIssue,
  num? busiestTime,
  num? firstActivityHome,
  num? flexibilityLevel,
  num? freeDayStyle,
  num? groupActivityPreference,
  num? messTolerance,
  num? occupationStatus,
  num? sleepTime,
  num? smokingPreference,
  num? studyEnvironment,
  num? studyOrWorkField,
}) => AnswerQuestionsRequest(  ageGroup: ageGroup ?? this.ageGroup,
  biggestSharedLivingIssue: biggestSharedLivingIssue ?? this.biggestSharedLivingIssue,
  busiestTime: busiestTime ?? this.busiestTime,
  firstActivityHome: firstActivityHome ?? this.firstActivityHome,
  flexibilityLevel: flexibilityLevel ?? this.flexibilityLevel,
  freeDayStyle: freeDayStyle ?? this.freeDayStyle,
  groupActivityPreference: groupActivityPreference ?? this.groupActivityPreference,
  messTolerance: messTolerance ?? this.messTolerance,
  occupationStatus: occupationStatus ?? this.occupationStatus,
  sleepTime: sleepTime ?? this.sleepTime,
  smokingPreference: smokingPreference ?? this.smokingPreference,
  studyEnvironment: studyEnvironment ?? this.studyEnvironment,
  studyOrWorkField: studyOrWorkField ?? this.studyOrWorkField,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age_group'] = ageGroup;
    map['biggest_shared_living_issue'] = biggestSharedLivingIssue;
    map['busiest_time'] = busiestTime;
    map['first_activity_home'] = firstActivityHome;
    map['flexibility_level'] = flexibilityLevel;
    map['free_day_style'] = freeDayStyle;
    map['group_activity_preference'] = groupActivityPreference;
    map['mess_tolerance'] = messTolerance;
    map['occupation_status'] = occupationStatus;
    map['sleep_time'] = sleepTime;
    map['smoking_preference'] = smokingPreference;
    map['study_environment'] = studyEnvironment;
    map['study_or_work_field'] = studyOrWorkField;
    return map;
  }

}