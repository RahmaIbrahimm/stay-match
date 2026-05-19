// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:meta/meta.dart';
// import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
//
// import '../../data/repos/my_properties_repo.dart';
//
// part 'my_properties_state.dart';
//
// class MyPropertiesCubit extends Cubit<MyPropertiesState> {
//   MyPropertiesRepo myPropertiesRepo;
//
//   MyPropertiesCubit({required this.myPropertiesRepo})
//     : super(MyPropertiesInitial()) {
//     _loadInitialData();
//   }
//
//   MyPropertiesResponse? _cachedResponse;
//    String selectedFilter = 'All Properties';  Future<void> _loadInitialData() async {
//     if (_cachedResponse != null) {
//       emit(MyPropertiesSuccess(response: _cachedResponse!));
//     } else {
//       await getMyProperties();
//     }
//   }
//
//   Future<void> getMyProperties({
//     String? filter,
//     int? page = 1,
//     int? pageSize = 10,
//   }) async {
//     emit(MyPropertiesLoading());
//     var response = await myPropertiesRepo.getMyProperties(
//       filter: filter,
//       page: page,
//       pageSize: pageSize,
//     );
//     response.fold(
//       (failure) => emit(MyPropertiesFailure(errMessage: failure.errMessage)),
//       (resp) {
//         if (resp.isSuccess == true) {
//           emit(MyPropertiesSuccess(response: resp));
//         } else {
//           emit(
//             MyPropertiesFailure(
//               errMessage: resp.message ?? 'something went wrong',
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   // pagination
// // Inside MyPropertiesCubit
//   Future<void> fetchPage(int pageKey, PagingController<int, Properties> pagingController) async {
//     // Use your existing repository logic
//     final response = await myPropertiesRepo.getMyProperties(
//       filter: selectedFilter == 'All Properties' ? null : selectedFilter,
//       page: pageKey,
//       pageSize: 10,
//     );
//
//     response.fold(
//           (failure) {
//         // Correct way to pass errors to the UI in v4
//         pagingController.error = failure.errMessage;
//       },
//           (resp) {
//         if (resp.isSuccess == true) {
//           final items = resp.data?.properties ?? [];
//           final isLastPage = items.length < 10;
//
//           if (isLastPage) {
//             pagingController.appendLastPage(items);
//           } else {
//             // Tell the controller the next page is pageKey + 1
//             pagingController.appendPage(items, pageKey + 1);
//           }
//
//           // Keep your original success emit for the total count UI
//           emit(MyPropertiesSuccess(response: resp));
//         } else {
//           pagingController.error = resp.message ?? 'Something went wrong';
//         }
//       },
//     );
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  String selectedFilter = 'All Properties';

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

  // ─── PAGINATION METHOD WITH BOTH PARAMETERS EXPECTED BY THE VIEW ───
  Future<void> fetchPage(int pageKey, PagingController<int, Properties> pagingController) async {
    final response = await myPropertiesRepo.getMyProperties(
      filter: selectedFilter == 'All Properties' ? null : selectedFilter,
      page: pageKey,
      pageSize: 10,
    );

    response.fold(
          (failure) {
        pagingController.error = failure.errMessage;
      },
          (resp) {
        if (resp.isSuccess == true) {
          final items = resp.data?.properties ?? [];
          final isLastPage = items.length < 10;

          if (isLastPage) {
            pagingController.appendLastPage(items);
          } else {
            pagingController.appendPage(items, pageKey + 1);
          }

          emit(MyPropertiesSuccess(response: resp));
        } else {
          pagingController.error = resp.message ?? 'Something went wrong';
        }
      },
    );
  }
}