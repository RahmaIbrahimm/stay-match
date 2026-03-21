import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/features/filter/presentation/manager/filter_cubit.dart';

import '../../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../../core/constants/app_styles.dart';

import '../../../../shared/widgets/search_app_bar.dart';
import '../../manager/rooms_cubit.dart';
import 'show_rooms.dart';

class FindRoomBody extends StatelessWidget {
  const FindRoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is RoomsFilterSuccess) {
          var roomPropertiesData = state.response.data?.items ?? [];
          return Padding(
            padding: EdgeInsets.all(16.0.r),
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
                          size: 20.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        AppStrings.stayMatch,
                        style: AppStyles.regular20protestRiot.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SearchAppBar(),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                ShowSearchResults(roomPropertiesData: roomPropertiesData),
              ],
            ),
          );
        } else if (state is RoomsFilterFailure) {
          log(state.errMessage);
          return Text(state.errMessage);
        } else if (state is RoomsFilterLoading) {
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