import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../core/routing/app_routing.dart';
import '../../../../core/utils/service_locator.dart';
import '../../data/repos/saved_properties_repo_impl.dart';
import '../manager/recommended_cubit.dart';
import '../widgets/saved_view_body.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainAppDrawer(),
      backgroundColor: AppColors.fieldFillColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            if (context.mounted) context.goNamed(AppRouting.homeViewName);
          },
        ),
        title: Text(
          'My Saved',
          style: AppStyles.semiBold18poppins.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            RecommendedCubit(getIt.get<SavedPropertiesRepoImpl>()),
        child: SavedViewBody(),
      ),
    );
  }
}