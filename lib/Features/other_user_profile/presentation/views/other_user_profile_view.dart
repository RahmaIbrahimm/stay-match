import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/Features/other_user_profile/data/repos/other_user_profile_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../manager/other_user_profile_cubit.dart';

class OtherUserProfileView extends StatelessWidget {
  final String userId;

  const OtherUserProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtherUserProfileCubit(
        otherUserProfileRepo: getIt.get<OtherUserProfileRepoImpl>(),
      )..getOtherUserProfile(userId: userId),
      child: const _OtherUserProfileContent(),
    );
  }
}

// ── Main scaffold ─────────────────────────────────────────────────────────────

class _OtherUserProfileContent extends StatelessWidget {
  const _OtherUserProfileContent();

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
                  _HostCard(hostInfo: data.hostInfo),
                  SizedBox(height: 16.h),
                  const _CompatibilitySection(),
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
                        child: _ListingCard(listing: listing),
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
                        child: _ReviewCard(review: review),
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

// ── Host card ─────────────────────────────────────────────────────────────────

class _HostCard extends StatelessWidget {
  final HostInfo? hostInfo;

  const _HostCard({this.hostInfo});

  @override
  Widget build(BuildContext context) {
    final status = (hostInfo?.status ?? '').toLowerCase();
    final isSuspended = status == 'suspended';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          // Avatar with super-host badge
          Stack(
            children: [
              CircleAvatar(
                radius: 44.r,
                backgroundColor: AppColors.bgGrey,
                backgroundImage:
                    hostInfo?.hostImage != null &&
                        hostInfo!.hostImage!.isNotEmpty
                    ? CachedNetworkImageProvider(hostInfo!.hostImage!)
                    : null,
                child:
                    hostInfo?.hostImage == null || hostInfo!.hostImage!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 44.r,
                        color: AppColors.textColorSecondary,
                      )
                    : null,
              ),
              if (hostInfo?.isSuperHost == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.containerColor,
                        width: 2.r,
                      ),
                    ),
                    child: Icon(
                      Icons.verified,
                      size: 14.r,
                      color: AppColors.textColorWhite,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // Name
          Text(
            hostInfo?.hostName ?? 'Unknown Host',
            style: AppStyles.semiBold18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          SizedBox(height: 8.h),

          // Status badge
          _StatusBadge(status: hostInfo?.status),

          SizedBox(height: 16.h),
          Divider(height: 1, color: AppColors.stroke),
          SizedBox(height: 16.h),

          // Stats row
          Row(
            children: [
              _StatColumn(
                value: hostInfo?.rating != null
                    ? hostInfo!.rating!.toStringAsFixed(1)
                    : '—',
                label: 'RATING',
              ),
              _StatDivider(),
              _StatColumn(
                value: hostInfo?.rentalsCount?.toString() ?? '0',
                label: 'RENTALS',
              ),
              _StatDivider(),
              _StatColumn(
                value: hostInfo?.reviewsCount?.toString() ?? '0',
                label: 'REVIEWS',
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Contact Host button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: CustomElevatedButton(
              text: 'Contact Host',
              // TODO: navigate to chat screen with hostInfo?.hostId via ChatService/ChatRepoImpl
              onPressed: isSuspended
                  ? null
                  : () {
                      // TODO: context.pushNamed(AppRouting.chatView, extra: hostInfo?.hostId);
                      if (context.mounted) {
                        context.pushNamed(
                          AppRouting.messagesName,
                          pathParameters: {
                            'otherUserId': hostInfo?.hostId.toString() ?? '',
                          },
                        );
                      }
                    },
              backgroundColor: isSuspended
                  ? AppColors.textColorSecondary
                  : AppColors.primary,
              textColor: AppColors.textColorWhite,
              textStyle: AppStyles.semiBold16poppins,
              borderRadius: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String? status;

  const _StatusBadge({this.status});

  @override
  Widget build(BuildContext context) {
    final normalized = (status ?? '').toLowerCase();

    Color bgColor;
    Color textColor;
    IconData? icon;
    String label;

    switch (normalized) {
      case 'verified':
        bgColor = const Color(0xFFE3F6EA);
        textColor = const Color(0xFF1E9E5C);
        icon = Icons.check_circle;
        label = 'Verified';
        break;
      case 'suspended':
        bgColor = const Color(0xFFE0473E);
        textColor = AppColors.textColorWhite;
        icon = null;
        label = 'Suspended';
        break;
      case 'pending':
        bgColor = const Color(0xFFF5B82E);
        textColor = AppColors.textColorWhite;
        icon = null;
        label = 'Pending';
        break;
      default:
        bgColor = AppColors.bgGrey;
        textColor = AppColors.textColorSecondary;
        icon = null;
        label = status ?? 'Unknown';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.r, color: textColor),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: AppStyles.semiBold12poppins.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

// ── Stat column / divider ───────────────────────────────────────────────────────

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: AppStyles.medium16inter.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: AppStyles.medium12inter.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 32.h, width: 1.w, color: AppColors.stroke);
  }
}

// ── Compatibility section ───────────────────────────────────────────────────────

// TODO: This entire section uses static placeholder data.
// Replace with real values once a "compatibility" endpoint/model exists.
// Expected shape (suggested): { score: int, items: [{ title, description, status: matched|info|mismatched }] }
class _CompatibilitySection extends StatelessWidget {
  const _CompatibilitySection();

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real compatibility score from API
    const compatibilityScore = 94;

    // TODO: replace with real compatibility items from API
    const items = [
      _CompatibilityItemData(
        icon: Icons.check,
        iconBg: Color(0xFFE3F6EA),
        iconColor: Color(0xFF1E9E5C),
        title: 'Quiet Hours',
        description: 'Both prefer quiet after 10 PM.',
      ),
      _CompatibilityItemData(
        icon: Icons.check,
        iconBg: Color(0xFFE3F6EA),
        iconColor: Color(0xFF1E9E5C),
        title: 'No Smoking',
        description: 'Ahmed maintains a smoke-free environment.',
      ),
      _CompatibilityItemData(
        icon: Icons.info_outline,
        iconBg: Color(0xFFE3ECFB),
        iconColor: Color(0xFF3B6FE0),
        title: 'Pet Policy',
        description: 'Ahmed prefers small pets only.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Compatibility',
                style: AppStyles.semiBold16poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              Text(
                '$compatibilityScore%',
                style: AppStyles.bold16poppins.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: compatibilityScore / 100,
              minHeight: 8.h,
              backgroundColor: AppColors.bgGrey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          SizedBox(height: 16.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _CompatibilityItem(data: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompatibilityItemData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String description;

  const _CompatibilityItemData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}

class _CompatibilityItem extends StatelessWidget {
  final _CompatibilityItemData data;

  const _CompatibilityItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(color: data.iconBg, shape: BoxShape.circle),
          child: Icon(data.icon, size: 16.r, color: data.iconColor),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: AppStyles.semiBold14poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                data.description,
                style: AppStyles.regular12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Listing card ─────────────────────────────────────────────────────────────────

class _ListingCard extends StatelessWidget {
  final ActiveListings listing;

  const _ListingCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with "View Reviews" overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: listing.image != null && listing.image!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: listing.image!,
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _ImagePlaceholder(),
                        errorWidget: (_, __, ___) => _ImagePlaceholder(),
                      )
                    : _ImagePlaceholder(),
              ),
              Positioned(
                top: 12.r,
                right: 12.r,
                child: GestureDetector(
                  // TODO: navigate to property reviews screen with listing.propertyId
                  onTap: () {
                    // TODO: context.pushNamed(AppRouting.reviewsView, extra: listing.propertyId);
                    if (listing?.type?.toLowerCase() == 'apartment') {
                      context.pushNamed(
                        AppRouting.apartmentReviewsName,
                        pathParameters: {'id': listing.propertyId.toString()},
                      );
                    } else {
                      // todo: reviews for room implementation
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.containerColor.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'View Reviews',
                      style: AppStyles.semiBold12poppins.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Details
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Type chip + rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (listing.type != null && listing.type!.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blueGrey,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          listing.type!.toUpperCase(),
                          style: AppStyles.bold10inter.copyWith(
                            color: AppColors.primary,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    if (listing.rating != null && listing.rating! > 0)
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.r, color: Colors.amber),
                          SizedBox(width: 4.w),
                          Text(
                            listing.rating!.toStringAsFixed(1),
                            style: AppStyles.semiBold14poppins.copyWith(
                              color: AppColors.textColorPrimary,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Title
                Text(
                  listing.title ?? 'Untitled Property',
                  style: AppStyles.semiBold16poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 13.r,
                      color: AppColors.textColorSecondary,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        [
                          listing.city,
                          listing.government,
                        ].where((e) => e != null && e.isNotEmpty).join(', '),
                        style: AppStyles.regular12poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(height: 1, color: AppColors.stroke),
                SizedBox(height: 10.h),

                // Amenities row
                Row(
                  children: [
                    if (listing.beds != null)
                      _AmenityChip(
                        icon: Icons.bed_outlined,
                        label: '${listing.beds} Bed',
                      ),
                    if (listing.beds != null) SizedBox(width: 12.w),
                    if (listing.baths != null)
                      _AmenityChip(
                        icon: Icons.bathtub_outlined,
                        label: '${listing.baths} Bath',
                      ),
                    if (listing.sharedBathroom == true) ...[
                      SizedBox(width: 12.w),
                      _AmenityChip(icon: Icons.group_outlined, label: 'Shared'),
                    ],
                    if (listing.size != null) ...[
                      SizedBox(width: 12.w),
                      _AmenityChip(
                        icon: Icons.straighten,
                        label: '${listing.size} sqft',
                      ),
                    ],
                    if (listing.wifi == true) ...[
                      SizedBox(width: 12.w),
                      _AmenityChip(icon: Icons.wifi, label: 'High Speed'),
                    ],
                  ],
                ),
                SizedBox(height: 14.h),

                // View Details button
                SizedBox(
                  width: double.infinity,
                  height: 46.h,
                  child: CustomElevatedButton(
                    text: 'View Details',
                    // TODO: navigate to property details with listing.propertyId / listing.roomId
                    onPressed: () {
                      // TODO: context.pushNamed(AppRouting.propertyDetails, extra: listing.propertyId);
                      if (listing?.type?.toLowerCase() == 'apartment') {
                        context.pushNamed(
                          AppRouting.apartmentDetailsViewName,
                          pathParameters: {'id': listing.propertyId.toString()},
                        );
                      } else {
                        context.pushNamed(
                          AppRouting.roomDetailsViewName,
                          pathParameters: {
                            'propertyId': listing.propertyId.toString(),
                            'roomId': listing.roomId.toString(),
                          },
                        );
                      }
                    },
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.textColorWhite,
                    textStyle: AppStyles.semiBold14poppins,
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AmenityChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.r, color: AppColors.textColorSecondary),
        SizedBox(width: 4.w),
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

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      color: AppColors.bgGrey,
      child: Icon(
        Icons.apartment_rounded,
        size: 40.r,
        color: AppColors.textColorSecondary,
      ),
    );
  }
}

// ── Review card ──────────────────────────────────────────────────────────────────

class _ReviewCard extends StatelessWidget {
  final RecentReviews review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.elevationShadow,
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.bgGrey,
                backgroundImage:
                    review.reviewerImage != null &&
                        review.reviewerImage!.isNotEmpty
                    ? CachedNetworkImageProvider(review.reviewerImage!)
                    : null,
                child:
                    review.reviewerImage == null ||
                        review.reviewerImage!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 20.r,
                        color: AppColors.textColorSecondary,
                      )
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName?.trim() ?? 'Anonymous',
                      style: AppStyles.regular16inter.copyWith(
                        color: AppColors.textColorPrimary,
                      ),
                    ),
                    Text(
                      _formatDate(review.createdAt),
                      style: AppStyles.medium12inter.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _StarRating(rating: review.rating?.toDouble() ?? 0),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            '"${review.comment ?? ''}"',
            style: AppStyles.regular14inter.copyWith(
              color: AppColors.textColorSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      const months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return '';
    }
  }
}

class _StarRating extends StatelessWidget {
  final double rating;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    final rounded = rating.round();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rounded ? Icons.star : Icons.star_border,
          size: 14.r,
          color: Colors.amber,
        );
      }),
    );
  }
}

// ── Loading / Error / Empty states ─────────────────────────────────────────────────

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