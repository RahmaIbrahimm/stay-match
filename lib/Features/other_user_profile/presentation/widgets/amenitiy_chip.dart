import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/Features/other_user_profile/data/repos/other_user_profile_repo_impl.dart';
import 'package:stay_match/Features/other_user_profile/presentation/widgets/user_review_card.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../../reviews/presentation/widgets/apartment_reviews_widgets/review_card.dart';
import '../manager/other_user_profile_cubit.dart';
class AmenityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const AmenityChip({required this.icon, required this.label});

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