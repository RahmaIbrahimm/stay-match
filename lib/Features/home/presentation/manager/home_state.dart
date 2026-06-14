part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

final class HomeSuccess extends HomeState {
  final PropertiesGeneralSearch response;

  HomeSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class HomeFailure extends HomeState {
  final String errMessage;

  HomeFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}