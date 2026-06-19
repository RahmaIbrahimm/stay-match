// questions_cubit.dart
import 'package:flutter/material.dart%20';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/answer_questions_request.dart';
import '../manager/questions_state.dart';
import '../../data/repos/questions_repo.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final QuestionsRepo questionsRepo;

  QuestionsCubit({required this.questionsRepo}) : super(QuestionsInitial()){
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    emit(QuestionsLoading());
    var result = await questionsRepo.getQuestions();
    result.fold(
          (failure) => emit(QuestionsFailure(failure.errMessage)),
          (response) => emit(QuestionsSuccess(
        categories: response.questions ?? [],
        currentStep: 0,
        selectedAnswers: {},
      )),
    );
  }

  void selectOption(String questionKey, String optionKey) {
    if (state is QuestionsSuccess) {
      final currentState = state as QuestionsSuccess;
      final updatedAnswers = Map<String, String>.from(currentState.selectedAnswers);
      updatedAnswers[questionKey] = optionKey;

      emit(currentState.copyWith(selectedAnswers: updatedAnswers));
    }
  }
  Future<void> submitAnswers() async {
    if (state is QuestionsSuccess) {
      final currentState = state as QuestionsSuccess;
      final answers = currentState.selectedAnswers;

      // Map the generic string map entries cleanly into your explicit AnswerQuestionsRequest model fields
      final request = AnswerQuestionsRequest(
        ageGroup: int.tryParse(answers['age_group'] ?? ''),
        biggestSharedLivingIssue: int.tryParse(answers['biggest_shared_living_issue'] ?? ''),
        busiestTime: int.tryParse(answers['busiest_time'] ?? ''),
        firstActivityHome: int.tryParse(answers['first_activity_home'] ?? ''),
        flexibilityLevel: int.tryParse(answers['flexibility_level'] ?? ''),
        freeDayStyle: int.tryParse(answers['free_day_style'] ?? ''),
        groupActivityPreference: int.tryParse(answers['group_activity_preference'] ?? ''),
        messTolerance: int.tryParse(answers['mess_tolerance'] ?? ''),
        occupationStatus: int.tryParse(answers['occupation_status'] ?? ''),
        sleepTime: int.tryParse(answers['sleep_time'] ?? ''),
        smokingPreference: int.tryParse(answers['smoking_preference'] ?? ''),
        studyEnvironment: int.tryParse(answers['study_environment'] ?? ''),
        studyOrWorkField: int.tryParse(answers['study_or_work_field'] ?? ''),
      );

      final result = await questionsRepo.answerQuestions(request: request);

      result.fold(
            (failure) {
          emit(QuestionsFailure(failure.errMessage));
        },
            (response) {
          emit(QuestionsSubmissionSuccess(response));
        },
      );
    }
  }

  void nextStep() {
    if (state is QuestionsSuccess) {
      final currentState = state as QuestionsSuccess;
      if (currentState.currentStep < currentState.categories.length - 1) {
        emit(currentState.copyWith(currentStep: currentState.currentStep + 1));
      }
    }
  }

  void previousStep() {
    if (state is QuestionsSuccess) {
      final currentState = state as QuestionsSuccess;
      if (currentState.currentStep > 0) {
        emit(currentState.copyWith(currentStep: currentState.currentStep - 1));
      }
    }
  }
  /// Checks if all questions in the current category step have been answered
  bool isCurrentStepValid() {
    if (state is QuestionsSuccess) {
      final currentState = state as QuestionsSuccess;

      // Get the questions specifically for the active step
      final currentCategory = currentState.categories[currentState.currentStep];
      final currentQuestions = currentCategory.questions ?? [];

      // Ensure every question key is present in the selectedAnswers map
      for (final question in currentQuestions) {
        if (question.key == null || !currentState.selectedAnswers.containsKey(question.key)) {
          return false; // Found an unanswered question
        }
      }
      return true; // All questions answered!
    }
    return false;
  }

  /// Optional: Trigger a validation failure state if needed,
  /// or simply return a boolean to show a SnackBar in the UI.
  void triggerValidationError(String message) {
    // You can use this to temporarily show a validation error message banner
    ScaffoldMessengerState();
  }
}