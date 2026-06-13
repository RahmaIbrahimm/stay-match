import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../manager/write_review_cubit.dart';

class SubmitBar extends StatelessWidget {
  final VoidCallback onSubmit;

  const SubmitBar({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteReviewCubit, WriteReviewState>(
      builder: (context, state) {
        final isLoading = state is WriteReviewLoading;
        return Container(
          width: double.infinity,
          color: AppColors.secondaryScaffBg,
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
          child: CustomElevatedButton(
            text: 'Submit Review',
            isLoading: isLoading,
            onPressed: isLoading ? null : onSubmit,
            backgroundColor: AppColors.primary,
            textStyle: AppStyles.semiBold16poppins,
            textColor: AppColors.textColorWhite,
            borderRadius: 14,
            verticalPadding: 16,
          ),
        );
      },
    );
  }
}