import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../../core/constants/app_styles.dart';
import '../../../../shared/widgets/search_app_bar.dart';
import '../../manager/apartment_cubit.dart';
import '../shared/apartment_card.dart';

class FindApartmentBody extends StatelessWidget {
  const FindApartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApartmentCubit, ApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          var propertiesData = state.response.data?.items ?? [];
          return RPadding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                //AppBar(
                //       surfaceTintColor: Colors.transparent,
                //       leading: IconButton(
                //         onPressed: () async {
                //           if (context.canPop()) context.pop(true);
                //         },
                //         icon: Icon(Icons.arrow_back, color: AppColors.primary),
                //       ),
                //       title: Text(
                //         title,
                //         style: AppStyles.bold18poppins.copyWith(
                //           color: AppColors.textColorPrimary,
                //           letterSpacing: -0.45.r,
                //         ),
                //       ),
                //       actions: [Icon(Icons.share, color: AppColors.primary)],
                //       centerTitle: true,
                //
                //       backgroundColor: Colors.white.withValues(alpha: 0.8),
                //     )
                // SliverAppBar(
                //   leading: IconButton(
                //     onPressed: () async {
                //       if (context.canPop()) context.pop(true);
                //     },
                //     icon: Icon(Icons.arrow_back, color: AppColors.primary),
                //   ),
                //   title: Text(
                //     AppStrings.apartmentDetails,
                //     style: AppStyles.bold18poppins.copyWith(
                //       color: AppColors.textColorPrimary,
                //       letterSpacing: -0.45.r,
                //     ),
                //   ),
                //   backgroundColor: Colors.white.withValues(alpha: 0.8),
                //
                // ),
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
                SliverToBoxAdapter(child: SizedBox(height: 16.h,),),
                propertiesData.isEmpty
                    ? SliverToBoxAdapter(
                  child: Center(
                    child: RPadding(
                      padding: EdgeInsets.all(32.0.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.house_outlined,
                            size: 100.sp,
                            color: AppColors.primary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No Apartments Available',
                            style: AppStyles.bold28poppins.copyWith(
                              color: AppColors.textColorPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'At the Moment',
                            style: AppStyles.bold28poppins.copyWith(
                              color: AppColors.textColorSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.all(16.r),
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.r,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              'Please check again later.\nNew apartments are added regularly!',
                              style: AppStyles.regular16poppins.copyWith(
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
        } else if (state is GetApartmentsFailure) {
          log(state.errMessage);
          return Text(state.errMessage);
        } else if (state is GetApartmentsLoading) {
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