import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/routing/app_routing.dart';
import '../models/property_details_response.dart';

class HostNameSliver extends StatelessWidget {
  const HostNameSliver({super.key, required this.details});

  final PropertyDetailsData? details;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
          if(context.mounted){
            context.pushNamed(AppRouting.otherUserProfileName, extra: details?.hostId.toString());
          }
        },
        child: RPadding(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.r),
              alignment: Alignment.center,
                width: 200.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15.r),
              ),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.person, size: 20.sp, color: Colors.white),),
                  WidgetSpan(child: SizedBox(width: 8.w,)),
                  TextSpan(
                    text: details?.hostName ?? 'Host Name',
                    style: AppStyles.semiBold16poppins.copyWith(
                      color: Colors.white,
                    ),
                  ),

                ]
                ),)
            ),
          ),
        ),
      ),
    );
  }
}