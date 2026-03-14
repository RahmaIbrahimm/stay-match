import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/features/home/presentation/widget/small_custom_button.dart';
import 'package:stay_match/features/properties/presentation/views/rooms/presentation/widgets/room_in_property_data.dart';

import '../../../../../../../core/widgets/amenities.dart';
import '../../../../widgets/card_cover_photo.dart';
import '../../data/models/get_all_rooms.dart';


class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
    required this.size,
    required this.coverImageUrl,
    required this.name,
    required this.street,
    required this.city,
    required this.isFurnished,
    required this.id,
    required this.rooms,
  });

  final Size size;
  final String? coverImageUrl;
  final String? name;
  final String? street;
  final String? city;
  final List<Rooms> rooms;
  final bool isFurnished;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.42,
      margin: const EdgeInsets.only(right: 12, top: 12),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppColors.elevationShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // todo: add rating and match percent
          CardCoverPhoto(size: size, imageUrl: coverImageUrl ?? ''),
          Container(
            height: size.height * 0.187,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.containerColor,
              border: Border(
                left: BorderSide(
                  color: AppColors.primary,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                right: BorderSide(
                  color: AppColors.primary,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                bottom: BorderSide(
                  color: AppColors.primary,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    name ?? 'No name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.semiBold10poppins.copyWith(
                      color: AppColors.textColorPrimary,
                    ),
                  ),
                ),
                // location of the property
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.textColorSecondary,
                        size: 10,
                      ),
                      Text(
                        '${street ?? 'No street'}, ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.medium8poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                      Text(
                        city ?? 'No name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.medium8poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // todo: make it reusable for match also maybe?
                Amenities(isFurnished: isFurnished),
                // divider
                Divider(color: AppColors.textColorSecondary, thickness: 0.5),
                RoomInPropertyData(rooms: rooms),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: SmallCustomButton(
                      text: AppStrings.viewDetails,
                      onPressed: () {
                        // todo: when server comes back on check this out
                        context.pushNamed(
                          AppRouting.roomDetailsViewName,
                          pathParameters: {'id': id.toString()},
                        );
                      },
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