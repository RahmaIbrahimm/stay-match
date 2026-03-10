import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart%20';
import 'package:meta/meta.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/features/properties/data/models/get_all_apartments.dart';
import 'package:stay_match/features/properties/data/repos/properties_repo.dart';

part 'properties_state.dart';

class PropertiesCubit extends Cubit<PropertiesState> {
  PropertiesRepo propertiesRepo;

  PropertiesCubit(this.propertiesRepo) : super(PropertiesInitial());
  List<Data> apartments = [];

  // get all apartments
  // todo: add parameters for filter..
  Future<void> getAllApartments() async {
    log('before : the token stored is: ${SecureStorageHelper.token ??  '--------> NO TOKEN WTFFFF'}');
    emit(GetPropertiesLoading());
    log('1.Started loading');
    var response = await propertiesRepo.getAllApartments();

    response.fold(
      (fail) {
        emit(GetPropertiesFailure(errMessage: fail.errMessage));
        log('2.error happened');
      },
      (response) {
        if (response.isSuccess == true) {
          emit(GetPropertiesSuccess(response: response));
          log('2.SUCCESS');
          log('after : the token stored is: ${SecureStorageHelper.token ??  '--------> NO TOKEN WTFFFF'}');
        } else {
          log('after 2 : the token stored is: ${SecureStorageHelper.token ??  '--------> NO TOKEN WTFFFF'}');
          emit(
            GetPropertiesFailure(
              errMessage: response.message ?? 'Error getting Apartments',
            ),
          );
          log('3.error');
          log('after : the token stored is: ${SecureStorageHelper.token ??  '--------> NO TOKEN WTFFFF'}');
        }
      },
    );
  }
}