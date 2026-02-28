import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';

import '../../../../widgets/form_section.dart';
import 'divider_between_login_buttons.dart';

class LoginViewBodyBottomSheet extends StatelessWidget {
  LoginViewBodyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Form(
      key: authCubit.loginKey,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginStateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[800],
                content: Text(state.errMessage ),
              ),
            );
          }
          if (state is LoginStateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.secondary,
                content: Text(state.user.message ?? 'Login Successful'),
              ),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is LoginStateLoading;
          return ListView(
          children: [
            const SizedBox(height: 33),
            // todo: implement validator email
            FormSection(
              validator: authCubit.loginEmailValidator(),
              hintText: AppStrings.enterYourEmail,
              fieldTitle: AppStrings.email,
              suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
              controller: authCubit.emailController,
            ),
            const SizedBox(height: 37),
            // todo: implement validator password
            FormSection(
              validator: authCubit.loginPasswordValidator(),
              hintText: AppStrings.enterYourPassword,
              fieldTitle: AppStrings.password,
              suffixIcon: Icon(
                Icons.remove_red_eye_outlined,
                color: AppColors.primary,
              ),
              controller: authCubit.passwordController,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomTextButton(
                onPressed: () {},
                text: AppStrings.forgetPasswordQuestion,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: AppStrings.login,
                onPressed: isLoading
                    ? null
                    : () {
                  final formState = authCubit.loginKey.currentState;
                  if (formState is FormState && formState.validate() == true) {
                    authCubit.login();
                  }
                },
                isLoading: isLoading,
              ),
            ),
            const SizedBox(height: 15),
            DividerBetweenLoginButtons(size: size),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                text: AppStrings.loginWithGoogle,
                backgroundColor: AppColors.secondary,
                textColor: AppColors.backgroundColor,
                icon: Brand(Brands.google, size: 20),
                onPressed: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppStrings.dontHaveAnAccount),
                // TODO: implement on pressed
                CustomTextButton(
                  onPressed: () {},
                  text: AppStrings.signUp,
                  textColor: AppColors.secondary,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        );
        },
      ),
    );
  }
}