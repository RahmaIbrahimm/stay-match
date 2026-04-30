import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/booking/data/repos/booking_repo_impl.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../filter/presentation/widgets/filter_helper.dart';
import '../manager/booking_request_cubit.dart';

class BookingRequestView extends StatefulWidget {
  final int propertyId;
  final String startDate;
  final int duration;
  final double monthlyRent;
  final String hostName;
  final String propertyImg;

  // final String hostImg;
  final String propertyName;
  final String street;
  final String city;

  // final int joinYear;

  // final String match;

  const BookingRequestView({
    super.key,
    required this.propertyId,
    required this.startDate,
    required this.duration,
    required this.hostName,
    required this.street,
    required this.city,
    required this.propertyName,
    required this.propertyImg,
    required this.monthlyRent,
    // required this.hostImg,
    // required this.joinYear,
  });

  @override
  State<BookingRequestView> createState() => _BookingRequestViewState();
}

class _BookingRequestViewState extends State<BookingRequestView> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingRequestCubit(
            getIt.get<BookingRepoImpl>(),
            propertyType:
                PropertyType.apartment, // Adjust if your Cubit requires this
          )..updateBookingData(
            propertyId: widget.propertyId,
            duration: widget.duration,
            startDate: widget.startDate,
          ),
      child: Scaffold(
        backgroundColor: AppColors.fieldFillColor,
        appBar: _buildAppBar(context),
        body: BlocConsumer<BookingRequestCubit, BookingRequestState>(
          listener: (context, state) {
            if (state is BookingRequestSuccess) {
              // 1. Success: Professional Toast
              _showSuccessDialog(context: context);
            } else if (state is BookingRequestFailure) {
              // 2. Error: Modern Floating SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          state.errMessage,
                          style: AppStyles.medium14poppins.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFFD32F2F),
                  // Professional crimson red
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(16.r),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 4,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        _buildApartmentHeaderCard(),
                        SizedBox(height: 30.h),
                        Text(
                          "What Happens Next?",
                          style: AppStyles.bold14poppins.copyWith(
                            color: const Color(0xFF4B6191),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildTimeline(),
                        SizedBox(height: 30.h),
                        _buildHostCard(),
                        SizedBox(height: 30.h),
                        _buildMessageSection(),
                        SizedBox(height: 25.h),
                        _buildTotalRentBanner(),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                _buildBottomButton(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1A2E63)),
        onPressed: () => context.pop(),
      ),
      title: Text(
        "Ready to Book?",
        style: AppStyles.bold18poppins.copyWith(color: const Color(0xFF1A2E63)),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF1A2E63)),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildApartmentHeaderCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.propertyImg,
            width: 85.w,
            height: 85.h,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              width: 85.w,
              height: 85.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5), // Light grey base
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: const Color(
                      0xFF1A2E63,
                    ).withValues(alpha: 0.3), // Faded primary
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 85.w,
              height: 85.h,
              decoration: BoxDecoration(
                color: AppColors.grey, // Very light error red tint
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: AppColors.textColorSecondary,
                size: 28.sp,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF86C9A3).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "90% MATCH",
                    style: TextStyle(
                      color: const Color(0xFF4CAF50),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.propertyName,
                  style: AppStyles.bold16poppins.copyWith(
                    color: const Color(0xFF1A2E63),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: Colors.grey,
                    ),
                    Text(
                      " ${widget.city}, Egypt",
                      style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _timelineStep("1", "Send Request", "Current step", true),
        _timelineStep(
          "2",
          "Host Approval",
          "Usually respond within 24h",
          false,
        ),
        _timelineStep("3", "Chat & Pay", "After Approval", false, isLast: true),
      ],
    );
  }

  Widget _timelineStep(
    String num,
    String title,
    String sub,
    bool active, {
    bool isLast = false,
  }) {
    Color primary = active ? const Color(0xFF1A2E63) : const Color(0xFFD3E4FE);
    Color textColor = active ? Colors.white : AppColors.textColorPrimary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999.r),
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: CircleAvatar(
                radius: 12.r,
                backgroundColor: primary,
                child: Text(
                  num,
                  style: AppStyles.bold10poppins.copyWith(color: textColor),
                ),
              ),
            ),
            Container(
              width: 1.5,
              height: !isLast ? 35.h : 10.h,
              color: const Color(0xFFD3E4FE),
            ),
          ],
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.regular16poppins.copyWith(
                color: AppColors.primary,
              ),
            ),
            Text(
              sub,
              style: AppStyles.regular16poppins.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHostCard() {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2FF),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: const Color(0xFFEFF4FF),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hosted By ${widget.hostName}",
                style: AppStyles.bold14poppins.copyWith(
                  color: const Color(0xFF1A2E63),
                ),
              ),
              // todo: come from backend
              Text(
                "Joined in 2027",
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Message to Host (Optional)",
          style: AppStyles.regular16poppins.copyWith(color: AppColors.primary),
        ),
        SizedBox(height: 10.h),
        TextField(
          controller: _messageController,
          maxLines: 4,
          maxLength: 600,
          decoration: InputDecoration(
            hintText: "Introduce yourself and your stay...",
            hintStyle: TextStyle(
              color: AppColors.textColorSecondary,
              fontSize: 16.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            counterStyle: TextStyle(
              color: AppColors.textColorSecondary,
              fontSize: 12.sp,
            ),
            contentPadding: EdgeInsets.all(16.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFD1D9E6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Color(0xFFD1D9E6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(color: Color(0xFF1A2E63)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRentBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: const Color(0xFF86C9A3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Monthly Rent",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            (widget.monthlyRent * widget.duration).toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, BookingRequestState state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: CustomElevatedButton(
        // Logic: Disable button by passing null to onPressed if loading
        onPressed: state is BookingRequestLoading
            ? null
            : () async {
                context.read<BookingRequestCubit>().updateBookingData(
                  message: _messageController.text,
                );
                await context
                    .read<BookingRequestCubit>()
                    .sendApartmentBooking();
              },

        // State handling
        isLoading: state is BookingRequestLoading,

        // Text & Styling
        text: "Send Booking Request",
        textStyle: AppStyles.bold16poppins,
        textColor: Colors.white,
        backgroundColor: const Color(0xFF1A2E63),
        borderRadius: 12,
        verticalPadding: 16,
      ),
    );
  }

  void _showSuccessDialog({required BuildContext context}) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap the button to close
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F5E9), // Light green tint
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: const Color(0xFF2E7D32),
                    size: 60.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Request Sent!",
                  style: AppStyles.bold18poppins.copyWith(
                    color: const Color(0xFF1A2E63),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Your booking request has been sent to ${widget.hostName}. You will be notified once they respond.",
                  textAlign: TextAlign.center,
                  style: AppStyles.regular14poppins.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: "Back to Home",
                  backgroundColor: const Color(0xFF1A2E63),
                  onPressed: () {
                    // Close dialog
                    context.pop();
                    // Go back to the property details or home
                    GoRouter.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}