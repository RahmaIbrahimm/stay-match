import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/features/auth/verify_email/presentation/views/widgets/verify_email_otp.dart';

class VerifyEmailContainerBody extends StatelessWidget {
  const VerifyEmailContainerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          'person@gmail.com',
          style: AppStyles.cardTitle.copyWith(color: AppColors.secondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: VerifyEmailOTP(validator: (String? p1) {  },)
        ),
        CustomElevatedButton(text: AppStrings.confirmCode, onPressed: () {}),
        const SizedBox(height: 16),
        // todo: timer implementation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Text(
              '0:29',
              style: AppStyles.bodyText.copyWith(
                color: AppColors.textColorPrimary,
              ),
            ),
            Text(
              AppStrings.resendConfirmation,
              style: AppStyles.bodyText.copyWith(
                color: AppColors.textColorSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}