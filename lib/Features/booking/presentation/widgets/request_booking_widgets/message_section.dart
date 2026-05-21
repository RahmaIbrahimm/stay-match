import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
class MessageSection extends StatelessWidget {
  const MessageSection({
    super.key,
    required TextEditingController messageController,
  }) : _messageController = messageController;

  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
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
}