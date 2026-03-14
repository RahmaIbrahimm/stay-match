import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/features/properties/presentation/views/apartments/presentation/widgets/apartment_Brief_Info_container.dart';
import 'package:stay_match/features/properties/presentation/widgets/card_cover_photo.dart';

import '../../../../../../../core/constants/app_strings.dart';
import '../../data/models/get_all_apartments.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({super.key, required this.size, required this.property});

  final Size size;
  final Items? property;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.42,
      margin: const EdgeInsets.only(right: 12, top: 12),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Photo
          CardCoverPhoto(size: size, imageUrl: property?.coverImageUrl ?? ''),

          // Details Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Monthly Rent
                MonthlyRent(monthlyRent: property?.monthlyRent),
                const SizedBox(height: 4),

                // Property Name
                Text(
                  property?.name ?? 'N/A',
                  style: AppStyles.bold15poppins,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.textColorSecondary,
                      size: 16,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        '${property?.street ?? 'No street'}, ${property?.city ?? 'No city'}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.regular12poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Features Container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.bgGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildFeatureItem(
                        icon: Icon(
                          Icons.king_bed,
                          color: Colors.black,
                          size: 18,
                        ),
                        text: _getBedroomsText(property!.numberOfBedrooms!.toInt()),
                      ),
                      _buildFeatureItem(
                        icon: ImageIcon(
                          AssetImage(AppIcons.bathroomIcon),
                          color: Colors.black,
                          size: 18,
                        ),
                        text: _getBathroomsText(property),
                      ),
                      _buildFeatureItem(
                        icon: ImageIcon(
                          AssetImage(AppIcons.sizeIcon),
                          size: 18,
                          color: Colors.black,
                        ),
                        text: '${property?.size?.toInt() ?? 0} m²',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // View Details Button
                CustomElevatedButton(
                  text: AppStrings.viewDetails,
                  textStyle: AppStyles.semiBold12Poppins,
                  verticalPadding: 8,
                  borderRadius: 8,
                  onPressed: () {
                    // TODO: Navigate to details screen
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({required Widget icon, required String text}) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 4),
        Text(text, style: AppStyles.regular16poppins),
      ],
    );
  }

  String _getBedroomsText(int? bedrooms) {
    if (bedrooms == null) return '0 Bed';
    return '$bedrooms ${bedrooms > 1 ? 'Beds' : 'Bed'}';
  }

  String _getBathroomsText(Items? property) {
    if (property == null) return '0 Bath';
    final totalBathrooms =
        (property.numberOfEnSuiteBathrooms ?? 0) +
        (property.numberOfGuestBathrooms ?? 0);
    return '$totalBathrooms ${totalBathrooms > 1 ? 'Baths' : 'Bath'}';
  }
}