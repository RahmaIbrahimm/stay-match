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

  @override
  void initState() {
    super.initState();
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
    var cubit = context.read<FilterCubit>();

    return BlocListener<FilterCubit, FilterState>(
      // FIX: Only trigger a refresh when the state resets to FilterInitial.
      // When your filter sheets close, make sure your Cubit emits FilterInitial() to kick off page 1 fetch!
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
              const SearchAppBar(),
              PropertyBodyBase.buildFilterHeader(
                title: AppStrings.findYourRoom,
                subtitle: AppStrings.browseRoom,
              ),

              BlocBuilder<FilterCubit, FilterState>(
                builder: (context, state) {
                  return FilterCard(filterType: PropertyType.room);
                },
              ),

              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // PagedSliverGrid<int, Items>(
              //   pagingController: _pagingController,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: screenWidth < 360 ? 8.r : 16.r,
              //     crossAxisSpacing: 10.r,
              //     childAspectRatio: aspectRatio,
              //   ),
              //   builderDelegate: PagedChildBuilderDelegate<Items>(
              //     itemBuilder: (context, item, index) => RoomCard(
              //       coverImageUrl: item.coverImageUrl,
              //       name: item.name,
              //       street: item.street,
              //       city: item.city,
              //       rooms: item.rooms ?? [],
              //       id: item.id!.toInt(),
              //     ),
              //     firstPageProgressIndicatorBuilder: (_) => const Center(
              //       child: CircularProgressIndicator(color: AppColors.primary),
              //     ),
              //     newPageProgressIndicatorBuilder: (_) => const Center(
              //       child: CircularProgressIndicator(color: AppColors.primary),
              //     ),
              //     noItemsFoundIndicatorBuilder: (_) => const NoPropertiesSliver(),
              //     firstPageErrorIndicatorBuilder: (context) => GlobalErrorWidget(
              //       onTryAgain: () => _pagingController.refresh(),
              //     ),
              //     newPageErrorIndicatorBuilder: (context) => Center(
              //       child: TextButton(
              //         onPressed: () => _pagingController.retryLastFailedRequest(),
              //         child: const Text('Retry'),
              //       ),
              //     ),
              //   ),
              // ),
              // --- REMOVE PagedSliverGrid and replace with PagedSliverList ---
              PagedSliverList<int, Items>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Items>(
                  itemBuilder: (context, item, index) => Padding(
                    // Add comfortable spacing between vertical full-width cards
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: RoomCard(
                      coverImageUrl: item.coverImageUrl,
                      name: item.name,
                      street: item.street,
                      city: item.city,
                      rooms: item.rooms ?? [],
                      id: item.id!.toInt(),
                      scaleUp: true, // Set to true since it's full width now!
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
                          // Subtle background circle with an alert icon
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

                          // Error Message
                          Text(
                            _pagingController.error?.toString() ?? 'Something went wrong while fetching data.',
                            textAlign: TextAlign.center,
                            style: AppStyles.medium14poppins.copyWith(
                              color: AppColors.textColorPrimary,
                            ),
                          ),
                          SizedBox(height: 6.h),

                          // Secondary helpful hint text
                          Text(
                            'Please check your internet connection or reset filters and try again.',
                            textAlign: TextAlign.center,
                            style: AppStyles.medium12poppins.copyWith(
                              color: AppColors.textColorSecondary,
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Stylized Retry Button
                          SizedBox(
                            width: 140.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                // Resetting filters completely clears state anomalies
                                cubit.resetRoomsFilters();
                              },
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
                      onPressed: () => _pagingController.retryLastFailedRequest(),
                      child: const Text('Retry'),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            ],
          ),
        ),
      ),
    );
  }
}