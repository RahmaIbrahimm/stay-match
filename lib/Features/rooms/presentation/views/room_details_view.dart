import 'package:flutter/material.dart';
import '../../../../../../../core/constants/app_strings.dart';
import '../../../shared/widgets/details_view_app_bar.dart';
import '../widgets/room_details/room_details_body.dart';

class RoomDetailsView extends StatelessWidget {
  const RoomDetailsView({
    super.key,
    required this.roomId,
    required this.propertyId,
  });

  final int roomId;
  final int propertyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsViewAppBar(title: AppStrings.roomDetails,barHeight: kToolbarHeight,),
      body: RoomDetailsBody(),
    );
  }
}