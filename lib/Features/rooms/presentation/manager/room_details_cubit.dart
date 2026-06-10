import 'package:bloc/bloc.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo.dart';
import 'package:stay_match/Features/rooms/presentation/manager/room_details_state.dart';

import '../../../shared/models/property_details_response.dart';


class RoomDetailsCubit extends Cubit<RoomDetailsState> {
  final RoomsRepo roomsRepo;
  final int id;
  RoomDetailsCubit({required this.roomsRepo, required this.id}) : super(RoomDetailsInitial()){
    _loadInitialData();
  }
  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(GetRoomDetailsSuccess(response: _cachedResponse!));
    } else {
      await getPropertyDetails(id: id);
    }
  }
  PropertyDetailsResponse? _cachedResponse;

  Future<void> getPropertyDetails({required int id}) async {
    emit(GetRoomDetailsLoading());

    try {
      var response = await roomsRepo.getRoomDetails(id: id);

      response.fold(
            (fail) {
          emit(GetRoomDetailsFailure(errMessage: fail.errMessage));
        },
            (response) {
          if (response.isSuccess == true) {
            _cachedResponse = response;
            emit(GetRoomDetailsSuccess(response: response));
          } else {
            emit(
              GetRoomDetailsFailure(
                errMessage:
                response.message ?? 'Error getting Apartment Details',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(GetRoomDetailsFailure(errMessage: e.toString()));
    }
  }

}