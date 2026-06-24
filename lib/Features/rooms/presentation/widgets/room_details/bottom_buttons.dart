import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/rooms/data/models/room_details_response.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../../../../core/routing/app_routing.dart';

class BottomButtons extends StatelessWidget {
  final RoomDetailsResponseData data;
  final DateTime? moveInDate;
  final int? duration;
  final int? propertyId;
  const BottomButtons({super.key, required this.data, required this.moveInDate, required this.duration,required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        MediaQuery.of(context).padding.bottom + 12.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 52.h,
            child: CustomElevatedButton(
              text:data.isMyProperty ?? false ?'Back To Home':'Book This Room',
              backgroundColor: AppColors.primary,
              textColor: AppColors.textColorWhite,
              textStyle: AppStyles.semiBold16poppins,
              borderRadius: 14,
              onPressed: () => _onBookNowPressed(details: data, context: context),

            ),
          ),
          if (data.isPaid ?? false) ...[
            SizedBox(height: 10.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: CustomElevatedButton(
                text: 'Chat with ${data.hostName?.trim() ?? 'Host'}',
                backgroundColor: AppColors.secondary,
                textColor: AppColors.textColorPrimary,
                textStyle: AppStyles.semiBold16poppins,
                borderRadius: 14,
                suffixIcon: Icon(
                  Icons.chat_bubble_outline,
                  size: 18.r,
                  color: AppColors.textColorPrimary,
                ),
                onPressed: () {
                  if (context.mounted) {
                    context.pushNamed(
                      AppRouting.messagesName,
                      pathParameters: {'otherUserId': data.hostId.toString()},
                    );
                  }
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
  void _onBookNowPressed({
    required RoomDetailsResponseData? details,
    required BuildContext context,
  }) {
    // 1. Check for nulls
    if ((moveInDate == null || duration == null) && !(details?.isMyProperty ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please select both a Move In date and Duration"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // 🌟 Safe image extraction check
    final images = details?.propertyImages;
    final String firstImageUrl = (images != null && images.isNotEmpty)
        ? (images[0].imageUrl ?? '')
        : '';

    // 2. If valid, proceed with navigation
    if (context.mounted) {
    // todo : is my property
      if(details?.isMyProperty ?? false){
        context.goNamed(
          AppRouting.homeViewName,
        );
      }
      else{
        context.pushNamed(
          AppRouting.bookingRequestName,
          extra: {
            'propertyId': propertyId,
            'roomId': details?.id ?? -1,
            'startDate': moveInDate?.toIso8601String(),
            'duration': duration,
            'monthlyRent': details?.monthRent,
            'securityDeposit': details?.deposit,
            'street': details?.street ?? '',
            'city': details?.city ?? '',
            'hostName': details?.hostName,
            'propertyName': details?.roomName,
            'propertyImg': firstImageUrl,
            'isRoom': true,
          },
        );
      }
    }
  }
}