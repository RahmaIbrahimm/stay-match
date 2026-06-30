import 'dart:convert';

/// questions : [{"category":{"id":1,"name_ar":"الخلفية الشخصية","name_en":"Personal Background"},"questions":[]}]

class GetQuestionsResponse {
  List<QuestionCategory>? questions;

  GetQuestionsResponse({this.questions});

  GetQuestionsResponse.fromJson(dynamic json) {
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(QuestionCategory.fromJson(v));
      });
    }
  }

  GetQuestionsResponse copyWith({
    List<QuestionCategory>? questions,
  }) =>
      GetQuestionsResponse(
        questions: questions ?? this.questions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// category : {"id":1,"name_ar":"الخلفية الشخصية","name_en":"Personal Background"}
/// questions : [{"id":1,"key":"age_group", ...}]

class QuestionCategory {
  Category? category;
  List<Question>? questions;

  QuestionCategory({this.category, this.questions});

  QuestionCategory.fromJson(dynamic json) {
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Question.fromJson(v));
      });
    }
  }

  QuestionCategory copyWith({
    Category? category,
    List<Question>? questions,
  }) =>
      QuestionCategory(
        category: category ?? this.category,
        questions: questions ?? this.questions,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name_ar : "الخلفية الشخصية"
/// name_en : "Personal Background"

class Category {
  num? id;
  String? nameAr;
  String? nameEn;

  Category({this.id, this.nameAr, this.nameEn});

  Category.fromJson(dynamic json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Category copyWith({
    num? id,
    String? nameAr,
    String? nameEn,
  }) =>
      Category(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_ar'] = nameAr;
    map['name_en'] = nameEn;
    return map;
  }
}

/// id : 1
/// key : "age_group"
/// question_ar : "ما هي فئتك العمرية؟"
/// question_en : "What is your age group?"
/// question_type : "ordered"
/// weight : 3
/// options : {"1":{"ar":"18-21","en":"18-21"}}

class Question {
  num? id;
  String? key;
  String? questionAr;
  String? questionEn;
  String? questionType;
  num? weight;
  Map<String, OptionValue>? options;

  Question({
    this.id,
    this.key,
    this.questionAr,
    this.questionEn,
    this.questionType,
    this.weight,
    this.options,
  });

  Question.fromJson(dynamic json) {
    id = json['id'];
    key = json['key'];
    questionAr = json['question_ar'];
    questionEn = json['question_en'];
    questionType = json['question_type'];
    weight = json['weight'];

    if (json['options'] != null) {
      options = {};
      json['options'].forEach((k, v) {
        options![k] = OptionValue.fromJson(v);
      });
    }
  }

  Question copyWith({
    num? id,
    String? key,
    String? questionAr,
    String? questionEn,
    String? questionType,
    num? weight,
    Map<String, OptionValue>? options,
  }) =>
      Question(
        id: id ?? this.id,
        key: key ?? this.key,
        questionAr: questionAr ?? this.questionAr,
        questionEn: questionEn ?? this.questionEn,
        questionType: questionType ?? this.questionType,
        weight: weight ?? this.weight,
        options: options ?? this.options,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['key'] = key;
    map['question_ar'] = questionAr;
    map['question_en'] = questionEn;
    map['question_type'] = questionType;
    map['weight'] = weight;
    if (options != null) {
      final optionsMap = <String, dynamic>{};
      options!.forEach((k, v) {
        optionsMap[k] = v.toJson();
      });
      map['options'] = optionsMap;
    }
    return map;
  }
}

/// ar : "18-21"
/// en : "18-21"

class OptionValue {
  String? ar;
  String? en;

  OptionValue({this.ar, this.en});

  OptionValue.fromJson(dynamic json) {
    ar = json['ar'];
    en = json['en'];
  }

  OptionValue copyWith({
    String? ar,
    String? en,
  }) =>
      OptionValue(
        ar: ar ?? this.ar,
        en: en ?? this.en,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ar'] = ar;
    map['en'] = en;
    return map;
  }
}