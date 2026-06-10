import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/add_property/data/repos/add_property_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/app_drawer/main_app_drawer.dart';
import '../../../add_property/presentation/manager/add_property_cubit.dart';
import '../../data/repos/my_properties_repo.dart';
import '../manager/my_properties_cubit.dart';
import '../widgets/my_properties_body.dart';

class MyPropertiesView extends StatefulWidget {
  const MyPropertiesView({super.key});

  @override
  State<MyPropertiesView> createState() => _MyPropertiesViewState();
}

class _MyPropertiesViewState extends State<MyPropertiesView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MyPropertiesCubit(
                  myPropertiesRepo: getIt.get<MyPropertiesRepo>()),
        ),
        // BlocProvider(
        //   create: (context) => AddPropertyCubit(addPropertyRepo: getIt.get<AddPropertyRepoImpl>()),
        // ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.fieldFillColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF182E6E)),
            onPressed: () {
              context.goNamed(AppRouting.homeViewName);
            },
          ),
          title: Text(
            AppStrings.myProperties,
            style: AppStyles.bold20poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          centerTitle: true,
        ),
        endDrawer: MainAppDrawer(),
        body: MyPropertiesBody(),
      ),
    );
  }
}