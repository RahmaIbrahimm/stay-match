import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';

import '../../../../../../../core/widgets/form_section.dart';
import '../../../../manager/auth_cubit.dart';

class ForgetPasswordContainerBody extends StatelessWidget {
  const ForgetPasswordContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SendCodeStateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[800],
              content: Text(state.errMessage),
            ),
          );
        }

        if (state is SendCodeStateSuccess) {
          context.pushNamed(AppRouting.verifyEmailViewName);
        }
        // if (state is VerifyCodeStateSuccess) {
        //
        // }
      },
      builder: (context, state) {
        return Form(
          key: authCubit.forgetFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.forgetPassword,
                style: AppStyles.bold28poppins,
                textAlign: TextAlign.center,
              ),
               SizedBox(height: 16.h),
              Text(
                AppStrings.forgetPasswordInstructions,
                style: AppStyles.regular16poppins,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              FormSection(
                validator: (val) => authCubit.emailValidator(email: val),
                hintText: AppStrings.enterYourEmail,
                fieldTitle: AppStrings.emailAddress,
                stroke: false,
                controller: authCubit.forgetEmailController,
              ),
              SizedBox(height: 36.h),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  text: AppStrings.confirmEmail,
                  onPressed: () {
                    authCubit.formValidationAndInvokeMethod(
                      key: authCubit.forgetFormKey,
                      authMethod: authCubit.sendCode(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}