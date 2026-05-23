import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/reviews/presentation/widgets/shared/reviews_helpers.dart';

import '../../../../../core/constants/app_styles.dart';

class ReviewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReviewsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 20.r,
          color: RColors.textPrimary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Reviews & Feed backs',
        style: AppStyles.semiBold18poppins.copyWith(color: RColors.textPrimary),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.share_outlined,
            size: 22.r,
            color: RColors.textPrimary,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}