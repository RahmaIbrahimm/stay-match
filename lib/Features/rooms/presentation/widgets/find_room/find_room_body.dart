// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
//
// import '../../../../../../../../core/constants/app_strings.dart';
// import '../../../../../../../../core/constants/app_styles.dart';
//
// import '../../../../shared/widgets/search_app_bar.dart';
// import '../../manager/rooms_cubit.dart';
// import 'show_search_rooms.dart';
//
// class FindRoomBody extends StatelessWidget {
//   const FindRoomBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return BlocBuilder<FilterCubit, FilterState>(
//       builder: (context, state) {
//         if (state is RoomsFilterSuccess) {
//           var roomPropertiesData = state.response.data?.items ?? [];
//           return Padding(
//             padding: EdgeInsets.all(16.0.r),
//             child: CustomScrollView(
//               slivers: [
//                 SliverToBoxAdapter(
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           context.pop();
//                         },
//                         icon: Icon(
//                           Icons.arrow_back,
//                           size: 20.sp,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                       Text(
//                         AppStrings.stayMatch,
//                         style: AppStyles.regular20protestRiot.copyWith(
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SearchAppBar(),
//                 SliverToBoxAdapter(child: SizedBox(height: 16.h)),
//                 ShowSearchResults(roomPropertiesData: roomPropertiesData),
//               ],
//             ),
//           );
//         } else if (state is RoomsFilterFailure) {
//           log(state.errMessage);
//           return Text(state.errMessage);
//         } else if (state is RoomsFilterLoading) {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.primary),
//           );
//         } else {
//           return Text(state.toString());
//         }
//       },
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/find_room/show_search_rooms.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../../filter/presentation/widgets/filter_card.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../../../shared/widgets/no_properties_sliver.dart';
import '../../../../shared/widgets/property_body_base.dart';
import '../../../../shared/widgets/search_app_bar.dart';

class FindRoomBody extends StatelessWidget {
  const FindRoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Load rooms when widget first appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<FilterCubit>();
      if (cubit.state is FilterInitial) {
        log('Initial load of rooms');
        cubit.getAllRooms();
      }
    });

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is FilterInitial) {
          return PropertyBodyBase.buildLoadingStateInitial(
            loadingMessage: 'Finding rooms for you...',
          );
        }

        if (state is RoomsFilterSuccess) {
          var roomPropertiesData = state.response.data?.items ?? [];
          log('Displaying ${roomPropertiesData.length} rooms');

          return RPadding(
            padding: EdgeInsets.all(16.0.r),
            child: CustomScrollView(
              slivers: [
                PropertyBodyBase.buildHeader(context),
                const SearchAppBar(),
                PropertyBodyBase.buildFilterHeader(
                  title: 'Find your Room',
                  subtitle: AppStrings.browseRoom,
                ),
                FilterCard(filterType: PropertyType.room),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                roomPropertiesData.isEmpty
                    ? const NoPropertiesSliver()
                    : ShowSearchResults(roomPropertiesData: roomPropertiesData),
              ],
            ),
          );
        }
        else if (state is RoomsFilterFailure) {
          log(state.errMessage);
          return PropertyBodyBase.buildErrorState(
            context: context,
            errorMessage: state.errMessage,
            onTryAgain: () {
              context.read<FilterCubit>().getAllRooms(forceRefresh: true);
            },
          );
        } else if (state is RoomsFilterLoading) {
          return PropertyBodyBase.buildLoadingState(
            context: context,
            filterHeader: PropertyBodyBase.buildFilterHeader(
              title: 'Find your Room',
              subtitle: AppStrings.browseRoom,
            ),
            filterCard: FilterCard(filterType: PropertyType.room),
            loadingMessage: 'Finding rooms for you...',
          );
        }

        return PropertyBodyBase.buildInitialState(
          context: context,
          icon: Icons.bed_rounded,
          message: 'Ready to find your perfect room?',
          onStartSearching: () {
            context.read<FilterCubit>().getAllRooms();
          },
        );
      },
    );
  }
}