import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';
import 'package:stay_match/features/properties/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/features/properties/rooms/manager/rooms_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/service_locator.dart';
import '../widgets/find_room_body.dart';

class FindRoomView extends StatelessWidget {
  const FindRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => RoomsCubit(RoomsRepoImpl( apiService: getIt.get<DioConsumer>()))..getAllRooms(),
        child: Scaffold(
          body: FindRoomBody(),
        ),
      ),
    );
  }
}