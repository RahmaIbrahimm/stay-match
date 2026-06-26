import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/show_reviews_widgets/reviews_app_bar.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/show_reviews_widgets/reviews_body.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../../data/models/get_apartment_reviews.dart';
import '../../manager/reviews_cubit.dart';
import 'error_view.dart';

class ShowReviewsBody extends StatefulWidget {
  final int propertyId;
  final bool isRoom;

  const ShowReviewsBody({super.key, required this.propertyId,  this.isRoom = false});

  @override
  State<ShowReviewsBody> createState() => _ShowReviewsBodyState();
}

class _ShowReviewsBodyState extends State<ShowReviewsBody> {
  final TextEditingController _searchCtrl = TextEditingController();
  final PagingController<int, Reviews> _pagingController = PagingController(
    firstPageKey: 1,
  );
  ReviewSortOption _sort = ReviewSortOption.all;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<ReviewsCubit>().fetchPage(
        propertyId: widget.propertyId,
        pageKey: pageKey,
        pagingController: _pagingController,
        propertyType: widget.isRoom ? PropertyType.room:PropertyType.apartment
      );
    });
  }

  void _onSortChanged(ReviewSortOption option) {
    if (_sort == option) return;
    setState(() => _sort = option);
    context.read<ReviewsCubit>().changeSortBy(
      sort: option.apiValue,
      propertyId: widget.propertyId,
      pagingController: _pagingController,
    );
  }

  void _onSearchChanged(String query) {
    context.read<ReviewsCubit>().search(
      query: query,
      propertyId: widget.propertyId,
      pagingController: _pagingController,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RColors.pageBg,
      appBar: const ReviewsAppBar(),
      body: BlocConsumer<ReviewsCubit, ReviewsState>(
        listenWhen: (_, s) => s is ReviewsFailure,
        listener: (context, state) {
          if (state is ReviewsFailure) {
            _pagingController.error = state.errMessage;
          }
        },
        buildWhen: (_, curr) =>
            curr is ReviewsLoading ||
            curr is ReviewsFailure ||
            curr is ReviewsSuccess,
        builder: (context, state) {
          if (state is ReviewsLoading && _pagingController.itemList == null) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is ReviewsFailure && _pagingController.itemList == null) {
            return ErrorView(
              message: state.errMessage,
              onRetry: () => _pagingController.refresh(),
            );
          }
          GetApartmentReviewsData? data;
          if (state is ReviewsSuccess) data = state.apartmentReviews?.data;

          return ReviewsBody(
            data: data,
            pagingController: _pagingController,
            searchCtrl: _searchCtrl,
            currentSort: _sort,
            onSortChanged: _onSortChanged,
            onSearchChanged: _onSearchChanged,
            onClearSearch: () {
              _searchCtrl.clear();
              _onSearchChanged('');
            },
          );
        },
      ),
    );
  }
}