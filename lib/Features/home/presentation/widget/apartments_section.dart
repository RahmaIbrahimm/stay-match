import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../properties/apartments/data/models/get_all_apartments.dart';
import '../../../properties/apartments/presentation/widgets/apartment_list.dart';
class ApartmentsSection extends StatelessWidget {
  const ApartmentsSection({
    super.key,
    required this.size,
    required this.properties,
  });

  final Size size;
  final List<Items>? properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.discoverApartments,
                style: AppStyles.semiBold15poppins.copyWith(
                  color: AppColors.textColorPrimary,
                ),
              ),
              // todo: view all apartments text button implementation
              CustomTextButton(
                onPressed: () {},
                text: AppStrings.viewAllApartments,
                isUnderlined: false,
                textColor: AppColors.primary,
                textStyle: AppStyles.semiBold10poppins,
                isPadded: false,
              ),
            ],
          ),

          Text(
            AppStrings.handPickedApartments,
            style: AppStyles.regular8poppins.copyWith(
              color: AppColors.textColorSecondary,
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: size.height * 0.22,
            child: PropertyList(properties: properties, size: size),
          ),
        ],
      ),
    );
  }
}