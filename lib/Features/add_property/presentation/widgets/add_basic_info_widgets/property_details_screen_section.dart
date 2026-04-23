import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/app_styles.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/custom_toggle_switch.dart';
import '../../manager/add_property_cubit.dart';
import '../add_basic_info_widgets/counter_widget.dart';
import '../shared/validation_helper.dart';

class PropertyDetailsSection extends StatelessWidget {
  final AddPropertyCubit cubit;
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController rentController;
  final TextEditingController depositController;
  final TextEditingController sizeController;
  final TextEditingController dateController;
  final VoidCallback onSelectDate;

  const PropertyDetailsSection({
    super.key,
    required this.cubit,
    required this.nameController,
    required this.descController,
    required this.rentController,
    required this.depositController,
    required this.sizeController,
    required this.dateController,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    final req = cubit.request;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.info_outline, AppStrings.basicDetails),
        SizedBox(height: 16.h),
        _label(AppStrings.propertyName),
        _textField(
          AppStrings.propertyNameHint,
          nameController,
              (v) => req.name = v,
          fieldName: AppStrings.propertyName,
          validator: ValidationHelper.validateName,
        ),
        SizedBox(height: 16.h),
        _label(AppStrings.description),
        SizedBox(
          height: 150.h,
          child: _textField(
            AppStrings.descriptionHint,
            descController,
                (v) => req.description = v,
            maxLines: 4,
            fieldName: AppStrings.description,
            validator: ValidationHelper.validateDescription,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _labeledField(
                AppStrings.monthlyRent,
                "\$ 0.00",
                rentController,
                    (v) => req.monthlyRent = int.tryParse(v) ?? 0,
                keyboardType: TextInputType.number,
                fieldName: AppStrings.monthlyRent, validator: (v)=> ValidationHelper.validateNumeric(v, 'Monthly Rent'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _labeledField(
                "Security Deposit",
                "\$ 0.00",
                depositController,
                    (v) => req.deposite = int.tryParse(v) ?? 0,
                keyboardType: TextInputType.number,
                fieldName: "Security Deposit", validator: (v)=> ValidationHelper.validateNumeric(v, 'Security Deposit'),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildCounterRow(context, "Min Stay", "Months", req.minimumStay ?? 1),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(AppStrings.furnished),
                  Row(
                    children: [
                      CustomToggleSwitch(
                        onTap: () => cubit.toggleFurnished(),
                        current: req.furnished ?? true,
                        height: 20,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        (req.furnished ?? true)
                            ? AppStrings.yes
                            : AppStrings.no,
                        style: AppStyles.medium14poppins.copyWith(
                          color: AppColors.textColorSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: _labeledField(
                "Size (sqft)",
                "e.g. 1200",
                sizeController,
                    (v) => req.size = int.tryParse(v) ?? 0,
                keyboardType: TextInputType.number,
                fieldName: 'Size', validator: (v)=> ValidationHelper.validateNumeric(v, 'Size'),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _label(AppStrings.availableFrom),
        GestureDetector(
          onTap: onSelectDate,
          child: AbsorbPointer(
            child: _textField(
              "mm/dd/yyyy",
              dateController,
                  (_) {},
              suffix: Icons.calendar_today_outlined,
              fieldName: 'Availability Date'
              ,
              validator:(v) => ValidationHelper.validateRequired(v, 'Availability Date'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _labeledField(String label,
      String hint,
      TextEditingController controller,
      Function(String) onChanged, {
        TextInputType? keyboardType,
        required String fieldName,
        required String? Function(String?) validator
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        _textField(
          hint,
          controller,
          onChanged,
          keyboardType: keyboardType,
          fieldName: '',
          validator: validator,
        ),
      ],
    );
  }

  Widget _textField(String hint,
      TextEditingController controller,
      Function(String) onChanged, {
        int maxLines = 1,
        IconData? suffix,
        TextInputType? keyboardType,
        required String fieldName,
        required String? Function(String?) validator,
      }) {
    return CustomTextFormField(
      hintText: hint,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      fillColor: const Color(0xFFF7F9FC),
      suffixIcon: suffix != null
          ? Icon(suffix, color: AppColors.primary, size: 20.sp)
          : null,
      hasShadow: false,
      stroke: true,
      strokeColor: AppColors.primary.withValues(alpha: 0.05),
      borderRadius: 12,
      hintStyle: AppStyles.regular14poppins.copyWith(
        color: AppColors.textColorSecondary,
      ),
      validator: validator,
    );
  }

  Widget _buildCounterRow(BuildContext context,
      String title,
      String sub,
      int val,) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.semiBold14poppins),
              Text(
                sub,
                style: AppStyles.regular12poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
            ],
          ),
          CounterWidget(context: context, cubitKey: title, val: val),
        ],
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22.sp),
        SizedBox(width: 8.w),
        Text(title, style: AppStyles.bold18poppins),
      ],
    );
  }

  Widget _label(String t) =>
      Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t, style: AppStyles.semiBold14poppins),
      );
}