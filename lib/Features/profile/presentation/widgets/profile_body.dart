import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/profile/presentation/manager/profile_cubit.dart';
import 'package:stay_match/core/widgets/custom_drop_down_menu.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_form_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_styles.dart';
import '../../data/models/profile_response.dart';
import '../../data/models/update_profile_request.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_toggle_tile.dart';
import '../widgets/vibe_check_slider.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Flag to prevent the text fields from snapping back to old values while typing
  bool _isInitialSyncDone = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _educationController.dispose();
    _jobController.dispose();
    _bioController.dispose();
    _governorateController.dispose();
    _budgetController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess && !_isInitialSyncDone) {
          final data = state.response.data;
          _nameController.text = data?.fullName ?? '';
          _emailController.text = data?.email ?? '';
          _phoneController.text = data?.phoneNumber ?? '';
          _genderController.text = data?.gender ?? '';
          _educationController.text = data?.fieldOfStudy ?? '';
          _jobController.text = data?.jobTitle ?? '';
          _governorateController.text = data?.governorate ?? '';
          _bioController.text = data?.aboutMe ?? '';
          // _budgetController.text = data?.budget?.toString() ?? '';

          _isInitialSyncDone =
              true; // Prevents overwriting user input on future state changes
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is ProfileFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is ProfileSuccess) {
          return _buildProfileForm(state.response.data);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildProfileForm(ProfileRespData? data) {
    final cubit = context.watch<ProfileCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(cubit: cubit, data: data!),
          SizedBox(height: 24.h),

          _buildLabel(AppStrings.fullName),
          _buildField(
            hintText: AppStrings.enterYourName,
            validator: (val) => val!.isEmpty ? "Required" : null,
            controller: _nameController,
            onChanged: (val) =>
                cubit.updateRequest(UpdateProfileRequest(fullName: val)),
          ),
          SizedBox(height: 16.h),

          _buildLabel(AppStrings.emailAddress),
          _buildField(
            hintText: AppStrings.email,
            validator: (val) => val!.isEmpty ? "Required" : null,
            controller: _emailController,
            enabled: false,
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(AppStrings.phone),
                    _buildField(
                      hintText: AppStrings.phone,
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      controller: _phoneController,
                      onChanged: (val) => cubit.updateRequest(
                        UpdateProfileRequest(phoneNumber: val),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(AppStrings.gender),
                    CustomDropDownMenu<String>(
                      fillColor: AppColors.fieldFillColor,
                      strokeColor: AppColors.stroke,
                      hasSearch: false,
                      hasShadow: false,
                      menuItems: AppStrings.authGenderMenuItems,
                      hintText: AppStrings.gender,
                      selectedValue: _genderController,
                      onChanged: (val) => cubit.updateRequest(
                        UpdateProfileRequest(gender: val),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          _buildLabel(AppStrings.education),
          _buildField(
            hintText: AppStrings.education,
            validator: (val) => val!.isEmpty ? "Required" : null,
            controller: _educationController,
            onChanged: (val) =>
                cubit.updateRequest(UpdateProfileRequest(fieldOfStudy: val)),
          ),
          SizedBox(height: 16.h),

          _buildLabel(AppStrings.jobTitle),
          _buildField(
            hintText: AppStrings.jobTitle,
            validator: (val) => val!.isEmpty ? "Required" : null,
            controller: _jobController,
            onChanged: (val) =>
                cubit.updateRequest(UpdateProfileRequest(jobTitle: val)),
          ),
          SizedBox(height: 16.h),
          Container(height: 16.h, color: AppColors.fieldFillColor),
          SizedBox(height: 16.h),
          _buildSectionTitle("Compatibility Preferences"),
          _buildLabel(AppStrings.aboutMe),
          _buildField(
            hintText: "Write something about yourself...",
            validator: (val) => null,
            controller: _bioController,
            maxLines: 4,
            onChanged: (val) => cubit.updateRequest(UpdateProfileRequest(aboutMe: val)),
          ),
          SizedBox(height: 24.h),

          ProfileToggleTile(
            icon: Icons.smoking_rooms,
            title: AppStrings.smoker,
            isOn: false,
            // fixme isOn: data?.isSmoker ?? false,
            // --- PENDING BACKEND INTEGRATION ---
            onChanged: () => null,
          ),
          ProfileToggleTile(
            icon: Icons.pets,
            title: AppStrings.hasPets,
            isOn: false,
            // fixme isOn: data?.hasPets ?? false,
            // todo --- PENDING BACKEND INTEGRATION ---
            onChanged: () => null,
          ),
          ProfileToggleTile(
            icon: Icons.nightlight_round,
            title: AppStrings.nightOwl,
            isOn: false,
            // fixme isOn: data?.isNightOwl ?? false,
            // todo --- PENDING BACKEND INTEGRATION ---
            onChanged: () => null,
          ),

          SizedBox(height: 16.h),
          Container(height: 16.h, color: AppColors.fieldFillColor),
          SizedBox(height: 16.h),
          _buildSectionTitle(AppStrings.housingPref),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(AppStrings.governorate),
                    CustomDropDownMenu<String>(
                      fillColor: AppColors.fieldFillColor,
                      strokeColor: AppColors.stroke,
                      hasShadow: false,
                      menuItems: AppStrings.egyptCities,
                      hintText: AppStrings.governorate,
                      selectedValue: _governorateController,
                      onChanged: (val) => cubit.updateRequest(
                        UpdateProfileRequest(governorate: val),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Budget"),
                    CustomTextFormField(
                      fillColor: AppColors.fieldFillColor,
                      strokeColor: AppColors.stroke,
                      hasShadow: false,
                      hintText: "Budget (LE/mo)",
                      controller: _budgetController,
                      keyboardType: TextInputType.number,
                      validator: (val) => null,
                      // todo --- PENDING BACKEND INTEGRATION ---
                      // onChanged: (val) => cubit.updateRequest(UpdateProfileRequest(budget: val)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          Container(height: 16.h, color: AppColors.fieldFillColor),
          SizedBox(height: 16.h),
          _buildSectionTitle("Vibe Check"),
          VibeCheckSlider(
            title: AppStrings.culturalImportance,
            options: AppStrings.culturalImportanceSliderOptions,
            initialValue: 2,
            //fixme initialValue: data?.culturalImportance ?? 2,
            onChanged: (index) {
              log("Cultural: $index");
              // todo --- PENDING BACKEND INTEGRATION ---
              // cubit.updateRequest(UpdateProfileRequest(culturalImportance: index));
            },
          ),
          VibeCheckSlider(
            title: "Cleanliness Level",
            options: const ["Relaxed", "Normal", "Strict", "Very Strict"],
            initialValue: 3,
            //fixme initialValue: data?.cleanlinessLevel ?? 3,
            onChanged: (index) {
              log("Cleanliness: $index");
              // todo --- PENDING BACKEND INTEGRATION ---
              // cubit.updateRequest(UpdateProfileRequest(cleanlinessLevel: index));
            },
          ),

          SizedBox(height: 16.h),
          Container(height: 16.h, color: AppColors.fieldFillColor),
          SizedBox(height: 16.h),
          _buildSectionTitle(AppStrings.accountSecurity),
          _buildField(
            hintText: AppStrings.newPassword,
            fillColor: AppColors.containerColor,
            validator: (val) => null,
            controller: _passwordController,
            isObsecure: true,
            onChanged: (val) =>
                cubit.updateRequest(UpdateProfileRequest(password: val)),
          ),
          SizedBox(height: 12.h),
          _buildField(
            fillColor: AppColors.containerColor,
            hintText: AppStrings.confirmPassword,
            validator: (val) => null,
            controller: _confirmPasswordController,
            isObsecure: true,
            onChanged: (val) => cubit.updateRequest(
              UpdateProfileRequest(passwordConfirmation: val),
            ),
          ),

          SizedBox(height: 16.h),
          _buildDeleteAccountButton(),
          SizedBox(height: 16.h),
          _buildSaveChangesButton(),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildField({
    required String hintText,
    bool enabled = true,
    required String? Function(String?) validator,
    required TextEditingController controller,
    void Function(String)? onChanged,
    bool isObsecure = false,
    int? maxLines,
    Color? fillColor,
  }) {
    return CustomTextFormField(
      fillColor: fillColor ?? AppColors.fieldFillColor,
      strokeColor: AppColors.stroke,
      enabled: enabled,
      hasShadow: false,
      hintText: hintText,
      isObscure: isObsecure,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        text,
        style: AppStyles.semiBold14poppins.copyWith(
          color: AppColors.textColorSecondary,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(text, style: AppStyles.bold16poppins),
    );
  }

  Widget _buildSaveChangesButton() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.watch<ProfileCubit>();
        return CustomElevatedButton(
          text: state is ProfileLoading ? "Saving..." : AppStrings.saveChanges,
          onPressed: (cubit.isDirty && state is! ProfileLoading)
              ? () => cubit.saveProfileChanges()
              : null,
          borderRadius: 12,
          textStyle: AppStyles.bold16poppins,
          verticalPadding: 16,
        );
      },
    );
  }

  Widget _buildDeleteAccountButton() {
    return CustomElevatedButton(
      mainAxisAlignment: MainAxisAlignment.start,
      text: AppStrings.deleteAccount,
      onPressed: () {},
      borderRadius: 12,
      textStyle: AppStyles.semiBold14poppins,
      verticalPadding: 16,
      suffixIcon: Icon(
        MdiIcons.trashCanOutline,
        color: AppColors.textColorError,
        size: 20.sp,
      ),
      textColor: AppColors.textColorError,
      backgroundColor: const Color(0xffFEF2F2),
      borderColor: const Color(0xffFECACA),
    );
  }
}