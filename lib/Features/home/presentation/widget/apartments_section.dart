import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/custom_text_button.dart';
class ApartmentsSection extends StatelessWidget {
  const ApartmentsSection({
    super.key,
    required this.size,
    required this.widget
  });

  final Size size;
  final Widget widget;

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
                onPressed: () {
                  context.pushNamed(AppRouting.findApartmentViewName);
                },
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
            height: size.height * 0.24,
            child: widget,
          ),
        ],
      ),
    );
  }
}