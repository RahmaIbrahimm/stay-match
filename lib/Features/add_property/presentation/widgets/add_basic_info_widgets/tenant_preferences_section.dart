import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_drop_down_menu.dart';
import '../../manager/add_property_cubit.dart';

class TenantPreferencesSection extends StatelessWidget {
  final AddPropertyCubit cubit;

  const TenantPreferencesSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.groups_outlined, AppStrings.allowedTenants),
        SizedBox(height: 16.h),
        _buildTenantGrid(cubit),
        SizedBox(height: 24.h),
        _sectionHeader(Icons.wc_outlined, AppStrings.preferredGender),
        SizedBox(height: 16.h),
        CustomDropDownMenu(
          menuItems: AppStrings.genderMenuItems,
          hintText: AppStrings.enterYourGender,
          hasSearch: false,
          onChanged: (val) => cubit.toggleGenderType(genderType: val!),
          fillColor: AppColors.fieldFillColor,
          strokeColor: const Color(0xFFE8EDF5),
          hasShadow: false,
        ),
      ],
    );
  }

  Widget _buildTenantGrid(AddPropertyCubit cubit) {
    final t = cubit.request.allowedTenants;
    final Map<String, bool> tenantStatus = {
      AppStrings.pets: t?.petsAllowed ?? false,
      AppStrings.families: t?.allowsFamilies ?? false,
      AppStrings.children: t?.allowsChildren ?? false,
      AppStrings.students: t?.allowsStudents ?? false,
      AppStrings.workersProfessionals: t?.allowsWorkers ?? false,
    };
    final labels = tenantStatus.keys.toList();

    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: labels.asMap().entries.map((entry) {
        final String label = entry.value;
        final bool isSel = tenantStatus[label]!;
        final bool isLast = entry.key == labels.length - 1;

        return GestureDetector(
          onTap: () => cubit.toggleTenantType(label),
          child: Container(
            width: isLast ? 1.sw : (1.sw - 32.w - 34.w) / 2,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: isSel ? AppColors.primary : const Color(0xFFE8EDF5), width: 1.5),
            ),
            child: Row(children: [
              _customCheckbox(isSel),
              SizedBox(width: 12.w),
              Expanded(child: Text(label, style: AppStyles.medium14poppins.copyWith(color: const Color(0xFF1A1C1E)))),
            ]),
          ),
        );
      }).toList(),
    );
  }

  Widget _customCheckbox(bool isSel) {
    return Container(
      decoration: BoxDecoration(
        color: isSel ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: isSel ? AppColors.primary : const Color(0xFFD1D9E6)),
      ),
      child: Icon(Icons.check, color: Colors.white, size: 14.sp),
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