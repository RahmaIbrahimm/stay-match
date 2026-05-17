import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_strings.dart';

class SavedHeaderSection extends StatelessWidget {
  final int totalCount;
  const SavedHeaderSection({super.key, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.savedListings,
          style: AppStyles.bold24poppins.copyWith(color: Colors.black),
        ),
        SizedBox(height: 4.h),
        Text(
          totalCount > 0
              ? '${AppStrings.youHave}$totalCount ${AppStrings.savedSubtitle}'
              : AppStrings.noSavedYet,
          style: AppStyles.regular14poppins
              .copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}