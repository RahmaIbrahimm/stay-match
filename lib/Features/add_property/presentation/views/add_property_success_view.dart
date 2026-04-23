import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_images.dart';
import '../../../../core/constants/app_colors.dart';

class AddPropertySuccessView extends StatelessWidget {
  const AddPropertySuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: AppColors.containerColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColorPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Success',
          style: TextStyle(
            color: AppColors.textColorPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            // --- MAIN SUCCESS CARD ---
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: AppColors.elevationShadow, // Using your custom shadow
              ),
              child: Column(
                children: [
                  // The combined graphic asset
                  Image.asset(
                    AppImages.listingSuccess,
                    height: 120.h,
                  ),

                  SizedBox(height: 32.h),

                  Text(
                    'Listing Submitted\nSuccessfully!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColorPrimary,
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Text(
                    'Your property is currently under review. This process typically takes a few hours for approval. We will notify you once it’s live.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textColorSecondary,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Dashboard Button (Primary)
                  _buildButton(
                    text: 'Go to Dashboard',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textColorWhite,
                    onTap: () {
                      // Action for Dashboard
                    },
                  ),

                  SizedBox(height: 12.h),

                  // Preview Button (Secondary/Grey)
                  _buildButton(
                    text: 'View Preview',
                    backgroundColor: AppColors.darkerGrey,
                    textColor: AppColors.textColorPrimary,
                    onTap: () {
                      // Action for Preview
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // --- BOTTOM INFO ROW ---
            Row(
              children: [
                Expanded(
                  child: _buildInfoTile(
                    icon: Icons.verified_user_outlined,
                    label: 'SECURE\nPROCESS',
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildInfoTile(
                    icon: Icons.electric_bolt_outlined,
                    label: 'FAST\nREVIEW',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: AppColors.bgGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.sp),
          ),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.textColorPrimary,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}