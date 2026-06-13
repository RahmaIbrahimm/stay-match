import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';


class StarRatingRow extends StatelessWidget {
  final String label;
  final int rating;
  final ValueChanged<int> onRatingChanged;

  const StarRatingRow({
    super.key,
    required this.label,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label.toUpperCase(),
                style: AppStyles.semiBold12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                  letterSpacing: 0.5,
                ),
              ),
              if (rating > 0)
                Text(
                  rating.toStringAsFixed(1),
                  style: AppStyles.semiBold14poppins.copyWith(
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return GestureDetector(
                onTap: () => onRatingChanged(starIndex),
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Icon(
                    starIndex <= rating ? Icons.star : Icons.star_border,
                    color: AppColors.primary,
                    size: 25.r,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}