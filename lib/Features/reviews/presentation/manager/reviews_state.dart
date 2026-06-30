// part of 'reviews_cubit.dart';
//
// sealed class ReviewsState extends Equatable {
//   const ReviewsState();
// }
//
// final class ReviewsInitial extends ReviewsState {
//   @override
//   List<Object> get props => [];
// }
//
// final class ReviewsLoading extends ReviewsState {
//   @override
//   List<Object> get props => [];
// }
//
// final class ReviewsSuccess extends ReviewsState {
//   final GetPropertyReviews? apartmentReviews;
//
//   const ReviewsSuccess({this.apartmentReviews});
//
//   @override
//   List<Object> get props => [?apartmentReviews];
// }
//
// final class ReviewsFailure extends ReviewsState {
//   final String errMessage;
//
//   const ReviewsFailure({required this.errMessage});
//
//   @override
//   List<Object> get props => [errMessage];
// }
part of 'reviews_cubit.dart';

sealed class ReviewsState extends Equatable {
  const ReviewsState();
}

final class ReviewsInitial extends ReviewsState {
  @override
  List<Object> get props => [];
}

final class ReviewsLoading extends ReviewsState {
  @override
  List<Object> get props => [];
}

final class ReviewsSuccess extends ReviewsState {
  final GetPropertyReviews? apartmentReviews;

  const ReviewsSuccess({this.apartmentReviews});

  @override
  List<Object> get props => [?apartmentReviews];
}

final class ReviewsFailure extends ReviewsState {
  final String errMessage;

  const ReviewsFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

// ─── Host reply states ─────────────────────────────────────────
final class HostReplyLoading extends ReviewsState {
  final int reviewId;

  const HostReplyLoading({required this.reviewId});

  @override
  List<Object> get props => [reviewId];
}

final class HostReplySuccess extends ReviewsState {
  final int reviewId;
  final String response;

  const HostReplySuccess({required this.reviewId, required this.response});

  @override
  List<Object> get props => [reviewId, response];
}

final class HostReplyFailure extends ReviewsState {
  final int reviewId;
  final String errMessage;

  const HostReplyFailure({required this.reviewId, required this.errMessage});

  @override
  List<Object> get props => [reviewId, errMessage];
}