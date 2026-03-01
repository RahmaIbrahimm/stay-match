import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/features/auth/widgets/form_section.dart';

import '../../../../../../core/constants/app_styles.dart';
import '../../../../data/manager/auth_cubit.dart';

class ResetPasswordContainerBody extends StatelessWidget {
  ResetPasswordContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPassStateFailure) {
          print(state.errMessage);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[800],
              content: Text(state.errMessage),
            ),
          );
        }
        if (state is ResetPassStateSuccess) {
          print(state.response.message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondary,
              content: Text(
                state.response.message ?? 'Password changed Successfully!',
              ),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.go(AppRouting.loginView);
            }
          });        }
      },
      builder: (context, state) {
        return Form(
          key: authCubit.resetPasswordFormKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                AppStrings.newPassword,
                style: AppStyles.headLine.copyWith(
                  color: AppColors.textColorPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.pleaseWriteNewPass,
                style: AppStyles.cardTitle.copyWith(
                  color: AppColors.textColorSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              FormSection(
                validator: authCubit.passwordValidator(),
                hintText: AppStrings.enterYourNewPass,
                fieldTitle: AppStrings.newPassword,
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: AppColors.primary,
                ),
                controller: authCubit.resetPasswordController,
              ),
              const SizedBox(height: 28),
              FormSection(
                validator: authCubit.passwordValidator(),
                hintText: AppStrings.enterYourNewPass,
                fieldTitle: AppStrings.confirmPassword,
                suffixIcon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: AppColors.primary,
                ),
                controller: authCubit.resetConfirmPasswordController,
              ),
              const SizedBox(height: 40),
              CustomElevatedButton(
                text: AppStrings.confirmCode,
                onPressed: () {
                  authCubit.resetPassValidation();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}