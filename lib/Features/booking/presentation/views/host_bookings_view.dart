import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/data/model/host_requests_response.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/utils/service_locator.dart';
import 'package:stay_match/core/widgets/app_drawer/main_app_drawer.dart';

import '../../../../core/widgets/draggable_chatbot_fab.dart';
import '../../../profile/data/repos/profile_repo_impl.dart';
import '../../../profile/presentation/manager/profile_cubit.dart';
import '../manager/booking_request_cubit.dart';
import '../widgets/host_bookings_widgets/host_bookings_body.dart';

class HostBookingsView extends StatelessWidget {
  const HostBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingRequestCubit(bookingRepo: getIt.get<BookingRepoImpl>()),

      child: DraggableChatbotFab(hasBottomNav: false,
      child: const HostBookingsBody()),
    );
  }
}