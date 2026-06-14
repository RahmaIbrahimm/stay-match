import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/presentation/manager/booking_request_cubit.dart';
import 'package:stay_match/Features/booking/presentation/widgets/renter_bookings_widgets/renter_booking_request_card.dart';
import 'package:stay_match/Features/booking/presentation/widgets/renter_bookings_widgets/renter_tips.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/utils/app_keys.dart';

import '../../../data/model/renter_bookings_response.dart';
import '../../manager/booking_request_state.dart';
import 'filter_tabs.dart';

class RenterBookingsBody extends StatelessWidget {
  const RenterBookingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<BookingRequestCubit>();

    return BlocListener<BookingRequestCubit, BookingRequestState>(
      listener: (context, state) {
        if (state is BookingRequestSuccess && state.deleteBooking != null) {
          AppKeys.rootScaffoldMessengerKey.currentState
              ?.removeCurrentSnackBar();
          AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content:  Text(state.successMessage ?? "Success!",style: AppStyles.semiBold14poppins.copyWith(color: Colors.white),),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              margin: EdgeInsets.all(16.r),
              backgroundColor: AppColors.primary,
            ),
          );

          final controller = cubit.renterPagingController;
          final currentState = controller.value;
          final updatedItems = List<RenterBookings>.from(
            currentState.itemList ?? [],
          )..removeWhere((item) => item.id == cubit.deletedBookingId);
          controller.itemList = updatedItems;
          cubit.deletedBookingId = -1;
          cubit.canceledBookingId = -1;
        }
        else if (state is BookingRequestFailure) {
          AppKeys.rootScaffoldMessengerKey.currentState
              ?.removeCurrentSnackBar();
          AppKeys.rootScaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content:  Text(
                state.errMessage,
              ),
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
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            cubit.renterPagingController.refresh();
          },
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12.h),
                    const FilterByLocationAndCalendar(),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Container(
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD2E4FF),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Renter tips',
                              style: AppStyles.bold16poppins.copyWith(
                                color: const Color(0xFF0A194E),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildTipItem(
                              '1',
                              'Message the host immediately after approval to arrange a viewing',
                            ),
                            SizedBox(height: 8.h),
                            _buildTipItem(
                              '2',
                              'Complete your profile to increase your acceptance rate',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              const FilterTabs(),
              BlocBuilder<BookingRequestCubit, BookingRequestState>(
                builder: (context, state) {
                  // todo: add events to card
                  return PagedSliverList<int, dynamic>(
                    pagingController: cubit.renterPagingController,
                    builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, booking, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 4.h,
                          ),
                          child: RenterBookingRequestCard(bookings:  booking),
                        );
                      },
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
                      firstPageProgressIndicatorBuilder: (context) =>
                          const Center(child: CircularProgressIndicator(color: AppColors.primary,)),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22.r,
          height: 22.r,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: AppStyles.bold12poppins.copyWith(
              color: const Color(0xFF0A194E),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppStyles.regular12poppins.copyWith(
              color: const Color(0xFF1E3A8A),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}