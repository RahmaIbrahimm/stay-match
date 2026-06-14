import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/booking/presentation/widgets/renter_bookings_widgets/sticky_tab_bar_delegate.dart';
import 'package:stay_match/Features/booking/presentation/widgets/renter_bookings_widgets/tab_item.dart';
import 'package:stay_match/core/constants/app_colors.dart';

import '../../../../../core/constants/app_styles.dart';
import '../../manager/booking_request_cubit.dart';
import '../../manager/booking_request_state.dart';

class FilterTabs extends StatelessWidget {
  const FilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: BlocBuilder<BookingRequestCubit, BookingRequestState>(
            builder: (context, state) {
              var cubit = context.read<BookingRequestCubit>();
              final List<dynamic> activeTabs =  [
                      TabItem(key: 'all', label: 'All Requests'),
                      TabItem(key: 'pending', label: 'Pending'),
                      TabItem(key: 'approved', label: 'Approved'),
                      TabItem(key: 'past', label: 'Past/Declined'),
                    ];

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: activeTabs.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final tabItem = activeTabs[index];
                  final isSelected =
                      cubit.currentRenterFilterKey == tabItem.key;

                  return _buildTabButton(
                    text: tabItem.label ?? '',
                    isActive: isSelected,
                    onTap: () {
                      if (tabItem.key != null) {
                        cubit.changeRenterFilterTab(tabItem.key!);
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String text,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : const Color(0xFFEAEFF8),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          text,
          style: AppStyles.medium14poppins.copyWith(
            color: isActive ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }
}