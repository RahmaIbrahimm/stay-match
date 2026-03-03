import 'package:flutter/material.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_images.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/features/home/presentation/views/widget/home_search.dart';

import '../../../../../core/widgets/custom_text_form_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          height: size.height * 0.25,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.homeHeader),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppStrings.stayMatch} ',
                    style: AppStyles.logo.copyWith(
                      color: AppColors.textColorWhite,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.homeHeader,
                      style: AppStyles.secondary.copyWith(
                        color: AppColors.textColorWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              HomeSearch(validator: (v){}, hintText: AppStrings.searchHome)
            ],
          ),
        ),
      ],
    );
  }
}