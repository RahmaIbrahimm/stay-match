// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
// import 'package:stay_match/Features/rooms/presentation/widgets/find_room/show_search_results.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
// import 'package:stay_match/core/widgets/global_error_widget.dart';
//
// import '../../../../filter/presentation/widgets/filter_card.dart';
// import '../../../../filter/presentation/widgets/filter_helper.dart';
// import '../../../../shared/widgets/no_properties_sliver.dart';
// import '../../../../shared/widgets/property_body_base.dart';
// import '../../../../shared/widgets/search_app_bar.dart';
//
// class FindRoomBody extends StatelessWidget {
//   const FindRoomBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Load rooms when widget first appears
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final cubit = context.read<FilterCubit>();
//       if (cubit.state is FilterInitial) {
//         log('Initial load of rooms');
//         cubit.getAllRooms();
//       }
//     });
//
//     return BlocBuilder<FilterCubit, FilterState>(
//       builder: (context, state) {
//         if (state is FilterInitial) {
//           return PropertyBodyBase.buildLoadingStateInitial(
//             loadingMessage: 'Finding rooms for you...',
//           );
//         }
//
//         if (state is RoomsFilterSuccess) {
//           var roomPropertiesData = state.response.data?.items ?? [];
//           log('Displaying ${roomPropertiesData.length} rooms');
//
//           return RPadding(
//             padding: EdgeInsets.all(16.0.r),
//             child: CustomScrollView(
//               slivers: [
//                 PropertyBodyBase.buildHeader(context),
//                 const SearchAppBar(),
//                 PropertyBodyBase.buildFilterHeader(
//                   title: AppStrings.findYourRoom,
//                   subtitle: AppStrings.browseRoom,
//                 ),
//                 FilterCard(filterType: PropertyType.room),
//                 SliverToBoxAdapter(child: SizedBox(height: 16.h)),
//                 roomPropertiesData.isEmpty
//                     ? const NoPropertiesSliver()
//                     : ShowSearchResults(roomPropertiesData: roomPropertiesData),
//               ],
//             ),
//           );
//         } else if (state is RoomsFilterFailure) {
//           final cubit = context.read<FilterCubit>();
//           log(state.errMessage);
//           // return PropertyBodyBase.buildErrorState(
//           //   context: context,
//           //   errorMessage: state.errMessage,
//           //   onTryAgain: () {
//           //     context.read<FilterCubit>().getAllRooms(forceRefresh: true);
//           //   },
//           // );
//           return GlobalErrorWidget(onTryAgain: (){
//             cubit.getAllRooms();
//
//           });
//         } else if (state is RoomsFilterLoading) {
//           return PropertyBodyBase.buildLoadingState(
//             context: context,
//             filterHeader: PropertyBodyBase.buildFilterHeader(
//               title: AppStrings.findYourRoom,
//               subtitle: AppStrings.browseRoom,
//             ),
//             filterCard: FilterCard(filterType: PropertyType.room),
//             loadingMessage: 'Finding rooms for you...',
//           );
//         }
//
//         return PropertyBodyBase.buildInitialState(
//           context: context,
//           icon: Icons.bed_rounded,
//           message: 'Ready to find your perfect room?',
//           onStartSearching: () {
//             context.read<FilterCubit>().getAllRooms();
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/rooms/data/models/get_all_rooms.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared/room_card.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/widgets/global_error_widget.dart';

import '../../../../filter/presentation/widgets/filter_card.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../../../shared/widgets/no_properties_sliver.dart';
import '../../../../shared/widgets/property_body_base.dart';
import '../../../../shared/widgets/search_app_bar.dart';

class FindRoomBody extends StatefulWidget {
  const FindRoomBody({super.key});

  @override
  State<FindRoomBody> createState() => _FindRoomBodyState();
}

class _FindRoomBodyState extends State<FindRoomBody> {
  // v4.0.0 PagingController
  // We use 'Items' which is the model from your get_all_rooms.dart
  final PagingController<int, Items> _pagingController =
  PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    // Link the pagination request to the fetchRoomsPage method in FilterCubit
    _pagingController.addPageRequestListener((pageKey) {
      context.read<FilterCubit>().fetchRoomsPage(pageKey, _pagingController);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Maintain your custom aspect ratio logic
    double aspectRatio = screenWidth < 400
        ? 0.54
        : screenWidth < 500
        ? 0.60
        : 0.7;
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        // Show the initial full-screen loading only if we have no items yet
        if (state is RoomsFilterLoading && _pagingController.itemList == null) {
          return PropertyBodyBase.buildLoadingStateInitial(
            loadingMessage: 'Finding rooms for you...',
          );
        }

        return RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          child: RPadding(
            padding: EdgeInsets.all(16.0.r),
            child: CustomScrollView(
              slivers: [
                // 1. App Header (StayMatch Logo/Back button)
                PropertyBodyBase.buildHeader(context),

                // 2. Search Bar
                const SearchAppBar(),

                // 3. Section Title (Find your room / Browse)
                PropertyBodyBase.buildFilterHeader(
                  title: AppStrings.findYourRoom,
                  subtitle: AppStrings.browseRoom,
                ),

                // 4. Horizontal Filter Chips (Families, Students, etc.)
                FilterCard(filterType: PropertyType.room),

                SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                // 5. The Paginated Grid
                PagedSliverGrid<int, Items>(
                  pagingController: _pagingController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: screenWidth < 360 ? 8.r : 16.r,
                    crossAxisSpacing: 10.r,
                    childAspectRatio: aspectRatio,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<Items>(
                    itemBuilder: (context, item, index) => RoomCard(
                      coverImageUrl: item.coverImageUrl,
                      name: item.name,
                      street: item.street,
                      city: item.city,
                      rooms: item.rooms ?? [],
                      id: item.id!.toInt(),
                    ),

                    // Loading indicator for the first page
                    firstPageProgressIndicatorBuilder: (_) => const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),

                    // Loading indicator for subsequent pages (at the bottom)
                    newPageProgressIndicatorBuilder: (_) => const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),

                    // What to show if the list is empty
                    noItemsFoundIndicatorBuilder: (_) => const NoPropertiesSliver(),

                    // Error handling for the first page
                    firstPageErrorIndicatorBuilder: (context) => GlobalErrorWidget(
                      onTryAgain: () => _pagingController.refresh(),
                    ),

                    // Error handling for "load more" fails
                    newPageErrorIndicatorBuilder: (context) => Center(
                      child: TextButton(
                        onPressed: () => _pagingController.retryLastFailedRequest(),
                        child: const Text('Retry'),
                      ),
                    ),
                  ),
                ),

                // Bottom padding
                SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              ],
            ),
          ),
        );
      },
    );
  }
}