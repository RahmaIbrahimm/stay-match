import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_match/Features/rooms/presentation/widgets/room_details/price_row.dart';
import 'package:stay_match/core/constants/app_colors.dart';

class PriceBreakdown extends StatelessWidget {
  final double monthlyRent;
  final double deposit;
  final double serviceFee;

  const PriceBreakdown({
    required this.monthlyRent,
    required this.deposit,
    required this.serviceFee,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xffF2F4F8),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.textColorSecondary),
      ),
      child: Column(
        children: [
          PriceRow(
            label: 'Monthly Rent',
            value: '${monthlyRent.toStringAsFixed(0)} EGP',
          ),
          SizedBox(height: 12.h),
          PriceRow(
            label: 'Security Deposit',
            value: '${deposit.toStringAsFixed(0)} EGP',
          ),
          SizedBox(height: 12.h),
          PriceRow(
            label: 'Service Fee (3%)',
            value: '${serviceFee.toStringAsFixed(0)} EGP',
          ),
        ],
      ),
    );
  }
}