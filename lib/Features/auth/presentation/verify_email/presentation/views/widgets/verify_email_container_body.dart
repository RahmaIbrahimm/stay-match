import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';
import 'package:stay_match/features/auth/presentation/verify_email/presentation/views/widgets/verify_email_otp.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../manager/auth_cubit.dart';

class VerifyEmailContainerBody extends StatelessWidget {
  const VerifyEmailContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyCodeStateFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[800],
              content: Text(state.errMessage),
            ),
          );
        }
        if (state is VerifyCodeStateSuccess) {
          authCubit.otpController.clear();
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.response.message ?? 'SUCCESS'),
            ),
          );
          context.go(AppRouting.resetPasswordView);
        }
      },
      builder: (context, state) {
        return Form(
          key: authCubit.verifyCodeFormKey,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            clipBehavior: Clip.antiAlias,
            children: [
              Text(
                AppStrings.verifyEmailAddress,
                style: AppStyles.headLine,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.verificationCodeSentTo,
                style: AppStyles.cardTitle.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
              // TODO: implement logic Email sent to
              Text(
                authCubit.forgetEmailController.text,
                style: AppStyles.cardTitle.copyWith(color: AppColors.secondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: VerifyEmailOTP(
                  validator: (String? p1) {
                    if (p1 == null || p1.isEmpty) {
                      return 'Code is required';
                    }
                    return null;
                  },
                  controller: authCubit.otpController,
                ),
              ),
              CustomElevatedButton(
                text: AppStrings.confirmCode,
                onPressed: () {
                  if (authCubit.verifyCodeFormKey.currentState!.validate()) {
                    authCubit.verifyOTP();
                    context.pop();
                  }
                },
              ),
              const SizedBox(height: 16),
              // todo: timer implementation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Countdown(
                    seconds: 120,
                    build: (context, time) {
                      return Text(
                        _formatTime(time),
                        style: AppStyles.bodyText.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
                      );
                    },
                    interval: const Duration(seconds: 1),
                  ),
                  CustomTextButton(
                    onPressed: () {
                      if (state is SendCodeStateSuccess ) {
                        authCubit.sendCode();
                      }
                    },
                    text: AppStrings.resendConfirmation,
                    textColor: AppColors.textColorSecondary,
                    textStyle: AppStyles.bodyText,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(double time) {
    int totalSeconds = time.toInt();
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}