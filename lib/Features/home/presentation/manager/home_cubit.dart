import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stay_match/Features/home/data/models/properties_general_search.dart';
import 'package:stay_match/Features/home/data/repos/home_repo.dart';
import 'package:stay_match/Features/home/presentation/widget/section_failure.dart';

import '../../../filter/presentation/widgets/filter_helper.dart';

part 'home_state.dart';

enum HomeSearchFilter {
  entire,
  shared
}
class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(HomeInitial());
  HomeSearchFilter selectedProperty = HomeSearchFilter.entire;

  Future<void> searchProperties({required String q}) async {
    emit(HomeLoading());
    var response = await homeRepo.homeSearch(type: selectedProperty.name, q: q);
    response.fold(
            (fail) => emit(HomeFailure(errMessage: fail.errMessage)),
            (resp) {
          if (resp.isSuccess == true) {
            log('✅ HomeSuccess emitted, entire count: ${resp.data
                ?.entireProperties?.items?.length}');
            emit(HomeSuccess(response: resp));
          } else {
            emit(HomeFailure(
                errMessage: resp.message ?? 'something went wrong'));
          }
        }
    );
  }

  void clearSearch() {
    emit(HomeInitial());
  }
}