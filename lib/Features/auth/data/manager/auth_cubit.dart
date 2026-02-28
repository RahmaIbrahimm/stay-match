import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:stay_match/features/auth/data/models/login_response.dart';

import '../repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepo authRepo;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  // email
  final TextEditingController emailController = TextEditingController();

  // password
  final TextEditingController passwordController = TextEditingController();

  AuthCubit(this.authRepo) : super(AuthStateInitial());

  Future<void> login() async {
    emit(LoginStateLoading());
    var user = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );
    user.fold(
            (exception) {
          emit(LoginStateFailure(errMessage: exception.errMessage));
        },
            (response) {
          if (response.isSuccess == true) {
            emit(LoginStateSuccess(response));
          } else {
            emit(LoginStateFailure(
                errMessage: response.message ?? "Invalid Email or Password"
            ));
          }
        }
    );
  }  String? Function(String?) loginEmailValidator() {
    return (email) => authRepo.loginEmailValidator(email: email);
  }
  String? Function(String?) loginPasswordValidator() {
    return (password) => authRepo.loginPasswordValidator(password: password);
  }
}