import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import 'package:stay_match/features/home/presentation/widget/rooms_list.dart';
import 'package:stay_match/features/home/presentation/widget/rooms_section_container.dart';

import '../../../rooms/presentation/manager/rooms_cubit.dart';

class RoomsSection extends StatelessWidget {
  const RoomsSection({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
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
          return Text('Error: ${state.errMessage}');
        }
        // Initial state (before any loading)
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
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
      },
    );
  }
}