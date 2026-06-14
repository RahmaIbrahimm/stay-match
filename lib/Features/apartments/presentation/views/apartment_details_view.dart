import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../shared/widgets/details_view_app_bar.dart';
import '../../data/repos/apartment_repo_impl.dart';
import '../manager/apartment_details_cubit.dart';
import '../widgets/apartment_details/apartment_details_view_body.dart';

class ApartmentDetailsView extends StatelessWidget {
  const ApartmentDetailsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ApartmentDetailsCubit(getIt.get<ApartmentRepoImpl>(), id)
            ..getPropertyDetails(id: id),
      child: Scaffold(
        backgroundColor: AppColors.darkerGrey,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: DetailsViewAppBar(
          title: AppStrings.apartmentDetails,
          barHeight: kToolbarHeight,
        ),
        body: ApartmentDetailsViewBody(id: id),
      ),
    );
  }
}