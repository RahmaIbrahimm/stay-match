import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../data/models/profile_response.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.cubit, required this.data});

  final ProfileCubit cubit;
  final ProfileRespData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 128.r,
                width: 128.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.containerColor,
                  boxShadow: AppColors.elevationShadow,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    width: 2.r,
                  ),
                  image:
                      (cubit.pickedImageFile != null ||
                          (data.profilePicture?.isNotEmpty ?? false))
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: cubit.pickedImageFile != null
                              ? FileImage(cubit.pickedImageFile!)
                                    as ImageProvider
                              : CachedNetworkImageProvider(
                                  data.profilePicture!,
                                ),
                        )
                      : null,
                ),
                child:
                    (cubit.pickedImageFile == null &&
                        (data.profilePicture?.isEmpty ?? true))
                    ? Icon(
                        Icons.person,
                        size: 50.sp,
                        color: AppColors.textColorSecondary,
                      )
                    : null,
              ),
              GestureDetector(
                onTap: () => cubit.pickProfileImage(),
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 18.sp,
                    color: AppColors.containerColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(data.fullName ?? "User Name", style: AppStyles.bold18poppins,textAlign: TextAlign.center,),
          Text(
            "${data.fieldOfStudy ?? 'Student'} @ ${data.university ?? 'University'}",
            style: AppStyles.regular14poppins.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}