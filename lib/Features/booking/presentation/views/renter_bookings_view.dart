import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo_impl.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../../../../core/constants/app_styles.dart';
import '../manager/booking_request_cubit.dart';
import '../widgets/renter_bookings_widgets/renter_bookings_body.dart';

class RenterBookingsView extends StatelessWidget {
  const RenterBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingRequestCubit(bookingRepo: getIt.get<BookingRepoImpl>()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: const Color(0xFF111827),
              size: 20.r,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'My Booking',
            style: AppStyles.bold18poppins.copyWith(
              color: const Color(0xFF111827),
            ),
          ),
          centerTitle: true,
        ),
        endDrawer: MainAppDrawer(),
        body: RenterBookingsBody(),
      ),
    );
  }
}