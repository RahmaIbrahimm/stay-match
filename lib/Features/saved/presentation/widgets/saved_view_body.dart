// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
// import 'package:stay_match/Features/saved/presentation/widgets/recommended_section.dart';
// import 'package:stay_match/Features/saved/presentation/widgets/saved_header_section.dart';
// import 'package:stay_match/Features/saved/presentation/widgets/saved_property_card.dart';
// import 'package:stay_match/core/constants/app_styles.dart';
// import '../../../../core/constants/app_strings.dart';
// import '../manager/recommended_cubit.dart';
// import '../manager/saved_properties_cubit.dart';
// import 'filter_chips_row.dart';
//
// class SavedViewBody extends StatelessWidget {
//   const SavedViewBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         // ── Header ──────────────────────────────────────────────────────────
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//             child: BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
//               builder: (context, state) {
//                 int totalCount = 0;
//                 if (state is SavedPropertiesSuccess) {
//                   totalCount =
//                       state.response.data?.pagination?.totalCount ?? 0;
//                 }
//                 return SavedHeaderSection(totalCount: totalCount);
//               },
//             ),
//           ),
//         ),
//
//         // ── Filter chips ─────────────────────────────────────────────────────
//         SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
//               builder: (context, state) {
//                 final cubit = context.read<SavedPropertiesCubit>();
//
//                 // read currentType from state when available, fallback to cubit field
//                 final currentType = state is FilterChanged
//                     ? state.currentType
//                     : cubit.currentType;
//
//                 return FilterChipsRow(
//                   currentFilter: currentType,
//                   onFilterChanged: cubit.changeFilter,
//                   stats: state is SavedPropertiesSuccess
//                       ? state.response.data?.stats
//                       : null,
//                 );
//               },
//             ),
//           ),
//         ),
//         SliverToBoxAdapter(child: SizedBox(height: 20.h)),
//
//         // ── Paged saved property list ────────────────────────────────────────
//         BlocListener<SavedPropertiesCubit, SavedPropertiesState>(
//           listener: (context, state) {
//             if (state is SavedPropertiesFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.errMessage)),
//               );
//             }
//             if (state is ToggleSuccess) {
//               context.read<SavedPropertiesCubit>().pagingController.refresh();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text(AppStrings.savedListUpdated)),
//               );
//             }
//           },
//           child: PagedSliverList<int, SavedItems>(
//             pagingController:
//             context.read<SavedPropertiesCubit>().pagingController,
//             builderDelegate: PagedChildBuilderDelegate<SavedItems>(
//               itemBuilder: (context, item, index) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 20.w, vertical: 10.h),
//                   child: BlocBuilder<SavedPropertiesCubit,
//                       SavedPropertiesState>(
//                     builder: (context, state) {
//                       final isToggling = state is ToggleLoading;
//                       return SavedPropertyCard(
//                         item: item,
//                         isToggling: isToggling,
//                         onUnsave: () {
//                           context.read<SavedPropertiesCubit>().toggleSaved(
//                             itemType: item.itemType == 'room'
//                                 ? SavedItemType.room
//                                 : SavedItemType.wholeApartment,
//                             propertyId: item.propertyId,
//                             roomId: item.roomId,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 );
//               },
//               firstPageProgressIndicatorBuilder: (_) => Padding(
//                 padding: EdgeInsets.all(40.r),
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//               newPageProgressIndicatorBuilder: (_) => Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//               firstPageErrorIndicatorBuilder: (context) => _ErrorWidget(
//                 onRetry: () => context
//                     .read<SavedPropertiesCubit>()
//                     .pagingController
//                     .refresh(),
//               ),
//               noItemsFoundIndicatorBuilder: (_) => const _EmptyWidget(),
//             ),
//           ),
//         ),
//
//         // ── Show more properties button ───────────────────────────────────────
//         SliverToBoxAdapter(
//           child: BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
//             builder: (context, state) {
//               final hasMore = state is SavedPropertiesSuccess &&
//                   (state.response.data?.pagination?.hasMore ?? false);
//               if (!hasMore) return const SizedBox.shrink();
//               return Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: 20.w, vertical: 8.h),
//                 child: _ShowMoreButton(
//                   label: AppStrings.showMoreProperties,
//                   onTap: () {},
//                 ),
//               );
//             },
//           ),
//         ),
//
//         SliverToBoxAdapter(child: SizedBox(height: 24.h)),
//
//         // ── Recommended section ──────────────────────────────────────────────
//         SliverToBoxAdapter(
//           child: BlocBuilder<RecommendedCubit, RecommendedState>(
//             builder: (context, state) {
//               if (state is RecommendedLoading) {
//                 return Padding(
//                   padding: EdgeInsets.all(20.r),
//                   child: const Center(child: CircularProgressIndicator()),
//                 );
//               }
//               if (state is RecommendedFailure) {
//                 return Padding(
//                   padding: EdgeInsets.all(20.r),
//                   child: Center(
//                     child: Text(
//                       state.errMessage,
//                       style: AppStyles.regular14poppins
//                           .copyWith(color: Colors.red),
//                     ),
//                   ),
//                 );
//               }
//               if (state is RecommendedSuccess) {
//                 return RecommendedSection(
//                   response: state.response,
//                   onShowMore: () => context
//                       .read<RecommendedCubit>()
//                       .fetchRecommendations(),
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ),
//
//         SliverToBoxAdapter(child: SizedBox(height: 40.h)),
//       ],
//     );
//   }
// }
//
// // ── Error widget ──────────────────────────────────────────────────────────────
//
// class _ErrorWidget extends StatelessWidget {
//   final VoidCallback onRetry;
//   const _ErrorWidget({required this.onRetry});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(32.r),
//         child: Column(
//           children: [
//             Icon(Icons.error_outline, size: 48.r, color: Colors.red),
//             SizedBox(height: 12.h),
//             Text(
//               AppStrings.somethingWentWrong,
//               style: AppStyles.medium14poppins.copyWith(color: Colors.black87),
//             ),
//             SizedBox(height: 12.h),
//             ElevatedButton(
//               onPressed: onRetry,
//               child: Text(
//                 AppStrings.retry,
//                 style: AppStyles.medium14poppins.copyWith(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Empty widget ──────────────────────────────────────────────────────────────
//
// class _EmptyWidget extends StatelessWidget {
//   const _EmptyWidget();
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(48.r),
//         child: Column(
//           children: [
//             Icon(Icons.bookmark_border, size: 64.r, color: Colors.grey),
//             SizedBox(height: 16.h),
//             Text(
//               AppStrings.noSavedProperties,
//               style:
//               AppStyles.medium16poppins.copyWith(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ── Show more button ──────────────────────────────────────────────────────────
//
// class _ShowMoreButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onTap;
//   const _ShowMoreButton({required this.label, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 16.h),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(label, style: AppStyles.medium14poppins),
//             SizedBox(width: 6.w),
//             Icon(Icons.keyboard_arrow_down, size: 18.r),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/saved/data/models/my_saved_response.dart';
import 'package:stay_match/Features/saved/presentation/widgets/recommended_section.dart';
import 'package:stay_match/Features/saved/presentation/widgets/saved_header_section.dart';
import 'package:stay_match/Features/saved/presentation/widgets/saved_property_card.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_strings.dart';
import '../manager/recommended_cubit.dart';
import '../manager/saved_properties_cubit.dart';
import 'filter_chips_row.dart';

class SavedViewBody extends StatelessWidget {
  const SavedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        var savedCubit = context.read<SavedPropertiesCubit>();
        var recCubit = context.read<RecommendedCubit>();
        savedCubit.pagingController.refresh();
        await recCubit.fetchRecommendations();
      },
      child: CustomScrollView(
        slivers: [
          // ── Header ──────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
                builder: (context, state) {
                  int totalCount = 0;
                  if (state is SavedPropertiesSuccess) {
                    totalCount =
                        state.response.data?.pagination?.totalCount ?? 0;
                  }
                  return SavedHeaderSection(totalCount: totalCount);
                },
              ),
            ),
          ),

          // ── Filter chips ─────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
                builder: (context, state) {
                  final cubit = context.read<SavedPropertiesCubit>();

                  // read currentType from state when available, fallback to cubit field
                  final currentType = state is FilterChanged
                      ? state.currentType
                      : cubit.currentType;

                  return FilterChipsRow(
                    currentFilter: currentType,
                    onFilterChanged: cubit.changeFilter,
                    stats: state is SavedPropertiesSuccess
                        ? state.response.data?.stats
                        : null,
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // ── Paged saved property list ────────────────────────────────────────
          // ── Paged saved property list ────────────────────────────────────────
          BlocListener<SavedPropertiesCubit, SavedPropertiesState>(
            listener: (context, state) {
              if (state is SavedPropertiesFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage)));
              }
              if (state is ToggleSuccess) {
                context.read<SavedPropertiesCubit>().pagingController.refresh();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.savedListUpdated)),
                );
              }
            },
            child: PagedSliverList<int, SavedItems>(
              pagingController: context
                  .read<SavedPropertiesCubit>()
                  .pagingController,
              builderDelegate: PagedChildBuilderDelegate<SavedItems>(
                itemBuilder: (context, item, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child:
                        BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
                          builder: (context, state) {
                            final isToggling = state is ToggleLoading;
                            return SavedPropertyCard(
                              item: item,
                              isToggling: isToggling,
                              onUnsave: () {
                                context
                                    .read<SavedPropertiesCubit>()
                                    .toggleSaved(
                                      itemType: item.itemType == 'room'
                                          ? SavedItemType.room
                                          : SavedItemType.wholeApartment,
                                      propertyId: item.propertyId,
                                      roomId: item.roomId,
                                    );
                              },
                            );
                          },
                        ),
                  );
                },
                firstPageProgressIndicatorBuilder: (_) => Padding(
                  padding: EdgeInsets.all(40.r),
                  child: const Center(child: CircularProgressIndicator()),
                ),
                newPageProgressIndicatorBuilder: (_) => Padding(
                  padding: EdgeInsets.all(20.r),
                  child: const Center(child: CircularProgressIndicator()),
                ),

                // FIXED: Return the _ErrorWidget directly without SliverFillRemaining
                firstPageErrorIndicatorBuilder: (context) => _ErrorWidget(
                  onRetry: () => context
                      .read<SavedPropertiesCubit>()
                      .pagingController
                      .refresh(),
                ),

                // FIXED: Return the _EmptyWidget directly without SliverFillRemaining
                noItemsFoundIndicatorBuilder: (_) => const _EmptyWidget(),
              ),
            ),
          ),

          // ── Show more properties button ───────────────────────────────────────
          // SliverToBoxAdapter(
          //   child: BlocBuilder<SavedPropertiesCubit, SavedPropertiesState>(
          //     builder: (context, state) {
          //       final hasMore = state is SavedPropertiesSuccess &&
          //           (state.response.data?.pagination?.hasMore ?? false);
          //       if (!hasMore) return const SizedBox.shrink();
          //       return Padding(
          //         padding: EdgeInsets.symmetric(
          //             horizontal: 20.w, vertical: 8.h),
          //         child: _ShowMoreButton(
          //           label: AppStrings.showMoreProperties,
          //           onTap: () {},
          //         ),
          //       );
          //     },
          //   ),
          // ),
          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          // ── Recommended section ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: BlocBuilder<RecommendedCubit, RecommendedState>(
              builder: (context, state) {
                if (state is RecommendedLoading) {
                  return Padding(
                    padding: EdgeInsets.all(20.r),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is RecommendedFailure) {
                  return Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Center(
                      child: Text(
                        state.errMessage,
                        style: AppStyles.regular14poppins.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                }
                if (state is RecommendedSuccess) {
                  return RecommendedSection(
                    response: state.response,
                    onShowMore: () =>
                        context.read<RecommendedCubit>().fetchRecommendations(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
        ],
      ),
    );
  }
}

// ── Error widget ──────────────────────────────────────────────────────────────

class _ErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorWidget({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Aligns content correctly inside viewport limits
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.r, color: Colors.red),
            SizedBox(height: 12.h),
            Text(
              AppStrings.somethingWentWrong,
              style: AppStyles.medium14poppins.copyWith(color: Colors.black87),
            ),
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(
                AppStrings.retry,
                style: AppStyles.medium14poppins.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty widget ──────────────────────────────────────────────────────────────

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Aligns content correctly inside viewport limits
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmark_border, size: 64.r, color: Colors.grey),
            SizedBox(height: 16.h),
            Text(
              AppStrings.noSavedProperties,
              style: AppStyles.medium16poppins.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Show more button ──────────────────────────────────────────────────────────

class _ShowMoreButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ShowMoreButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: AppStyles.medium14poppins),
            SizedBox(width: 6.w),
            Icon(Icons.keyboard_arrow_down, size: 18.r),
          ],
        ),
      ),
    );
  }
}