// part of 'write_review_cubit.dart';
//
// abstract class WriteReviewState extends Equatable {
//   const WriteReviewState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class WriteReviewInitial extends WriteReviewState {}
//
// class WriteReviewLoading extends WriteReviewState {}
//
// class WriteReviewSuccess extends WriteReviewState {
//   final String message;
//
//   const WriteReviewSuccess({required this.message});
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class WriteReviewFailure extends WriteReviewState {
//   final String errMessage;
//
//   const WriteReviewFailure({required this.errMessage});
//
//   @override
//   List<Object?> get props => [errMessage];
// }
part of 'write_review_cubit.dart';

abstract class WriteReviewState extends Equatable {
  const WriteReviewState();

  @override
  List<Object?> get props => [];
}

class WriteReviewInitial extends WriteReviewState {}

class WriteReviewLoading extends WriteReviewState {}

class WriteReviewSuccess extends WriteReviewState {
  final String message;

  const WriteReviewSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class WriteReviewFailure extends WriteReviewState {
  final String errMessage;

  const WriteReviewFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

// ── Recommendations ───────────────────────────────────────────────────────────

class RecommendationsLoading extends WriteReviewState {}

class RecommendationsSuccess extends WriteReviewState {
  final ReviewRecommendations recommendations;

  const RecommendationsSuccess({required this.recommendations});

  @override
  List<Object?> get props => [recommendations];
}

class RecommendationsFailure extends WriteReviewState {
  final String errMessage;

  const RecommendationsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}