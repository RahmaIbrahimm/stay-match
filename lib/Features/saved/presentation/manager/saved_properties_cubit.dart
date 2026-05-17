import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
import 'package:stay_match/Features/saved/data/repos/saved_properties_repo_impl.dart';

part 'saved_properties_state.dart';

enum SavedItemType { wholeApartment, room, sharedApartment }

class SavedPropertiesCubit extends Cubit<SavedPropertiesState> {
  final SavedPropertiesRepoImpl repo;

  // Controller for infinite scroll
  final PagingController<int, SavedItems> pagingController = PagingController(
    firstPageKey: 1,
  );

  String currentType = 'all';

  SavedPropertiesCubit(this.repo) : super(SavedPropertiesInitial()) {
    pagingController.addPageRequestListener((pageKey) {
      fetchSavedProperties(pageKey);
    });
  }

  Future<void> fetchSavedProperties(int pageKey) async {
    final result = await repo.getSavedProperties(
      // Correctly passing null if 'all' is selected
      type: currentType == 'all' ? null : currentType,
      page: pageKey,
    );

    result.fold(
      (failure) {
        pagingController.error = failure;
        emit(SavedPropertiesFailure(errMessage: failure.errMessage));
      },
      (response) {
        final items = response.data?.savedItems ?? [];
        final isLastPage = !(response.data?.pagination?.hasMore ?? false);

        if (isLastPage) {
          pagingController.appendLastPage(items);
        } else {
          pagingController.appendPage(items, pageKey + 1);
        }

        // Emit success to update the "Total Count" in the UI header
        emit(SavedPropertiesSuccess(response: response));
      },
    );
  }

  // in saved_properties_cubit.dart — update changeFilter:
  void changeFilter(String type) {
    if (currentType == type) return;
    currentType = type;
    emit(
      FilterChanged(currentType: currentType),
    ); // ← triggers BlocBuilder rebuild
    pagingController.refresh();
  }

  Future<void> toggleSaved({
    required SavedItemType itemType,
    required int? propertyId,
    int? roomId,
  }) async {
    emit(ToggleLoading());
    final result = itemType == SavedItemType.room
        ? await repo.toggleSavedRoom(propertyId: propertyId!, roomId: roomId!)
        : await repo.toggleSavedApartment(propertyId: propertyId!);

    result.fold(
      (failure) => emit(ToggleFailure(errMessage: failure.errMessage)),
      (success) {
        emit(ToggleSuccess());
      },
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}