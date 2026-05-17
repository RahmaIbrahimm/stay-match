import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/auth/manager/auth_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/cache_service.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../utils/secure_storage_helper.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key}); // خليتها const أحسن

  @override
  Widget build(BuildContext context) {
    final cacheHelper = getIt.get<CacheService>();

    final String? userName = cacheHelper.getData(key: cacheHelper.userNameKey);
    final String? profilePic = cacheHelper.getData(
      key: cacheHelper.userProfilePicKey,
    );

    return Column(
      children: [
        SizedBox(height: 10.h),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 50.r,
            width: 50.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.containerColor,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
                width: 2.r,
              ),
              image: (profilePic != null && profilePic.isNotEmpty)
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(profilePic),
                    )
                  : null,
            ),
            child: (profilePic == null || profilePic.isEmpty)
                ? Icon(
                    Icons.person,
                    size: 30.sp,
                    color: AppColors.textColorSecondary,
                  )
                : null,
          ),
          title: Text(
            userName ?? 'Guest User',
            style: AppStyles.semiBold15poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          trailing: IconButton(
            onPressed: () => showLogoutDialog(context),
            icon: Icon(
              Icons.logout_outlined,
              size: 20.sp,
              color: const Color(0xFF7F8B9B),
            ),
          ),
        ),
      ],
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Subtle, Professional Icon
                Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary, // Use your app's main color
                  size: 32.sp,
                ),
                SizedBox(height: 16.h),
                // Clear, Direct Title
                Text(
                  'Confirm Logout',
                  style: AppStyles.bold15poppins.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.textColorPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                // Objective, Professional Subtitle
                Text(
                  'Are you sure you want to end your current session?',
                  textAlign: TextAlign.center,
                  style: AppStyles.medium14poppins.copyWith(
                    color: AppColors.textColorSecondary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: AppStyles.medium14poppins.copyWith(
                            color: AppColors.textColorSecondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          // Professional Primary Color
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () async {
                          final authCubit = BlocProvider.of<AuthCubit>(context);
                          final secureStorage = getIt.get<SecureStorageHelper>();
                          final cacheService = getIt.get<CacheService>();

                          // 1. Close all overlays (Dialog & Drawer)
                          // Use rootNavigator: true to ensure we are popping the dialog correctly
                          Navigator.of(context, rootNavigator: true).pop();

                          // 2. Logic Execution
                          await authCubit.logout();
                          await cacheService.clearAll();
                          await secureStorage.storage.deleteAll();

                          // 3. The "Nuclear" Navigation
                          // We use the root router to go to the login path
                          AppRouting.router.go(AppRouting.loginView);
                        },
                        child: Text(
                          'Logout',
                          style: AppStyles.medium14poppins.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}