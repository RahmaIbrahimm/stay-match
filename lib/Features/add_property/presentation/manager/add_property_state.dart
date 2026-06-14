part of 'add_property_cubit.dart';

sealed class AddPropertyState extends Equatable {}

final class AddPropertyInitial extends AddPropertyState {
  @override
  List<Object?> get props => [];
}

final class AddPropertyLoading extends AddPropertyState {
  @override
  List<Object?> get props => [];
}

// Used to refresh the UI during the multi-step form process
final class AddPropertyFormUpdated extends AddPropertyState {
  final DateTime lastUpdate;
  AddPropertyFormUpdated(this.lastUpdate);
  @override
  List<Object?> get props => [lastUpdate];
}

final class AddPropertySuccess extends AddPropertyState {
  final String message;
  AddApartmentResponse? addApartmentResponse;
  AddRoomResponse? addRoomResponse;
  AddPropertySuccess({required this.message,this.addApartmentResponse,this.addRoomResponse});
  @override
  List<Object?> get props => [message,addApartmentResponse,addRoomResponse];
}

final class AddPropertyFailure extends AddPropertyState {
  final String errMessage;
  AddPropertyFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}