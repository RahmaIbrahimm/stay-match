import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stay_match/Features/add_property/data/models/add_apartment_request.dart';
import 'package:stay_match/Features/add_property/data/repos/add_property_repo.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../filter/presentation/widgets/filter_helper.dart';

part 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  final AddPropertyRepo addPropertyRepo;

  late AddApartmentRequest _request;
  int _currentStep = 0;
  PropertyType _selectedType = PropertyType.none;
  List<File> localImages = [];

  AddPropertyCubit({required this.addPropertyRepo})
      : super(AddPropertyInitial()) {
    _initializeRequest();
    log('🏢 AddPropertyCubit: Initialized');
  }

  void _initializeRequest() {
    _request = AddApartmentRequest(
      name: "",
      description: "",
      monthlyRent: 0,
      deposite: 0,
      furnished: true,
      availableFrom: DateTime.now().toIso8601String(),
      numberOfBedrooms: 0,
      numberOfLivingRooms: 0,
      numberOfEnSuiteBathrooms: 0,
      numberOfGuestBathrooms: 0,
      street: "",
      city: "",
      government: "Cairo",
      latitude: 0,
      longitude: 0,
      size: 0,
      minimumStay: 1,
      isDraft: false,
      propertyImages: [],
      amenities: AddApartmentAmenities(
        wifi: false,
        tv: false,
        cooktop: false,
        oven: false,
        kettle: false,
        dishwasher: false,
        refrigerator: false,
        microwave: false,
        washer: false,
        freeParking: false,
        airConditioning: false,
        smokeAlarm: false,
        fireExtinguisher: false,
      ),
      nearbyServices: AddApartmentNearbyServices(
        hasGroceryStore: false,
        hasPharmacy: false,
        hasHospital: false,
        hasSchool: false,
        hasUniversity: false,
        hasPublicTransport: false,
        hasParking: false,
        hasMall: false,
        hasRestaurants: false,
        hasPark: false,
        hasGym: false,
        isSafeArea: false,
        hasPoliceStation: false,
        isQuietArea: false,
        hasChurchNearby: false,
        hasMosqueNearby: false,
      ),
      allowedTenants: AddApartmentAllowedTenants(
        allowsFamilies: false,
        allowsChildren: false,
        allowsStudents: false,
        studentGender: "any",
        allowsWorkers: false,
        workerGender: "any",
        petsAllowed: false,
      ),
    );
    log('📦 Request Model: Initialized with default values');
  }
  Future<void> submitProperty() async {
    if (localImages.isEmpty) {
      emit( AddPropertyFailure(errMessage: "Upload at least one image"));
      return;
    }

    log('🚀 Starting Sequential Submission...');
    emit(AddPropertyLoading());

    // Fix: Ensure name matches exactly what you use in the loop
    List<PropertyImages> uploadedImages = [];
    String? errorMessage;

    // STEP 1: Loop through local files and upload
    for (int i = 0; i < localImages.length; i++) {
      final bool isCover = (i == 0);
      log('📸 Uploading image $i: ${localImages[i].path}');

      final result = await addPropertyRepo.uploadImg(
        file: localImages[i].path,
        isCover: isCover,
      );

      result.fold(
            (failure) {
          errorMessage = failure.errMessage;
          log('❌ Upload Error: $errorMessage');
        },
            (uploadModel) {
          if (uploadModel.isSuccess == true && uploadModel.data?.imageUrl != null) {
            uploadedImages.add(PropertyImages(
              id: i,
              imageUrl: uploadModel.data!.imageUrl,
              isCover: uploadModel.data!.isCover ?? isCover,
            ));
            log('✅ Image $i success: ${uploadModel.data!.imageUrl}');
          } else {
            errorMessage = uploadModel.message ?? "Server error on image $i";
          }
        },
      );

      if (errorMessage != null) break;
    }

    // STEP 2: Send final JSON
    if (errorMessage == null) {
      log('🔗 All images uploaded. Sending final data...');
      _request.propertyImages = uploadedImages;

      final finalResult = await addPropertyRepo.addApartment(request: _request);

      finalResult.fold(
            (failure) {
          log('❌ Final Post Failed: ${failure.errMessage}');
          emit(AddPropertyFailure(errMessage: failure.errMessage));
        },
            (success) {
          log('🎉 SUCCESS!');
          emit(AddPropertySuccess(message: "Property published successfully!"));
        },
      );
    } else {
      emit(AddPropertyFailure(errMessage: errorMessage!));
    }
  }
  // --- LOCATION LOGIC ---
  Future<void> determineCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition();
    updateLocation(position.latitude, position.longitude);
  }

  void updateLocation(double lat, double lng) {
    _request.latitude = lat;
    _request.longitude = lng;
    _refreshUI();
  }

  // --- IMAGE HANDLING ---
  Future<void> pickCoverImage() async {
    final XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (localImages.isEmpty) {
        localImages.add(File(picked.path));
      } else {
        localImages[0] = File(picked.path);
      }
      _refreshUI();
    }
  }

  Future<void> pickImages() async {
    final List<XFile> picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      localImages.addAll(picked.map((x) => File(x.path)));
      _refreshUI();
    }
  }

  void removeImage(int index) {
    localImages.removeAt(index);
    _refreshUI();
  }

  void removeLocalImage(int index) {
    localImages.removeAt(index);
    _refreshUI();
  }

  // --- GETTERS ---
  AddApartmentRequest get request => _request;
  int get currentStep => _currentStep;
  PropertyType get selectedType => _selectedType;

  // --- UI ACTIONS & TOGGLES (STRICTLY AS PROVIDED) ---
  void toggleFurnished() {
    _request.furnished = !(_request.furnished ?? true);
    log('🛋️ Furnished toggled to: ${_request.furnished}');
    _refreshUI();
  }

  void toggleGenderType({required String genderType}) {
    _request.allowedTenants?.studentGender = genderType;
    _request.allowedTenants?.workerGender = genderType;
    log('👥 gender Type Toggled: $genderType');
    _refreshUI();
  }

  void toggleTenantType(String type) {
    final t = _request.allowedTenants;
    if (t == null) return;
    switch (type) {
      case AppStrings.pets: t.petsAllowed = !(t.petsAllowed ?? false); break;
      case AppStrings.families: t.allowsFamilies = !(t.allowsFamilies ?? false); break;
      case AppStrings.children: t.allowsChildren = !(t.allowsChildren ?? false); break;
      case AppStrings.students: t.allowsStudents = !(t.allowsStudents ?? false); break;
      case AppStrings.workersProfessionals: t.allowsWorkers = !(t.allowsWorkers ?? false); break;
    }
    log('👥 Tenant Type Toggled: $type');
    _refreshUI();
  }

  void selectType(PropertyType type) {
    _selectedType = type;
    log('🏠 Property Type Selected: $type');
    _refreshUI();
  }

  void nextStep() {
    _currentStep++;
    log('➡️ Step Advanced: $_currentStep');
    _refreshUI();
  }

  void prevStep() {
    if (_currentStep > 0) {
      _currentStep--;
      log('⬅️ Step Reverted: $_currentStep');
    }
    _refreshUI();
  }

  void toggleAmenity(String key) {
    final json = _request.amenities?.toJson() ?? {};
    if (json.containsKey(key)) {
      json[key] = !(json[key] as bool);
      _request.amenities = AddApartmentAmenities.fromJson(json);
      log('✨ Amenity Toggled: $key -> ${json[key]}');
      _refreshUI();
    }
  }

  void toggleNearbyServices(String key) {
    final json = _request.nearbyServices?.toJson() ?? {};
    if (json.containsKey(key)) {
      json[key] = !(json[key] as bool);
      _request.nearbyServices = AddApartmentNearbyServices.fromJson(json);
      log('✨ Amenity Toggled: $key -> ${json[key]}');
      _refreshUI();
    }
  }

  void updateGender(String gender, {bool isStudent = true}) {
    if (isStudent) {
      _request.allowedTenants?.studentGender = gender;
    } else {
      _request.allowedTenants?.workerGender = gender;
    }
    log('🚻 Gender Updated: ${isStudent ? "Student" : "Worker"} -> $gender');
    _refreshUI();
  }

  void updateCounter(String key, bool increase) {
    int change = increase ? 1 : -1;
    switch (key) {
      case AppStrings.bedrooms:
        if (_request.numberOfBedrooms == 1 && !increase) break;
        _request.numberOfBedrooms = (_request.numberOfBedrooms ?? 1) + change;
        break;
      case AppStrings.livingRooms:
        if (_request.numberOfLivingRooms == 1 && !increase) break;
        _request.numberOfLivingRooms = (_request.numberOfLivingRooms ?? 1) + change;
        break;
      case 'Min Stay':
        if (_request.minimumStay == 1 && !increase) break;
        _request.minimumStay = (_request.minimumStay ?? 1) + change;
        break;
      case AppStrings.enSuiteBathrooms:
        if (_request.numberOfEnSuiteBathrooms == 0 && !increase) break;
        _request.numberOfEnSuiteBathrooms = (_request.numberOfEnSuiteBathrooms ?? 0) + change;
        break;
      case AppStrings.guestBathrooms:
        if (_request.numberOfGuestBathrooms == 0 && !increase) break;
        _request.numberOfGuestBathrooms = (_request.numberOfGuestBathrooms ?? 0) + change;
        break;
    }
    log('🔢 Counter Updated [$key]: Change $change');
    _refreshUI();
  }

// --- REFRESH UI & SYNC ---
  void _refreshUI() {
    // 💡 This part ensures your ValidationHelper.isLocationAndGalleryValid returns true!
    _request.propertyImages = localImages.asMap().entries.map((entry) {
      return PropertyImages(
        imageUrl: entry.value.path, // Temporary local path for validation check
        isCover: entry.key == 0,
      );
    }).toList();

    emit(AddPropertyFormUpdated(DateTime.now()));
  }
}