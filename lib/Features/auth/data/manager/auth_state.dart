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

class RegisterStateLoading extends AuthState {}
class RegisterStateSuccess extends AuthState {}
class RegisterStateFailure extends AuthState {
  final String errMessage;

  const RegisterStateFailure({required this.errMessage});
  List<Object> get props => [errMessage];
}