import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/saved/data/models/recommended_properties_response.dart';
import 'package:stay_match/Features/saved/presentation/manager/saved_properties_cubit.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/heart_favourite_button.dart';

import '../../../../core/routing/app_routing.dart';

class RecommendedItemCard extends StatelessWidget {
  final Items item;

  const RecommendedItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var route = item.propertyType == "Apartment"
            ? AppRouting.apartmentDetailsViewName
            : AppRouting.roomDetailsViewName;
        if (context.mounted) {
          if (item.propertyType == "Apartment") {
            context.pushNamed(route, queryParameters: {"id": item.id});
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                width: 72.r,
                height: 72.r,
                child: item.imageUrl != null
                    ? Image.network(
                  item.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _ThumbPlaceholder(),
                )
                    : _ThumbPlaceholder(),
              ),
            ),

            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? 'Property',
                    style: AppStyles.semiBold14poppins.copyWith(
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 12.r,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          '${item.city ?? ''}, ${item.government ?? ''}',
                          style: AppStyles.regular12poppins.copyWith(
                            color: Colors.grey.shade500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    '\$${item.priceDisplay ?? item.price.toString()}',
                    style: AppStyles.semiBold14poppins.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Wrap the button to listen for taps and sync with the main layout list
            GestureDetector(
              onTap: () {
                final savedCubit = context.read<SavedPropertiesCubit>();

                // Determine the correct type mapping for the Cubit toggler
                var itemType = item.propertyType == "Apartment"
                    ? SavedItemType.wholeApartment
                    : SavedItemType.room;

                // Fire off the toggle action
                savedCubit.toggleSaved(
                  itemType: itemType,
                  propertyId: item.id ?? 0,
                  roomId: item.propertyType == "Room" ? item.id : null,
                );
              },
              child: HeartFavoriteButton(
                id: item.id,
                // Check if this item is already contained within your saved paging items
                initialSavedStatus: context.read<SavedPropertiesCubit>().pagingController.itemList?.any(
                      (savedItem) => savedItem.propertyId == item.id || savedItem.roomId == item.id,
                ) ?? false,
                scaleUp: true,
                type: SavedItemType.wholeApartment,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ThumbPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(Icons.image_not_supported, color: Colors.grey, size: 32.r),
    );
  }
}