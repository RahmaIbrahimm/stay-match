// lib/features/location/presentation/manager/location_cubit.dart

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/location_model.dart';
import '../../data/repos/location_repo.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepo locationRepository;

  List<Governorate> allGovernorates = [];
  Governorate? selectedGovernorate;
  List<City> filteredCities = [];
  City? selectedCity;

  LocationCubit({required this.locationRepository}) : super(LocationInitial());

  Future<void> loadLocations() async {
    print('loadGovernorates called');
    emit(LocationLoading());

    var response = await locationRepository.getGovernorates();
    print('Response received: $response');
    response.fold(
      (fail) {
        print('Error: ${fail.errMessage}');
        emit(LocationErrorState(message: fail.errMessage));
      },
      (resp) {
        print('Success: ${resp.length} governorates loaded');
        allGovernorates = resp;
        emit(GovernoratesLoadedState(resp));
      },
    );
  }

  // REMOVED CitiesLoadedState - just update local variables
  void selectGovernorate(Governorate? governorate) {
    log('government selected', name: 'location cubit');

    selectedGovernorate = governorate;
    if (governorate != null) {
      filteredCities = governorate.citiesAndVillages;
    } else {
      filteredCities = [];
      selectedCity = null;
    }
    // Don't emit anything - let the widget manage UI state
  }

  void selectCity(City? city) {
    log('city selected', name: 'location cubit');
    selectedCity = city;
    // Don't emit anything - let the widget manage UI state
  }

  void reset() {
    selectedGovernorate = null;
    selectedCity = null;
    filteredCities = [];
    // Don't emit anything
  }
  void refreshCities(){
    emit(GovernoratesLoadedState(allGovernorates));
  }
}