import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/reviews/data/models/write_review_request.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';

import '../manager/write_review_cubit.dart';
import '../widgets/add_review_widgets/feedback_portal_header.dart';
import '../widgets/add_review_widgets/rate_host_card.dart';
import '../widgets/add_review_widgets/rate_place_card.dart';
import '../widgets/add_review_widgets/submit_bar.dart';
import '../widgets/add_review_widgets/tell_us_more_section.dart';

class AddReviewArgs {
  final int bookingId;
  final String propertyName;
  final String stayDates;
  final String hostName;
  final String? hostImageUrl;

  const AddReviewArgs({
    required this.bookingId,
    required this.propertyName,
    required this.stayDates,
    required this.hostName,
    this.hostImageUrl,
  });
}

class AddReviewView extends StatefulWidget {
  final AddReviewArgs args;

  const AddReviewView({super.key, required this.args});

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

class _AddReviewViewState extends State<AddReviewView> {
  int _accuracy = 0;
  int _cleanliness = 0;
  int _checkIn = 0;
  int _location = 0;
  int _value = 0;
  int _communication = 0;

  final TextEditingController _commentController = TextEditingController();

  bool get _isFormValid =>
      _accuracy > 0 &&
      _cleanliness > 0 &&
      _checkIn > 0 &&
      _location > 0 &&
      _value > 0 &&
      _communication > 0 &&
      _commentController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteReviewCubit, WriteReviewState>(
      listener: (context, state) {
        if (state is WriteReviewFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errMessage,
                style: AppStyles.regular14poppins.copyWith(
                  color: AppColors.textColorWhite,
                ),
              ),
              backgroundColor: AppColors.textColorError,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          );
        } else if (state is WriteReviewSuccess) {
          // Navigate to your review success screen — replace route name as needed
          context.pushReplacementNamed(AppRouting.reviewSubmittedName);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryScaffBg,
        appBar: AppBar(
          backgroundColor: AppColors.containerColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.textColorPrimary,
              size: 24.r,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Write Reviews',
            style: AppStyles.bold18poppins.copyWith(
              color: AppColors.textColorPrimary,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeedbackPortalHeader(
                      propertyName: widget.args.propertyName,
                      stayDates: widget.args.stayDates,
                    ),
                    SizedBox(height: 20.h),
                    RatePlaceCard(
                      accuracy: _accuracy,
                      cleanliness: _cleanliness,
                      checkIn: _checkIn,
                      location: _location,
                      value: _value,
                      onAccuracyChanged: (v) => setState(() => _accuracy = v),
                      onCleanlinessChanged: (v) =>
                          setState(() => _cleanliness = v),
                      onCheckInChanged: (v) => setState(() => _checkIn = v),
                      onLocationChanged: (v) => setState(() => _location = v),
                      onValueChanged: (v) => setState(() => _value = v),
                    ),
                    SizedBox(height: 16.h),
                    RateHostCard(
                      hostName: widget.args.hostName,
                      hostImageUrl: widget.args.hostImageUrl,
                      communication: _communication,
                      onCommunicationChanged: (v) =>
                          setState(() => _communication = v),
                    ),
                    SizedBox(height: 24.h),
                    TellUsMoreSection(controller: _commentController),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            SubmitBar(onSubmit: _onSubmit),
          ],
        ),
      ),
    );
  }
  void _onSubmit() {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all ratings and your comment.',
            style: AppStyles.regular14poppins.copyWith(
              color: AppColors.textColorWhite,
            ),
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    context.read<WriteReviewCubit>().submitReview(
      request: WriteReviewRequest(
        bookingId: widget.args.bookingId,
        accuracy: _accuracy,
        cleanliness: _cleanliness,
        location: _location,
        checkIn: _checkIn,
        value: _value,
        communication: _communication,
        comment: _commentController.text.trim(),
      ),
    );
  }
}