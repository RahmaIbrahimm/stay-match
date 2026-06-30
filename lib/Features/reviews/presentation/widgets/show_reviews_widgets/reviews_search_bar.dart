import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';

import '../../../../../core/constants/app_styles.dart';
class ReviewsSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const ReviewsSearchBar({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: RColors.divider),
        ),
        child: Row(
          children: [
            SizedBox(width: 12.w),
            Icon(Icons.search, size: 20.r, color: RColors.textHint),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: AppStyles.regular14poppins.copyWith(
                  color: RColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Search reviews...',
                  hintStyle: AppStyles.regular14poppins.copyWith(
                    color: RColors.textHint,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (controller.text.isNotEmpty)
              GestureDetector(
                onTap: onClear,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Icon(Icons.clear, size: 18.r, color: RColors.textHint),
                ),
              )
            else
              SizedBox(width: 12.w),
          ],
        ),
      ),
    );
  }
}