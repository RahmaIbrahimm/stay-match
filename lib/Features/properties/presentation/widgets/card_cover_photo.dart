import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
class CardCoverPhoto extends StatelessWidget {
  const CardCoverPhoto({
    super.key,
    required this.size,
    required this.imageUrl,
  });

  final Size size;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            height: size.height * 0.1,
            width: double.infinity,
            fit: BoxFit.cover,

            errorWidget: (context, url, error) {
              return Icon(Icons.error_outline,color: AppColors.textColorError,);

            },
            placeholder: (context, url) {
              return Icon(Icons.error_outline,color: AppColors.textColorError,);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(5),
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
          top: 6,
          right: 6,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
              color: AppColors.bgGrey,
              borderRadius: BorderRadius.circular(5),
            ),
            //todo: add actual match logic when api given
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: [
                Icon(Icons.star_rate_rounded,color: Colors.yellowAccent,size: 12,),
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