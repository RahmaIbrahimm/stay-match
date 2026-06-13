// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_styles.dart';
// import '../../data/models/profile_response.dart';
//
// class ProfileHeader extends StatelessWidget {
//   const ProfileHeader({super.key, required this.cubit, required this.data});
//
//   final ProfileCubit cubit;
//   final ProfileRespData data;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Stack(
//             alignment: Alignment.bottomRight,
//             children: [
//               Container(
//                 height: 128.r,
//                 width: 128.r,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.containerColor,
//                   boxShadow: AppColors.elevationShadow,
//                   border: Border.all(
//                     color: AppColors.primary.withValues(alpha: 0.05),
//                     width: 2.r,
//                   ),
//                   image:
//                       (cubit.pickedImageFile != null ||
//                           (data.profilePicture?.isNotEmpty ?? false))
//                       ? DecorationImage(
//                           fit: BoxFit.cover,
//                           image: cubit.pickedImageFile != null
//                               ? FileImage(cubit.pickedImageFile!)
//                                     as ImageProvider
//                               : CachedNetworkImageProvider(
//                                   data.profilePicture!,
//                                 ),
//                         )
//                       : null,
//                 ),
//                 child:
//                     (cubit.pickedImageFile == null &&
//                         (data.profilePicture?.isEmpty ?? true))
//                     ? Icon(
//                         Icons.person,
//                         size: 50.sp,
//                         color: AppColors.textColorSecondary,
//                       )
//                     : null,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   cubit.pickProfileImage();
//
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(6.r),
//                   decoration: const BoxDecoration(
//                     color: AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.edit,
//                     size: 18.sp,
//                     color: AppColors.containerColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Text(data.fullName ?? "User Name", style: AppStyles.bold18poppins,textAlign: TextAlign.center,),
//           Text(
//             "${data.fieldOfStudy ?? 'Student'} @ ${data.university ?? 'University'}",
//             style: AppStyles.regular14poppins.copyWith(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

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
                onTap: () {
                  _showPictureDialog(context);
                  if (cubit.hasProfilePic) {}
                },
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
          Text(
            data.fullName ?? "User Name",
            style: AppStyles.bold18poppins,
            textAlign: TextAlign.center,
          ),
          Text(
            "${data.fieldOfStudy ?? 'Student'} @ ${data.university ?? 'University'}",
            style: AppStyles.regular14poppins.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  void _showPictureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: AppColors.containerColor,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 24.w, vertical: 16.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            // Shrinks card tightly around content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: AppColors.grey,),
              SizedBox(height: 12.h),

              // 1. Upload Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.r),
                decoration: BoxDecoration(
                    color: AppColors.blueGrey,
                    borderRadius: BorderRadius.circular(8.r)
                ),
                child: CustomElevatedButton(
                  text: "Upload New picture",
                  textStyle: AppStyles.semiBold16poppins,
                  backgroundColor: const Color(0xff1A2E6D),
                  // Navy Blue
                  textColor: Colors.white,
                  borderRadius: 8,
                  verticalPadding: 6,
                  onPressed: () {
                    Navigator.pop(
                        context); // Instantly closes the dialog window
                    cubit.pickProfileImage();
                  },
                ),
              ),

              // 2. Conditional Delete Button via inline if block
              if (cubit.hasProfilePic) ...[
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.r),
                  decoration: BoxDecoration(
                      color: AppColors.blueGrey,
                      borderRadius: BorderRadius.circular(8.r)
                  ),
                  child: CustomElevatedButton(
                    text: "Delete my picture",
                    textStyle: AppStyles.semiBold16poppins,
                    backgroundColor: const Color(0xff82C4A6),
                    // Sage Green
                    textColor: const Color(0xff1A2E6D),
                    // Dark Navy text
                    borderRadius: 8,
                    verticalPadding: 6,
                    onPressed: () async {
                      await cubit.deleteProfilePic();
                      Navigator.pop(
                          context); // Instantly closes the dialog window
                      // TODO: Connect to your image removal repository request here
                    },
                  ),
                ),
              ],
              Divider(color: AppColors.grey,),

            ],
          ),
        );
      },
    );
  }
}