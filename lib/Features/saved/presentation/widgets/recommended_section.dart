import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/Features/saved/data/models/recommended_properties_response.dart';
import 'package:stay_match/Features/saved/presentation/manager/saved_properties_cubit.dart';
import 'package:stay_match/Features/saved/presentation/widgets/recommended_item_card.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/routing/app_routing.dart';

class RecommendedSection extends StatelessWidget {
  final RecommendedPropertiesResponse response;
  final VoidCallback onShowMore;

  const RecommendedSection({
    super.key,
    required this.response,
    required this.onShowMore,
  });

  @override
  Widget build(BuildContext context) {
    final items = response.data?.items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ───────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.anthologyCurated,
                style: AppStyles.bold10poppins.copyWith(
                  color: Colors.grey.shade400,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                response.data?.title ?? AppStrings.recommendedForYou,
                style: AppStyles.bold20poppins.copyWith(color: Colors.black),
              ),
              if (response.data?.subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  response.data!.subtitle!,
                  style: AppStyles.regular12poppins.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // ── Items list ────────────────────────────────────────────────────
        if (items.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Center(
              child: Text(
                AppStrings.noRecommendations,
                style: AppStyles.regular14poppins.copyWith(color: Colors.grey),
              ),
            ),
          )
        else
          // Replaced ListView.separated with a clean Column loop to stay secure inside CustomScrollView
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: List.generate(items.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == items.length - 1 ? 0 : 12.h,
                  ),
                  child: RecommendedItemCard(item: items[index]),
                );
              }),
            ),
          ),

        SizedBox(height: 16.h),

        // ── Show more button ──────────────────────────────────────────────
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20.w),
        //   child: GestureDetector(
        //     onTap: onShowMore,
        //     child: Container(
        //       padding: EdgeInsets.symmetric(vertical: 16.h),
        //       decoration: BoxDecoration(
        //         color: Colors.grey.shade100,
        //         borderRadius: BorderRadius.circular(12.r),
        //       ),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text(
        //             AppStrings.showMoreSuggestions,
        //             style: AppStyles.medium14poppins,
        //           ),
        //           SizedBox(width: 6.w),
        //           Icon(Icons.keyboard_arrow_down, size: 18.r),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}