import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class CardCoverPhoto extends StatelessWidget {
  const CardCoverPhoto({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.r),
            topRight: Radius.circular(8.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            width: double.infinity,
            fit: BoxFit.cover,

            // Placeholder
            placeholder: (context, url) =>
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgGrey,
                    border: Border(
                      left: BorderSide(color: AppColors.primary),
                      right: BorderSide(color: AppColors.primary),
                      top: BorderSide(color: AppColors.primary),
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.w,
                    ),
                  ),
                ),

            // Error
            errorWidget: (context, url, error) =>
                Container(
                  decoration: BoxDecoration(border:Border(
                    top: BorderSide(color: AppColors.primary),
                    right: BorderSide(color: AppColors.primary),
                    left: BorderSide(color: AppColors.primary),
                  ), color: AppColors.bgGrey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                  )
                  ),
                  child: Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 30.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 2.r),
          margin: EdgeInsets.symmetric(horizontal: 3.r, vertical: 6.r),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(5.r),
          ),
          //todo: add actual match logic when api given
          child: Text(
            '98 % Match',
            style: AppStyles.medium8poppins.copyWith(
              color: AppColors.textColorWhite,
            ),
          ),
        ),
        Positioned(
          top: 6.r,
          right: 6.r,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 2.r),
            margin: EdgeInsets.symmetric(vertical: 3.r, horizontal: 6.r),
            decoration: BoxDecoration(
              color: AppColors.bgGrey,
              borderRadius: BorderRadius.circular(5.r),
            ),
            //todo: add actual match logic when api given
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              spacing: 2.w,
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  color: Colors.yellowAccent,
                  size: 12,
                ),
                Text(
                  '4.5',
                  style: AppStyles.medium8poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}