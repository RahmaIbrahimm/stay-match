import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/rooms/data/models/shared_apartment_details.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';

part 'shared_property_state.dart';

class SharedPropertyCubit extends Cubit<SharedPropertyState> {
  final RoomsRepoImpl roomsRepo;
  late int _propertyId;

  SharedPropertyCubit({required this.roomsRepo}) : super(SharedPropertyInitial());

  Future<void> fetchDetails({required int propertyId}) async {
    _propertyId = propertyId;
    emit(SharedPropertyLoading());
    final result = await roomsRepo.getSharedPropertyDetails(id: propertyId);
    result.fold(
          (f) => emit(SharedPropertyFailure(errMessage: f.errMessage)),
          (r) {
        if (r.isSuccess == true && r.data != null) {
          emit(SharedPropertySuccess(details: r));
        } else {
          emit(SharedPropertyFailure(errMessage: r.message ?? 'Failed to load'));
        }
      },
    );
  }

  void retry() => fetchDetails(propertyId: _propertyId);
}