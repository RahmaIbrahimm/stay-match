import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/Features/rooms/presentation/manager/room_details_cubit.dart';
import 'package:stay_match/Features/rooms/presentation/manager/rooms_cubit.dart';

import '../../../../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../shared/widgets/details_view_app_bar.dart';
import '../widgets/room_details/room_details_body.dart';

class RoomDetailsView extends StatelessWidget {
  const RoomDetailsView({
    super.key,
    this.roomId,
    required this.propertyId,
  });

  final int? roomId;
  final int propertyId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RoomDetailsCubit(
            id: propertyId, roomsRepo: getIt.get<RoomsRepoImpl>(),),
      child: Scaffold(
        backgroundColor: AppColors.darkerGrey,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: DetailsViewAppBar(
          title: AppStrings.roomDetails,
          barHeight: kToolbarHeight,
        ),
        body: RoomDetailsViewBody(id: propertyId),
      ),
    );
  }
}