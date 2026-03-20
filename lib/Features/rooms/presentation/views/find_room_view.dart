import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';

import '../../../../../../../core/utils/service_locator.dart';
import '../../data/repos/rooms_repo_impl.dart';
import '../manager/rooms_cubit.dart';
import '../widgets/find_room/find_room_body.dart';

class FindRoomView extends StatelessWidget {
  const FindRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            RoomsCubit(RoomsRepoImpl(apiService: getIt.get<DioConsumer>())),
        child: Scaffold(body: FindRoomBody()),
      ),
    );
  }
}