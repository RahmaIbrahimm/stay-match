import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/routing/app_routing.dart';


class AddNewPropertyButton extends StatelessWidget {
  const AddNewPropertyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => context.goNamed(AppRouting.addPropertyName),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 12.r),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0x33000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 20.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                'Add New Property',
                style: AppStyles.semiBold14poppins.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}