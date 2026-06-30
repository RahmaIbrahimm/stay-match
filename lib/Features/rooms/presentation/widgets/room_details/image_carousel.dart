import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../../core/widgets/heart_favourite_button.dart';
import '../../../../saved/presentation/manager/saved_properties_cubit.dart';

class ImageCarousel extends StatelessWidget {
  final List<PropertyImages> images;
  final int numImages;
  final ValueNotifier<int> picNotifier;
  final String? roomName;
  final bool isSaved;
  final int propertyId;
  final int roomId;
  const ImageCarousel({super.key,
    required this.images,
    required this.numImages,
    required this.picNotifier,
    required this.roomName,
    required this.isSaved,
    required this.propertyId, required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.h,
      child: Stack(
        children: [
          // Pages
          PageView.builder(
            onPageChanged: (v) => picNotifier.value = v + 1,
            itemCount: numImages,
            itemBuilder: (_, i) {
              final url = images.isNotEmpty ? (images[i].imageUrl ?? '') : '';
              return CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.bgGrey,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.bgGrey,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 40.r,
                    color: AppColors.textColorSecondary,
                  ),
                ),
              );
            },
          ),

          // Heart + share — top right
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Container(
              width: 34.r,
              height: 34.r,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: AppColors.elevationShadow,
              ),
              child: HeartFavoriteButton(
                id: propertyId,
                initialSavedStatus: isSaved,
                scaleUp: true,
                type: SavedItemType.room,
                roomId: roomId,
              ),
            ),
          ),

          // Dot indicator — bottom center
          Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: picNotifier,
              builder: (_, val, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  numImages,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: (val - 1) == i ? 16.w : 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.white, width: 0.3.r),
                      color: (val - 1) == i ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}