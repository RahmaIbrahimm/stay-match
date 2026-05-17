import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stay_match/Features/profile/data/models/profile_response.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_picture_response.dart';
import 'package:stay_match/Features/profile/data/models/update_profile_request.dart';
import 'package:stay_match/Features/profile/data/repos/profile_repo.dart';
import 'package:stay_match/core/utils/cache_service.dart';
import 'package:stay_match/core/utils/service_locator.dart';

import '../../data/models/upload_profile_picture_response.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  UpdateProfileRequest? _request;
  File? pickedImageFile;
  late bool hasProfilePic;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial()) {
    getProfileData();
  }

  bool get isDirty {
    if (state is! ProfileSuccess || _request == null) return false;
    final original = (state as ProfileSuccess).response.data;

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
      aboutMe: original?.aboutMe,
    );

    final dirty = _request != originalRequest || pickedImageFile != null;
    log('🔍 Checking isDirty: $dirty (Request changed: ${_request != originalRequest}, Image picked: ${pickedImageFile != null})');
    return dirty;
  }

  UpdateProfileRequest? get request => _request;

  Future<void> getProfileData() async {
    log('🔄 Fetching Profile Data...');
    emit(ProfileLoading());
    var response = await profileRepo.getProfile();

    response.fold(
          (fail) {
        log('❌ Profile Fetch Failed: ${fail.errMessage}');
        emit(ProfileFailure(errMessage: fail.errMessage));
      },
          (profileResponse) async {
        if (profileResponse.success == true) {
          log('✅ Profile Fetch Success: ${profileResponse.data?.fullName}');
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
            aboutMe: data?.aboutMe,
          );
          hasProfilePic = profileResponse.data?.profilePicture != null;
          emit(ProfileSuccess(response: profileResponse));
          final cacheHelper = getIt.get<CacheService>();
          await cacheHelper.setData(key: cacheHelper.userProfilePicKey, value:profileResponse.data?.profilePicture);
          await cacheHelper.setData(key: cacheHelper.userNameKey,value:  profileResponse.data?.fullName);
        } else {
          log('⚠️ Profile Fetch Error: ${profileResponse.message}');
          emit(ProfileFailure(errMessage: profileResponse.message ?? 'Error'));
        }
      },
    );
  }

  Future<void> pickProfileImage() async {
    log('📸 Opening Gallery...');
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImageFile = File(image.path);
      log('🖼️ Image Selected: ${image.path}');

      if (state is ProfileSuccess) {
        final currentResponse = (state as ProfileSuccess).response;
        emit(ProfileSuccess(response: currentResponse.copyWith()));
      }
    } else {
      log('🚫 Image Selection Cancelled');
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
      aboutMe: update.aboutMe ?? _request?.aboutMe,
      password: update.password ?? _request?.password,
      passwordConfirmation: update.passwordConfirmation ?? _request?.passwordConfirmation,
    );

    if (newRequest != _request) {
      log('📝 Request Field Updated');
      _request = newRequest;

      final currentState = state as ProfileSuccess;
      emit(ProfileSuccess(response: currentState.response.copyWith()));

      log('📝 Draft Updated: ${_request?.fullName}');
    }
  }

  Future<void> saveProfileChanges() async {
    if (_request == null || state is! ProfileSuccess) {
      log('🛑 Save cancelled: Request is null or state is not Success');
      return;
    }
    final original = (state as ProfileSuccess).response.data;

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
      aboutMe: original?.aboutMe,
    );
    log('💾 Saving Profile Changes...');
    emit(ProfileLoading());


    if (originalRequest != _request) {
      log('📤 Updating Text Info...');
      var result = await profileRepo.updateProfile(request: _request!);
      result.fold(
            (fail) {
          log('❌ Profile Update Failed: ${fail.errMessage}');
          emit(ProfileFailure(errMessage: fail.errMessage));
        },
            (success) async {
          log('✅ Profile Info Saved');
          await getProfileData();
        },
      );
    }

    if (pickedImageFile != null) {
      log('📤 Image changed, starting upload...');
      hasProfilePic ? await updateProfileImg() : await uploadProfileImg();
    }

    if (isDirty) {
      log('🔄 Re-syncing Profile Data...');
      await getProfileData();
    }
  }

  Future<void> uploadProfileImg() async {
    if (pickedImageFile == null) return;

    log('🚀 Uploading Profile Image...');
    emit(ProfileLoading());

    var result = await profileRepo.uploadProfileImg(imageFile: pickedImageFile!.path);
    result.fold(
          (fail) {
        log('❌ Image Upload Failed: ${fail.errMessage}');
        emit(ProfileFailure(errMessage: fail.errMessage));
      },
          (success) async {
        log('✅ Profile Image Upload Success');
        pickedImageFile = null; // Clear after success
        await getProfileData();
      },
    );
  }
  Future<void> updateProfileImg() async {
    if (pickedImageFile == null) return;

    log('🚀 Uploading Profile Image...');
    emit(ProfileLoading());

    var result = await profileRepo.updateProfileImg(imageFile: pickedImageFile!.path);
    result.fold(
          (fail) {
        log('❌ Image Upload Failed: ${fail.errMessage}');
        emit(ProfileFailure(errMessage: fail.errMessage));
      },
          (success) async {
        log('✅ Profile Image Upload Success');
        pickedImageFile = null; // Clear after success
        await getProfileData();
      },
    );
  }
}