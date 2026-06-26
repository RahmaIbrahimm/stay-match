import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stay_match/Features/filter/presentation/manager/location_cubit.dart';
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
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isInitialSyncDone = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfileData();
    context.read<LocationCubit>().loadLocations();
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
    _cityController.dispose();
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
          _cityController.text = data?.city ?? '';
          _bioController.text = data?.aboutMe ?? '';
          _isInitialSyncDone = true;
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
    final profileCubit = context.watch<ProfileCubit>();

    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        var locationCubit = context.read<LocationCubit>();
        if (state is LocationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LocationErrorState) {
          return Center(child: Text(state.message));
        } else if (state is GovernoratesLoadedState) {

          // 1. Resolve Birth Date Display dynamically from draft request
          String birthDate = profileCubit.request?.birthDate ?? '';
          final bdConvertedAToDt = DateTime.tryParse(birthDate);
          String formattedBirthDate = bdConvertedAToDt != null
              ? DateFormat('dd/MM/yyyy').format(bdConvertedAToDt)
              : 'Select Date';

          // 2. Resolve National ID Display Text dynamically from the source of truth
          String idImageDisplayText = "Add Image";
          if (profileCubit.pickedIdImageFile != null) {
            // Local file picked priority view
            idImageDisplayText = "Selected: ${profileCubit.pickedIdImageFile!.path.split('/').last}";
          } else if (data?.idImage != null && data!.idImage!.isNotEmpty) {
            // Cloud file verified fallback view
            idImageDisplayText = "ID Image Uploaded Verified";
          }

          var governorates = state.governorates;
          var governoratesNames = governorates.map((e) => e.nameInEnglish).toList();
          final currentGovern = data?.governorate ?? '';
          final currentCity = data?.city ?? '';

          final matchedGov = governorates.firstWhereOrNull(
                (e) => e.nameInEnglish == currentGovern,
          );

          final cities = locationCubit.filteredCities.isNotEmpty
              ? locationCubit.filteredCities
              : (matchedGov?.citiesAndVillages ?? []);
          var citiesName = cities.map((e) => e.nameInEnglish).toList();

          if (locationCubit.selectedGovernorate == null && matchedGov != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              locationCubit.selectGovernorate(matchedGov);
              final matchedCity = cities.firstWhereOrNull(
                    (e) => e.nameInEnglish == currentCity,
              );
              if (matchedCity != null) locationCubit.selectCity(matchedCity);
            });
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(20.r),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(cubit: profileCubit, data: data!),
                  SizedBox(height: 24.h),

                  _buildLabel(AppStrings.fullName),
                  _buildField(
                    hintText: AppStrings.enterYourName,
                    validator: (val) => val!.isEmpty ? "Required" : null,
                    controller: _nameController,
                    onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(fullName: val)),
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
                              onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(phoneNumber: val)),
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
                              onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(gender: val)),
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
                    onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(fieldOfStudy: val)),
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel(AppStrings.jobTitle),
                  _buildField(
                    hintText: AppStrings.jobTitle,
                    validator: (val) => val!.isEmpty ? "Required" : null,
                    controller: _jobController,
                    onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(jobTitle: val)),
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel(AppStrings.birthDate),
                  GestureDetector(
                    onTap: () async {
                      var resDate = await _selectDate(context);
                      if (resDate != null) {
                        profileCubit.updateRequest(UpdateProfileRequest(birthDate: resDate.toString()));
                        setState(() {});
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: AppColors.fieldFillColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.stroke, width: 2),
                      ),
                      child: Text(formattedBirthDate),
                    ),
                  ),
                  SizedBox(height: 16.h),

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
                              menuItems: governoratesNames,
                              hintText: currentGovern,
                              selectedValue: _governorateController,
                              onChanged: (val) {
                                if (val == null) return;
                                _governorateController.text = val;

                                final gov = governorates.firstWhereOrNull((e) => e.nameInEnglish == val);
                                final firstCity = gov?.citiesAndVillages.firstOrNull;
                                _cityController.text = firstCity?.nameInEnglish ?? '';

                                profileCubit.updateRequest(
                                  UpdateProfileRequest(
                                    governorate: val,
                                    city: firstCity?.nameInEnglish,
                                  ),
                                );
                                locationCubit.selectGovernorate(gov);
                                if (firstCity != null) locationCubit.selectCity(firstCity);
                                locationCubit.refreshCities();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel(AppStrings.city),
                            CustomDropDownMenu<String>(
                              fillColor: AppColors.fieldFillColor,
                              strokeColor: AppColors.stroke,
                              hasShadow: false,
                              menuItems: citiesName,
                              hintText: currentCity,
                              selectedValue: _cityController,
                              onChanged: (val) {
                                if (val == null) return;
                                _cityController.text = val;
                                profileCubit.updateRequest(UpdateProfileRequest(city: val));
                                var city = cities.firstWhereOrNull((e) => e.nameInEnglish == val);
                                locationCubit.selectCity(city);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // National ID Field Fixed Sequence
                  SizedBox(height: 16.h),
                  _buildLabel("National Id"),
                  GestureDetector(
                    onTap: () async {
                      await profileCubit.pickIdImage();
                      setState(() {}); // Triggers build recalculation against updated Cubit references
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: AppColors.fieldFillColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.stroke, width: 2),
                      ),
                      child: Text(idImageDisplayText),
                    ),
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
                    onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(aboutMe: val)),
                  ),
                  SizedBox(height: 24.h),

                  ProfileToggleTile(
                    icon: Icons.smoking_rooms,
                    title: AppStrings.smoker,
                    isOn: false,
                    onChanged: () => null,
                  ),
                  ProfileToggleTile(
                    icon: Icons.pets,
                    title: AppStrings.hasPets,
                    isOn: false,
                    onChanged: () => null,
                  ),
                  ProfileToggleTile(
                    icon: Icons.nightlight_round,
                    title: AppStrings.nightOwl,
                    isOn: false,
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
                              onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(governorate: val)),
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
                    onChanged: (index) {
                      log("Cultural: $index");
                    },
                  ),
                  VibeCheckSlider(
                    title: "Cleanliness Level",
                    options: const ["Relaxed", "Normal", "Strict", "Very Strict"],
                    initialValue: 3,
                    onChanged: (index) {
                      log("Cleanliness: $index");
                    },
                  ),

                  SizedBox(height: 16.h),
                  Container(height: 16.h, color: AppColors.fieldFillColor),
                  SizedBox(height: 16.h),
                  _buildSectionTitle(AppStrings.accountSecurity),
                  _buildField(
                    hintText: AppStrings.newPassword,
                    fillColor: AppColors.containerColor,
                    validator: (val) {
                      if (val == null || val.isEmpty) return null;
                      if (val.length < 6) return 'At least 6 characters';
                      if (!val.contains(RegExp(r'[A-Z]'))) return 'Needs an uppercase letter';
                      if (!val.contains(RegExp(r'[a-z]'))) return 'Needs a lowercase letter';
                      if (!val.contains(RegExp(r'[0-9]'))) return 'Needs a number';
                      if (!val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'Needs a special character';
                      return null;
                    },
                    controller: _passwordController,
                    isObscure: true,
                    onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(password: val)),
                  ),
                  SizedBox(height: 12.h),
                  _buildField(
                    fillColor: AppColors.containerColor,
                    hintText: AppStrings.confirmPassword,
                    validator: (val) {
                      if (_passwordController.text.isEmpty) return null;
                      if (val == null || val.isEmpty) return 'Please confirm your password';
                      if (val != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                    controller: _confirmPasswordController,
                    isObscure: true,
                    onChanged: (val) => profileCubit.updateRequest(UpdateProfileRequest(passwordConfirmation: val)),
                  ),

                  SizedBox(height: 16.h),
                  _buildDeleteAccountButton(),
                  SizedBox(height: 16.h),
                  _buildSaveChangesButton(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildField({
    required String hintText,
    bool enabled = true,
    required String? Function(String?) validator,
    required TextEditingController controller,
    void Function(String)? onChanged,
    bool isObscure = false,
    int? maxLines,
    Color? fillColor,
  }) {
    return CustomTextFormField(
      fillColor: fillColor ?? AppColors.fieldFillColor,
      strokeColor: AppColors.stroke,
      enabled: enabled,
      hasShadow: false,
      hintText: hintText,
      isObscure: isObscure,
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
        return SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(
            text: state is ProfileLoading ? "Saving..." : AppStrings.saveChanges,
            onPressed: (cubit.isDirty && state is! ProfileLoading)
                ? () {
              if (_formKey.currentState?.validate() ?? true) {
                cubit.saveProfileChanges();
              }
            }
                : null,
            borderRadius: 12,
            textStyle: AppStyles.bold16poppins,
            verticalPadding: 16,
          ),
        );
      },
    );
  }

  Widget _buildDeleteAccountButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
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
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 100 * 365)),
      lastDate: DateTime.now().subtract(const Duration(days: 13 * 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF1A2E63)),
        ),
        child: child!,
      ),
    );
  }
}