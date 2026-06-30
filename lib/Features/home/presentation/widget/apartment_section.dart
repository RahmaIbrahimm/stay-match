import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/Features/home/presentation/widget/section_failure.dart';

import '../../../apartments/presentation/manager/apartment_cubit.dart';
import 'apartment_list.dart';
import 'apartments_section_container.dart';

class ApartmentSection extends StatelessWidget {
  const ApartmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApartmentCubit, ApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          var properties = state.response.data?.items;
          if (properties != null && properties.isNotEmpty) {
            return ApartmentsSectionContainer(
              widget: ApartmentList(properties: properties),
            );
          } else {
            // Show empty state when no shared
            return ApartmentsSectionContainer(
              widget: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.h,),
                    Text(
                      AppStrings.noApartmentsAvailable,
                      style: AppStyles.semiBold20poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h,),

                  ],
                ),
              ),
            );
          }
        }
        if (state is GetApartmentsLoading) {
          return ApartmentsSectionContainer(
            widget: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        if (state is GetApartmentsFailure) {
          return ApartmentsSectionContainer(
            widget: SectionFailure(property: Property.apartment),
          );
        }
        //  Default state
        return ApartmentsSectionContainer(
          widget: Center(child: CircularProgressIndicator(color: Colors.red)),
        );
      },
    );
  }
}