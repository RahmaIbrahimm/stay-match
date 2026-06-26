import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/home/presentation/widget/section_failure.dart';
import 'package:stay_match/Features/my_properties/presentation/widgets/home_my_property_card.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../../../core/routing/app_routing.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../my_properties/presentation/manager/my_properties_cubit.dart';
class AddOrShowMyProperties extends StatelessWidget {
  const AddOrShowMyProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.myProperties,
                style: AppStyles.semiBold18poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              // Your requested CustomTextButton implementation
              CustomTextButton(
                onPressed: () {
                  // Ensure this route is defined for showing all your properties
                  context.pushNamed(AppRouting.myPropertiesName);
                },
                text: AppStrings.viewAllProperties, // Typically just "View All" for sections
                textColor: AppColors.primary,
                textStyle: AppStyles.semiBold12poppins,
                isPadded: false,
              ),
            ],
          ),
          SizedBox(height: 10.h),

          BlocBuilder<MyPropertiesCubit, MyPropertiesState>(
            builder: (context, state) {
              if (state is MyPropertiesLoading) {
                return RPadding(
                  padding: EdgeInsets.all(20.r),
                  child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                );
              }

              if (state is MyPropertiesSuccess) {
                final properties = state.response?.data?.properties;

                if (properties == null || properties.isEmpty) {
                  return Column(
                    children: [
                      Text(
                        AppStrings.addYourProperty,
                        style: AppStyles.medium16poppins.copyWith(color: AppColors.textColorPrimary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        AppStrings.shareApartmentDetails,
                        style: AppStyles.medium12poppins.copyWith(color: AppColors.textColorSecondary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.r),
                        child: CustomElevatedButton(
                          verticalPadding: 8.r,
                          text: AppStrings.addProperty,
                          onPressed: () {
                            StatefulNavigationShell.of(context).goBranch(1);
                            context.goNamed(AppRouting.addPropertyName);
                          },
                        ),
                      ),
                    ],
                  );
                }

                return SizedBox(
                  height: 230.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: properties.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemBuilder: (context, index) => HomeMyPropertyCard(property: properties[index]),
                  ),
                );
              }

              if (state is MyPropertiesFailure) {
                return SectionFailure(property: Property.myProperties);
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}