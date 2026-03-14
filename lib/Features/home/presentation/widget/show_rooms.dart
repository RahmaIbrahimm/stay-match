import 'package:flutter/material.dart';

import '../../../properties/presentation/views/rooms/data/models/get_all_rooms.dart';
import '../../../properties/presentation/views/rooms/presentation/widgets/room_card.dart';

class ShowSearchResults extends StatelessWidget {
  const ShowSearchResults({
    super.key,
    required this.roomPropertiesData,
    required this.size,
  });

  final List<RoomData> roomPropertiesData;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 32,
        childAspectRatio: 0.68482,
      ),
      itemCount: roomPropertiesData.length,
      itemBuilder: (context, index) {
        return roomPropertiesData.isEmpty
            ? Center(
                child: Text(
                  'No Rooms Available',
                  style: TextStyle(fontSize: 50),
                ),
              )
            : RoomCard(
                size: size,
                coverImageUrl: roomPropertiesData[index].coverImageUrl,
                name: roomPropertiesData[index].name,
                street: roomPropertiesData[index].street,
                city: roomPropertiesData[index].city,
                rooms: roomPropertiesData[index].rooms ?? [],
                // todo: add furnished impl
                isFurnished: true,
                id: roomPropertiesData[index].id!,
              );
      },
    );
  }
}