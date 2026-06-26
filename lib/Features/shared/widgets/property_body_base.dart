import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/shared/widgets/search_app_bar.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

/// Shared UI components for both Apartment and Room screens
class PropertyBodyBase {
  static Widget buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back, size: 20.sp, color: AppColors.primary),
          ),
          Text(
            AppStrings.stayMatch,
            style: AppStyles.regular20protestRiot.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  static SliverToBoxAdapter buildFilterHeader({
    required String title,
    required String subtitle,
  }) {
    return SliverToBoxAdapter(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: AppStyles.bold24poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            TextSpan(
              text: '\n$subtitle',
              style: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildErrorState({
    required BuildContext context,
    required String errorMessage,
    required VoidCallback onTryAgain,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.textColorError.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 50.sp,
                color: AppColors.textColorError,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Oops! Something went wrong',
              style: AppStyles.bold20poppins,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              errorMessage,
              style: AppStyles.medium14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onTryAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: AppStyles.semiBold16poppins.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (context.canPop()) context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: AppStyles.semiBold16poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildLoadingStateInitial({required String loadingMessage}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(50.r),
            width: 60.w,
            height: 60.w,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            loadingMessage,
            style: AppStyles.medium16poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
        ],
      ),
    );
  }
  //
  // static Widget buildLoadingState({
  //   required BuildContext context,
  //   required Widget filterHeader,
  //   required Widget filterCard,
  //   required String loadingMessage,
  // }) {
  //   return RPadding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: CustomScrollView(
  //       slivers: [
  //         buildHeader(context),
  //         const SearchAppBar(),
  //         filterHeader,
  //         filterCard,
  //         SliverToBoxAdapter(child: SizedBox(height: 16.h)),
  //         SliverToBoxAdapter(
  //           child: buildLoadingStateInitial(loadingMessage: loadingMessage),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  static Widget buildInitialState({
    required BuildContext context,
    required IconData icon,
    required String message,
    required VoidCallback onStartSearching,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80.sp,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: AppStyles.medium16poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onStartSearching,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Start Searching',
              style: AppStyles.semiBold16poppins.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}