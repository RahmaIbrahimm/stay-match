// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
// import 'package:stay_match/Features/rooms/data/models/get_all_rooms.dart';
// import 'package:stay_match/Features/rooms/presentation/widgets/shared/room_card.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/core/widgets/global_error_widget.dart';
//
// import '../../../../../core/constants/app_styles.dart';
// import '../../../../filter/presentation/widgets/filter_card.dart';
// import '../../../../filter/presentation/widgets/filter_helper.dart';
// import '../../../../shared/widgets/no_properties_sliver.dart';
// import '../../../../shared/widgets/property_body_base.dart';
// import '../../../../shared/widgets/search_app_bar.dart';
//
// class FindRoomBody extends StatefulWidget {
//   const FindRoomBody({super.key});
//
//   @override
//   State<FindRoomBody> createState() => _FindRoomBodyState();
// }
//
// class _FindRoomBodyState extends State<FindRoomBody> {
//   final PagingController<int, Items> _pagingController =
//   PagingController(firstPageKey: 1);
//
//   @override
//   void initState() {
//     super.initState();
//     _pagingController.addPageRequestListener((pageKey) {
//       context.read<FilterCubit>().fetchRoomsPage(pageKey, _pagingController);
//     });
//   }
//
//   @override
//   void dispose() {
//     _pagingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var cubit = context.read<FilterCubit>();
//
//     return BlocListener<FilterCubit, FilterState>(
//       // FIX: Only trigger a refresh when the state resets to FilterInitial.
//       // When your filter sheets close, make sure your Cubit emits FilterInitial() to kick off page 1 fetch!
//       listenWhen: (previous, current) => current is FilterInitial,
//       listener: (context, state) {
//         _pagingController.refresh();
//       },
//       child: RefreshIndicator(
//         onRefresh: () => Future.sync(() => _pagingController.refresh()),
//         child: RPadding(
//           padding: EdgeInsets.all(16.0.r),
//           child: CustomScrollView(
//             slivers: [
//               PropertyBodyBase.buildHeader(context),
//               const SearchAppBar(),
//               PropertyBodyBase.buildFilterHeader(
//                 title: AppStrings.findYourRoom,
//                 subtitle: AppStrings.browseRoom,
//               ),
//
//               BlocBuilder<FilterCubit, FilterState>(
//                 builder: (context, state) {
//                   return FilterCard(filterType: PropertyType.room);
//                 },
//               ),
//
//               SliverToBoxAdapter(child: SizedBox(height: 16.h)),
//
//               PagedSliverList<int, Items>(
//                 pagingController: _pagingController,
//                 builderDelegate: PagedChildBuilderDelegate<Items>(
//                   itemBuilder: (context, item, index) => Padding(
//                     // Add comfortable spacing between vertical full-width cards
//                     padding: EdgeInsets.only(bottom: 16.h),
//                     child: RoomCard(
//                       coverImageUrl: item.coverImageUrl,
//                       name: item.name,
//                       street: item.street,
//                       city: item.city,
//                       rooms: item.rooms ?? [],
//                       id: item.id!.toInt(),
//                       scaleUp: true, item: item,
//                     ),
//                   ),
//                   firstPageProgressIndicatorBuilder: (_) => const Center(
//                     child: CircularProgressIndicator(color: AppColors.primary),
//                   ),
//                   newPageProgressIndicatorBuilder: (_) => const Center(
//                     child: CircularProgressIndicator(color: AppColors.primary),
//                   ),
//                   noItemsFoundIndicatorBuilder: (_) => const NoPropertiesSliver(),
//                   firstPageErrorIndicatorBuilder: (context) => Padding(
//                     padding: EdgeInsets.all(24.r),
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Subtle background circle with an alert icon
//                           Container(
//                             padding: EdgeInsets.all(16.r),
//                             decoration: BoxDecoration(
//                               color: AppColors.primary.withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.error_outline_rounded,
//                               color: AppColors.primary,
//                               size: 40.r,
//                             ),
//                           ),
//                           SizedBox(height: 16.h),
//
//                           // Error Message
//                           Text(
//                             _pagingController.error?.toString() ?? 'Something went wrong while fetching data.',
//                             textAlign: TextAlign.center,
//                             style: AppStyles.medium14poppins.copyWith(
//                               color: AppColors.textColorPrimary,
//                             ),
//                           ),
//                           SizedBox(height: 6.h),
//
//                           // Secondary helpful hint text
//                           Text(
//                             'Please check your internet connection or reset filters and try again.',
//                             textAlign: TextAlign.center,
//                             style: AppStyles.medium12poppins.copyWith(
//                               color: AppColors.textColorSecondary,
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//
//                           // Stylized Retry Button
//                           SizedBox(
//                             width: 140.w,
//                             height: 40.h,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // Resetting filters completely clears state anomalies
//                                 cubit.resetRoomsFilters();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.primary,
//                                 foregroundColor: Colors.white,
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8.r),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Retry',
//                                 style: AppStyles.semiBold14poppins,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   newPageErrorIndicatorBuilder: (context) => Center(
//                     child: TextButton(
//                       onPressed: () => _pagingController.retryLastFailedRequest(),
//                       child: const Text('Retry'),
//                     ),
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(child: SizedBox(height: 30.h)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/home/data/models/properties_general_search.dart';
import 'package:stay_match/Features/home/presentation/manager/home_cubit.dart';
import 'package:stay_match/Features/rooms/data/models/get_all_rooms.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared/room_card.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../../core/constants/app_styles.dart';
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
  final PagingController<int, Items> _pagingController =
  PagingController(firstPageKey: 1);
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<FilterCubit>().fetchRoomsPage(pageKey, _pagingController);
    });
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    final q = _searchController.text.trim();

    if (q.isEmpty) {
      context.read<HomeCubit>().clearSearch();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<HomeCubit>()
        ..selectedProperty = HomeSearchFilter.shared
        ..searchProperties(q: q);
    });
  }

  List<AllRooms> _mapRooms(List<Rooms>? rooms) => (rooms ?? [])
      .map((r) => AllRooms(
    id: r.id,
    roomName: r.roomName,
    monthRent: r.monthRent,
    isAvailable: r.isAvailable,
    availableFrom: r.availableFrom,
    status: r.status,
  ))
      .toList();

  void _clearSearch() {
    _searchController.clear();
    context.read<HomeCubit>().clearSearch();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterCubit>();

    return BlocListener<FilterCubit, FilterState>(
      listenWhen: (previous, current) => current is FilterInitial,
      listener: (context, state) {
        _pagingController.refresh();
      },
      child: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: RPadding(
          padding: EdgeInsets.all(16.0.r),
          child: CustomScrollView(
            slivers: [
              PropertyBodyBase.buildHeader(context),
              _RoomSearchBar(controller: _searchController, onClear: _clearSearch),
              PropertyBodyBase.buildFilterHeader(
                title: AppStrings.findYourRoom,
                subtitle: AppStrings.browseRoom,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, homeState) {
                  if (homeState is HomeLoading) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      ),
                    );
                  }

                  if (homeState is HomeSuccess) {
                    final items =
                        homeState.response.data?.sharedProperties?.items ?? [];
                    return _RoomSearchResultsSliver(
                      items: items,
                      mapRooms: _mapRooms,
                      onClear: _clearSearch,
                    );
                  }

                  if (homeState is HomeFailure) {
                    return SliverFillRemaining(
                      child: Center(child: Text(homeState.errMessage)),
                    );
                  }

                  // Default: filter card + paginated list
                  return SliverMainAxisGroup(
                    slivers: [
                      BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, state) {
                          return FilterCard(filterType: PropertyType.room);
                        },
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                      PagedSliverList<int, Items>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<Items>(
                          itemBuilder: (context, item, index) => Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: RoomCard(
                              coverImageUrl: item.coverImageUrl,
                              name: item.name,
                              street: item.street,
                              city: item.city,
                              rooms: item.rooms ?? [],
                              id: item.id!.toInt(),
                              scaleUp: true,
                              item: item,
                            ),
                          ),
                          firstPageProgressIndicatorBuilder: (_) => const Center(
                            child: CircularProgressIndicator(color: AppColors.primary),
                          ),
                          newPageProgressIndicatorBuilder: (_) => const Center(
                            child: CircularProgressIndicator(color: AppColors.primary),
                          ),
                          noItemsFoundIndicatorBuilder: (_) => const NoPropertiesSliver(),
                          firstPageErrorIndicatorBuilder: (context) => Padding(
                            padding: EdgeInsets.all(24.r),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: AppColors.primary,
                                      size: 40.r,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    _pagingController.error?.toString() ??
                                        'Something went wrong while fetching data.',
                                    textAlign: TextAlign.center,
                                    style: AppStyles.medium14poppins.copyWith(
                                      color: AppColors.textColorPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'Please check your internet connection or reset filters and try again.',
                                    textAlign: TextAlign.center,
                                    style: AppStyles.medium12poppins.copyWith(
                                      color: AppColors.textColorSecondary,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: 140.w,
                                    height: 40.h,
                                    child: ElevatedButton(
                                      onPressed: () => cubit.resetRoomsFilters(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                      ),
                                      child: Text(
                                        'Retry',
                                        style: AppStyles.semiBold14poppins,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          newPageErrorIndicatorBuilder: (context) => Center(
                            child: TextButton(
                              onPressed: () =>
                                  _pagingController.retryLastFailedRequest(),
                              child: const Text('Retry'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;
  const _RoomSearchBar({required this.controller, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      leading: Container(),
      backgroundColor: Colors.white,
      pinned: true,
      centerTitle: true,
      shadowColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Search rooms...',
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) => value.text.isEmpty
                ? Icon(Icons.search,
                color: AppColors.textColorSecondary, size: 20.sp)
                : IconButton(
              icon: Icon(Icons.clear,
                  color: AppColors.textColorSecondary, size: 20.sp),
              onPressed: onClear,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide:
            BorderSide(color: AppColors.textColorSecondary, width: 1.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide:
            BorderSide(color: AppColors.textColorSecondary, width: 1.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primary, width: 1.r),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        ),
      ),
    );
  }
}

class _RoomSearchResultsSliver extends StatelessWidget {
  final List<SharedItems> items;
  final List<AllRooms> Function(List<Rooms>?) mapRooms;
  final VoidCallback onClear;
  const _RoomSearchResultsSliver({
    required this.items,
    required this.mapRooms,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off,
                  size: 48.sp, color: AppColors.textColorSecondary),
              SizedBox(height: 12.h),
              Text('No rooms found',
                  style: AppStyles.medium14poppins
                      .copyWith(color: AppColors.textColorSecondary)),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: onClear,
                child: Text('Clear search',
                    style: AppStyles.bold14poppins
                        .copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h,top: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${items.length} rooms found'),
                  TextButton(
                    onPressed: onClear,
                    child: Text('Clear',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
            );
          }
          final SharedItems item = items[index - 1];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: RoomCard(
              coverImageUrl: item.coverImageUrl,
              name: item.name,
              street: item.street,
              city: item.city,
              rooms: mapRooms(item.rooms),
              id: item.id ?? -1,
              scaleUp: true,
              item: null,
            ),
          );
        },
        childCount: items.length + 1,
      ),
    );
  }
}