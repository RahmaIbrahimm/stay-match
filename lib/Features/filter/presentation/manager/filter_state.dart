part of 'filter_cubit.dart';

sealed class FilterState extends Equatable {}

final class FilterInitial extends FilterState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class ApartmentFilterLoading extends FilterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class ApartmentFilterSuccess extends FilterState {
  final AllApartmentsResponse response;

  ApartmentFilterSuccess({required this.response});

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}
final class ApartmentFilterFailure extends FilterState {
  String errMessage;

  ApartmentFilterFailure({required this.errMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}

final class RoomsFilterLoading extends FilterState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class RoomsFilterSuccess extends FilterState {
  final GetAllRooms response;

  RoomsFilterSuccess({required this.response});

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}
final class RoomsFilterFailure extends FilterState {
  final String errMessage;

  RoomsFilterFailure({required this.errMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errMessage];
}