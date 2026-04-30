import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../manager/add_property_cubit.dart';
import '../add_basic_info_widgets/counter_widget.dart';

class RoomCapacitySection extends StatelessWidget {
  final AddPropertyCubit cubit;

  const RoomCapacitySection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final req = cubit.apartmentRequest;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.bed_outlined, AppStrings.capacityAndRooms),
        SizedBox(height: 16.h),
        _buildCounter(context, AppStrings.bedrooms, req.numberOfBedrooms ?? 1),
        _buildCounter(context, AppStrings.livingRooms,req.numberOfLivingRooms  ?? 1),
        _buildCounter(context, AppStrings.enSuiteBathrooms, req.numberOfEnSuiteBathrooms ?? 1),
        _buildCounter(context, AppStrings.guestBathrooms, req.numberOfGuestBathrooms ?? 1),
      ],
    );
  }

  Widget _buildCounter(BuildContext context, String label, int val) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(color: const Color(0xFFF7F9FC), borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppStyles.regular14poppins),
            CounterWidget(context: context, cubitKey: label, val: val),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(children: [
      Icon(icon, color: AppColors.primary, size: 22.sp),
      SizedBox(width: 8.w),
      Text(title, style: AppStyles.bold18poppins),
    ]);
  }
}