import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../rooms/data/models/get_all_rooms.dart';
import '../../../rooms/presentation/widgets/shared/room_card.dart';

class RoomsList extends StatelessWidget {
  const RoomsList({super.key, required this.roomPropertiesData});

  final List<Items>? roomPropertiesData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return roomPropertiesData!.isEmpty
        ? Center(
            child: Text(
              'No rooms available',
              style: TextStyle(fontSize: 30.sp),
            ),
          )
        : SizedBox(
            height: 275.h,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return RoomCard(
                        coverImageUrl: roomPropertiesData?[index].coverImageUrl,
                        name: roomPropertiesData?[index].name,
                        street: roomPropertiesData?[index].street,
                        city: roomPropertiesData?[index].city,

                        // todo: add furnished impl
                        id: roomPropertiesData![index].id!.toInt(),
                        rooms: roomPropertiesData?[index].rooms ?? [],
                      );
                    },
                    childCount: (roomPropertiesData?.length ?? 0) > 3
                        ? 3
                        : roomPropertiesData?.length,
                  ),
                ),
              ],
            ),
          );
  }
}