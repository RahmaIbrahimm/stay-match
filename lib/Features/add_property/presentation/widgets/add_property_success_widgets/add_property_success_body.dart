import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/add_property/presentation/manager/add_property_cubit.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';

class AddPropertySuccessBody extends StatelessWidget {
  const AddPropertySuccessBody({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              boxShadow: AppColors.elevationShadow,
            ),
            child: Column(
              children: [
                Image.asset(AppImages.listingSuccess, height: 120.h),

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
                  style: AppStyles.regular14poppins.copyWith(
                    height: 1.5,
                    color: AppColors.textColorSecondary,
                  ),
                ),

                SizedBox(height: 32.h),

                // Dashboard Button (Primary)
                _buildButton(
                  text: 'Go to Dashboard',
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.textColorWhite,
                  onPressed: () {
                    context.read<AddPropertyCubit>().resetAll();
                    final StatefulNavigationShellState shell =
                        StatefulNavigationShell.of(context);
                    shell.goBranch(0, initialLocation: true);
                  },
                ),

                SizedBox(height: 12.h),

                // Preview Button (Secondary/Grey)
                _buildButton(
                  text: 'View Preview',
                  backgroundColor: AppColors.darkerGrey,
                  textColor: AppColors.textColorPrimary,
                  onPressed: () {
                    // 1. Read the necessary state variables first while they still exist
                    final cubit = context.read<AddPropertyCubit>();
                    final isApartment = cubit.selectedType == PropertyType.apartment;

                    // 2. Wipe the state clean now that you have what you need
                    cubit.resetAll();

                    // 3. Navigate safely using the captured value and the passed id
                    if (isApartment) {
                      context.pushNamed(
                        AppRouting.apartmentDetailsViewName,
                        pathParameters: {"id": id.toString()},
                      );
                    } else {
                      context.pushNamed(
                        AppRouting.roomDetailsViewName,
                        pathParameters: {"propertyId": id.toString()},
                      );
                    }
                  },                ),
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
      child: CustomElevatedButton(
        text: text,
        borderRadius: 12,
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        textStyle: AppStyles.semiBold16poppins,
        textColor: textColor,
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