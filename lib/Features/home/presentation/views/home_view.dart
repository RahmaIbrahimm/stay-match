import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/my_properties/presentation/manager/my_properties_cubit.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../apartments/data/repos/apartment_repo_impl.dart';
import '../../../apartments/presentation/manager/apartment_cubit.dart';
import '../../../my_properties/data/repos/my_properties_repo.dart';
import '../../../rooms/data/repos/rooms_repo_impl.dart';
import '../../../rooms/presentation/manager/rooms_cubit.dart';
import '../../data/repos/home_repo_impl.dart';
import '../manager/home_cubit.dart';
import '../widget/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ApartmentCubit(getIt.get<ApartmentRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => RoomsCubit(getIt.get<RoomsRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => HomeCubit(getIt.get<HomeRepoImpl>()),
          ),
          BlocProvider(
            create: (context) => MyPropertiesCubit(
              myPropertiesRepo: getIt.get<MyPropertiesRepo>(),
            ),
          ),
        ],
        // add home cubit
        child: Scaffold(backgroundColor: Colors.white, body: HomeViewBody()),
      ),
    );
  }
}