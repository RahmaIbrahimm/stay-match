import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/add_property/presentation/manager/add_property_cubit.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

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
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: AppColors.textColorPrimary),
        //   onPressed: (){
        //   },
        // ),
        title: Text(
          'Success',
          style: AppStyles.bold18poppins.copyWith(color: AppColors.textColorPrimary)
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

                  SizedBox(height: 16.h),

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

                  SizedBox(height: 12.h),

                  Text(
                    'Your property is currently under review. This process typically takes a few hours for approval. We will notify you once it’s live.',
                    textAlign: TextAlign.center,
                    style: AppStyles.regular14poppins.copyWith(height: 1.5, color: AppColors.textColorSecondary),
                  ),

                  SizedBox(height: 32.h),

                  // Dashboard Button (Primary)
                  _buildButton(
                    text: 'Go to Dashboard',
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textColorWhite,
                    onPressed: () {
                      context.read<AddPropertyCubit>().resetAll();
                      // 1. Access the shell from the context
                      final StatefulNavigationShellState shell = StatefulNavigationShell.of(context);
                      shell.goBranch(
                        0,
                        initialLocation: true,
                      );
                      },
                  ),

                  SizedBox(height: 12.h),

                  // Preview Button (Secondary/Grey)
                  _buildButton(
                    text: 'View Preview',
                    backgroundColor: AppColors.darkerGrey,
                    textColor: AppColors.textColorPrimary,
                    onPressed: () {
                      context.read<AddPropertyCubit>().resetAll();
                      // todo: goes to property details
                      // context.goNamed(AppRouting.apartmentDetailsViewName,pathParameters: {
                      //   "id" :
                      // });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

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
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: CustomElevatedButton(text: text,
        borderRadius: 12,
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        textStyle: AppStyles.semiBold16poppins,
        textColor: textColor,),
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