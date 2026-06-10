import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/widgets/custom_drop_down_menu.dart';

import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../core/constants/app_icons.dart';
import '../../../../../../../core/constants/app_strings.dart';
import '../../../../../../../core/constants/app_styles.dart';
import '../../../../../../../core/routing/app_routing.dart';
import '../../../../../../../core/widgets/custom_date_selector.dart';
import '../../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../../core/widgets/custom_text_button.dart';
import '../../../../../../../core/widgets/form_section.dart';
import '../../../../manager/auth_cubit.dart';

class BottomSheetBody extends StatelessWidget {
  BottomSheetBody({super.key});

  final ValueNotifier<bool> _isObscureNotifierPass = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isObscureNotifierConfirmPass = ValueNotifier<bool>(
    true,
  );

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    var size = MediaQuery.of(context).size;
    return Form(
      key: authCubit.signupKey,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterStateFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  authCubit.signPasswordController !=
                          authCubit.signConfirmPasswordController
                      ? 'Passwords do not match'
                      : state.errMessage,
                ),
              ),
            );
          }
          if (state is RegisterStateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.secondary,
                content: Text('Sign Up Successful ✔️'),
              ),
            );
            context.go(AppRouting.homeView);
          }
        },
        child: ListView(
          padding: EdgeInsets.only(top: 30.r),
          children: [
            // info: name
            Row(
              children: [
                Expanded(
                  child: FormSection(
                    validator: (val) => authCubit.nullFieldValidator(text: val),
                    hintText: AppStrings.enterYourFirstName,
                    fieldTitle: AppStrings.firstName,
                    controller: authCubit.signFirstNameController,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: FormSection(
                    validator: (val) => authCubit.nullFieldValidator(text: val),
                    hintText: AppStrings.enterYourLastName,
                    fieldTitle: AppStrings.lastName,
                    controller: authCubit.signLastNameController,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            // info: email
            FormSection(
              validator: (val) => authCubit.emailValidator(email: val),
              hintText: AppStrings.enterYourEmail,
              fieldTitle: AppStrings.email,
              suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
              controller: authCubit.signEmailController,
            ),
            SizedBox(height: 22.h),
            // info: password
            ValueListenableBuilder<bool>(
              valueListenable: _isObscureNotifierPass,
              builder: (context, isObscure, child) {
                return FormSection(
                  validator: (val) =>
                      authCubit.passwordValidator(password: val),
                  hintText: AppStrings.enterYourPassword,
                  fieldTitle: AppStrings.password,
                  suffixIcon: IconButton(
                    color: AppColors.primary,
                    onPressed: () {
                      _isObscureNotifierPass.value =
                          !_isObscureNotifierPass.value;
                    },
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                  isObscure: isObscure,
                  controller: authCubit.signPasswordController,
                );
              },
            ),
            SizedBox(height: 22.h),
            // info: confirm password
            ValueListenableBuilder<bool>(
              valueListenable: _isObscureNotifierConfirmPass,
              builder: (context, isObscure, child) {
                return FormSection(
                  validator: (val) => authCubit.passwordMatchValidator(
                    password: authCubit.signPasswordController.text,
                    confirmPassword:
                        authCubit.signConfirmPasswordController.text,
                  ),
                  hintText: AppStrings.enterYourPassword,
                  fieldTitle: AppStrings.confirmPassword,
                  suffixIcon: IconButton(
                    color: AppColors.primary,
                    onPressed: () {
                      _isObscureNotifierConfirmPass.value =
                          !_isObscureNotifierConfirmPass.value;
                    },
                    icon: Icon(
                      isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                  isObscure: isObscure,
                  controller: authCubit.signConfirmPasswordController,
                );
              },
            ),
            SizedBox(height: 22.h),
            // info: city and birth date
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.city, style: AppStyles.semibold24poppins),
                      SizedBox(height: 8.h),
                      CustomDropDownMenu(
                        hasSearch: false,
                        menuItems: AppStrings.egyptCities,
                        hintText: AppStrings.chooseYourCity,
                        selectedValue: authCubit.cityController,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.birthDate,
                        style: AppStyles.semibold24poppins,
                      ),
                      SizedBox(height: 8.h),
                      CustomDateSelector(
                        size: size,
                        dateController: authCubit.birthDateController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            // info: gender
            Text(AppStrings.gender, style: AppStyles.semibold24poppins),
            SizedBox(height: 8.h),
            CustomDropDownMenu(
              hasSearch: false,
              menuItems: AppStrings.authGenderMenuItems,
              hintText: AppStrings.enterYourGender,
              selectedValue: authCubit.genderController,
            ),
            SizedBox(height: 45.h),
            CustomElevatedButton(
              text: AppStrings.submit,
              onPressed: () {
                authCubit.formValidationAndInvokeMethod(
                  key: authCubit.signupKey,
                  authMethod: authCubit.signup(),
                  hasConfirmPassword: true,
                  pass: authCubit.signPasswordController.text,
                  confirmPass: authCubit.signConfirmPasswordController.text,
                );
              },
            ),
            // info: nav to login page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.alreadyHaveAnAccount,
                  style: AppStyles.regular14poppins.copyWith(
                    color: AppColors.textColorSecondary,
                  ),
                ),
                CustomTextButton(
                  onPressed: () {
                    context.pushReplacement(AppRouting.loginView);
                  },
                  text: AppStrings.login,
                  textColor: AppColors.secondary,
                ),
              ],
            ),
            SizedBox(height: 45.h),
          ],
        ),
      ),
    );
  }
}