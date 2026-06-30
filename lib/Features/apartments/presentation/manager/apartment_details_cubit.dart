import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/property_details_response.dart';
import '../../data/repos/apartment_repo.dart';

part 'apartment_details_state.dart';

class ApartmentDetailsCubit extends Cubit<ApartmentDetailsState> {
  final ApartmentRepo apartmentRepo;
  final int id;

  ApartmentDetailsCubit(this.apartmentRepo, this.id)
    : super(ApartmentDetailsInitial()) {
    _loadInitialData();
  }

  PropertyDetailsResponse? _cachedResponse;

  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(GetApartmentDetailsSuccess(response: _cachedResponse!));
    } else {
      await getPropertyDetails(id: id);
    }
  }

  Future<void> getPropertyDetails({required int id}) async {
    emit(GetApartmentDetailsLoading());

    try {
      var response = await apartmentRepo.getApartmentDetail(id: id);

      response.fold(
        (fail) {
          emit(GetApartmentDetailsFailure(errMessage: fail.errMessage));
        },
        (response) {
          if (response.isSuccess == true) {
            _cachedResponse = response;
            emit(GetApartmentDetailsSuccess(response: response));
          } else {
            emit(
              GetApartmentDetailsFailure(
                errMessage:
                    response.message ?? 'Error getting Apartment Details',
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(GetApartmentDetailsFailure(errMessage: e.toString()));
    }
  }
}