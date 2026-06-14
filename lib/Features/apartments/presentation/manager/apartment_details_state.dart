part of 'apartment_details_cubit.dart';

sealed class ApartmentDetailsState extends Equatable {
  const ApartmentDetailsState();

  @override
  List<Object?> get props => [];
}

final class ApartmentDetailsInitial extends ApartmentDetailsState {
  const ApartmentDetailsInitial();
}

final class GetApartmentDetailsLoading extends ApartmentDetailsState {
  const GetApartmentDetailsLoading();
}

final class GetApartmentDetailsSuccess extends ApartmentDetailsState {
  final PropertyDetailsResponse response;

  const GetApartmentDetailsSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class GetApartmentDetailsFailure extends ApartmentDetailsState {
  final String errMessage;

  const GetApartmentDetailsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}