import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/reviews/data/models/review_recommendations.dart';
import 'package:stay_match/Features/reviews/data/models/write_review_request.dart';
import 'package:stay_match/Features/reviews/data/repos/reviews_repo.dart';

part 'write_review_state.dart';

class WriteReviewCubit extends Cubit<WriteReviewState> {
  final ReviewsRepo reviewsRepo;

  WriteReviewCubit({required this.reviewsRepo}) : super(WriteReviewInitial());

  Future<void> submitReview({required WriteReviewRequest request}) async {
    emit(WriteReviewLoading());

    final result = await reviewsRepo.writeReview(request: request);

    result.fold(
          (failure) => emit(WriteReviewFailure(errMessage: failure.errMessage)),
          (response) {
        if (response.isSuccess == true) {
          emit(WriteReviewSuccess(
              message: response.message ?? 'Review submitted successfully'));
        } else {
          emit(WriteReviewFailure(
              errMessage: response.message ?? 'Failed to submit review'));
        }
      },
    );
  }

  Future<void> fetchRecommendations() async {
    emit(RecommendationsLoading());

    final result = await reviewsRepo.getRecommendations();

    result.fold(
          (failure) =>
          emit(RecommendationsFailure(errMessage: failure.errMessage)),
          (response) {
        if (response.isSuccess == true) {
          emit(RecommendationsSuccess(recommendations: response));
        } else {
          emit(const RecommendationsFailure(
              errMessage: 'Failed to load recommendations'));
        }
      },
    );
  }
}