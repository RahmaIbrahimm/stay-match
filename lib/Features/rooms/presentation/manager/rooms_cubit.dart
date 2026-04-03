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

  Future<void> getAllRooms() async {
    log(
      'before : the token stored is: ${ await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey) ?? '--------> NO TOKEN WTFFFF'}',
    );
    emit(GetRoomsLoading());
    log('1.Started loading');
    // todo: search / filter impl
    var response = await roomsRepo.getAllRooms();

    response.fold(
      (fail) {
        log('Failure object: $fail');
        log('Failure type: ${fail.runtimeType}');
        log('Failure errMessage: ${fail.errMessage}');

        // Verify what we're emitting
        final errorMessage = fail.errMessage;
        log('Emitting error message: $errorMessage');

        emit(GetRoomsFailure(errMessage: fail.errMessage));
        log('2.error happened getting rooms');
      },
      (response) async {
        if (response.isSuccess == true) {
          emit(GetRoomsSuccess(response: response));
          log('2.SUCCESS');
          log(
            'after : the token stored is: ${await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey) ?? '--------> NO TOKEN WTFFFF'}',
          );
        } else {
          log(
            'after 2 : the token stored is: ${await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey) ?? '--------> NO TOKEN WTFFFF'}',
          );
          emit(
            GetRoomsFailure(
              errMessage: response.message ?? 'Error getting Rooms',
            ),
          );
          log('3.error');
          log(
            'after : the token stored is: ${await SecureStorageHelper.readFromSecureStorage(key: SecureStorageHelper.refreshTokenKey) ?? '--------> NO TOKEN WTFFFF'}',
          );
        }
      },
    );
  }
}