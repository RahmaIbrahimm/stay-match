import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stay_match/Features/booking/data/model/my_bookings_response.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../manager/booking_request_cubit.dart';

class MyBookingRequestsView extends StatelessWidget {
  const MyBookingRequestsView({super.key});
// todo: fix all buttons and add case there is no about part and the filter is broken //////////////
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingRequestCubit(getIt.get<BookingRepoImpl>()),
      child: Builder(
          builder: (context) {
            final cubit = context.read<BookingRequestCubit>();
            return Scaffold(
              backgroundColor: const Color(0xFFF4F5FA), // Matched subtle background tint
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Text(
                  'Booking Requests',
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
                            Text(
                              cubit.latestResponseData?.data?.pageInfo?.title ?? 'Booking Requests',
                              style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w900, // True Bold/Heavy Weight
                                color: const Color(0xFF0F2963), // Correct Deep Indigo Accent
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              cubit.latestResponseData?.data?.pageInfo?.subtitle ??
                                  'Manage incoming inquiries. Review compatibility and approve matches',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF64748B), // Custom Neutral slate gray
                                  height: 1.35
                              ),
                            ),
                            SizedBox(height: 20.h),

                            // Segmented TabBar Container Layout
                            BlocBuilder<BookingRequestCubit, BookingRequestState>(
                              builder: (context, state) {
                                final rawTabs = cubit.latestResponseData?.data?.tabs ?? [];

                                final tabsList = rawTabs.isNotEmpty
                                    ? rawTabs
                                    : [
                                  Tabs(key: 'all', label: 'All Requests', count: 0),
                                  Tabs(key: 'pending', label: 'Pending', count: 3),
                                  Tabs(key: 'approved', label: 'Accepted', count: 0),
                                  Tabs(key: 'past', label: 'History', count: 0),
                                ];

                                return Container(
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                    // color: const Color(0xFFEBEBF2), // Outer pill bar track background
                                    borderRadius: BorderRadius.circular(30.r), // Uniform circular track
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: tabsList.map((tab) {
                                        final isSelected = cubit.currentFilterKey == tab.key;
                                        final displayLabel = '${tab.label} (${tab.count ?? 0})';

                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: ChoiceChip(
                                            showCheckmark: false,
                                            label: Text(displayLabel),
                                            selected: isSelected,
                                            // color: WidgetStateProperty.all(Color(0xffE3E1E9)),
                                            selectedColor: AppColors.primary, // Deep choice selection background
                                            backgroundColor: Color(0xffE3E1E9), // Inherits track background color seamlessly
                                            side: BorderSide.none, // Removes borders to look unified like a native TabBar
                                            labelStyle: TextStyle(
                                              color: isSelected ? Colors.white : const Color(0xFF5A677D),
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(24.r), // Inner fully circular selection capsule
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
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

                            // Sort Badge Indicator
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE4E6ED),
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Sort : ',
                                      style: TextStyle(color: const Color(0xFF4A5568), fontSize: 14.sp, fontWeight: FontWeight.w500),
                                      children: [
                                        TextSpan(
                                          text: 'Newest',
                                          style: TextStyle(
                                            color: const Color(0xFF132F75),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),

                            _buildRequestItemCard(context, booking),
                          ],
                        );
                      }

                      return _buildRequestItemCard(context, booking);
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
                          'No booking requests found.',
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

  Widget _buildRequestItemCard(BuildContext context, Bookings booking) {
    final String hostName = booking.host?.name ?? "Applicant User";
    final String hostAvatar = booking.host?.image ?? "";
    final String profession = booking.propertyType ?? "Tenant Match";

    final List<String> profileHabits = (booking.id ?? 0) % 2 == 0
        ? ["Early Bird", "Social", "Non-smoker"]
        : ["Night Owl", "Quiet"];
    final String bioText = booking.title ?? "Interested in booking this space. Looking forward to finding a clean home environment.";

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
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Picture Frame with requested subtle Drop Shadow
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 3), // Smooth profile picture drop shadow
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: hostAvatar,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 28.r,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 28.r,
                    backgroundColor: const Color(0xFFE2E8F0),
                    child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF132F75)),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 28.r,
                    backgroundColor: const Color(0xFFE2E8F0),
                    child: Icon(Icons.person, size: 28.r, color: Colors.grey[400]),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hostName,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      profession,
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F3275),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  '98% Match',
                  style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(height: 16.h),

          Text(
            'LIFE STYLE & HABITS',
            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.grey[400], letterSpacing: 0.5),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: profileHabits.map((habit) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  habit,
                  style: TextStyle(color: const Color(0xFF1A73E8), fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '"$bioText"',
              style: TextStyle(fontSize: 13.sp, color: const Color(0xFF334155), height: 1.4, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: booking.coverImage ?? '',
                    width: 64.w,
                    height: 64.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 64.w,
                      height: 64.w,
                      color: const Color(0xFFE2E8F0),
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF132F75))),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 64.w,
                      height: 64.w,
                      color: const Color(0xFFE2E8F0),
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.title ?? 'Target Property',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Duration: ${booking.duration ?? 1} Month',
                        style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                      ),
                      SizedBox(height: 4.h),
                      RichText(
                        text: TextSpan(
                          text: '\$${booking.totalPrice ?? 0} ',
                          style: TextStyle(color: const Color(0xFF132F75), fontWeight: FontWeight.bold, fontSize: 14.sp),
                          children: [
                            TextSpan(
                              text: 'TOTAL PRICE',
                              style: TextStyle(color: Colors.grey[400], fontSize: 9.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFDC2626),
                    side: const BorderSide(color: Color(0xFFFCA5A5)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    backgroundColor: const Color(0xFFFEF2F2),
                  ),
                  child: const Text('Decline', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF132F75),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    elevation: 0,
                  ),
                  child: const Text('Approve Request', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),

          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Color(0xFF132F75)),
              label: Text(
                'Message ${hostName.split(' ')[0]}',
                style: const TextStyle(color: Color(0xFF132F75), fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}