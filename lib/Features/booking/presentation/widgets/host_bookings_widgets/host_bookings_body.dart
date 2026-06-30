import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/data/model/host_requests_response.dart';
import 'package:stay_match/Features/booking/presentation/manager/booking_request_state.dart';
import 'package:stay_match/Features/booking/presentation/widgets/host_bookings_widgets/request_card.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/routing/app_routing.dart';
import '../../../../../core/utils/app_keys.dart';
import '../../manager/booking_request_cubit.dart';
import '../filter_pill.dart';

class HostBookingsBody extends StatelessWidget {
  const HostBookingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BookingRequestCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: AppColors.containerColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Booking Requests",
          style: TextStyle(
            color: AppColors.textColorPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            context.goNamed(AppRouting.homeViewName);
          },
        ),
      ),
      endDrawer: MainAppDrawer(),
      body: BlocConsumer<BookingRequestCubit, BookingRequestState>(
        listener: (context, state) {
          if (state is BookingRequestSuccess) {
            if (state.successMessage != null ||
                state.approveBooking != null ||
                state.declineBooking != null ||
                state.deleteBooking != null) {
              AppKeys.rootScaffoldMessengerKey.currentState
                  ?.removeCurrentSnackBar();
              AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text(state.successMessage ?? "Success!"),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  margin: EdgeInsets.all(16.r),
                  backgroundColor: AppColors.primary,
                ),
              );
            }

          } else if (state is BookingRequestFailure) {
            AppKeys.rootScaffoldMessengerKey.currentState
                ?.removeCurrentSnackBar();
            AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                margin: EdgeInsets.all(16.w),
                backgroundColor: AppColors.primary,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    Text(
                      "Booking Requests",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1D2939),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Manage incoming inquiries. Review compatibility and approve matches",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterPill(
                        label: "Pending",
                        isActive: cubit.currentFilterKey == 'pending',
                        onTap: () {
                          cubit.changeActiveFilterTab('pending', UserType.host);
                        },
                      ),
                      FilterPill(
                        label: "Accepted",
                        isActive: cubit.currentFilterKey == 'approved',
                        onTap: () {
                          cubit.changeActiveFilterTab(
                            'approved',
                            UserType.host,
                          );
                        },
                      ),
                      FilterPill(
                        label: "History",
                        isActive: cubit.currentFilterKey == 'history',
                        onTap: () {
                          cubit.changeActiveFilterTab('history', UserType.host);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: GestureDetector(
                  onTap: () => cubit.toggleSort(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4E7EC),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sort : ",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF667085),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          cubit.currentSortKey == 'newest'
                              ? "Newest"
                              : "Oldest",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: PagedListView<int, Requests>(
                  pagingController: cubit.hostPagingController,
                  padding: EdgeInsets.only(bottom: 24.h),
                  builderDelegate: PagedChildBuilderDelegate<Requests>(
                    itemBuilder: (context, request, index) =>
                        RequestCard(request: request),
                    noItemsFoundIndicatorBuilder: (context) => Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 100.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 64.sp,
                              color: AppColors.blueGrey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No requests found",
                              style: AppStyles.bold16poppins.copyWith(
                                color: AppColors.textColorPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "Try changing your filter settings",
                              style: AppStyles.regular14poppins.copyWith(
                                color: AppColors.textColorSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ─── OPTIONAL: Add a loading indicator for the initial fetch ───
                    firstPageProgressIndicatorBuilder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}