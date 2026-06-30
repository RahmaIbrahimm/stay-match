import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/Features/rooms/data/repos/rooms_repo_impl.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../rooms/presentation/manager/shared_property_cubit.dart';
import '../widgets/shared_proeprty/shared_property_scaffold.dart';

class SharedPropertyView extends StatelessWidget {
  final int propertyId;

  const SharedPropertyView({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SharedPropertyCubit(roomsRepo: getIt.get<RoomsRepoImpl>())
            ..fetchDetails(propertyId: propertyId),
      child: const SharedPropertyScaffold(),
    );
  }
}