import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/features/home/manager/home_cubit.dart';

import '../../../properties/apartments/data/repos/apartment_repo_impl.dart';
import '../../../properties/apartments/data/repos/rooms_repo_impl.dart';
import '../../../properties/apartments/manager/apartment_cubit.dart';
import '../../../properties/rooms/manager/rooms_cubit.dart';
import '../../data/repos/home_repo_impl.dart';
import '../widget/home_nav_bar.dart';
import '../widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PropertiesCubit(
              ApartmentRepoImpl(apiService: getIt.get<DioConsumer>()),
            )..getAllApartments(),
          ),
          BlocProvider(
            create: (context) =>
                RoomsCubit(RoomsRepoImpl(apiService: getIt.get<DioConsumer>()))
                  ..getAllRooms(),
          ),
          BlocProvider(
            create: (context) =>
                HomeCubit(HomeRepoImpl(apiService: getIt.get<DioConsumer>())),
          ),
        ],
        // add home cubit
        child: Scaffold(
          backgroundColor: Colors.white,
          body: HomeViewBody(),
          bottomNavigationBar: HomeNavBar(),
        ),
      ),
    );
  }
}