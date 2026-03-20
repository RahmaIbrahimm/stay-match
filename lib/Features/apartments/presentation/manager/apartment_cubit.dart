import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/all_apartments.dart';
import '../../data/repos/apartment_repo.dart';

part 'apartment_state.dart';

class ApartmentCubit extends Cubit<ApartmentsState> {
  ApartmentRepo apartmentRepo;

  ApartmentCubit(this.apartmentRepo) : super(ApartmentsInitial()) {
    _loadInitialData();
  }

  AllApartmentsResponse? _cachedResponse;

  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(GetApartmentsSuccess(response: _cachedResponse!));
    } else {
      await getAllApartments();
    }
  }

  // get all apartments
  // todo: add parameters for filter..
  Future<void> getAllApartments({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedResponse != null) {
      emit(GetApartmentsSuccess(response: _cachedResponse!));
      return;
    }

    emit(GetApartmentsLoading());

    try {
      var response = await apartmentRepo.getAllApartments();

      response.fold(
            (fail) {
          emit(GetApartmentsFailure(errMessage: fail.errMessage));
        },
            (response) {
          if (response.isSuccess == true) {
            _cachedResponse = response;
            emit(GetApartmentsSuccess(response: response));
          } else {
            emit(
              GetApartmentsFailure(
                errMessage: response.message ?? 'Error getting Apartments',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(GetApartmentsFailure(errMessage: e.toString()));
    }
  }

  Future<void> refreshApartments() async {
    await getAllApartments(forceRefresh: true);
  }

// get apartment details by id
}