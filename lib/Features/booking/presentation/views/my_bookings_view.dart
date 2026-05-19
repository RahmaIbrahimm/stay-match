import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/data/model/my_bookings_response.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo_impl.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../manager/booking_request_cubit.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingRequestCubit(getIt.get<BookingRepoImpl>()),
      child: Builder(
          builder: (context) {
            final cubit = context.read<BookingRequestCubit>();
            return Scaffold(
              backgroundColor: const Color(0xFFF4F5FA),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Text(
                  'My Booking',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
                centerTitle: true,
              ),
              body: RefreshIndicator(
                onRefresh: () async => cubit.refreshBookingList(),
                child: PagedListView<int, Bookings>.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  pagingController: cubit.pagingController,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  builderDelegate: PagedChildBuilderDelegate<Bookings>(
                    itemBuilder: (context, booking, index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Search Box & Calendar Widget Block
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.02),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: Colors.grey[400], size: 20.r),
                                        SizedBox(width: 8.w),
                                        Text(
                                          'Search by location',
                                          style: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Container(
                                  height: 48.h,
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF132F75),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Calendar',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Blue Renter Tips Panel Block
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3EDFA),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Renter tips',
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0F2963)),
                                  ),
                                  SizedBox(height: 12.h),
                                  _buildTipRow('1', 'Message the host immediately after approval to arrange a viewing'),
                                  SizedBox(height: 10.h),
                                  _buildTipRow('2', 'Complete your profile to increase your acceptance rate'),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Pill-shaped Dynamic Tab Track layout matching MyBookingsRequest specs
                            BlocBuilder<BookingRequestCubit, BookingRequestState>(
                              builder: (context, state) {
                                final rawTabs = cubit.latestResponseData?.data?.tabs ?? [];

                                final tabsList = rawTabs.isNotEmpty
                                    ? rawTabs
                                    : [
                                  Tabs(key: 'all', label: 'All Bookings', count: 0),
                                  Tabs(key: 'pending', label: 'Pending', count: 0),
                                  Tabs(key: 'approved', label: 'Approved', count: 0),
                                ];

                                return Container(
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEBEBF2),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: tabsList.map((tab) {
                                        final isSelected = cubit.currentFilterKey == tab.key;
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: ChoiceChip(
                                            showCheckmark: false,
                                            label: Text(tab.label ?? ''),
                                            selected: isSelected,
                                            selectedColor: const Color(0xFF132F75),
                                            backgroundColor: Colors.transparent,
                                            side: BorderSide.none,
                                            labelStyle: TextStyle(
                                              color: isSelected ? Colors.white : const Color(0xFF5A677D),
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                              fontSize: 13.sp,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(24.r),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            onSelected: (_) {
                                              if (tab.key != null) {
                                                cubit.changeActiveFilterTab(tab.key!);
                                              }
                                            },
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.h),

                            _buildBookingPropertyItemCard(context, booking),
                          ],
                        );
                      }

                      return _buildBookingPropertyItemCard(context, booking);
                    },
                    firstPageProgressIndicatorBuilder: (_) => const Center(
                      child: CircularProgressIndicator(color: Color(0xFF132F75)),
                    ),
                    newPageProgressIndicatorBuilder: (_) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(color: Color(0xFF132F75)),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 60.h),
                        child: Text(
                          'No bookings found.',
                          style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  Widget _buildTipRow(String indexStr, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22.w,
          height: 22.w,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Center(
            child: Text(
              indexStr,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A3B8B)),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13.sp, color: const Color(0xFF4A5568), height: 1.35),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingPropertyItemCard(BuildContext context, Bookings booking) {
    final String currentStatus = (booking.status ?? 'pending').toLowerCase();

    Color statusBadgeColor = const Color(0xFFFEF3C7);
    Color statusTextColor = const Color(0xFFD97706);
    String statusLabel = 'Pending';

    if (currentStatus == 'approved' || currentStatus == 'accepted') {
      statusBadgeColor = const Color(0xFFD1FAE5);
      statusTextColor = const Color(0xFF059669);
      statusLabel = 'Approved';
    } else if (currentStatus == 'declined' || currentStatus == 'past') {
      statusBadgeColor = const Color(0xFFFEE2E2);
      statusTextColor = const Color(0xFFDC2626);
      statusLabel = 'Declined';
    }

    // ─── FIXED DATA TYPES & OBJECT MAPPING ───
    final String propertyTitle = booking.title ?? 'Target Property Asset';

    // Safely extract from your Location object (adjust properties like .name or .address based on your actual model class)
    final String locationText = booking.location != null
        ? booking.location!.fullAddress ?? ''
        : 'Cairo, Egypt';

    // If your location string ends up empty or with just a comma, fall back cleanly
    final String displayLocation = locationText.replaceFirst(RegExp(r'^,\s*'), '').isEmpty
        ? 'Cairo, Egypt'
        : locationText;

    final String coverUrl = booking.coverImage ?? '';

    // Convert duration to int safely even if it arrives as a string variant
    final int durationMonths = int.tryParse(booking.duration?.toString() ?? '') ?? 1;

    // Safely cast or parse to double for calculation/formatting precision
    final double monthlyPrice = double.tryParse(booking.totalPrice?.toString() ?? '') ?? 0.0;

    final String dateInterval = booking.moveInDate ?? '15 Oct 2023';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      margin: EdgeInsets.only(bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                child: CachedNetworkImage(
                  imageUrl: coverUrl,
                  width: double.infinity,
                  height: 184.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 184.h,
                    color: const Color(0xFFE2E8F0),
                    child: const Center(child: CircularProgressIndicator(color: Color(0xFF132F75))),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 184.h,
                    color: const Color(0xFFE2E8F0),
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 14.h,
                right: 14.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusBadgeColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(color: statusTextColor, shape: BoxShape.circle),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        statusLabel,
                        style: TextStyle(color: statusTextColor, fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  propertyTitle,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1E293B)),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 16.r, color: Colors.grey[400]),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        locationText,
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey[500]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '$durationMonths Months',
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DURATION',
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.grey[400], letterSpacing: 0.5),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          dateInterval,
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF334155)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'PRICE',
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.grey[400], letterSpacing: 0.5),
                        ),
                        SizedBox(height: 4.h),
                        RichText(
                          text: TextSpan(
                            text: '$monthlyPrice EGP',
                            style: TextStyle(color: const Color(0xFF132F75), fontWeight: FontWeight.bold, fontSize: 16.sp),
                            children: [
                              TextSpan(
                                text: '/month',
                                style: TextStyle(color: Colors.grey[500], fontSize: 11.sp, fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 18.h),

                _buildActionButtons(currentStatus),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(String status) {
    if (status == 'approved' || status == 'accepted') {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.white),
              label: const Text('Chat with host', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3275),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF76C8A4),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: const Text('Add Details', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      );
    } else if (status == 'declined' || status == 'past') {
      return OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.delete_outline, size: 18, color: Color(0xFFDC2626)),
        label: const Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFDC2626),
          side: const BorderSide(color: Color(0xFFFCA5A5)),
          padding: EdgeInsets.symmetric(vertical: 14.h),
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          backgroundColor: const Color(0xFFFEF2F2),
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F3275),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: const Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF64748B),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                backgroundColor: const Color(0xFFF8FAFC),
              ),
              child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      );
    }
  }
}