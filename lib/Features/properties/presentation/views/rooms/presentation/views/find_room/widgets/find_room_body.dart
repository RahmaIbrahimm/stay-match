import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../../../core/constants/app_styles.dart';
import '../../../../../../../../home/presentation/widget/show_rooms.dart';
import '../../../../manager/rooms_cubit.dart';
import '../../../../../../widgets/search_app_bar.dart';

class FindRoomBody extends StatelessWidget {
  const FindRoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<RoomsCubit, RoomsState>(
      builder: (context, state) {
        if (state is GetRoomsSuccess) {
          var roomPropertiesData = state.response.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        AppStrings.stayMatch,
                        style: AppStyles.regular15protestRiot.copyWith(
                          color: AppColors.primary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SearchAppBar(),
                ShowSearchResults(roomPropertiesData: roomPropertiesData, size: size),
              ],
            ),
          );
        } else if (state is GetRoomsFailure) {
          log(state.errMessage);
          return Text(state.errMessage);
        } else if (state is GetRoomsLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else {
          return Text(state.toString());
        }
      },
    );
  }
}