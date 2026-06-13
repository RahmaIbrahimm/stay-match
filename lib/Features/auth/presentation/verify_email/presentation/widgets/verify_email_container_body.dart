// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:stay_match/Features/auth/presentation/verify_email/presentation/widgets/verify_email_otp.dart';
// // import 'package:stay_match/core/constants/app_colors.dart';
// // import 'package:stay_match/core/constants/app_strings.dart';
// // import 'package:stay_match/core/constants/app_styles.dart';
// // import 'package:stay_match/core/routing/app_routing.dart';
// // import 'package:stay_match/core/widgets/custom_elevated_button.dart';
// // import 'package:stay_match/core/widgets/custom_text_button.dart';
// // import 'package:timer_count_down/timer_count_down.dart';
// //
// // import '../../../../manager/auth_cubit.dart';
// //
// //
// // class VerifyEmailContainerBody extends StatefulWidget {
// //   const VerifyEmailContainerBody({super.key});
// //
// //   @override
// //   State<VerifyEmailContainerBody> createState() => _VerifyEmailContainerBodyState();
// // }
// //
// // class _VerifyEmailContainerBodyState extends State<VerifyEmailContainerBody> {
// //   int _timerKeyCounter = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     var authCubit = BlocProvider.of<AuthCubit>(context);
// //     return BlocConsumer<AuthCubit, AuthState>(
// //       listener: (context, state) {
// //         if (state is VerifyCodeStateFailure) {
// //           ScaffoldMessenger.of(context).clearSnackBars();
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(
// //               backgroundColor: Colors.red[800],
// //               content: Text(state.errMessage),
// //             ),
// //           );
// //         }
// //         if (state is VerifyCodeStateSuccess) {
// //           authCubit.otpController.clear();
// //           ScaffoldMessenger.of(context).clearSnackBars();
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(
// //               backgroundColor: Colors.green,
// //               content: Text(state.response.message ?? 'SUCCESS'),
// //             ),
// //           );
// //           // context.go(AppRouting.resetPasswordView);
// //           context.go(AppRouting.loginView);
// //
// //         }
// //       },
// //       builder: (context, state) {
// //         return Form(
// //           key: authCubit.verifyCodeFormKey,
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //
// //             children: [
// //               Text(
// //                 AppStrings.verifyEmailAddress,
// //                 style: AppStyles.bold28poppins,
// //                 textAlign: TextAlign.center,
// //               ),
// //               SizedBox(height: 16.h),
// //               Text(
// //                 AppStrings.verificationCodeSentTo,
// //                 style: AppStyles.medium20poppins.copyWith(
// //                   color: AppColors.textColorSecondary,
// //                 ),
// //               ),
// //               Text(
// //                 authCubit.forgetEmailController.text,
// //                 style: AppStyles.medium20poppins.copyWith(
// //                   color: AppColors.secondary,
// //                 ),
// //                 maxLines: 1,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //               Padding(
// //                 padding:  EdgeInsets.all(20.r),
// //                 child: VerifyEmailOTP(
// //                   validator: (String? p1) {
// //                     if (p1 == null || p1.isEmpty) {
// //                       return 'Code is required';
// //                     }
// //                     return null;
// //                   },
// //                   controller: authCubit.otpController,
// //                 ),
// //               ),
// //               CustomElevatedButton(
// //                 text: AppStrings.confirmCode,
// //                 onPressed: () async{
// //                   if (authCubit.verifyCodeFormKey.currentState!.validate()) {
// //                     await authCubit.verifyOTP();
// //                   }
// //                 },
// //               ),
// //                SizedBox(height: 16.h),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 spacing: 5,
// //                 children: [
// //                   Countdown(
// //                     key: ValueKey(_timerKeyCounter),
// //                     seconds: 120,
// //                     build: (context, time) {
// //                       return Text(
// //                         _formatTime(time),
// //                         style: AppStyles.regular16poppins.copyWith(
// //                           color: AppColors.textColorPrimary,
// //                         ),
// //                       );
// //
// //                     },
// //                     interval: const Duration(seconds: 1),
// //                   ),
// //                   CustomTextButton(
// //                     onPressed: () async{
// //                       if (state is SendCodeStateSuccess) {
// //                         await authCubit.sendCode();
// //                         setState(() {
// //                           _timerKeyCounter++;
// //                         });
// //                       }
// //                     },
// //                     text: AppStrings.resendConfirmation,
// //                     textColor: AppColors.textColorSecondary,
// //                     textStyle: AppStyles.regular16poppins,
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   String _formatTime(double time) {
// //     int totalSeconds = time.toInt();
// //     int minutes = totalSeconds ~/ 60;
// //     int seconds = totalSeconds % 60;
// //     return '$minutes:${seconds.toString().padLeft(2, '0')}';
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:stay_match/Features/auth/presentation/verify_email/presentation/widgets/verify_email_otp.dart';
// import 'package:stay_match/core/constants/app_colors.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
// import 'package:stay_match/core/constants/app_styles.dart';
// import 'package:stay_match/core/routing/app_routing.dart';
// import 'package:stay_match/core/widgets/custom_elevated_button.dart';
// import 'package:stay_match/core/widgets/custom_text_button.dart';
// import 'package:timer_count_down/timer_count_down.dart';
//
// import '../../../../manager/auth_cubit.dart';
//
// class VerifyEmailContainerBody extends StatefulWidget {
//   const VerifyEmailContainerBody({super.key});
//
//   @override
//   State<VerifyEmailContainerBody> createState() => _VerifyEmailContainerBodyState();
// }
//
// class _VerifyEmailContainerBodyState extends State<VerifyEmailContainerBody> {
//   int _timerKeyCounter = 0;
//   bool _showTimer = true;
//
//   @override
//   Widget build(BuildContext context) {
//     var authCubit = BlocProvider.of<AuthCubit>(context);
//     return BlocConsumer<AuthCubit, AuthState>(
//       listener: (context, state) {
//         if (state is VerifyCodeStateFailure) {
//           ScaffoldMessenger.of(context).clearSnackBars();
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.red[800],
//               content: Text(state.errMessage),
//             ),
//           );
//         }
//         if (state is VerifyCodeStateSuccess) {
//           // 1. Kill focus immediately to stop cursor blinking/text animations
//           FocusScope.of(context).unfocus();
//
//           authCubit.otpController.clear();
//           ScaffoldMessenger.of(context).clearSnackBars();
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.green,
//               content: Text(state.response.message ?? 'SUCCESS'),
//             ),
//           );
//
//           // 2. Clear timer layout instance
//           setState(() {
//             _showTimer = false;
//           });
//
//           // 3. Let the framework process the unfocus and state change before navigating
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (context.mounted) {
//               context.go(AppRouting.loginView);
//             }
//           });
//         }
//       },
//       builder: (context, state) {
//         return Form(
//           key: authCubit.verifyCodeFormKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 AppStrings.verifyEmailAddress,
//                 style: AppStyles.bold28poppins,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 16.h),
//               Text(
//                 AppStrings.verificationCodeSentTo,
//                 style: AppStyles.medium20poppins.copyWith(
//                   color: AppColors.textColorSecondary,
//                 ),
//               ),
//               Text(
//                 authCubit.forgetEmailController.text,
//                 style: AppStyles.medium20poppins.copyWith(
//                   color: AppColors.secondary,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20.r),
//                 child: VerifyEmailOTP(
//                   validator: (String? p1) {
//                     if (p1 == null || p1.isEmpty) {
//                       return 'Code is required';
//                     }
//                     return null;
//                   },
//                   controller: authCubit.otpController,
//                 ),
//               ),
//               CustomElevatedButton(
//                 text: AppStrings.confirmCode,
//                 onPressed: () async {
//                   if (authCubit.verifyCodeFormKey.currentState!.validate()) {
//                     await authCubit.verifyOTP();
//                   }
//                 },
//               ),
//               SizedBox(height: 16.h),
//               if (_showTimer)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   spacing: 5,
//                   children: [
//                     Countdown(
//                       key: ValueKey(_timerKeyCounter),
//                       seconds: 120,
//                       build: (context, time) {
//                         return Text(
//                           _formatTime(time),
//                           style: AppStyles.regular16poppins.copyWith(
//                             color: AppColors.textColorPrimary,
//                           ),
//                         );
//                       },
//                       interval: const Duration(seconds: 1),
//                     ),
//                     CustomTextButton(
//                       onPressed: () async {
//                         await authCubit.sendCode();
//                         if (mounted) {
//                           setState(() {
//                             _timerKeyCounter++;
//                           });
//                         }
//                       },
//                       text: AppStrings.resendConfirmation,
//                       textColor: AppColors.textColorSecondary,
//                       textStyle: AppStyles.regular16poppins,
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   String _formatTime(double time) {
//     int totalSeconds = time.toInt();
//     int minutes = totalSeconds ~/ 60;
//     int seconds = totalSeconds % 60;
//     return '$minutes:${seconds.toString().padLeft(2, '0')}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stay_match/Features/auth/presentation/verify_email/presentation/widgets/verify_email_otp.dart';
import 'package:stay_match/core/constants/app_colors.dart';
import 'package:stay_match/core/constants/app_strings.dart';
import 'package:stay_match/core/constants/app_styles.dart';
import 'package:stay_match/core/routing/app_routing.dart';
import 'package:stay_match/core/widgets/custom_elevated_button.dart';
import 'package:stay_match/core/widgets/custom_text_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../manager/auth_cubit.dart';

class VerifyEmailContainerBody extends StatefulWidget {
  const VerifyEmailContainerBody({super.key});

  @override
  State<VerifyEmailContainerBody> createState() => _VerifyEmailContainerBodyState();
}

class _VerifyEmailContainerBodyState extends State<VerifyEmailContainerBody> {
  int _timerKeyCounter = 0;
  final GlobalKey<FormState> verifyCodeFormKey = GlobalKey<FormState>(
    debugLabel: 'verify code form key',
  );
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
          // 1. Remove focus from primary focus nodes to kill cursor/input animations globally
          FocusManager.instance.primaryFocus?.unfocus();

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.response.message ?? 'SUCCESS'),
            ),
          );

          // 2. Allow the active frame to finish rendering before routing
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              authCubit.otpController.clear();
              // Using pushReplacement allows widgets to dispose of themselves gracefully
              context.pushReplacement(AppRouting.loginView);
            }
          });
        }
      },
      builder: (context, state) {
        return Form(
          key: verifyCodeFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.verifyEmailAddress,
                style: AppStyles.bold28poppins,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.verificationCodeSentTo,
                style: AppStyles.medium20poppins.copyWith(
                  color: AppColors.textColorSecondary,
                ),
              ),
              Text(
                authCubit.forgetEmailController.text,
                style: AppStyles.medium20poppins.copyWith(
                  color: AppColors.secondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
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
                onPressed: () async {
                  if (verifyCodeFormKey.currentState!.validate()) {
                    await authCubit.verifyOTP();
                  }
                },
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Countdown(
                    key: ValueKey(_timerKeyCounter),
                    seconds: 120,
                    build: (context, time) {
                      return Text(
                        _formatTime(time),
                        style: AppStyles.regular16poppins.copyWith(
                          color: AppColors.textColorPrimary,
                        ),
                      );
                    },
                    interval: const Duration(seconds: 1),
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      await authCubit.sendCode(isResend: true);
                      if (mounted) {
                        setState(() {
                          _timerKeyCounter++;
                        });
                      }
                    },
                    text: AppStrings.resendConfirmation,
                    textColor: AppColors.textColorSecondary,
                    textStyle: AppStyles.regular16poppins,
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