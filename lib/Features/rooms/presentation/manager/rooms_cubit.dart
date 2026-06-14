import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/secure_storage_helper.dart';
import '../../data/models/get_all_rooms.dart';
import '../../data/repos/rooms_repo.dart';

part 'rooms_state.dart';

class RoomsCubit extends Cubit<RoomsState> {
  RoomsRepo roomsRepo;

  RoomsCubit(this.roomsRepo) : super(RoomsInitial()) {
    _loadInitialData();
  }

  GetAllRooms? _cachedResponse;

  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(GetRoomsSuccess(response: _cachedResponse!));
    } else {
      await getAllRooms();
    }
  }

  Future<void> getAllRooms({bool forceRefresh = false}) async {
    emit(GetRoomsLoading());
    var response = await roomsRepo.getAllRooms();
    response.fold(
      (fail) {
        emit(GetRoomsFailure(errMessage: fail.errMessage));
        log('2.error happened getting rooms');
      },
      (response) async {
        if (response.isSuccess == true) {
          emit(GetRoomsSuccess(response: response));
        } else {
          emit(
            GetRoomsFailure(
              errMessage: response.message ?? 'Error getting Rooms',
            ),
          );
        }
      },
    );
  }

  Future<void> refreshRooms() async {
    await getAllRooms(forceRefresh: true);
  }
}