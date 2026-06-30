import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/shared_proeprty/shared_property_body.dart';
import 'package:stay_match/Features/shared/widgets/details_view_app_bar.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../../core/widgets/draggable_chatbot_fab.dart';
import '../../manager/shared_property_cubit.dart';

class SharedPropertyScaffold extends StatelessWidget {
  const SharedPropertyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainAppDrawer(),
      backgroundColor: Colors.white,
      appBar: DetailsViewAppBar(title: 'Apartment Details', barHeight: 56.h),
      body: BlocBuilder<SharedPropertyCubit, SharedPropertyState>(
        builder: (context, state) {
          if (state is SharedPropertyInitial ||
              state is SharedPropertyLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is SharedPropertyFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.errMessage,
                    textAlign: TextAlign.center,
                    style: AppStyles.regular14poppins.copyWith(
                      color: AppColors.textColorSecondary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextButton(
                    onPressed: () =>
                        context.read<SharedPropertyCubit>().retry(),
                    child: Text(
                      'Try again',
                      style: AppStyles.semiBold14poppins.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is SharedPropertySuccess) {
            return DraggableChatbotFab(
              hasBottomNav: false,
              child: SharedPropertyBody(data: state.details.data!),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}