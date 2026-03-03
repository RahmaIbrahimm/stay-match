import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stay_match/core/networking/endpoints.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';
import 'package:stay_match/features/auth/data/models/login_with_google_response.dart';
import 'package:stay_match/features/auth/data/models/verify_code_response.dart';

import '../models/reset_password_response.dart';
import '../repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthStateInitial());

  // ---- other ----
  String? _resetUserId;

  // String? idToken;
  //=========== login page ===========

  GlobalKey<FormState> loginKey = GlobalKey<FormState>(
    debugLabel: 'login form key',
  );

  // email
  final TextEditingController loginEmailController = TextEditingController(
    text: 'Rahmaibrahim315@gmail.com',
  );

  // password
  final TextEditingController loginPasswordController = TextEditingController(
    text: 'Kitty@123',
  );

  //=========== forget password page ===========
  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>(
    debugLabel: 'forget form key',
  );
  final TextEditingController forgetEmailController = TextEditingController(
    text: 'Rahmaibrahim315@gmail.com',
  );

  //=========== verify email code ===========
  final GlobalKey<FormState> verifyCodeFormKey = GlobalKey<FormState>(
    debugLabel: 'verify code form key',
  );
  final TextEditingController otpController = TextEditingController();

  //=========== verify email code ===========
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>(
    debugLabel: 'login form key',
  );

  // password
  final TextEditingController resetPasswordController = TextEditingController();

  // confirm password
  final TextEditingController resetConfirmPasswordController =
      TextEditingController();

  //--------methods---------

  // -------- login ----------
  Future<void> login() async {
    emit(LoginStateLoading());
    var user = await authRepo.login(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    );
    user.fold(
      (exception) {
        emit(LoginStateFailure(errMessage: exception.errMessage));
      },
      (response) {
        if (response.isSuccess == true) {
          emit(LoginStateSuccess(response));
        } else {
          emit(LoginStateFailure(errMessage: "Invalid Email or Password"));
        }
      },
    );
  }

  String? Function(String?) emailValidator() {
    return (email) => authRepo.emailValidator(email: email);
  }

  String? Function(String?) passwordValidator() {
    return (password) => authRepo.passwordValidator(password: password);
  }

  void loginAccountValidation() async {
    final formState = loginKey.currentState;
    if (formState is FormState && formState.validate() == true) {
      await login();
    }
  }

  // ----- google login ------

  // -------- forget password ----------
  Future<void> sendCode() async {
    emit(SendCodeStateLoading());
    var response = await authRepo.sendVerificationCode(
      email: forgetEmailController.text,
    );
    response.fold(
      (fail) {
        emit(SendCodeStateFailure(errMessage: fail.errMessage));
      },
      (resp) {
        if (resp.isSuccess == true) {
          emit(
            SendCodeStateSuccess(
              response: resp,
              email: forgetEmailController.text,
            ),
          );
        } else {
          emit(SendCodeStateFailure(errMessage: 'Invalid Email Address'));
        }
      },
    );
  }

  void emailForForgetPassValidation() async {
    final formState = forgetFormKey.currentState;
    if (formState is FormState && formState.validate() == true) {
      await sendCode();
    }
  }

  // -------- confirm password ----------
  Future<void> verifyOTP() async {
    emit(VerifyCodeStateLoading());
    var response = await authRepo.verifyOTP(
      code: otpController.text,
      email: forgetEmailController.text,
    );
    response.fold(
      (fail) {
        emit(VerifyCodeStateFailure(errMessage: fail.errMessage));
      },
      (resp) {
        if (resp.isSuccess == true) {
          emit(VerifyCodeStateSuccess(response: resp));
          _resetUserId = resp.data?.userId;
        } else {
          emit(VerifyCodeStateFailure(errMessage: "Incorrect Code"));
        }
      },
    );
  }

  // ---------- reset password ---------
  void resetPassValidation() async {
    final formState = resetPasswordFormKey.currentState;
    if (formState is FormState && formState.validate() == true) {
      await resetPassword();
    }
  }

  Future<void> resetPassword() async {
    var response = await authRepo.resetPassword(
      password: resetPasswordController.text,
      confirmPassword: resetConfirmPasswordController.text,
      userId: _resetUserId!,
    );
    response.fold(
      (fail) {
        emit(ResetPassStateFailure(errMessage: fail.errMessage));
      },
      (resp) {
        if (resp.isSuccess == true) {
          emit(ResetPassStateSuccess(response: resp));
        } else {
          emit(ResetPassStateFailure(errMessage: resp.message.toString()));
        }
      },
    );
  }

  // ---- overriden ---
  @override
  Future<void> close() {
    // TODO: implement close
    loginEmailController.dispose();
    loginPasswordController.dispose();
    otpController.dispose();
    forgetEmailController.dispose();
    return super.close();
  }

  // google sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final scopes = <String>["https://www.googleapis.com/auth/userinfo.email"];

  Future<void> googleLogin() async {
    emit(GoogleLoginStateLoading());

    try {
      await _googleSignIn.initialize(
        serverClientId:
            '936135595361-tkjd357n4h18pd6pc4pfoch6rto0vlh5.apps.googleusercontent.com',
      );
      print('success web 2');

      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        emit(GoogleLoginStateFailure(errMessage: "Google sign-in cancelled"));
        return;
      }
// ======= ======= =======
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // final gAuth = await googleUser.authorizationClient.authorizationForScopes(
      //   scopes,
      // );

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(GoogleLoginStateFailure(errMessage: "Failed to get ID token"));
        return;
      }
      print('id token : $idToken');
      var response = await authRepo.loginWithGoogle(idToken: idToken);

      response.fold(
        (failure) {
          print(failure.errMessage);
          emit(GoogleLoginStateFailure(errMessage: failure.errMessage));
        },
        (resp) {
          if (resp.isSuccess == true) {
            print('Token:$idToken');
            emit(GoogleLoginStateSuccess(resp: resp));
          } else {
            emit(
              GoogleLoginStateFailure(
                errMessage: resp.message ?? "Login failed",
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(GoogleLoginStateFailure(errMessage: "Google Sign-In failed: $e"));
    }
  }
}