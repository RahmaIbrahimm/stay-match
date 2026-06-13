import 'package:flutter/material.dart%20';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import '../../../widgets/auth_header.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import 'bottom_sheet_body.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
         SizedBox(height: 45.h),
        Padding(
          padding:  EdgeInsets.all(16.0.r),
          child: AuthHeaderText(
            greeting: AppStrings.signUpGreeting,
            title: AppStrings.signUpTitle,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: CustomBottomSheet(sheetBody: BottomSheetBody())),
      ],
    );
  }
}