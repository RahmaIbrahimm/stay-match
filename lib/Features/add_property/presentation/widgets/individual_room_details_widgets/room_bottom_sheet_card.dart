import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/custom_toggle_switch.dart';
import '../../manager/add_property_cubit.dart';
import '../location_and_gallery_widgets/property_gallery_widget.dart';
import '../shared/field_label.dart';

class RoomBottomSheetCard extends StatelessWidget {
  final int index;
  final dynamic room;
  final AddPropertyCubit cubit;
  final bool canDelete;

  const RoomBottomSheetCard({
    required this.index,
    required this.room,
    required this.cubit,
    required this.canDelete,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? displayDate;
    if (room.availableFrom != null) {
      displayDate = room.availableFrom is String
          ? DateTime.tryParse(room.availableFrom)
          : room.availableFrom;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: index == 0,
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.king_bed_outlined,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
          title: Text(
            "Room ${index + 1}: ${room.roomName ?? 'Standard Room'}",
            style: AppStyles.bold16poppins,
          ),
          subtitle: Text(
            room.furnished == true ? 'Furnished' : 'Unfurnished',
            style: AppStyles.medium12poppins.copyWith(color: Colors.grey),
          ),
          childrenPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
          children: [
            const Divider(color: Color(0xFFF1F5F9), thickness: 1.5),
            SizedBox(height: 12.h),
            FieldLabel(t: "Room Photos"),
            PropertyGalleryWidget(roomIndex: index, hasCoverImage: false),
            SizedBox(height: 20.h),
            FieldLabel(t: "Room Name"),
            CustomTextFormField(
              hasShadow: false,
              strokeColor: AppColors.stroke,
              hintText: "e.g. Master Suite",
              onChanged: (v) => cubit.updateRoomBasicData(index, name: v),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Name required" : null,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(t: AppStrings.monthlyRent),
                      CustomTextFormField(
                        hasShadow: false,
                        strokeColor: AppColors.stroke,
                        hintText: "\$",
                        keyboardType: TextInputType.number,
                        onChanged: (v) => cubit.updateRoomBasicData(
                          index,
                          rent: int.tryParse(v),
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Required" : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(t: "Deposit"),
                      CustomTextFormField(
                        hasShadow: false,
                        strokeColor: AppColors.stroke,
                        hintText: "\$",
                        keyboardType: TextInputType.number,
                        onChanged: (v) => cubit.updateRoomBasicData(
                          index,
                          deposit: int.tryParse(v),
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Required" : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(t: "Min. Stay (Months)"),
                      CustomTextFormField(
                        hasShadow: false,
                        strokeColor: AppColors.stroke,
                        hintText: "1",
                        keyboardType: TextInputType.number,
                        onChanged: (v) => cubit.updateRoomBasicData(
                          index,
                          minimumStay: int.tryParse(v),
                        ),
                        // Add this!
                        validator: (v) =>
                            (v == null || v.isEmpty) ? "Required" : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(t: "Available From"),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: displayDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 5 * 365),
                            ),
                          );
                          if (pickedDate != null) {
                            cubit.updateRoomBasicData(
                              index,
                              availableDate: pickedDate.toIso8601String(),
                            );
                          }
                        },
                        child: CustomTextFormField(
                          hasShadow: false,
                          strokeColor: AppColors.stroke,
                          hintText: displayDate != null
                              ? "${displayDate.day}/${displayDate.month}/${displayDate.year}"
                              : "dd/mm/yyyy",
                          enabled: false,
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: AppColors.textColorSecondary,
                          ),
                          validator: (v) =>
                              displayDate == null ? "Required" : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _buildCounterField(
                    "Total Capacity",
                    room.capacity ?? 1,
                    onIncrement: () => cubit.updateRoomCapacity(
                      index,
                      total: (room.capacity ?? 1) + 1,
                    ),
                    onDecrement: () {
                      if ((room.capacity ?? 1) > 1) {
                        int newTotal = (room.capacity ?? 1) - 1;
                        int currentAvail = room.capacityAvailable ?? 1;
                        cubit.updateRoomCapacity(
                          index,
                          total: newTotal,
                          available: currentAvail > newTotal
                              ? newTotal
                              : currentAvail,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildCounterField(
                    "Available Spots",
                    room.capacityAvailable ?? 1,
                    onIncrement: () {
                      if ((room.capacityAvailable ?? 1) <
                          (room.capacity ?? 1)) {
                        cubit.updateRoomCapacity(
                          index,
                          available: (room.capacityAvailable ?? 1) + 1,
                        );
                      }
                    },
                    onDecrement: () {
                      if ((room.capacityAvailable ?? 1) > 1) {
                        cubit.updateRoomCapacity(
                          index,
                          available: (room.capacityAvailable ?? 1) - 1,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Fully Furnished", style: AppStyles.medium14poppins),
                CustomToggleSwitch(
                  current: room.furnished ?? true,
                  onTap: () => cubit.toggleFurnished(
                    index: index,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            FieldLabel(t: "Bathroom Type"),
            Row(
              children: [
                _buildTab("En-suite", room.enSuiteBathroom ?? true, true),
                SizedBox(width: 12.w),
                _buildTab("Shared", !(room.enSuiteBathroom ?? true), false),
              ],
            ),
            SizedBox(height: 24.h),
            FieldLabel(t: "Key Features"),
            Wrap(
              spacing: 8.w,
              children: [
                _buildFeatureChip(
                  Icons.balcony,
                  "Balcony",
                  room.balcony ?? false,
                  () => cubit.toggleRoomKeyFeature(index, 'Balcony'),
                ),
                _buildFeatureChip(
                  Icons.window,
                  "Window",
                  room.window ?? false,
                  () => cubit.toggleRoomKeyFeature(index, 'Window'),
                ),
                _buildFeatureChip(
                  Icons.pets,
                  "Pets",
                  room.petsAllowed ?? false,
                  () => cubit.toggleRoomKeyFeature(index, 'Pets'),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            FieldLabel(t: "Room Amenities"),
            _buildAmenitiesGrid(),
            SizedBox(height: 24.h),
            FieldLabel(t: "Allowed Tenants"),
            _buildTenantGrid(),
            SizedBox(height: 24.h),
            _buildGenderPreference(),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterField(
    String label,
    int val, {
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(t: label),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove, size: 18),
              ),
              Text("$val", style: AppStyles.bold14poppins),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add, size: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String label, bool isSelected, bool value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => cubit.updateRoomBasicData(index, isEnSuite: value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF1F5F9) : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureChip(
    IconData icon,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isSelected ? AppColors.primary : Colors.black,
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected ? AppColors.primary : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmenitiesGrid() {
    final Map<String, String> amenities = {
      "airConditioning": "Air Conditioning",
      "closet": "Closet",
      "mirror": "Full Mirror",
      "fan": "Ceiling Fan",
    };
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 4,

      physics: const NeverScrollableScrollPhysics(),
      children: amenities.entries.map((entry) {
        final isSelected = room.roomAmenities?.toJson()[entry.key] ?? false;
        return Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              value: isSelected,
              activeColor: AppColors.primary,
              onChanged: (v) => cubit.toggleRoomAmenity(index, entry.key),
            ),
            Text(entry.value, style: AppStyles.medium12poppins),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTenantGrid() {
    final types = ["Families", "Children", "Students", "Workers"];
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: types.map((type) {
        bool isSelected = false;
        if (type == "Families")
          isSelected = room.allowedTenants?.allowsFamilies ?? true;
        if (type == "Children")
          isSelected = room.allowedTenants?.allowsChildren ?? true;
        if (type == "Students")
          isSelected = room.allowedTenants?.allowsStudents ?? true;
        if (type == "Workers")
          isSelected = room.allowedTenants?.allowsWorkers ?? true;
        return GestureDetector(
          onTap: () => cubit.toggleRoomTenantType(index, type),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xffF1F5F9),
              // color: !isSelected ? AppColors.containerColor : AppColors.bgGrey,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2,
              ),
            ),
            child: Text(
              type,
              style: AppStyles.medium12poppins.copyWith(
                color: !isSelected ? AppColors.primary : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGenderPreference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender preference:",
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
        ),
        Row(
          children: ["Male", "Female", "Any"].map((g) {
            return Row(
              children: [
                Radio<String>(
                  value: g,
                  groupValue: room.allowedTenants?.studentGender ?? "Any",
                  activeColor: AppColors.primary,
                  onChanged: (v) => cubit.updateRoomGender(index, v!),
                ),
                Text(g, style: TextStyle(fontSize: 13.sp)),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}