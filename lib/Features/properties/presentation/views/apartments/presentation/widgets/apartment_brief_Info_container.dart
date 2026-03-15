import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/features/home/presentation/widget/small_custom_button.dart';

import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../core/constants/app_icons.dart';
import '../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../core/constants/app_styles.dart';
import '../../data/models/all_apartments.dart';

class ApartmentBriefInfoContainer extends StatelessWidget {
  const ApartmentBriefInfoContainer({
    super.key,
    required this.name,
    required this.city,
    required this.streetName,
    required this.monthlyRent,
    required this.isFurnished,
    this.property,
    required this.size,
    required this.id
  });

  final Size size;
  final String? name;
  final String? city;
  final String? streetName;
  final num? monthlyRent;
  final bool isFurnished;
  final Items? property;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        border: Border(
          left: BorderSide(color: AppColors.primary),
          right: BorderSide(color: AppColors.primary),
          bottom: BorderSide(color: AppColors.primary),
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Text(
              name ?? 'No name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.semiBold10poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            const SizedBox(height: 4),
            // location row
            _buildLocation(),
            const SizedBox(height: 8),
            _buildFeatures(),
            _buildPrice(monthlyRent: monthlyRent?.toInt()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: SmallCustomButton(
                  text: AppStrings.viewDetails,
                  onPressed: () {
                    if (id != null) {
                      context.pushNamed(
                        AppRouting.apartmentDetailsViewName,
                        pathParameters: {'id': id.toString()},
                      );
                    } else {
                      // Handle missing ID - maybe show a snackbar or log error
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Cannot view details: Invalid property ID',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice({required int? monthlyRent}) {
    return Row(
      children: [
        Text(
          'EGP ${monthlyRent ?? 0}',
          style: AppStyles.bold15poppins.copyWith(color: AppColors.primary),
        ),
        Text(
          ' / month',
          style: AppStyles.medium10poppins.copyWith(
            color: AppColors.textColorSecondary,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesome.heart, size: 14),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildFeature({required Widget icon, required String text}) {
    return Column(
      children: [
        icon,
        Text(text, style: AppStyles.medium10poppins),
      ],
    );
  }

  Widget _buildFeatures() {
    int numBeds = property?.numberOfBedrooms?.toInt() ?? 0;
    double size = property?.size?.toDouble() ?? 0;
    int numBathrooms =
        (property?.numberOfGuestBathrooms?.toInt() ?? 0) +
        (property?.numberOfEnSuiteBathrooms?.toInt() ?? 0);
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFeature(
            icon: Icon(Icons.king_bed, color: Colors.black, size: 12),
            text: '$numBeds ${numBeds > 1 ? 'Beds' : 'Bed'}',
          ),
          _buildFeature(
            icon: ImageIcon(
              AssetImage(AppIcons.bathroomIcon),
              color: Colors.black,
              size: 12,
            ),
            text:
                '$numBathrooms ${numBathrooms > 1 ? 'Bathrooms' : 'Bathroom'}',
          ),
          _buildFeature(
            icon: ImageIcon(
              AssetImage(AppIcons.sizeIcon),
              color: Colors.black,
              size: 12,
            ),
            text: '$size m',
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      children: [
        Icon(Icons.location_on, color: AppColors.textColorSecondary, size: 10),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            '${streetName ?? 'No street'}, ${city ?? 'No city'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.medium10poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
        ),
      ],
    );
  }
}