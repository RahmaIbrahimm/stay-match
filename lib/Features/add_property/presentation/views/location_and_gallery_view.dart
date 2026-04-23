import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/filter/data/repos/location_repo_impl.dart';
import 'package:stay_match/Features/filter/presentation/manager/location_cubit.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../widgets/location_and_gallery_widgets/location_and_gallery_body.dart';

class LocationAndGalleryView extends StatelessWidget {
  const LocationAndGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LocationCubit(locationRepository: getIt.get<LocationRepoImpl>()),
      child: LocationAndGalleryBody(),
    );
  }
}