import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/get_all_rooms.dart';
import '../shared/room_card.dart';

class ShowSearchResults extends StatelessWidget {
  const ShowSearchResults({super.key, required this.roomPropertiesData});

  final List<Items> roomPropertiesData;

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust aspect ratio based on screen size
    double aspectRatio = screenWidth < 360 ? 0.45 :
    screenWidth < 400 ? 0.56 : 0.65;

    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: screenWidth < 360 ? 8.r : 16.r,
        childAspectRatio: aspectRatio,
      ),
      itemCount: roomPropertiesData.length < 3 ? roomPropertiesData.length : 3,
      itemBuilder: (context, index) {
        return roomPropertiesData.isEmpty
            ? Center(
          child: Text(
            'No Rooms Available',
            style: TextStyle(fontSize: 16.sp),
          ),
        )
            : RoomCard(
          coverImageUrl: roomPropertiesData[index].coverImageUrl,
          name: roomPropertiesData[index].name,
          street: roomPropertiesData[index].street,
          city: roomPropertiesData[index].city,
          rooms: roomPropertiesData[index].rooms ?? [],
          id: roomPropertiesData[index].id!.toInt(),
        );
      },
    );
  }
}