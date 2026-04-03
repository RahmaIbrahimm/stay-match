import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';

import '../../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../../core/constants/app_styles.dart';
import '../../../../filter/presentation/widgets/filter_card.dart';
import '../../../../filter/presentation/widgets/filter_helper.dart';
import '../../../../shared/widgets/no_properties_sliver.dart';
import '../../../../shared/widgets/search_app_bar.dart';
import '../shared/apartment_card.dart';

class FindApartmentBody extends StatelessWidget {
  const FindApartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Load apartments when widget first appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<FilterCubit>();
      if (cubit.state is FilterInitial) {
        log('Initial load of apartments');
        cubit.getAllApartments();
      }
    });

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        if (state is FilterInitial) {
          _buildLoadingStateInitial();
        }
        if (state is ApartmentFilterSuccess) {
          var propertiesData = state.response.data?.items ?? [];
          log('Displaying ${propertiesData
              .length} apartments, sortOrder: ${context
              .read<FilterCubit>()
              .currentApartmentFilters
              .orderByOldest}');

          return RPadding(
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
                const SearchAppBar(),
                _buildFilterHeader(),
                FilterCard(filterType: PropertyType.apartment,),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                propertiesData.isEmpty
                    ? const NoPropertiesSliver()
                    : SliverList.separated(
                  itemCount: propertiesData.length,
                  itemBuilder: (context, index) {
                    return ApartmentCard(
                      scaleUp: true,
                      property: propertiesData[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 16.h);
                  },
                ),
              ],
            ),
          );
        }
        else if (state is ApartmentFilterFailure) {
          log(state.errMessage);
          return _buildErrorState(context, state.errMessage);
        }
        else if (state is ApartmentFilterLoading) {
          return _buildLoadingState(context);
        }

        return _buildInitialState(context);
      },
    );
  }

  SliverToBoxAdapter _buildFilterHeader() {
    return SliverToBoxAdapter(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Find your Apartment',
              style: AppStyles.bold24poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            TextSpan(
              text: '\n${AppStrings.browseApartment}',
              style: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for filter prompts
  String _getWherePrompt(BuildContext context) {
    final cubit = context.read<FilterCubit>();
    final government = cubit.currentApartmentFilters.government;
    if (government != null && government.isNotEmpty) {
      return '\n$government';
    }
    return '\nSearch Destinations';
  }

  String _getWhenPrompt(BuildContext context) {
    final cubit = context.read<FilterCubit>();
    final start = cubit.currentApartmentFilters.start;
    final monthsCount = cubit.currentApartmentFilters.monthsCount;

    if (start != null && start.isNotEmpty) {
      if (monthsCount != null) {
        return '\n$start ($monthsCount months)';
      }
      return '\n$start';
    }
    return '\nSearch Dates';
  }


  bool _hasActiveFilters(BuildContext context) {
    final cubit = context.read<FilterCubit>();
    final filters = cubit.currentApartmentFilters;

    return filters.government != null ||
        filters.start != null ||
        filters.monthsCount != null ||
        filters.allowsFamilies != null ||
        filters.allowsChildren != null ||
        filters.allowsStudents != null ||
        filters.workerGender != null ||
        filters.onlyAvailable == true;
        // || filters.orderByOldest == true;
  }

  GestureDetector _searchPrompt({
    required String titleText,
    required String prompt,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(

        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: titleText,
              style: AppStyles.semiBold16poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
            TextSpan(
              text: prompt,
              style: AppStyles.regular18poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.textColorError.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 50.sp,
                color: AppColors.textColorError,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Oops! Something went wrong',
              style: AppStyles.bold20poppins,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              errorMessage,
              style: AppStyles.medium14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FilterCubit>().getAllApartments(
                        forceRefresh: true,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        // horizontal: 32.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: AppStyles.semiBold16poppins.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if(context.canPop()) context.pop();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: AppStyles.semiBold16poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingStateInitial() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(50.r),
            width: 60.w,
            height: 60.w,
            child: CircularProgressIndicator(
              strokeWidth: 3.w,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Finding apartments for you...',
            style: AppStyles.medium16poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return RPadding(
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
          const SearchAppBar(),
          _buildFilterHeader(),
          FilterCard(filterType: PropertyType.apartment,),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(child: _buildLoadingStateInitial()
            ,)
        ],
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apartment_rounded,
            size: 80.sp,
            color: AppColors.primary.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'Ready to find your perfect stay?',
            style: AppStyles.medium16poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<FilterCubit>().getAllApartments();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Start Searching',
              style: AppStyles.semiBold16poppins.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}