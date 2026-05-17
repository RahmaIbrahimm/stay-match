part of 'recommended_cubit.dart';

abstract class RecommendedState extends Equatable {}

class RecommendedInitial extends RecommendedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RecommendedLoading extends RecommendedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class RecommendedFailure extends RecommendedState {
  final String errMessage;

  RecommendedFailure({required this.errMessage});
  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}

class RecommendedSuccess extends RecommendedState {
  final RecommendedPropertiesResponse response;

  RecommendedSuccess({required this.response});

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}
class RecommendedMoreLoading extends RecommendedState {
  final RecommendedPropertiesResponse currentResponse;

  RecommendedMoreLoading({required this.currentResponse});

  @override
  List<Object?> get props => [currentResponse];
}