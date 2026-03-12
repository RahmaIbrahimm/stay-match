part of 'apartment_cubit.dart';

@immutable
sealed class ApartmentsState extends Equatable{}

final class ApartmentsInitial extends ApartmentsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// get all apartments
final class GetPropertiesLoading extends ApartmentsState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class GetPropertiesSuccess extends ApartmentsState {
  final GetAllApartments response;
  GetPropertiesSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}
final class GetPropertiesFailure extends ApartmentsState {
  final String errMessage;
  GetPropertiesFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}