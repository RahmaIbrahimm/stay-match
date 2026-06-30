import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/filter/data/repos/location_repo_impl.dart';
import 'package:stay_match/Features/filter/presentation/manager/filter_cubit.dart';
import 'package:stay_match/Features/filter/presentation/manager/location_cubit.dart';
import 'package:stay_match/Features/home/data/repos/home_repo_impl.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';

import '../../../../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/draggable_chatbot_fab.dart';
import '../../../home/presentation/manager/home_cubit.dart';
import '../../data/repos/apartment_repo_impl.dart';
import '../widgets/find_apartment/find_apartment_body.dart';

class FindApartmentView extends StatelessWidget {
  const FindApartmentView({super.key});

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
            ),
          ),
          BlocProvider(
            create: (context) => LocationCubit(
              locationRepository: getIt.get<LocationRepoImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(
              homeRepo: getIt.get<HomeRepoImpl>(),
            ),
          ),
        ],
        child: DraggableChatbotFab(hasBottomNav: false,
        child: SafeArea(child: Scaffold(body: FindApartmentBody()))),
      ),
    );
  }
}