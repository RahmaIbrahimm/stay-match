import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import 'home_search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.size,
    required TabController tabController,
  }) : _tabController = tabController;

  // todo: add validators and contoller better
  final Size size;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.28,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
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
                style: AppStyles.logo.copyWith(color: AppColors.textColorWhite),
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
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              dividerColor: AppColors.textColorSecondary,
              unselectedLabelColor: AppColors.textColorSecondary,
              unselectedLabelStyle: AppStyles.textStyleTab,
              labelColor: AppColors.primary,
              labelStyle: AppStyles.textStyleTab,
              labelPadding: EdgeInsetsGeometry.all(6),
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Row(
                  children: [
                    Icon(Icons.apartment, size: 12),
                    Text(AppStrings.rentWholeApartment),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.meeting_room_sharp, size: 12),
                    Text(AppStrings.rentRoom),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 3, child: HomeSearchField()),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(vertical: 7),
                      elevation: 0,
                      minimumSize: Size(0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      AppStrings.search,
                      style: AppStyles.smallButton.copyWith(
                        color: AppColors.textColorWhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}