part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {}

class LoginStateLoading extends AuthState {}

class LoginStateSuccess extends AuthState {
  final LoginResponse user;

  const LoginStateSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateFailure extends AuthState {
  final String errMessage;

  const LoginStateFailure({required this.errMessage});
}

class GoogleLoginStateLoading extends AuthState {}

class GoogleLoginStateSuccess extends AuthState {
  final LoginWithGoogleResponse? resp;

  const GoogleLoginStateSuccess({required this.resp});

  @override
  List<Object> get props => [?resp];
}

class GoogleLoginStateFailure extends AuthState {
  final String errMessage;

  const GoogleLoginStateFailure({required this.errMessage});
}

class RegisterStateLoading extends AuthState {}

class RegisterStateSuccess extends AuthState {
  final RegisterResponse response;
  RegisterStateSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

class RegisterStateFailure extends AuthState {
  final String errMessage;

  const RegisterStateFailure({required this.errMessage});

  List<Object> get props => [errMessage];
}

class SendCodeStateLoading extends AuthState {}

class SendCodeStateSuccess extends AuthState {
  final ForgetPasswordResponse response;
  final String email;

  const SendCodeStateSuccess({required this.response, required this.email});

  @override
  List<Object> get props => [response];
}

class SendCodeStateFailure extends AuthState {
  final String errMessage;

  const SendCodeStateFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class VerifyCodeStateLoading extends AuthState {}

class VerifyCodeStateSuccess extends AuthState {
  final VerifyCodeResponse response;

  const VerifyCodeStateSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class VerifyCodeStateFailure extends AuthState {
  final String errMessage;

  const VerifyCodeStateFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class ResetPassStateLoading extends AuthState {}

class ResetPassStateSuccess extends AuthState {
  final ResetPasswordResponse response;

  const ResetPassStateSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class ResetPassStateFailure extends AuthState {
  final String errMessage;

  const ResetPassStateFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class LogoutStateLoading extends AuthState {}
class LogoutStateSuccess extends AuthState {
  final LogoutResponse response;
  LogoutStateSuccess({required this.response});
  @override
  List<Object> get props => [response];
}
class LogoutStateFailure extends AuthState {
  final String errMessage;
  const LogoutStateFailure({required this.errMessage});
  @override
  List<Object> get props => [errMessage];

}