import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/other_user_profile/presentation/widgets/user_review_card.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../manager/other_user_profile_cubit.dart';
import 'compatibility_section.dart';
import 'host_card.dart';
import 'listing_card.dart';

class OtherUserProfileBody extends StatelessWidget {
  const OtherUserProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryScaffBg,
      appBar: AppBar(
        backgroundColor: AppColors.containerColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.textColorPrimary,
            size: 24.r,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Stay Match',
          style: AppStyles.bold18poppins.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: AppColors.textColorPrimary,
              size: 24.r,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<OtherUserProfileCubit, OtherUserProfileState>(
        builder: (context, state) {
          if (state is OtherUserProfileLoading) {
            return const _LoadingView();
          }

          if (state is OtherUserProfileFailure) {
            return _ErrorView(
              message: state.errMessage,
              onRetry: () => context.read<OtherUserProfileCubit>().retry(),
            );
          }

          if (state is OtherUserProfileSuccess) {
            final data = state.profile.data;

            if (data == null) {
              return const _ErrorView(message: 'No profile data found.');
            }

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HostCard(hostInfo: data.hostInfo),
                  SizedBox(height: 16.h),
                  const CompatibilitySection(),
                  SizedBox(height: 24.h),
                  Text(
                    'Active Listings',
                    style: AppStyles.bold18poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (data.activeListings == null ||
                      data.activeListings!.isEmpty)
                    _EmptyState(message: 'No active listings yet.')
                  else
                    ...data.activeListings!.map(
                      (listing) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: ListingCard(listing: listing),
                      ),
                    ),
                  SizedBox(height: 24.h),
                  Text(
                    'Recent Reviews',
                    style: AppStyles.bold18poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  if (data.recentReviews == null || data.recentReviews!.isEmpty)
                    _EmptyState(message: 'No reviews yet.')
                  else
                    ...data.recentReviews!.map(
                      (review) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: UserReviewCard(review: review),
                      ),
                    ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColors.primary));
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorView({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.r,
              color: AppColors.textColorError,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.regular14poppins.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
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
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String message;

  const _EmptyState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppStyles.regular14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      ),
    );
  }
}