//
// import 'dart:io';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/constants/app_colors.dart';
// import '../../../../../core/constants/app_styles.dart';
// import '../../manager/add_property_cubit.dart';
//
// class PropertyGalleryWidget extends StatelessWidget {
//   const PropertyGalleryWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddPropertyCubit, AddPropertyState>(
//       builder: (context, state) {
//         final cubit = context.read<AddPropertyCubit>();
//         final images = cubit.localImages;
//
//         // The first image is the cover
//         final File? coverImage = images.isNotEmpty ? images[0] : null;
//
//         // Everything after index 0 is the gallery
//         final List<File> gallerySubList = images.length > 1
//             ? images.sublist(1)
//             : [];
//
//         return Column(
//           children: [
//             // --- 1. COVER PHOTO SECTION ---
//             GestureDetector(
//               onTap: () {
//                 if (images.isNotEmpty) {
//                   // Specific logic to swap only the first image
//                   cubit.pickCoverImage();
//                 } else {
//                   // If empty, standard pick starts the list
//                   cubit.pickImages();
//                 }
//               },
//               child: _buildCoverPhoto(coverImage),
//             ),
//
//             // --- 2. GALLERY GRID SECTION ---
//             RPadding(
//               padding: EdgeInsets.symmetric(vertical: 16.h),
//               child: CustomScrollView(
//                 primary: false,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 // Parent handles scrolling
//                 slivers: [
//                   SliverGrid(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 12.h,
//                       crossAxisSpacing: 12.w,
//                       childAspectRatio: 0.9,
//                     ),
//                     delegate: SliverChildBuilderDelegate((context, index) {
//                       // Render existing gallery images
//                       if (index < gallerySubList.length) {
//                         return _buildGalleryTile(
//                           imageFile: gallerySubList[index],
//                           // index + 1 ensures we remove the correct item from the Cubit's master list
//                           onRemove: () => cubit.removeImage(index + 1),
//                         );
//                       }
//                       // Render the Dotted Upload Placeholder at the end
//                       else {
//                         return _buildUploadPlaceholder(
//                           onTap: () => cubit.pickImages(),
//                         );
//                       }
//                     }, childCount: gallerySubList.length + 1),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildCoverPhoto(File? imageFile) {
//     return Container(
//       height: 220.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.fieldFillColor,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: AppColors.primary.withValues(alpha: 0.1),
//           width: 1.5,
//         ),
//         image: imageFile != null
//             ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover)
//             : null,
//       ),
//       child: imageFile == null
//           ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.camera_alt_outlined,
//                   size: 40.sp,
//                   color: AppColors.primary,
//                 ),
//                 SizedBox(height: 8.h),
//                 Text(
//                   "Upload Cover Photo",
//                   style: AppStyles.medium14poppins.copyWith(
//                     color: AppColors.textColorSecondary,
//                   ),
//                 ),
//               ],
//             )
//           : Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircleAvatar(
//                     radius: 25.r,
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                       Icons.camera_alt_outlined,
//                       size: 25.sp,
//                       color: AppColors.primary,
//                     ),
//                   ),
//                   SizedBox(height: 12.h),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 8.h,
//                       horizontal: 20.w,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.black54,
//                       borderRadius: BorderRadius.circular(20.r),
//                     ),
//                     child: Text(
//                       "Change Cover",
//                       style: AppStyles.semiBold14poppins.copyWith(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget _buildGalleryTile({
//     required File imageFile,
//     required VoidCallback onRemove,
//   }) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(14.r),
//             child: Image.file(imageFile, fit: BoxFit.cover),
//           ),
//         ),
//         Positioned(
//           top: 6,
//           right: 6,
//           child: GestureDetector(
//             onTap: onRemove,
//             child: CircleAvatar(
//               radius: 12.r,
//               backgroundColor: Colors.red,
//               child: Icon(Icons.close, size: 12.sp, color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildUploadPlaceholder({required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: DottedBorder(
//         options: RoundedRectDottedBorderOptions(
//           color: AppColors.textColorSecondary.withValues(alpha: 0.3),
//           strokeWidth: 1.5,
//           dashPattern: const [6, 4],
//           radius: Radius.circular(14.r),
//         ),
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.fieldFillColor,
//             borderRadius: BorderRadius.circular(14.r),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.add, size: 24.sp, color: AppColors.textColorSecondary),
//               SizedBox(height: 4.h),
//               Text(
//                 "UPLOAD",
//                 style: AppStyles.bold10poppins.copyWith(
//                   color: AppColors.textColorSecondary,
//                   letterSpacing: 1.1,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../manager/add_property_cubit.dart';

class PropertyGalleryWidget extends StatelessWidget {
  final int? roomIndex; // If null, manages building images. If set, manages room images.
  const PropertyGalleryWidget(
      {super.key, this.roomIndex, this.hasCoverImage = true});

  final bool hasCoverImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      builder: (context, state) {
        final cubit = context.read<AddPropertyCubit>();

        // Choose data source
        final images = (roomIndex == null)
            ? cubit.localImages
            : (cubit.localRoomImages[roomIndex] ?? []);

        final File? coverImage = (hasCoverImage && images.isNotEmpty) ? images[0] : null;
        // final File? coverImage = images.isNotEmpty ? images[0] : null;
        final List<File> gallerySubList = images.length > 1
            ? images.sublist(1)
            : [];

        return Column(
          children: [
            if(hasCoverImage)GestureDetector(
              onTap: () {
                if (roomIndex == null) {
                  images.isNotEmpty ? cubit.pickCoverImage() : cubit
                      .pickImages();
                } else {
                  cubit.pickRoomImages(roomIndex!);
                }
              },
              child: _buildCoverPhoto(coverImage),
            ),
            RPadding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: GridView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 0.9,
                ),
                itemCount: gallerySubList.length + 1,
                itemBuilder: (context, index) {
                  if (index < gallerySubList.length) {
                    return _buildGalleryTile(
                      imageFile: gallerySubList[index],
                      onRemove: () {
                        if (roomIndex == null) {
                          cubit.removeImage(index + 1);
                        } else {
                          // Note: Ensure your cubit has a removeRoomImage or similar logic
                          cubit.localRoomImages[roomIndex!]?.removeAt(
                              index + 1);
                          cubit.emit(AddPropertyFormUpdated(DateTime.now()));
                        }
                      },
                    );
                  } else {
                    return _buildUploadPlaceholder(
                      onTap: () =>
                      roomIndex == null
                          ? cubit.pickImages()
                          : cubit.pickRoomImages(roomIndex!),
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCoverPhoto(File? imageFile) {
    return Container(
      height: 200.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withAlpha(10)),
        image: imageFile != null ? DecorationImage(
            image: FileImage(imageFile), fit: BoxFit.cover) : null,
      ),
      child: imageFile == null
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.camera_alt_outlined, size: 40.sp, color: AppColors.primary),
        Text("Upload Apartment Cover", style: AppStyles.medium14poppins),
      ])
          : Container(
        alignment: Alignment.center,
        color: Colors.black26,
        child: Icon(
            Icons.camera_alt_outlined, color: Colors.white, size: 30.sp),
      ),
    );
  }

  Widget _buildGalleryTile(
      {required File imageFile, required VoidCallback onRemove}) {
    return Stack(children: [
      Positioned.fill(child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(imageFile, fit: BoxFit.cover))),
      Positioned(top: 4,
          right: 4,
          child: GestureDetector(onTap: onRemove,
              child: CircleAvatar(radius: 10.r,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close, size: 10.sp, color: Colors.white)))),
    ]);
  }

  Widget _buildUploadPlaceholder({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          color: AppColors.textColorSecondary.withValues(alpha: 0.3),
          strokeWidth: 1.5,
          dashPattern: const [6, 4],
          radius: Radius.circular(14.r),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.fieldFillColor,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 24.sp, color: AppColors.textColorSecondary),
              SizedBox(height: 4.h),
              Text(
                "UPLOAD",
                style: AppStyles.bold10poppins.copyWith(
                  color: AppColors.textColorSecondary,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}