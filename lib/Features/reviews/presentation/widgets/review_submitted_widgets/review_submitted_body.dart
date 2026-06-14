import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/reviews/data/repos/reviews_repo_impl.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/review_submitted_widgets/recommendations_section.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import 'green_gradient_checkmark.dart';

class ReviewSubmittedBody extends StatelessWidget {
  const ReviewSubmittedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryScaffBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.containerColor,
            leading: IconButton(
                onPressed: () {
                  if(context.mounted) context.goNamed(AppRouting.homeViewName);
                }, icon: const Icon(Icons.close)),
            title: Text(
              'Review Submitted',
              style: AppStyles.bold18poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            centerTitle: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 32.h),
                  const GreenGradientCheckmark(),
                  SizedBox(height: 32.h),
                  Text(
                    'Thank you for your\nreview!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorPrimary,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Your feedback helps improve the Stay Match community and assists other travelers in making better choices. We appreciate you taking the time to share your experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorSecondary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: CustomElevatedButton(
                      text: 'Return to Home',
                      onPressed: () => context.goNamed(AppRouting.homeViewName),
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.textColorWhite,
                      textStyle: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                      borderRadius: 12,
                      elevation: 3,
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          RecommendationsSection(),
        ],
      ),
    );
  }
}