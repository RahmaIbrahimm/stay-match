import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_styles.dart';
class HostCard extends StatelessWidget {
  const HostCard({super.key, required this.hostName});
  final String hostName;
  @override
  Widget build(BuildContext context) {
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
                "Hosted By $hostName",
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
}