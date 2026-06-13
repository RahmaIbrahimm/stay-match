part of 'my_properties_cubit.dart';

@immutable
sealed class MyPropertiesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MyPropertiesInitial extends MyPropertiesState {}

final class MyPropertiesLoading extends MyPropertiesState {}

final class MyPropertiesSuccess extends MyPropertiesState {
  final MyPropertiesResponse? response;
  final String? successMessage;
  MyPropertiesSuccess({ this.response, this.successMessage});

  @override
  List<Object?> get props => [response];
}

final class MyPropertiesFailure extends MyPropertiesState {
  final String errMessage;

  MyPropertiesFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
final class MyPropertiesDeleteSuccess extends MyPropertiesState {
  final String successMessage;
  final int deletedId;
  MyPropertiesDeleteSuccess({required this.deletedId, required this.successMessage});

  @override
  List<Object?> get props => [successMessage,deletedId];
}