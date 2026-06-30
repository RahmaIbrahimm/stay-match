import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/Features/home/presentation/widget/rooms_list.dart';
import 'package:stay_match/Features/home/presentation/widget/rooms_section_container.dart';
import 'package:stay_match/Features/home/presentation/widget/section_failure.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../rooms/presentation/manager/rooms_cubit.dart';

class RoomsSection extends StatelessWidget {
  const RoomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
        log('Current state: $state');
        if (state is GetRoomsSuccess) {
          var roomPropertiesData = state.response.data?.items;
          if (roomPropertiesData == null || roomPropertiesData.isEmpty) {
            return RoomsSectionContainer(widget: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.h,),
                  Text(
                    AppStrings.noRoomsAvailable,
                    style: AppStyles.semiBold20poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                  SizedBox(height: 16.h,),

                ],
              ),
            ));
          } else {
            return RoomsSectionContainer(
            widget: RoomsList(roomPropertiesData: roomPropertiesData),
          );
          }
        }
        // Failure state
        else if (state is GetRoomsFailure) {
          return RoomsSectionContainer(
            widget: SectionFailure(property: Property.room),
          );
        }
        else if (state is RoomsInitial) {
          return Container(); // todo: or loading, or nothing
        }
        else if (state is GetRoomsLoading) {
          return RoomsSectionContainer(
            widget: Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}