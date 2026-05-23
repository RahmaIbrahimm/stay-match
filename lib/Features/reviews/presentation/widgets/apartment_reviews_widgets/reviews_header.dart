import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/apartment_reviews_widgets/sort_drop_down.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../shared/reviews_helpers.dart';

class ReviewsHeader extends StatelessWidget {
  final int totalReviews;
  final ReviewSortOption currentSort;
  final ValueChanged<ReviewSortOption> onSortChanged;

  const ReviewsHeader({
    super.key,
    required this.totalReviews,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$totalReviews ${totalReviews == 1 ? "review" : "reviews"}',
            style: AppStyles.bold16poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          SortDropdown(current: currentSort, onChanged: onSortChanged),
        ],
      ),
    );
  }
}