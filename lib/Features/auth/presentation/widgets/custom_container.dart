import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.containerBody});
  final Widget containerBody;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 16.w),
      padding:  EdgeInsets.symmetric(vertical: 50.h, horizontal: 16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Colors.black),
      ),
      child: containerBody,
    );
  }
}