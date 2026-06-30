import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../../core/routing/app_routing.dart';

class RoomDetailsHostPill extends StatelessWidget {
  final String? hostName;
  final String? hostId;

  const RoomDetailsHostPill({super.key, this.hostName, this.hostId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.mounted) {
          context.pushNamed(
            AppRouting.otherUserProfileName,
            extra: hostId.toString(),
          );
        }
      },
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
                  child: Icon(Icons.person, size: 20.sp, color: Colors.white),
                ),
                WidgetSpan(child: SizedBox(width: 8.w)),
                TextSpan(
                  text: hostName ?? 'Host Name',
                  style: AppStyles.semiBold16poppins.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}