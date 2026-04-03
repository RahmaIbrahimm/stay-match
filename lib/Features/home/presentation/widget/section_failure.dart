import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/presentation/manager/rooms_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../apartments/presentation/manager/apartment_cubit.dart';

enum Property { apartment, room }

class SectionFailure extends StatelessWidget {
  const SectionFailure({super.key, required this.property});

  final Property property;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          property == Property.apartment
              ? context.read<ApartmentCubit>().getAllApartments()
              : context.read<RoomsCubit>().getAllRooms();
        },
        child: RPadding(
          padding: EdgeInsets.all(16),
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
                'Tap to retry',
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