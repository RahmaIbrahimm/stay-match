import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      color: AppColors.bgGrey,
      child: Icon(
        Icons.apartment_rounded,
        size: 40.r,
        color: AppColors.textColorSecondary,
      ),
    );
  }
}