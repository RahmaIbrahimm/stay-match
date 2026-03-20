import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../data/models/apartment_details_response.dart';
class ApartmentAboutSliver extends StatelessWidget {
  const ApartmentAboutSliver({super.key, required this.details});

  final ApartmentDetailsData details;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RPadding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'About This Place',
                style: AppStyles.bold18poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              WidgetSpan(
                child: ReadMoreText(
                  details.description ?? '',
                  trimMode: TrimMode.Line,
                  trimLines: 3,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: AppStyles.regular15poppins.copyWith(
                    color: AppColors.textColorSecondary,
                    overflow: TextOverflow.ellipsis,
                  ),
                  moreStyle: AppStyles.regular15poppins.copyWith(
                    color: AppColors.primary,
                    overflow: TextOverflow.ellipsis,
                  ),
                  lessStyle: AppStyles.regular15poppins.copyWith(
                    color: AppColors.primary,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}