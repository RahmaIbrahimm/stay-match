import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
class ApplyButtonSliver extends StatelessWidget {
   ApplyButtonSliver({super.key, required this.onPressed, this.isLoading});
final VoidCallback onPressed;
  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: RPadding(
      padding: const EdgeInsets.all(16.0),
      child: CustomElevatedButton(text: AppStrings.apply,
        onPressed: onPressed,
        textStyle: AppStyles.bold18poppins,
        borderRadius: 12,
        isLoading: isLoading ?? false,),
    ))
    ;
  }
}