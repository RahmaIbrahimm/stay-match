import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/networking/dio_consumer.dart';

import '../../../../../../../core/utils/service_locator.dart';
import '../../data/repos/apartment_repo_impl.dart';
import '../manager/apartment_cubit.dart';
import '../widgets/find_apartment/find_apartment_body.dart';

class FindApartmentView extends StatelessWidget {
  const FindApartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => ApartmentCubit(
          ApartmentRepoImpl(apiService: getIt.get<DioConsumer>()),
        )..getAllApartments(),
        child: Scaffold(
          body: FindApartmentBody(),
        ),
      ),
    );
  }
}