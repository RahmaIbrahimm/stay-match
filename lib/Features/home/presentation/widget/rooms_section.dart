import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import 'package:stay_match/features/home/presentation/widget/rooms_list.dart';
import 'package:stay_match/features/home/presentation/widget/rooms_section_container.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../rooms/presentation/manager/rooms_cubit.dart';

class RoomsSection extends StatelessWidget {
  const RoomsSection({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
        log('Current state: $state');
        if (state is GetRoomsSuccess) {
          var roomPropertiesData = state.response.data?.items;
          return RoomsSectionContainer(
            widget: RoomsList(
              roomPropertiesData: roomPropertiesData,
            ),
          );
        }
        // Failure state
        else if (state is GetRoomsFailure) {
          return RoomsSectionContainer(
            widget: Center(
              child: GestureDetector(
                onTap: () {
                  context.read<RoomsCubit>().getAllRooms();
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
          );
        }
        else if (state is RoomsInitial) {
          return Container(); // todo: or loading, or nothing
        } else if (state is GetRoomsLoading) {
          return RoomsSectionContainer(
            widget: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}