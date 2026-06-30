part of 'other_user_profile_cubit.dart';

abstract class OtherUserProfileState extends Equatable {
  const OtherUserProfileState();

  @override
  List<Object?> get props => [];
}

class OtherUserProfileInitial extends OtherUserProfileState {}

class OtherUserProfileLoading extends OtherUserProfileState {}

class OtherUserProfileSuccess extends OtherUserProfileState {
  final OtherUserProfileResponse? profile;
  final UserListingsResponse? listings;

  const OtherUserProfileSuccess({this.profile, this.listings});

  @override
  List<Object?> get props => [profile];
}

class OtherUserProfileFailure extends OtherUserProfileState {
  final String errMessage;

  const OtherUserProfileFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}