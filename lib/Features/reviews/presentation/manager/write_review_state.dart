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