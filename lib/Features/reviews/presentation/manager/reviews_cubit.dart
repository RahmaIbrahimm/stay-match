import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/filter/presentation/widgets/filter_helper.dart';
import 'package:stay_match/Features/reviews/data/models/get_apartment_reviews.dart';
import 'package:stay_match/Features/reviews/data/repos/reviews_repo.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final ReviewsRepo reviewsRepo;

  ReviewsCubit({required this.reviewsRepo}) : super(ReviewsInitial());

  static const int _pageSize = 10;

  // ── internal filters ──
  // Never sent to the backend when 'all'; null is omitted by the repo.
  String  _sortBy  = 'all';
  String  _search  = '';

  // Cache the first-page response so header data (host, summary)
  // is preserved across filter/sort refreshes.
  GetPropertyReviews? _cachedBase;

  // ─── FETCH ONE PAGE ───────────────────────────────────────────
  // Called by the PagingController's page-request listener in the screen.
  Future<void> fetchPage({
    int? propertyId,
    required int pageKey,
    required PagingController<int, Reviews> pagingController,
    PropertyType propertyType = PropertyType.apartment,
  }) async {
    final result = propertyType == PropertyType.apartment
        ? await reviewsRepo.getApartmentReviews(
            propertyId: propertyId ?? -1,
            page:       pageKey,
      pageSize:   _pageSize,
      sortBy:     _sortBy == 'all' ? null : _sortBy,
      search:     _search.isEmpty  ? null : _search,
          )
        : await reviewsRepo.getRoomReviews(
            roomId: propertyId ?? -1,
            page: pageKey,
            pageSize: _pageSize,
            sortBy: _sortBy == 'all' ? null : _sortBy,
            search: _search.isEmpty ? null : _search,
          );

    result.fold(
          (failure) {
        pagingController.error = failure.errMessage;
        emit(ReviewsFailure(errMessage: failure.errMessage));
      },
          (response) {
        if (response.success != true) {
          final msg = response.message ?? 'Failed to load reviews';
          pagingController.error = msg;
          emit(ReviewsFailure(errMessage: msg));
          return;
        }

        // Keep host + summary from first page for the static header.
        if (pageKey == 1) {
          _cachedBase = response;
          emit(ReviewsSuccess(apartmentReviews: response));
        }

        final fetched  = response.data?.reviews ?? [];
        final isLast   = fetched.length < _pageSize;

        if (isLast) {
          pagingController.appendLastPage(fetched);
        } else {
          pagingController.appendPage(fetched, pageKey + 1);
        }
      },
    );
  }

  // ─── SORT ────────────────────────────────────────────────────
  void changeSortBy({
    required String sort,
    required int propertyId,
    required PagingController<int, Reviews> pagingController,
  }) {
    if (_sortBy == sort) return;
    _sortBy = sort;
    pagingController.refresh();   // triggers fetchPage(pageKey: 1) automatically
  }

  // ─── SEARCH ──────────────────────────────────────────────────
  void search({
    required String query,
    required int propertyId,
    required PagingController<int, Reviews> pagingController,
  }) {
    _search = query;
    pagingController.refresh();
  }
}