
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';

class GlobalErrorWidget extends StatelessWidget {
  final VoidCallback onTryAgain;
  final VoidCallback? onReturnHome;

  const GlobalErrorWidget({
    super.key,
    required this.onTryAgain,
    this.onReturnHome,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Image.asset(
                  AppImages.errorImg,
                  width: 250.r,
                  height: 250.r,
                ),

                SizedBox(height: 32.h),

                Text(
                  'Oops! Something went wrong.',
                  textAlign: TextAlign.center,
                  style: AppStyles.bold24poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  "We couldn't load the page you're looking for. "
                      "Please check your internet connection or try again later.",
                  textAlign: TextAlign.center,
                  style: AppStyles.regular14poppins.copyWith(
                    color: AppColors.textColorSecondary,
                    height: 1.6,
                  ),
                ),

                SizedBox(height: 48.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: onTryAgain,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Try Again',
                      style: AppStyles.medium14poppins.copyWith(
                        color: AppColors.containerColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                if (onReturnHome != null)
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: onReturnHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8EDF4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Return to Home',
                        style: AppStyles.medium14poppins.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 8.h),
                Divider(color: AppColors.blueGrey,),
                SizedBox(height: 8.h),
                FooterWidget(),
                Divider(color: AppColors.blueGrey,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace these with your AppStyles / AppColors if necessary


    final dividerColor = const Color(0xFFD3DCE6);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top row containing links and separator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // TODO: Handle Privacy Policy tap
              },
              child:  Text('Privacy Policy', style: AppStyles.bold14poppins.copyWith(color: AppColors.textColorSecondary)),
            ),

            // Vertical Divider Pipeline (|)
            RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 1.5,
                height: 16,
                color: dividerColor,
              ),
            ),

            GestureDetector(
              onTap: () {
                // TODO: Handle Terms of Service tap
              },
              child:  Text('Terms of Service', style: AppStyles.bold14poppins.copyWith(color: AppColors.textColorSecondary)),
            ),
          ],
        ),

         SizedBox(height: 12.h), // Space between row and copyright text

        // Copyright notice text
         Text(
          "© 2024 Stay Match Platform. All rights reserved.",
          style: AppStyles.regular12poppins.copyWith(color: AppColors.textColorSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}