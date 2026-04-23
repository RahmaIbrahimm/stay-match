import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';

import '../../data/repos/my_properties_repo.dart';

part 'my_properties_state.dart';

class MyPropertiesCubit extends Cubit<MyPropertiesState> {
  MyPropertiesRepo myPropertiesRepo;

  MyPropertiesCubit({required this.myPropertiesRepo})
    : super(MyPropertiesInitial()) {
    _loadInitialData();
  }

  MyPropertiesResponse? _cachedResponse;

  Future<void> _loadInitialData() async {
    if (_cachedResponse != null) {
      emit(MyPropertiesSuccess(response: _cachedResponse!));
    } else {
      await getMyProperties();
    }
  }

  Future<void> getMyProperties({
    String? filter,
    int? page = 1,
    int? pageSize = 10,
  }) async {
    emit(MyPropertiesLoading());
    var response = await myPropertiesRepo.getMyProperties(
      filter: filter,
      page: page,
      pageSize: pageSize,
    );
    response.fold(
      (failure) => emit(MyPropertiesFailure(errMessage: failure.errMessage)),
      (resp) {
        if (resp.isSuccess == true) {
          emit(MyPropertiesSuccess(response: resp));
        } else {
          emit(
            MyPropertiesFailure(
              errMessage: resp.message ?? 'something went wrong',
            ),
          );
        }
      },
    );
  }
}