
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/shared/models/property_details_response.dart';

import '../../data/models/room_details_response.dart';

sealed class RoomDetailsState extends Equatable {
  const RoomDetailsState();

  @override
  List<Object?> get props => [];
}

final class RoomDetailsInitial extends RoomDetailsState {
  const RoomDetailsInitial();
}

final class GetRoomDetailsLoading extends RoomDetailsState {
  const GetRoomDetailsLoading();
}

final class GetRoomDetailsSuccess extends RoomDetailsState {
  final PropertyDetailsResponse response;

  const GetRoomDetailsSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

final class GetRoomDetailsFailure extends RoomDetailsState {
  final String errMessage;

  const GetRoomDetailsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}