import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../apartments/presentation/manager/apartment_cubit.dart';
import 'apartment_list.dart';
import 'apartments_section_container.dart';

class ApartmentSection extends StatelessWidget {
  const ApartmentSection({
    super.key,
  });

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
                    Icon(
                      Icons.apartment_outlined,
                      size: 40.r,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No apartments available',
                      style: AppStyles.semibold24poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }

        if (state is GetApartmentsLoading) {
          return ApartmentsSectionContainer(
            widget: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }

        if (state is GetApartmentsFailure) {
          return ApartmentsSectionContainer(
            widget: Center(
              child: GestureDetector(
                onTap: () {
                  context.read<ApartmentCubit>().getAllApartments();
                },
                child: RPadding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 18.sp,
                        color: AppColors.textColorSecondary, // 👈 not red
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Tap to retry',
                        style: AppStyles.medium14poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );}
        // todo : Default loading state
        return ApartmentsSectionContainer(
          widget: Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}