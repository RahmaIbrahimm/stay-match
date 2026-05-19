import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';

class BookingHelper {
  static void showSuccessDialog({required BuildContext context,required hostName}) {
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
                  "Your booking request has been sent to ${hostName}. You will be notified once they respond.",
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