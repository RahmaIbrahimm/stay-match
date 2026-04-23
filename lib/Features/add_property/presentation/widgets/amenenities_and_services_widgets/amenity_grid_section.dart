import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_styles.dart';
import '../amenenities_and_services_widgets/selectable_card.dart';
import 'Amenity_item.dart';

class AmenityGridSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<AmenityItem> items;
  final Map<String, dynamic> currentValues;
  final Function(String) onTap;

  const AmenityGridSection({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.currentValues,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        // Section Header
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 24.sp),
                SizedBox(width: 8.w),
                Text(title, style: AppStyles.bold18poppins),
              ],
            ),
          ),
        ),
        // The Grid
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final item = items[index];
              final bool isSelected = currentValues[item.apiKey] ?? false;

              return SelectableCard(
                label: item.label,
                icon: item.icon,
                isSelected: isSelected,
                onTap: () => onTap(item.apiKey),
              );
            },
            childCount: items.length,
          ),
        ),
      ],
    );
  }
}