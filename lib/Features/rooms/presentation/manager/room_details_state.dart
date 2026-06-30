part of 'room_details_cubit.dart';

abstract class RoomDetailsState extends Equatable {
  const RoomDetailsState();
  @override
  List<Object?> get props => [];
}

class RoomDetailsInitial extends RoomDetailsState {}
class RoomDetailsLoading extends RoomDetailsState {}

class RoomDetailsSuccess extends RoomDetailsState {
  final RoomDetailsResponse response;
  const RoomDetailsSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}

class RoomDetailsFailure extends RoomDetailsState {
  final String errMessage;
  const RoomDetailsFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}