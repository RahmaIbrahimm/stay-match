import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_icons.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';


import '../../../../../../../core/routing/app_routing.dart';
import '../../../../../../../core/widgets/form_section.dart';
import '../../../../../manager/auth_cubit.dart';
import 'divider_between_login_buttons.dart';

class LoginViewBodyBottomSheet extends StatelessWidget {
  LoginViewBodyBottomSheet({super.key});

  final ValueNotifier<bool> _isObscureNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Form(
      key: authCubit.loginKey,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginStateFailure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
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
            context.go(AppRouting.homeView);
          }
          // GOOGLE LOGIN :
          if (state is GoogleLoginStateSuccess) {
            // Handle successful Google login
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Google Sign-In Successful!')),
            );
            context.go(AppRouting.homeView);
          }
          if (state is GoogleLoginStateFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          bool isLoading = state is LoginStateLoading;
          return ListView(
            children: [
              const SizedBox(height: 33),
              // todo: implement validator email
              FormSection(
                validator:(val)=>  authCubit.emailValidator(email: val),
                hintText: AppStrings.enterYourEmail,
                fieldTitle: AppStrings.email,
                suffixIcon: ImageIcon(AssetImage(AppIcons.emailIcon)),
                controller: authCubit.loginEmailController,
              ),
              const SizedBox(height: 37),
              // todo: implement validator password
              ValueListenableBuilder<bool>(
                valueListenable: _isObscureNotifier,
                builder: (context, isObscure, child) {
                  return FormSection(
                    validator: (val)=> authCubit.passwordValidator(password: val),
                    hintText: AppStrings.enterYourPassword,
                    fieldTitle: AppStrings.password,
                    suffixIcon: IconButton(
                      color: AppColors.primary,
                      onPressed: () {
                        _isObscureNotifier.value = !_isObscureNotifier.value;
                      },
                      icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.remove_red_eye_outlined,
                      ),
                    ),
                    isObscure: isObscure,
                    controller: authCubit.loginPasswordController,
                  );
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextButton(
                  onPressed: () {
                    context.go(AppRouting.forgetPasswordView);
                  },
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
                          authCubit.formValidationAndInvokeMethod(key: authCubit.loginKey, authMethod: authCubit.login());
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
                  onPressed: () async{
                    await authCubit.googleLogin();
                  } ,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.dontHaveAnAccount),
                  // TODO: implement on pressed
                  CustomTextButton(
                    onPressed: () {
                      context.go(AppRouting.signupView);
                    },
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