import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stay_match/Features/other_user_profile/data/models/other_user_profile_response.dart';
import 'package:stay_match/Features/other_user_profile/data/models/user_listings_response.dart';
import 'package:stay_match/Features/other_user_profile/data/repos/other_user_profile_repo.dart';

part 'other_user_profile_state.dart';

class OtherUserProfileCubit extends Cubit<OtherUserProfileState> {
  final OtherUserProfileRepo otherUserProfileRepo;

  /// Stored so the UI can retry without re-passing the userId.
  late String _userId;

  OtherUserProfileCubit({required this.otherUserProfileRepo})
      : super(OtherUserProfileInitial());

  Future<void> getOtherUserProfile({required String userId}) async {
    _userId = userId;
    emit(OtherUserProfileLoading());

    final result =
    await otherUserProfileRepo.getOtherUserProfile(userId: userId);

    result.fold(
          (failure) =>
          emit(OtherUserProfileFailure(errMessage: failure.errMessage)),
          (response) {
        if (response.success == true) {
          emit(OtherUserProfileSuccess(profile: response));
        } else {
          emit(OtherUserProfileFailure(
              errMessage: response.message ?? 'Failed to load profile'));
        }
      },
    );
  }
  Future<void> getOtherUserListings({required String userId}) async {
    _userId = userId;
    emit(OtherUserProfileLoading());

    final result =
    await otherUserProfileRepo.getUserListings(userId: userId);

    result.fold(
          (failure) =>
          emit(OtherUserProfileFailure(errMessage: failure.errMessage)),
          (response) {
        if (response.success == true) {
          emit(OtherUserProfileSuccess(listings: response));
        } else {
          emit(OtherUserProfileFailure(
              errMessage: response.message ?? 'Failed to load profile'));
        }
      },
    );
  }

  void retry() => getOtherUserProfile(userId: _userId);
}