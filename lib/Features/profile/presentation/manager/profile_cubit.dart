import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stay_match/Features/profile/data/models/profile_response.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_request.dart';
import 'package:stay_match/Features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  UpdateProfileRequest? _request;
  File? pickedImageFile; // Keep this as a simple variable

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial()) {
    getProfileData();
  }
  bool get isDirty {
    if (state is! ProfileSuccess || _request == null) return false;
    final original = (state as ProfileSuccess).response.data;

    // 1. Create a request object representing the 'original' state to compare
    final originalRequest = UpdateProfileRequest(
      firstName: original?.firstName,
      lastName: original?.lastName,
      fullName: original?.fullName,
      phoneNumber: original?.phoneNumber,
      gender: original?.gender,
      governorate: original?.governorate,
      city: original?.city,
      university: original?.university,
      fieldOfStudy: original?.fieldOfStudy,
      jobTitle: original?.jobTitle,
    );

    // 2. Compare the whole objects + check if an image was picked
    return _request != originalRequest || pickedImageFile != null;
  }  UpdateProfileRequest? get request => _request;


  Future<void> getProfileData() async {
    emit(ProfileLoading());
    var response = await profileRepo.getProfile();

    response.fold(
          (fail) => emit(ProfileFailure(errMessage: fail.errMessage)),
          (profileResponse) {
        if (profileResponse.success == true) {
          final data = profileResponse.data;

          _request = UpdateProfileRequest(
            firstName: data?.firstName,
            lastName: data?.lastName,
            fullName: data?.fullName,
            email: data?.email,
            phoneNumber: data?.phoneNumber,
            gender: data?.gender,
            city: data?.city,
            governorate: data?.governorate,
            university: data?.university,
            fieldOfStudy: data?.fieldOfStudy,
            jobTitle: data?.jobTitle,
          );

          emit(ProfileSuccess(response: profileResponse));
        } else {
          emit(ProfileFailure(errMessage: profileResponse.message ?? 'Error'));
        }
      },
    );
  }
  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImageFile = File(image.path);

      if (state is ProfileSuccess) {
        final currentResponse = (state as ProfileSuccess).response;
        emit(ProfileSuccess(response: currentResponse.copyWith()));
      }
    }
  }
  void updateRequest(UpdateProfileRequest update) {
    if (_request == null || state is! ProfileSuccess) return;

    final newRequest = _request!.copyWith(
      firstName: update.firstName ?? _request?.firstName,
      lastName: update.lastName ?? _request?.lastName,
      fullName: update.fullName ?? _request?.fullName,
      email: update.email ?? _request?.email,
      phoneNumber: update.phoneNumber ?? _request?.phoneNumber,
      gender: update.gender ?? _request?.gender,
      birthDate: update.birthDate ?? _request?.birthDate,
      city: update.city ?? _request?.city,
      governorate: update.governorate ?? _request?.governorate,
      university: update.university ?? _request?.university,
      fieldOfStudy: update.fieldOfStudy ?? _request?.fieldOfStudy,
      jobTitle: update.jobTitle ?? _request?.jobTitle,
      password: update.password ?? _request?.password,
      passwordConfirmation: update.passwordConfirmation ?? _request?.passwordConfirmation,
    );

    if (newRequest != _request) {
      _request = newRequest;

      // 🔥 CRITICAL: You must emit so the 'isDirty' getter
      // triggers a rebuild for the Save Button!
      final currentState = state as ProfileSuccess;
      emit(ProfileSuccess(response: currentState.response.copyWith()));

      log('📝 Draft Updated: ${_request?.fullName}');
    }
  }  Future<void> saveProfileChanges() async {
    if (_request == null || state is! ProfileSuccess) return;

    final oldResponse = (state as ProfileSuccess).response;
    emit(ProfileLoading());

    var result = await profileRepo.updateProfile(request: _request!);

    result.fold(
          (fail) => emit(ProfileFailure(errMessage: fail.errMessage)),
          (updateResponse) {
        final updatedData = oldResponse.data?.copyWith(
          firstName: _request?.firstName,
          lastName: _request?.lastName,
          fullName: _request?.fullName,
          phoneNumber: _request?.phoneNumber,
          gender: _request?.gender,
          birthDate: _request?.birthDate,
          city: _request?.city,
          governorate: _request?.governorate,
          university: _request?.university,
          fieldOfStudy: _request?.fieldOfStudy,
          jobTitle: _request?.jobTitle,
        );

        emit(ProfileSuccess(
          response: oldResponse.copyWith(data: updatedData),
        ));

        log('✅ Profile saved and UI refreshed locally');
      },
    );
  }
}