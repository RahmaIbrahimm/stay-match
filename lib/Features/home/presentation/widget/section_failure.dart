import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/presentation/manager/rooms_cubit.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../apartments/presentation/manager/apartment_cubit.dart';
import '../../../my_properties/presentation/manager/my_properties_cubit.dart';

enum Property { apartment, room ,myProperties}

class SectionFailure extends StatelessWidget {
  const SectionFailure({super.key, required this.property});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: ()async {
          property == Property.apartment
              ?await context.read<ApartmentCubit>().getAllApartments()
              :property == Property.apartment? await context.read<RoomsCubit>().getAllRooms(): await context.read<MyPropertiesCubit>().getMyProperties();
        },
        child: RPadding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.refresh,
                size: 18.sp,
                color: AppColors.textColorSecondary,
              ),
              SizedBox(width: 6.w),
              Text(
                AppStrings.tapToRetry,
                style: AppStyles.medium14poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}