import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../manager/add_property_cubit.dart';

class AddPropertyButtons extends StatelessWidget {
  const AddPropertyButtons({
    super.key,
    this.hasBackButton = true,
    this.submit = false,
    required this.nextPageRoute,
    required this.cubit,
    this.onNextPressed,
  });

  final bool hasBackButton;
  final String nextPageRoute;
  final AddPropertyCubit cubit;
  final bool submit;
  final VoidCallback? onNextPressed;
  // final PropertyType propertyType;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // back button
        if (hasBackButton)
          Expanded(
            flex: 3,
            child: CustomElevatedButton(
              text: AppStrings.back,
              onPressed: () {
                context.read<AddPropertyCubit>().prevStep();
                Future.microtask(() {
                  if (context.mounted) {
                    context.pop();
                  }
                });
              },
              borderRadius: 12.r,
              backgroundColor: AppColors.containerColor,
              textColor: AppColors.primary,
              borderColor: AppColors.primary,
            ),
          ),
        if (hasBackButton) SizedBox(width: 12.w),
        // next button
        Expanded(
          flex: 5,
          child: CustomElevatedButton(
            text: AppStrings.next,
            onPressed: () {
              if (onNextPressed != null) {
                onNextPressed!();
              } else {
                if (submit) {
                  cubit.submitApartment();
                } else {
                  cubit.nextStep();
                  context.pushNamed(nextPageRoute);
                }
              }
            },
            borderRadius: 12.r,
          ),
        ),
      ],
    );
  }
}