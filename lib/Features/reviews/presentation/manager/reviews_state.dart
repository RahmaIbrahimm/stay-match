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