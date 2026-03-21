
part of 'rooms_cubit.dart';


sealed class RoomsState extends Equatable{}

final class RoomsInitial extends RoomsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// get all rooms
final class GetRoomsLoading extends RoomsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class GetRoomsSuccess extends RoomsState {
  final GetAllRooms response;
  GetRoomsSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}
final class GetRoomsFailure extends RoomsState {
  final String errMessage;
  GetRoomsFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}