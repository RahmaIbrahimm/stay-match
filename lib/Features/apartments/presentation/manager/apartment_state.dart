part of 'apartment_cubit.dart';

@immutable
sealed class ApartmentsState extends Equatable {}

final class ApartmentsInitial extends ApartmentsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// get all apartments
final class GetApartmentsLoading extends ApartmentsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetApartmentsSuccess extends ApartmentsState {
  final AllApartmentsResponse response;
  GetApartmentsSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}

final class GetApartmentsFailure extends ApartmentsState {
  final String errMessage;
  GetApartmentsFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}