import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_text_button.dart';
class FilterBottomSheetAppBar extends StatelessWidget {
  const FilterBottomSheetAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      leading: IconButton(onPressed: () {
        if (context.canPop()) {
          context.pop();
        }
      },
        icon: Icon(Icons.close,
          color: AppColors
              .textColorPrimary,),
        color: AppColors.containerColor,),
      backgroundColor: AppColors
          .containerColor,
      foregroundColor: Colors.transparent,
      title: Text('Who\'s coming?',
        style: AppStyles.bold18poppins
            .copyWith(
          color: AppColors
              .textColorPrimary,
          letterSpacing: -0.45.r,
        ),
      ),
      actionsPadding: EdgeInsets
          .symmetric(horizontal: 24.r),
      surfaceTintColor: Colors.transparent,
      actions: [
        CustomTextButton(
          onPressed: () {},
          text: 'Reset',
          isUnderlined: false,
          textColor: AppColors.primary,
          textStyle: AppStyles
              .semiBold16poppins,)
      ],
      pinned: true,
    );
  }
}