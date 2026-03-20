import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/features/home/presentation/widget/small_custom_button.dart';

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
      height: 235.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        image: DecorationImage(
          image: AssetImage(AppImages.homeHeader),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${AppStrings.stayMatch} ',
                  style: AppStyles.regular15protestRiot.copyWith(
                    color: AppColors.textColorWhite,
                  ),
                ),
                TextSpan(
                  text: AppStrings.homeHeader,
                  style: AppStyles.regular14poppins.copyWith(
                    color: AppColors.textColorWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.only(top: 8.r),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              dividerColor: AppColors.textColorSecondary,
              unselectedLabelColor: AppColors.textColorSecondary,
              unselectedLabelStyle: AppStyles.medium10poppins,
              labelColor: AppColors.primary,
              labelStyle: AppStyles.medium10poppins,
              labelPadding: EdgeInsets.all(6.r),
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Row(
                  children: [
                    Icon(Icons.apartment, size: 12.sp),
                    Flexible(
                      child: Text(
                        AppStrings.rentWholeApartment,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.meeting_room_sharp, size: 12.sp),
                    Flexible(
                      child: Text(
                        AppStrings.rentRoom,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 16.r),
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(flex: 3, child: HomeSearchField()),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 2,
                  child: SmallCustomButton(
                    text: AppStrings.search,
                    onPressed: () {},
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