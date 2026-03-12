import 'package:flutter/material.dart';
import 'package:stay_match/core/widgets/amenities.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';

class PropertyBriefInfoContainer extends StatelessWidget {
  const PropertyBriefInfoContainer({
    super.key,
    required this.size,
    required this.name,
    required this.city,
    required this.streetName,
    required this.monthlyRent,
  });

  final Size size;
  final String? name;
  final String? city;
  final String? streetName;
  final num? monthlyRent;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: size.height * 0.12,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          border: Border(
            left: BorderSide(
              color: AppColors.primary,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            right: BorderSide(
              color: AppColors.primary,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            bottom: BorderSide(
              color: AppColors.primary,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 6),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  name ?? 'No name',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.semiBold10poppins.copyWith(
                    color: AppColors.textColorPrimary,
                  ),
                ),
              ),
            ),
            // location of the property
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.textColorSecondary,
                    size: 10,
                  ),
                  Flexible(
                    child: Text(
                      '${streetName ?? 'No street'}, ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.medium8poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      city ?? 'No name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.medium8poppins.copyWith(
                        color: AppColors.textColorSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // todo: make it reusable for match also maybe?
           Amenities(),
            Flexible(
              child: Divider(
                thickness: 0.5,
                color: AppColors.textColorSecondary,
              ),
            ),
            // monthly rent
            MonthlyRent(monthlyRent: monthlyRent),
            Container(
            )
          ],
        ),
      ),
    );
  }
}

class MonthlyRent extends StatelessWidget {
  const MonthlyRent({
    super.key,
    required this.monthlyRent,
  });

  final num? monthlyRent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
      ),
      // todo: widget inside class of this
      child: Row(
        children: [
          Flexible(
            child: Text(
              'EGP ${monthlyRent ?? 0}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.medium12poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
          ),
          Flexible(
            child: Text(
              ' / month',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.medium10poppins.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}