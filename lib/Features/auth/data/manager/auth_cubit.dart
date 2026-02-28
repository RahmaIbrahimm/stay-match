import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:stay_match/features/auth/data/models/forget_password_response.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';

import '../repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>(debugLabel: 'login form key' );

  //=========== login page ===========
  // email
  final TextEditingController loginEmailController = TextEditingController(
    text: 'Rahmaibrahim315@gmail.com',
  );

  // password
  final TextEditingController loginPasswordController = TextEditingController(
    text: 'Meow@123',
  );

  //=========== forget password page ===========
  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>(debugLabel: 'forget form key' );
  final TextEditingController forgetEmailController = TextEditingController(
    text: 'Rahmaibrahim315@gmail.com',
  );

  //--------methods---------
  AuthCubit(this.authRepo) : super(AuthStateInitial());

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
          emit(
            LoginStateFailure(
              errMessage: response.message ?? "Invalid Email or Password",
            ),
          );
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

  void loginAccountValidation() {
    final formState = loginKey.currentState;
    if (formState is FormState && formState.validate() == true) {
      login();
    }
  }
  // -------- forget password ----------
  Future<void> sendCode() async{
    emit(SendCodeStateLoading());
    var response = await authRepo.sendVerificationCode(email: forgetEmailController.text);
    response.fold((fail){
      emit(SendCodeStateFailure(errMessage: fail.errMessage));
    }, (resp){
      if(resp.isSuccess == true){
        SendCodeStateSuccess(resp);
      }
      else{
        SendCodeStateFailure( errMessage: resp.message ?? 'Failed sending code');
      }
    });
  }
  void emailForForgetPassValidation() {
    final formState = forgetFormKey.currentState;
    if (formState is FormState && formState.validate() == true) {
      sendCode();
    }
  }
// -------- confirm password ----------
}