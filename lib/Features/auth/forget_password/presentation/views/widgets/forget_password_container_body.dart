import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/features/auth/data/manager/auth_cubit.dart';
import 'package:stay_match/features/auth/login/presentation/views/widgets/form_section.dart';

class ForgetPasswordContainerBody extends StatelessWidget {
  ForgetPasswordContainerBody({super.key});



  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    return Form(
      key: authCubit.forgetFormKey,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            AppStrings.forgetPassword,
            style: AppStyles.headLine,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.forgetPasswordInstructions,
            style: AppStyles.bodyText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // todo implement validation
          FormSection(
            validator: (val) {},
            hintText: AppStrings.enterYourEmail,
            fieldTitle: AppStrings.emailAddress,
            stroke: false,
            controller: authCubit.forgetEmailController ,
          ),
          const SizedBox(height: 36),
          // todo implement on pressed logic
          CustomElevatedButton(text: AppStrings.confirmEmail, onPressed: () {
            authCubit.emailForForgetPassValidation();
            context.push(AppRouting.verifyEmailView);
          }),
        ],
      ),
    );
  }
}