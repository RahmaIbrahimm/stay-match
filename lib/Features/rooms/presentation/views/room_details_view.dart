import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../manager/room_details_cubit.dart';
import '../widgets/room_details/room_details_scaffold.dart';

class RoomDetailsView extends StatelessWidget {
  final int roomId;
  final int propertyId;
  const RoomDetailsView({
    super.key,
    required this.roomId,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RoomDetailsCubit(roomsRepo: getIt.get<RoomsRepoImpl>())
            ..fetchRoomDetails(roomId: roomId, propertyId: propertyId),
      child: RoomDetailsScaffold(propertyId: propertyId),
    );
  }
}