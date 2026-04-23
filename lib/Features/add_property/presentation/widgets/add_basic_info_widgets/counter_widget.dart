import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../manager/add_property_cubit.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget(
      {super.key, required this.context, required this.val, required this.cubitKey});

  final BuildContext context;
  final String cubitKey;
  final int val;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPropertyCubit>();
    return  Row(
      children: [
        IconButton(
          onPressed: () => cubit.updateCounter(cubitKey, false),
          icon: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.r),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '-',
              style: AppStyles.semiBold18poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        Text("$val", style: AppStyles.bold16poppins),
        IconButton(
          onPressed: () => cubit.updateCounter(cubitKey, true),
          icon: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.r),
            decoration: BoxDecoration(
              color: AppColors.primary,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              '+',
              style: AppStyles.semiBold18poppins.copyWith(
                color: AppColors.containerColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}