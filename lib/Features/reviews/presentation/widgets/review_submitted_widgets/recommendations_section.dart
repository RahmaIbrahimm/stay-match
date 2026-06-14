import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/review_submitted_widgets/review_recommendations_property_card.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/review_submitted_widgets/shimmer_box.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../manager/write_review_cubit.dart';

class RecommendationsSection extends StatelessWidget {
  const RecommendationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteReviewCubit, WriteReviewState>(
      buildWhen: (_, current) =>
          current is RecommendationsLoading ||
          current is RecommendationsSuccess ||
          current is RecommendationsFailure,
      builder: (context, state) {
        if (state is RecommendationsLoading) {
          return const SliverToBoxAdapter(child: _RecommendationsShimmer());
        }

        if (state is RecommendationsFailure) {
          return SliverToBoxAdapter(
            child: _RecommendationsError(
              onRetry: () =>
                  context.read<WriteReviewCubit>().fetchRecommendations(),
            ),
          );
        }

        if (state is RecommendationsSuccess) {
          final properties =
              state.recommendations.data?.recommendedProperties ?? [];
          final stats = state.recommendations.data?.siteStats;

          if (properties.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          // We return a Fragment/Iterable block instead of wrapping it in a layout widget
          return SliverMainAxisGroup(
            slivers: [
              // 1. Section Header Text
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'CURATED JUST FOR YOU',
                        style: AppStyles.bold12manrope.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 2.4,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: AppStyles.bold24plusJakartaSans.copyWith(
                              color: AppColors.textColorPrimary,
                            ),
                          ),
                          Text(
                            'View All',
                            style: AppStyles.bold14manrope.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              // 2. The Main Properties List (Renders directly into the page pipeline)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                sliver: SliverList.separated(
                  itemCount: properties.length,
                  separatorBuilder: (_, __) => SizedBox(height: 24.h),
                  itemBuilder: (context, index) {
                    return ReviewRecommendationPropertyCard(
                      property: properties[index],
                    );
                  },
                ),
              ),

              // 3. Stats section at the bottom
              if (stats != null) ...[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.blueGrey,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 12.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _StatItem(
                                value: stats.totalReviews?.toString() ?? '0',
                                label: 'Reviews',
                              ),
                              _StatDivider(),
                              _StatItem(
                                value:
                                    stats.totalVerifiedHosts?.toString() ?? '0',
                                label: 'Verified Hosts',
                              ),
                              _StatDivider(),
                              _StatItem(
                                value: stats.happyTenants?.toString() ?? '0',
                                label: 'Happy Tenants',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Bottom Safe Spacing
              SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            ],
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyles.bold20poppins.copyWith(color: AppColors.primary),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: AppStyles.regular12poppins.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 32.h, width: 1.w, color: AppColors.stroke);
  }
}

class _RecommendationsShimmer extends StatelessWidget {
  const _RecommendationsShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: 160.w, height: 14.h),
          SizedBox(height: 8.h),
          ShimmerBox(width: 200.w, height: 28.h),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (_, __) =>
                  ShimmerBox(width: 200.w, height: 250.h, borderRadius: 16.r),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendationsError extends StatelessWidget {
  final VoidCallback onRetry;

  const _RecommendationsError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        children: [
          Text(
            'Could not load recommendations',
            style: AppStyles.regular14poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Try again',
              style: AppStyles.semiBold14poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}