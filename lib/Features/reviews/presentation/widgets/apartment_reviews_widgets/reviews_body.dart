import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/apartment_reviews_widgets/protected_footer.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/apartment_reviews_widgets/rating_summary_card.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/apartment_reviews_widgets/review_card.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/apartment_reviews_widgets/reviews_header.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/apartment_reviews_widgets/reviews_search_bar.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../booking/presentation/widgets/request_booking_widgets/host_card.dart';
import '../../../data/models/get_apartment_reviews.dart';
import '../shared/reviews_helpers.dart';
import 'distribution_section.dart';
import 'error_view.dart';
import 'no_reviews_view.dart';

class ReviewsBody extends StatelessWidget {
  final Data? data;
  final PagingController<int, Reviews> pagingController;
  final TextEditingController searchCtrl;
  final ReviewSortOption currentSort;
  final ValueChanged<ReviewSortOption> onSortChanged;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;

  const ReviewsBody({
    super.key,
    required this.data,
    required this.pagingController,
    required this.searchCtrl,
    required this.currentSort,
    required this.onSortChanged,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    final summary = data?.summary;
    final host = data?.host;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ① Rating summary
              if (summary != null) RatingSummaryCard(summary: summary),
              SizedBox(height: 24.h),

              // ② Distribution
              if (summary != null) DistributionSection(summary: summary),
              SizedBox(height: 24.h),

              // ③ Host card
              if (host != null) HostCard(hostName: host.hostName ?? "Guest"),
              SizedBox(height: 24.h),

              // ④ Search
              ReviewsSearchBar(
                controller: searchCtrl,
                onChanged: onSearchChanged,
                onClear: onClearSearch,
              ),
              SizedBox(height: 20.h),

              // ⑤ Count + sort — sort uses Overlay dropdown
              ReviewsHeader(
                totalReviews: summary?.totalReviews ?? 0,
                currentSort: currentSort,
                onSortChanged: onSortChanged,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),

        // ⑥ Paged review cards
        PagedSliverList<int, Reviews>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<Reviews>(
            itemBuilder: (context, review, index) => ReviewCard(review: review),

            firstPageProgressIndicatorBuilder: (_) => Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: const Center(
                child: CircularProgressIndicator(color: RColors.primary),
              ),
            ),

            newPageProgressIndicatorBuilder: (_) => Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),

            noItemsFoundIndicatorBuilder: (_) => Padding(
              padding: EdgeInsets.symmetric(vertical: 60.h),
              child: const NoReviewsView(),
            ),

            firstPageErrorIndicatorBuilder: (_) => ErrorView(
              message: pagingController.error?.toString() ?? 'Failed to load',
              onRetry: () => pagingController.refresh(),
            ),

            newPageErrorIndicatorBuilder: (_) => Padding(
              padding: EdgeInsets.all(16.r),
              child: Center(
                child: TextButton(
                  onPressed: () => pagingController.retryLastFailedRequest(),
                  child: Text(
                    'Retry',
                    style: AppStyles.medium14poppins.copyWith(
                      color: RColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // ⑦ Show all + footer
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 24.h),
              const ProtectedFooter(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ],
    );
  }
}