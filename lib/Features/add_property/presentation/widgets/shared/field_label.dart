import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_styles.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.t});
  final String t;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
      child: Text(t, style: AppStyles.medium14poppins),
    );

  }
}