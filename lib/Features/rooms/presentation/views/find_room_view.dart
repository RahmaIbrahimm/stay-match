import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/home/presentation/manager/home_cubit.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';

import '../../../../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/draggable_chatbot_fab.dart';
import '../../../apartments/data/repos/apartment_repo_impl.dart';
import '../../../filter/data/repos/location_repo_impl.dart';
import '../../../filter/presentation/manager/filter_cubit.dart';
import '../../../filter/presentation/manager/location_cubit.dart';
import '../../../home/data/repos/home_repo_impl.dart';
import '../../data/repos/rooms_repo_impl.dart';
import '../widgets/find_room/find_room_body.dart';

class FindRoomView extends StatelessWidget {
  const FindRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FilterCubit(
              apartmentRepo: ApartmentRepoImpl(
                apiService: getIt.get<DioConsumer>(),
              ),
              roomsRepo: RoomsRepoImpl(apiService: getIt.get<DioConsumer>()),
            )..getAllRooms(),
          ),
          BlocProvider(
            create: (context) => LocationCubit(
              locationRepository: getIt.get<LocationRepoImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(homeRepo: getIt.get<HomeRepoImpl>()),
          ),
        ],
        child: DraggableChatbotFab(hasBottomNav: false,
            child: Scaffold(body: FindRoomBody())),
      ),
    );
  }
}