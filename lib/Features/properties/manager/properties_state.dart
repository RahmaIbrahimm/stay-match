part of 'properties_cubit.dart';

@immutable
sealed class PropertiesState extends Equatable{}

final class PropertiesInitial extends PropertiesState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// get all apartments
final class GetPropertiesLoading extends PropertiesState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class GetPropertiesSuccess extends PropertiesState {
  final GetAllApartments response;
  GetPropertiesSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}
final class GetPropertiesFailure extends PropertiesState {
  final String errMessage;
  GetPropertiesFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}