import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';

part 'room_details_state.dart';

class RoomDetailsCubit extends Cubit<RoomDetailsState> {
  final RoomsRepoImpl roomsRepo;

  late int _roomId;
  late int _propertyId;

  RoomDetailsCubit({required this.roomsRepo}) : super(RoomDetailsInitial());

  Future<void> fetchRoomDetails({
    required int roomId,
    required int propertyId,
  }) async {
    _roomId = roomId;
    _propertyId = propertyId;
    emit(RoomDetailsLoading());

    final result = await roomsRepo.getRoomDetails(
      roomid: roomId,
      propertyId: propertyId,
    );

    result.fold(
          (f) => emit(RoomDetailsFailure(errMessage: f.errMessage)),
          (r) {
        if (r.isSuccess == true && r.data != null) {
          emit(RoomDetailsSuccess(response: r));
        } else {
          emit(RoomDetailsFailure(
              errMessage: r.message ?? 'Failed to load room'));
        }
      },
    );
  }

  void retry() => fetchRoomDetails(roomId: _roomId, propertyId: _propertyId);
}