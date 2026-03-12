import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stay_match/core/utils/secure_storage_helper.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';
import 'package:stay_match/features/auth/data/models/login_with_google_response.dart';
import 'package:stay_match/features/auth/data/models/register_response.dart';
import 'package:stay_match/features/auth/data/models/verify_code_response.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/networking/endpoints.dart';
import '../data/models/reset_password_response.dart';
import '../data/repos/auth_repo.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthStateInitial());

  // ---- other ----
  String? _resetUserId;

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

  // ============ signup page ===============
  GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  // email
  final TextEditingController signEmailController = TextEditingController();

  // password
  final TextEditingController signFirstNameController = TextEditingController();
  final TextEditingController signLastNameController = TextEditingController();
  final TextEditingController signPasswordController = TextEditingController();

  // confirm password
  final TextEditingController signConfirmPasswordController =
      TextEditingController();

  // city
  final TextEditingController cityController = TextEditingController();
  final TextEditingController signSearchCityController =
      TextEditingController();

  final TextEditingController birthDateController = TextEditingController(
    text: AppStrings.dateFormat
  );

  // gender
  final TextEditingController genderController = TextEditingController();

  // birth date ==========================
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

  //=========== reset password ===========
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>(
    debugLabel: 'login form key',
  );

  // password
  final TextEditingController resetPasswordController = TextEditingController();

  // confirm password
  final TextEditingController resetConfirmPasswordController =
      TextEditingController();

  //-------- METHODS ---------
  Future<void> formValidationAndInvokeMethod({
    required GlobalKey<FormState> key,
    required Future<void> authMethod,
    bool hasConfirmPassword = false,
    String? pass ,
    String? confirmPass
  }) async {
    final formState = key.currentState;
    if (formState is FormState && formState.validate() == true && hasConfirmPassword? pass == confirmPass : true ) {
      await authMethod;
    }
  }

  String? passwordMatchValidator({
    required String? password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
  String? nullFieldValidator({String? text}) {
    if (text?.trim() == null || text!.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }
  String? emailValidator({String? email}) {
    email = email?.trim();
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }

    if (!email.contains('.') || email.startsWith('.') || email.endsWith('.')) {
      return 'Please enter a valid email address';
    }

    if (email.split('@').length != 2) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  String? passwordValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

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
      (response) async {
        if (response.isSuccess == true) {
          await SecureStorageHelper.storage.write(key: SecureStorageHelper.tokenKey, value: response.data?.token);
          await SecureStorageHelper.loadToken();
          emit(LoginStateSuccess(response));
        } else {
          emit(LoginStateFailure(errMessage: "Invalid Email or Password"));
        }
      },
    );
  }




  // ----- google login ------
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final scopes = <String>["https://www.googleapis.com/auth/userinfo.email"];

  Future<void> googleLogin() async {
    emit(GoogleLoginStateLoading());

    try {
      await _googleSignIn.initialize(serverClientId: Endpoints.webClientId);
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(GoogleLoginStateFailure(errMessage: "Failed to get ID token"));
        return;
      }
      var response = await authRepo.loginWithGoogle(idToken: idToken);

      response.fold(
        (failure) {
          emit(GoogleLoginStateFailure(errMessage: failure.errMessage));
        },
        (resp) {
          if (resp.isSuccess == true) {
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
  // -------- signup ----------
  Future<void> signup() async {
    var response = await authRepo.signup(
      firstName: signFirstNameController.text,
      lastName: signLastNameController.text,
      email: signEmailController.text,
      password: signPasswordController.text,
      confirmPassword: signConfirmPasswordController.text,
      genderType: genderController.text,
      birthDate: birthDateController.text,
      city: cityController.text,
    );
    response.fold(
      (failure) {
        emit(RegisterStateFailure(errMessage: failure.errMessage));
      },
      (response) {
        if (response.isSuccess == true) {
          emit(RegisterStateSuccess(response: response));
        } else {
          emit(
            RegisterStateFailure(
              errMessage: response.message ?? "Registration failed",
            ),
          );
        }
      },
    );
  }

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
}