import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../manager/add_property_cubit.dart';
import '../widgets/individual_room_details_widgets/room_bottom_sheet_card.dart';
import '../widgets/shared/add_property_app_bar.dart';
import '../widgets/shared/add_property_buttons.dart';
import '../widgets/shared/progress_bar.dart';

class IndividualRoomDetailsView extends StatefulWidget {
  const IndividualRoomDetailsView({super.key});

  @override
  State<IndividualRoomDetailsView> createState() =>
      _IndividualRoomDetailsViewState();
}

class _IndividualRoomDetailsViewState extends State<IndividualRoomDetailsView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddPropertyCubit>();
    final targetCount = cubit.roomRequest.availableRooms ?? 1;
    while ((cubit.roomRequest.rooms?.length ?? 0) < targetCount) {
      cubit.addRoom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyCubit, AddPropertyState>(
      builder: (context, state) {
        final cubit = context.read<AddPropertyCubit>();
        final rooms = cubit.roomRequest.rooms ?? [];
        final maxAllowedRooms = cubit.roomRequest.availableRooms ?? 1;

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  AddPropertyAppBar(
                      cubit: cubit, title: AppStrings.addProperty),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.h),
                          ProgressBar(stepNumber: cubit.currentStep + 1),
                          SizedBox(height: 24.h),
                          Text("Individual Room Details",
                              style: AppStyles.bold20poppins),
                          SizedBox(height: 4.h),
                          Text(
                            "Detail each room. (Max: $maxAllowedRooms rooms)",
                            style: AppStyles.medium12poppins.copyWith(
                                color: Colors.blueGrey),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                RoomBottomSheetCard(
                              index: index,
                              room: rooms[index],
                              cubit: cubit,
                              canDelete: rooms.length > 1,
                            ),
                        childCount: rooms.length,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 40.h),
                      child: AddPropertyButtons(
                        cubit: cubit,
                        // submit: true,
                        onNextPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            _showError("Please fill all fields");
                          } else if (_formKey.currentState!.validate()) {
                            cubit.submitRoomProperty();
                            context.pushNamed(AppRouting.addPropertySuccessName,
                                pathParameters: {'id': cubit.id.toString()});
                          }
                        },
                        nextPageRoute: '',
                        // nextPageRoute: AppRouting.addPropertySuccessName,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(16.w),
        content: Text(msg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

}