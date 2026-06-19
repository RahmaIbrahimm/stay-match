// // questions_state.dart
// import '../../data/models/get_questions_response.dart';
//
// abstract class QuestionsState {}
//
// class QuestionsInitial extends QuestionsState {}
// class QuestionsLoading extends QuestionsState {}
// class QuestionsSuccess extends QuestionsState {
//   final List<QuestionCategory> categories;
//   final int currentStep; // 0, 1, 2, 3 maps to Steps 1, 2, 3, 4
//   final Map<String, String> selectedAnswers; // { 'age_group': '1' }
//   final bool isSubmitting;
//
//   QuestionsSuccess({
//     required this.categories,
//     required this.currentStep,
//     required this.selectedAnswers,
//     this.isSubmitting = false,
//   });
//
//   QuestionsSuccess copyWith({
//     List<QuestionCategory>? categories,
//     int? currentStep,
//     Map<String, String>? selectedAnswers,
//     bool? isSubmitting,
//   }) {
//     return QuestionsSuccess(
//       categories: categories ?? this.categories,
//       currentStep: currentStep ?? this.currentStep,
//       selectedAnswers: selectedAnswers ?? this.selectedAnswers,
//       isSubmitting: isSubmitting ?? this.isSubmitting,
//     );
//   }
// }
// class QuestionsFailure extends QuestionsState {
//   final String errorMessage;
//   QuestionsFailure(this.errorMessage);
// }

import '../../data/models/get_questions_response.dart';
import '../../data/models/answer_questions_response.dart';

abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsFailure extends QuestionsState {
  final String errorMessage;
  QuestionsFailure(this.errorMessage);
}

class QuestionsSuccess extends QuestionsState {
  final List<QuestionCategory> categories;
  final int currentStep;
  final Map<String, String> selectedAnswers;

  QuestionsSuccess({
    required this.categories,
    required this.currentStep,
    required this.selectedAnswers,
  });

  QuestionsSuccess copyWith({
    List<QuestionCategory>? categories,
    int? currentStep,
    Map<String, String>? selectedAnswers,
  }) {
    return QuestionsSuccess(
      categories: categories ?? this.categories,
      currentStep: currentStep ?? this.currentStep,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
    );
  }
}

// Added state variant to capture final API confirmation mapping
class QuestionsSubmissionSuccess extends QuestionsState {
  final AnswerQuestionsResponse response;
  QuestionsSubmissionSuccess(this.response);
}