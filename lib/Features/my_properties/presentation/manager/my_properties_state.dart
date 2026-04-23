part of 'my_properties_cubit.dart';

@immutable
sealed class MyPropertiesState extends Equatable {}

final class MyPropertiesInitial extends MyPropertiesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class MyPropertiesLoading extends MyPropertiesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class MyPropertiesSuccess extends MyPropertiesState {
  final MyPropertiesResponse response;

  MyPropertiesSuccess({required this.response});

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}

final class MyPropertiesFailure extends MyPropertiesState {
  final String errMessage;

  MyPropertiesFailure({required this.errMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}