import 'package:flutter/material.dart';

import '../manager/questions_state.dart';

/// Checks if all questions in the current category step have been answered
bool isCurrentStepValid(dynamic state) {
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