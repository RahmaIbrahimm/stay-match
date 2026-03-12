import 'package:flutter/material.dart';

import '../../../properties/rooms/data/models/get_all_rooms.dart';
import '../../../properties/rooms/presentation/widgets/room_card.dart';

class RoomsList extends StatelessWidget {
  const RoomsList({
    super.key,
    required this.roomPropertiesData,
    required this.size,
  });

  final Size size;
  final List<RoomData>? roomPropertiesData;

  @override
  Widget build(BuildContext context) {
    return roomPropertiesData!.isEmpty
        ? Center(
            child: Text('No rooms available', style: TextStyle(fontSize: 30)),
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: roomPropertiesData?.length ?? 0,
            itemBuilder: (context, index) {
              return RoomCard(
                size: size,
                coverImageUrl: roomPropertiesData?[index].coverImageUrl,
                name: roomPropertiesData?[index].name,
                street: roomPropertiesData?[index].street,
                city: roomPropertiesData?[index].city,
                numOfRooms: roomPropertiesData?[index].rooms?.length,
                monthRent: roomPropertiesData?[index].rooms?[index].monthRent,
                // todo: add furnished impl
                isFurnished: true,
              );
            },
          );
  }
}