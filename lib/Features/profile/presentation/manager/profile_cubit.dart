import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stay_match/Features/profile/data/models/compatibility_profile_response.dart';
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
  File? pickedIdImageFile;
  late bool hasProfilePic;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial()) {
    getProfileData();
  }

  bool get isDirty {
    if (state is! ProfileSuccess || _request == null) return false;
    final original = (state as ProfileSuccess).response?.data;

    final hasTextChanges =
        _request?.fullName != original?.fullName ||
            _request?.phoneNumber != original?.phoneNumber ||
            _request?.gender != original?.gender ||
            _request?.governorate != original?.governorate ||
            _request?.city != original?.city ||
            _request?.fieldOfStudy != original?.fieldOfStudy ||
            _request?.jobTitle != original?.jobTitle ||
            _request?.aboutMe != original?.aboutMe ||
            _request?.birthDate != original?.birthDate ||
            _request?.idImage != original?.idImage;

    final hasPasswordChange = _request?.password != null &&
        _request!.password!.isNotEmpty;

    final dirty = hasTextChanges || hasPasswordChange ||
        pickedImageFile != null || pickedIdImageFile != null;
    log(
        '🔍 isDirty: $dirty (text: $hasTextChanges, pass: $hasPasswordChange, img: ${pickedImageFile !=
            null})');
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
            birthDate: data?.birthDate,
            idImage: data?.idImage,
          );
          hasProfilePic = profileResponse.data?.profilePicture != null;
          emit(ProfileSuccess(response: profileResponse));
          final cacheHelper = getIt.get<CacheService>();
          await cacheHelper.setData(key: cacheHelper.userProfilePicKey, value:profileResponse.data?.profilePicture);
          await cacheHelper.setData(key: cacheHelper.userNameKey,value:  profileResponse.data?.fullName);
        }
        else {
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
        emit(ProfileSuccess(response: currentResponse?.copyWith()));
      }
    } else {
      log('🚫 Image Selection Cancelled');
    }
  }

  Future<void> pickIdImage() async {
    log('📸 Opening Gallery for National ID Image...');
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedIdImageFile = File(image.path);
      log('🖼️ ID Image Selected: ${image.path}');

      // Update request structure with local file path string directly
      updateRequest(UpdateProfileRequest(idImage: image.path));
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
      idImage: update.idImage ?? _request?.idImage,
    );

    if (newRequest != _request) {
      log('📝 Request Field Updated');
      _request = newRequest;

      final currentState = state as ProfileSuccess;
      emit(ProfileSuccess(response: currentState.response?.copyWith()));

      log('📝 Draft Updated: ${_request?.fullName}');
    }
  }
  Future<void> saveProfileChanges() async {
    print(_request);

    if (_request == null || state is! ProfileSuccess) return;
    final original = (state as ProfileSuccess).response?.data;

    final hasTextChanges =
        _request?.fullName != original?.fullName ||
            _request?.phoneNumber != original?.phoneNumber ||
            _request?.gender != original?.gender ||
            _request?.governorate != original?.governorate ||
            _request?.city != original?.city ||
            _request?.fieldOfStudy != original?.fieldOfStudy ||
            _request?.jobTitle != original?.jobTitle ||
            _request?.aboutMe != original?.aboutMe ||
            _request?.birthDate != original?.birthDate ||
            _request?.idImage != original?.idImage ||
            pickedIdImageFile != null;

    final hasPasswordChange = _request?.password != null &&
        _request!.password!.isNotEmpty;

    emit(ProfileLoading());

    if (hasTextChanges || hasPasswordChange) {
      log('📤 Updating Text Info...');
      log(_request!.toJson().toString());
      var result = await profileRepo.updateProfile(request: _request!);
      result.fold(
            (fail) {
          emit(ProfileFailure(errMessage: fail.errMessage));
          return;
        },
            (success) => log('✅ Profile Info Saved'),
      );
    }

    if (pickedImageFile != null) {
      hasProfilePic ? await updateProfileImg() : await uploadProfileImg();
    }

    await getProfileData();
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
  Future<void> getPreferences() async{
    var response = await profileRepo.compatibilityProfile();
    response.fold(
          (fail) {
        log('❌ Profile Fetch Failed: ${fail.errMessage}');
        emit(ProfileFailure(errMessage: fail.errMessage));
      },
          (profileResponse) async {
        if (profileResponse.error != null) {
          log('✅ Profile Fetch Success: ${profileResponse.answeredQuestions}');
          final data = profileResponse;
        }
  });
  }

  Future<void> deleteProfilePic() async {
    // Guard check against the cubit's tracking flag instead of the local file
    if (!hasProfilePic && pickedImageFile == null) {
      log('🛑 No picture exists to delete.');
      return;
    }

    log('🚀 Starting profile picture removal sequence...');
    emit(ProfileLoading());

    var res = await profileRepo.deleteProfilePic();

    res.fold(
          (fail) {
        log('❌ Repository delete request failed: ${fail.errMessage}');
        emit(ProfileFailure(errMessage: fail.errMessage));
      },
          (resp) async {
        if (resp.success == true) {
          log('✅ Server picture deleted successfully.');
          pickedImageFile = null;
          await getProfileData();
        } else {
          emit(ProfileFailure(errMessage: "Error Deleting Profile Picture"));
        }
      },
    );
  }
}