part of 'profile_cubit.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileSuccess extends ProfileState {
  ProfileResponse response;
  ProfileSuccess({required this.response});
  @override
  List<Object?> get props => [response];
}

final class ProfileFailure extends ProfileState {
  String errMessage;
  ProfileFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}