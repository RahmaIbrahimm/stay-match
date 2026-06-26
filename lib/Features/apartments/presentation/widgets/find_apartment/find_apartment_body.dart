// // import 'dart:developer';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// // import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
// // import 'package:stay_match/core/constants/app_colors.dart';
// // import 'package:stay_match/core/constants/app_strings.dart';
// //
// // import '../../../../filter/presentation/widgets/filter_card.dart';
// // import '../../../../filter/presentation/widgets/filter_helper.dart';
// // import '../../../../shared/widgets/no_properties_sliver.dart';
// // import '../../../../shared/widgets/property_body_base.dart';
// // import '../../../../shared/widgets/search_app_bar.dart';
// // import '../../../data/models/all_apartments_response.dart';
// // import '../shared/apartment_card.dart';
// //
// // class FindApartmentBody extends StatefulWidget {
// //   const FindApartmentBody({super.key});
// //
// //   @override
// //   State<FindApartmentBody> createState() => _FindApartmentBodyState();
// // }
// //
// // class _FindApartmentBodyState extends State<FindApartmentBody> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Safely binds the page request listener on initial layout load
// //     context.read<FilterCubit>().initApartmentPagination();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final cubit = context.read<FilterCubit>();
// //
// //     // Wrap with BlocListener to handle side-effects when filters mutate
// //     return BlocListener<FilterCubit, FilterState>(
// //       listener: (context, state) {
// //         // If your Cubit emits a specific state on filter changes, capture it here.
// //         // If it simply re-emits a success state, we force refresh the controller.
// //         if (state is ApartmentFilterSuccess || state is FilterInitial) {
// //           log('Filters changed or reset! Refreshing pagination controller...');
// //           cubit.refreshApartmentPagination();
// //         }
// //       },
// //       child: RPadding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: CustomScrollView(
// //           slivers: [
// //             // ── Persistent Layout Elements ─────────────────────────────────────
// //             PropertyBodyBase.buildHeader(context),
// //             const SearchAppBar(),
// //             PropertyBodyBase.buildFilterHeader(
// //               title: AppStrings.findYourApartment,
// //               subtitle: AppStrings.browseApartment,
// //             ),
// //
// //             // This modifies Cubit states/variables, which triggers our BlocListener above
// //             FilterCard(filterType: PropertyType.apartment),
// //             SliverToBoxAdapter(child: SizedBox(height: 16.h)),
// //
// //             // ── Infinite Scrolling Dynamic List ────────────────────────────────
// //             PagedSliverList<int, AllApartmentsItems>.separated(
// //               pagingController: cubit.apartmentPagingController,
// //               separatorBuilder: (BuildContext context, int index) {
// //                 return SizedBox(height: 16.h);
// //               },
// //               builderDelegate: PagedChildBuilderDelegate<AllApartmentsItems>(
// //                 itemBuilder: (context, item, index) {
// //                   return ApartmentCard(
// //                     scaleUp: true,
// //                     property: item,
// //                   );
// //                 },
// //
// //                 firstPageProgressIndicatorBuilder: (_) => const Padding(
// //                   padding: EdgeInsets.all(32.0),
// //                   child: Center(child: CircularProgressIndicator()),
// //                 ),
// //                 newPageProgressIndicatorBuilder: (_) => const Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 24.0),
// //                   child: Center(child: CircularProgressIndicator()),
// //                 ),
// //                 firstPageErrorIndicatorBuilder: (_) => Padding(
// //                   padding: const EdgeInsets.all(24.0),
// //                   child: Center(
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Text(
// //                           cubit.apartmentPagingController.error?.toString() ?? 'Failed to load apartments',
// //                           textAlign: TextAlign.center,
// //                         ),
// //                         SizedBox(height: 12.h),
// //                         ElevatedButton(
// //                           onPressed: () => cubit.refreshApartmentPagination(),
// //                           child: const Text('Retry'),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //                 noItemsFoundIndicatorBuilder: (_) => const NoPropertiesSliver(),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
// import 'package:stay_match/Features/home/presentation/manager/home_cubit.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
// import 'package:stay_match/core/constants/app_styles.dart';
//
// import '../../../../filter/presentation/widgets/filter_card.dart';
// import '../../../../filter/presentation/widgets/filter_helper.dart';
// import '../../../../shared/widgets/no_properties_sliver.dart';
// import '../../../../shared/widgets/property_body_base.dart';
// import '../../../../shared/widgets/search_app_bar.dart';
// import '../../../data/models/all_apartments_response.dart';
// import '../shared/apartment_card.dart';
//
// class FindApartmentBody extends StatefulWidget {
//   const FindApartmentBody({super.key});
//
//   @override
//   State<FindApartmentBody> createState() => _FindApartmentBodyState();
// }
//
// class _FindApartmentBodyState extends State<FindApartmentBody> {
//   final _searchController = TextEditingController();
//   Timer? _debounce;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<FilterCubit>().initApartmentPagination();
//     _searchController.addListener(_onSearchChanged);
//   }
//
//   @override
//   void dispose() {
//     _searchController.removeListener(_onSearchChanged);
//     _searchController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }
//
//   void _onSearchChanged() {
//     _debounce?.cancel();
//     final q = _searchController.text.trim();
//
//     if (q.isEmpty) {
//       context.read<HomeCubit>().clearSearch();
//       return;
//     }
//
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       context.read<HomeCubit>()
//         ..selectedProperty = HomeSearchFilter.entire
//         ..searchProperties(q: q);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final filterCubit = context.read<FilterCubit>();
//
//     return BlocListener<FilterCubit, FilterState>(
//       listener: (context, state) {
//         if (state is ApartmentFilterSuccess || state is FilterInitial) {
//           log('Filters changed — refreshing pagination...');
//           filterCubit.refreshApartmentPagination();
//         }
//       },
//       child: RPadding(
//         padding: const EdgeInsets.all(16.0),
//         child: CustomScrollView(
//           slivers: [
//             PropertyBodyBase.buildHeader(context),
//
//             // ── Search bar ─────────────────────────────────────────────
//             _ApartmentSearchBar(controller: _searchController),
//
//             PropertyBodyBase.buildFilterHeader(
//               title: AppStrings.findYourApartment,
//               subtitle: AppStrings.browseApartment,
//             ),
//
//             FilterCard(filterType: PropertyType.apartment),
//             SliverToBoxAdapter(child: SizedBox(height: 16.h)),
//
//             // ── Search results OR paginated list ───────────────────────
//             BlocBuilder<HomeCubit, HomeState>(
//               builder: (context, homeState) {
//                 // Show search results when HomeCubit has results
//                 if (homeState is HomeLoading) {
//                   return const SliverFillRemaining(
//                     child: Center(
//                       child: CircularProgressIndicator(
//                           color: AppColors.primary),
//                     ),
//                   );
//                 }
//
//                 if (homeState is HomeSuccess) {
//                   final items =
//                       homeState.response.data?.entireProperties?.items ?? [];
//                   return _SearchResultsSliver(
//                     items: items,
//                     onClear: () {
//                       _searchController.clear();
//                       context.read<HomeCubit>().clearSearch();
//                     },
//                   );
//                 }
//
//                 if (homeState is HomeFailure) {
//                   return SliverFillRemaining(
//                     child: Center(child: Text(homeState.errMessage)),
//                   );
//                 }
//
//                 // Default: normal paginated list
//                 return PagedSliverList<int, AllApartmentsItems>.separated(
//                   pagingController: filterCubit.apartmentPagingController,
//                   separatorBuilder: (_, __) => SizedBox(height: 16.h),
//                   builderDelegate:
//                   PagedChildBuilderDelegate<AllApartmentsItems>(
//                     itemBuilder: (context, item, index) =>
//                         ApartmentCard(scaleUp: true, property: item),
//                     firstPageProgressIndicatorBuilder: (_) => const Padding(
//                       padding: EdgeInsets.all(32.0),
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                     newPageProgressIndicatorBuilder: (_) => const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 24.0),
//                       child: Center(child: CircularProgressIndicator()),
//                     ),
//                     firstPageErrorIndicatorBuilder: (_) => Padding(
//                       padding: const EdgeInsets.all(24.0),
//                       child: Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               filterCubit.apartmentPagingController.error
//                                   ?.toString() ??
//                                   'Failed to load apartments',
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 12.h),
//                             ElevatedButton(
//                               onPressed: () =>
//                                   filterCubit.refreshApartmentPagination(),
//                               child: const Text('Retry'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     noItemsFoundIndicatorBuilder: (_) =>
//                     const NoPropertiesSliver(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Search bar ────────────────────────────────────────────────────────────────
//
// class _ApartmentSearchBar extends StatelessWidget {
//   final TextEditingController controller;
//   const _ApartmentSearchBar({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       floating: true,
//       snap: true,
//
//       leading: Container(),
//       backgroundColor: Colors.white,
//       pinned: true,
//       centerTitle: true,
//       shadowColor: Colors.transparent,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       flexibleSpace: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: 'Search apartments...',
//           suffixIcon: ValueListenableBuilder<TextEditingValue>(
//             valueListenable: controller,
//             builder: (_, value, __) => value.text.isEmpty
//                 ? Icon(Icons.search,
//                 color: AppColors.textColorSecondary, size: 20.sp)
//                 : IconButton(
//               icon: Icon(Icons.clear,
//                   color: AppColors.textColorSecondary, size: 20.sp),
//               onPressed: () {
//                 controller.clear();
//                 context.read<HomeCubit>().clearSearch();
//               },
//             ),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide: BorderSide(
//                 color: AppColors.textColorSecondary, width: 1.r),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide: BorderSide(
//                 color: AppColors.textColorSecondary, width: 1.r),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.r),
//             borderSide:
//             BorderSide(color: AppColors.primary, width: 1.r),
//           ),
//           contentPadding: EdgeInsets.symmetric(
//               horizontal: 12.w, vertical: 8.h),
//         ),
//       ),
//     );
//   }
// }
//
// // ── Search results sliver ─────────────────────────────────────────────────────
//
// class _SearchResultsSliver extends StatelessWidget {
//   final List items;
//   final VoidCallback onClear;
//   const _SearchResultsSliver(
//       {required this.items, required this.onClear});
//
//   @override
//   Widget build(BuildContext context) {
//     if (items.isEmpty) {
//       return SliverFillRemaining(
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.search_off,
//                   size: 48.sp, color: AppColors.textColorSecondary),
//               SizedBox(height: 12.h),
//               Text('No apartments found',
//                   style: AppStyles.medium14poppins.copyWith(color: AppColors.textColorSecondary)),
//               SizedBox(height: 8.h),
//               TextButton(
//                   onPressed: onClear,
//                   child: Text('Clear search',style: AppStyles.bold14poppins.copyWith(color: AppColors.primary)),),
//             ],
//           ),
//         ),
//       );
//     }
//
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//             (context, index) {
//           if (index == 0) {
//             return Padding(
//               padding: EdgeInsets.only(bottom: 12.h),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('${items.length} apartments found'),
//                   TextButton(
//                       onPressed: onClear,
//                       child: Text('Clear',
//                           style: TextStyle(color: AppColors.primary))),
//                 ],
//               ),
//             );
//           }
//           final item = items[index - 1];
//           final adapted = AllApartmentsItems(
//             id: item.id,
//             name: item.name,
//             city: item.city,
//             street: item.street,
//             monthlyRent: item.monthlyRent,
//             numberOfBedrooms: item.numberOfBedrooms,
//             numberOfGuestBathrooms: item.numberOfGuestBathrooms,
//             numberOfEnSuiteBathrooms: item.numberOfEnSuiteBathrooms,
//             size: item.size,
//             coverImageUrl: item.coverImageUrl,
//             isSaved: item.isSaved,
//           );
//           return Padding(
//             padding: EdgeInsets.only(bottom: 16.h),
//             child: ApartmentCard(scaleUp: true, property: adapted),
//           );
//         },
//         childCount: items.length + 1,
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/home/presentation/manager/home_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../filter/presentation/widgets/filter_card.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../../../shared/widgets/no_properties_sliver.dart';
import '../../../../shared/widgets/property_body_base.dart';
import '../../../../shared/widgets/search_app_bar.dart';
import '../../../data/models/all_apartments_response.dart';
import '../shared/apartment_card.dart';

class FindApartmentBody extends StatefulWidget {
  const FindApartmentBody({super.key});

  @override
  State<FindApartmentBody> createState() => _FindApartmentBodyState();
}

class _FindApartmentBodyState extends State<FindApartmentBody> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<FilterCubit>().initApartmentPagination();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
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
        ..selectedProperty = HomeSearchFilter.entire
        ..searchProperties(q: q);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.read<FilterCubit>();

    return BlocListener<FilterCubit, FilterState>(
      listener: (context, state) {
        if (state is ApartmentFilterSuccess || state is FilterInitial) {
          log('Filters changed — refreshing pagination...');
          filterCubit.refreshApartmentPagination();
        }
      },
      child: RPadding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            PropertyBodyBase.buildHeader(context),
            _ApartmentSearchBar(controller: _searchController),
            PropertyBodyBase.buildFilterHeader(
              title: AppStrings.findYourApartment,
              subtitle: AppStrings.browseApartment,
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
                      homeState.response.data?.entireProperties?.items ?? [];
                  return _SearchResultsSliver(
                    items: items,
                    onClear: () {
                      _searchController.clear();
                      context.read<HomeCubit>().clearSearch();
                    },
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
                    FilterCard(filterType: PropertyType.apartment),
                    SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                    PagedSliverList<int, AllApartmentsItems>.separated(
                      pagingController: filterCubit.apartmentPagingController,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      builderDelegate:
                      PagedChildBuilderDelegate<AllApartmentsItems>(
                        itemBuilder: (context, item, index) =>
                            ApartmentCard(scaleUp: true, property: item),
                        firstPageProgressIndicatorBuilder: (_) => const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        newPageProgressIndicatorBuilder: (_) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        firstPageErrorIndicatorBuilder: (_) => Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  filterCubit.apartmentPagingController.error
                                      ?.toString() ??
                                      'Failed to load apartments',
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 12.h),
                                ElevatedButton(
                                  onPressed: () =>
                                      filterCubit.refreshApartmentPagination(),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        noItemsFoundIndicatorBuilder: (_) =>
                        const NoPropertiesSliver(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ApartmentSearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _ApartmentSearchBar({required this.controller});

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
          hintText: 'Search apartments...',
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (_, value, __) => value.text.isEmpty
                ? Icon(Icons.search,
                color: AppColors.textColorSecondary, size: 20.sp)
                : IconButton(
              icon: Icon(Icons.clear,
                  color: AppColors.textColorSecondary, size: 20.sp),
              onPressed: () {
                controller.clear();
                context.read<HomeCubit>().clearSearch();
              },
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

class _SearchResultsSliver extends StatelessWidget {
  final List items;
  final VoidCallback onClear;
  const _SearchResultsSliver({required this.items, required this.onClear});

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
              Text('No apartments found',
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
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${items.length} apartments found'),
                  TextButton(
                    onPressed: onClear,
                    child: Text('Clear',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
            );
          }
          final item = items[index - 1];
          final adapted = AllApartmentsItems(
            id: item.id,
            name: item.name,
            city: item.city,
            street: item.street,
            monthlyRent: item.monthlyRent,
            numberOfBedrooms: item.numberOfBedrooms,
            numberOfGuestBathrooms: item.numberOfGuestBathrooms,
            numberOfEnSuiteBathrooms: item.numberOfEnSuiteBathrooms,
            size: item.size,
            coverImageUrl: item.coverImageUrl,
            isSaved: item.isSaved,
          );
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: ApartmentCard(scaleUp: true, property: adapted),
          );
        },
        childCount: items.length + 1,
      ),
    );
  }
}