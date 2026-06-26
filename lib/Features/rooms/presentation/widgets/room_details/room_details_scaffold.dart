import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/room_details/room_details_body.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../../core/widgets/draggable_chatbot_fab.dart';
import '../../manager/room_details_cubit.dart';

class RoomDetailsScaffold extends StatelessWidget {
  final int propertyId;

  const RoomDetailsScaffold({
    super.key,
    required this.propertyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MainAppDrawer(),
      backgroundColor: Color(0xffF7F9FD),
      appBar: AppBar(
        backgroundColor: Color(0xffF7F9FD),
        elevation: 0,
        surfaceTintColor: Colors.white,
        title: Text(
          AppStrings.roomDetails,
          style: AppStyles.semiBold20poppins.copyWith(
            color: AppColors.textColorPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: DraggableChatbotFab(
        hasBottomNav: false,
        child: BlocBuilder<RoomDetailsCubit, RoomDetailsState>(
          builder: (context, state) {
            if (state is RoomDetailsInitial || state is RoomDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is RoomDetailsFailure) {
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
                      onPressed: () => context.read<RoomDetailsCubit>().retry(),
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
            if (state is RoomDetailsSuccess) {
              return RoomDetailsBody(
                data: state.response.data!,
                propertyId: propertyId,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}