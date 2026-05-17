part of 'profile_cubit.dart';

@immutable
sealed class ProfileState extends Equatable {}

final class ProfileInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

final class ProfileLoading extends ProfileState {@override List<Object?> get props => [];}
final class ProfileFailure extends ProfileState {
  final String errMessage;
  ProfileFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}
final class ProfileSuccess extends ProfileState {
  final ProfileResponse response;

  ProfileSuccess(
      {required this.response});

  @override
  List<Object?> get props =>
      [response];
}
final class ChangeProfilePictureFailure extends ProfileState{
  final String errMessage;
  ChangeProfilePictureFailure({required this.errMessage});
  @override
  List<Object?> get props => [errMessage];
}
final class ChangeProfilePictureSuccess extends ProfileState {
  UpdateProfilePictureResponse? updateProfilePictureResponse;
  UploadProfilePictureResponse? uploadProfilePictureResponse;

  ChangeProfilePictureSuccess(
      {this.updateProfilePictureResponse, this.uploadProfilePictureResponse});
  @override
  List<Object?> get props =>
      [ updateProfilePictureResponse, uploadProfilePictureResponse];
}