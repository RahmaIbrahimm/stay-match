
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stay_match/Features/add_property/data/models/add_apartment_request.dart';
import 'package:stay_match/Features/add_property/data/models/add_apartment_response.dart';
import 'package:stay_match/Features/add_property/data/models/add_room_request.dart';
import 'package:stay_match/Features/add_property/data/models/add_room_response.dart';
import 'package:stay_match/Features/add_property/data/repos/add_property_repo.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../filter/presentation/widgets/filter_helper.dart';

part 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  final AddPropertyRepo addPropertyRepo;

  late AddApartmentRequest _apartmentRequest;
  late AddRoomRequest _roomRequest;
  int _currentStep = 0;
  int? id = -1;
  PropertyType _selectedType = PropertyType.none;
  List<File> localImages = [];
  // EDIT PROPERTY stuff
  bool isEditMode = false;
  int? editPropertyId;
  // Room Specific
  Map<int, List<File>> localRoomImages = {};

  AddPropertyCubit({required this.addPropertyRepo})
      : super(AddPropertyInitial()) {
    _initializeRequest();
    log('🏢 AddPropertyCubit: Initialized');
  }

  // --- GETTERS ---
  AddApartmentRequest get apartmentRequest => _apartmentRequest;
  AddRoomRequest get roomRequest => _roomRequest;
  int get currentStep => _currentStep;
  PropertyType get selectedType => _selectedType;

  void _initializeRequest() {
    // --- APARTMENT REQUEST (RESTORED TO ORIGINAL) ---
    _apartmentRequest = AddApartmentRequest(
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
      amenities: AddApartmentRequestAmenities(
        wifi: false, tv: false, cooktop: false, oven: false, kettle: false,
        dishwasher: false, refrigerator: false, microwave: false, washer: false,
        freeParking: false, airConditioning: false, smokeAlarm: false, fireExtinguisher: false,
      ),
      nearbyServices: AddApartmentRequestNearbyServices(
        hasGroceryStore: false, hasPharmacy: false, hasHospital: false,
        hasSchool: false, hasUniversity: false, hasPublicTransport: false,
        hasParking: false, hasMall: false, hasRestaurants: false,
        hasPark: false, hasGym: false, isSafeArea: false,
        hasPoliceStation: false, isQuietArea: false,
        hasChurchNearby: false, hasMosqueNearby: false,
      ),
      allowedTenants: AddApartmentRequestAllowedTenants(
        allowsFamilies: false, allowsChildren: false, allowsStudents: false,
        studentGender: "any", allowsWorkers: false, workerGender: "any", petsAllowed: false,
      ),
    );

    // --- ROOM REQUEST ---
    _roomRequest = AddRoomRequest(
      name: "", size: 0, description: "", totalRooms: 1, availableRooms: 1,
      street: "", city: "", government: "Cairo", latitude: 0, longitude: 0,
      isDraft: false, propertyImages: [],
      amenities: AddRoomRequestPropertyAmenities(
        wifi: false, tv: false, cooktop: false, oven: false, kettle: false,
        dishwasher: false, refrigerator: false, microwave: false, washer: false,
        freeParking: false, airConditioning: false, smokeAlarm: false, fireExtinguisher: false,
      ),
      nearbyServices: AddRoomRequestNearbyServices(
        hasGroceryStore: false, hasPharmacy: false, hasHospital: false,
        hasSchool: false, hasUniversity: false, hasPublicTransport: false,
        hasParking: false, hasMall: false, hasRestaurants: false,
        hasPark: false, hasGym: false, isSafeArea: false,
        hasPoliceStation: false, isQuietArea: false,
        hasChurchNearby: false, hasMosqueNearby: false,
      ),
      rooms: [_createNewRoom(1)],
    );

    log('📦 Request Models: Initialized with default values');
  }

  AddRoomRequestRooms _createNewRoom(int index) {
    return AddRoomRequestRooms(
      roomName: "Room $index", minimumStay: 1, monthRent: 0, deposit: 0,
      furnished: true, availableFrom: DateTime.now().toIso8601String(),
      capacity: 1, capacityAvailable: 1, enSuiteBathroom: false, sharedBathroom: true,
      balcony: false, window: true, petsAllowed: false, propertyImages: [],
      roomAmenities: AddRoomRequestRoomAmenities(airConditioning: false, closet: false, mirror: false, fan: false),
      allowedTenants: AddRoomRequestAllowedTenants(
        allowsFamilies: false, allowsChildren: false, allowsStudents: false,
        studentGender: "any", allowsWorkers: false, workerGender: "Male", petsAllowed: false,
      ),

    );
  }

  // --- SUBMISSION LOGIC ---

  Future<void> submit() async {
    if (_selectedType == PropertyType.apartment) {
      await submitApartment();
    } else {
      await submitRoomProperty();
    }
  }

  Future<void> submitApartment() async {
    if (localImages.isEmpty) {
      emit(AddPropertyFailure(errMessage: "Upload at least one image"));
      return;
    }

    log('🚀 Starting Sequential Submission...');
    emit(AddPropertyLoading());

    List<AddApartmentRequestPropertyImages> uploadedImages = [];
    String? errorMessage;

    for (int i = 0; i < localImages.length; i++) {
      final bool isCover = (i == 0);
      log('📸 Uploading image $i: ${localImages[i].path}');

      final result = await addPropertyRepo.uploadPropertyImg(
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
            uploadedImages.add(AddApartmentRequestPropertyImages(
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

    if (errorMessage == null) {
      log('🔗 All images uploaded. Sending final data...');
      _apartmentRequest.propertyImages = uploadedImages;

      final finalResult = await addPropertyRepo.addApartment(request: _apartmentRequest);

      finalResult.fold(
            (failure) {
          log('❌ Final Post Failed: ${failure.errMessage}');
          emit(AddPropertyFailure(errMessage: failure.errMessage));
        },
            (success) {
          log('🎉 SUCCESS!');
          emit(AddPropertySuccess(message: "Property published successfully!",
              addApartmentResponse: success));
          id = success.data?.propertyId?? -1;
        },
      );
    } else {
      emit(AddPropertyFailure(errMessage: errorMessage!));
    }
  }


  // ======================= EDITING METHODS ===============================




  // --- ROOM UI METHODS ---

  void updateRoomBasicData(int index,
      {int? minimumStay, String? name, int? rent, int? deposit, String? availableDate, bool? isEnSuite}) {
    final room = _roomRequest.rooms![index];
    if (name != null) room.roomName = name;
    if (rent != null) room.monthRent = rent;
    if (deposit != null) room.deposit = deposit;
    if (availableDate != null) room.availableFrom = availableDate;
    if (minimumStay != null) room.minimumStay = minimumStay;
    if (isEnSuite != null) {
      room.enSuiteBathroom = isEnSuite;
      room.sharedBathroom = !isEnSuite;
    }
    _refreshUI();
  }

  void updateRoomCapacity(int index, {int? total, int? available}) {
    final room = _roomRequest.rooms![index];
    if (total != null) room.capacity = total;
    if (available != null) room.capacityAvailable = available;
    _refreshUI();
  }

  void toggleRoomKeyFeature(int index, String feature) {
    final room = _roomRequest.rooms![index];
    if (feature == 'Balcony') room.balcony = !(room.balcony ?? false);
    if (feature == 'Window') room.window = !(room.window ?? false);
    if (feature == 'Pets') room.petsAllowed = !(room.petsAllowed ?? false);
    _refreshUI();
  }

  void toggleRoomAmenity(int index, String key) {
    final room = _roomRequest.rooms![index];
    final json = room.roomAmenities?.toJson() ?? {};
    if (json.containsKey(key)) {
      json[key] = !(json[key] as bool);
      room.roomAmenities = AddRoomRequestRoomAmenities.fromJson(json);
      _refreshUI();
    }
  }

  void toggleRoomTenantType(int index, String type) {
    final tenants = _roomRequest.rooms![index].allowedTenants;
    if (tenants == null) return;
    if (type == 'Students') tenants.allowsStudents = !(tenants.allowsStudents ?? false);
    if (type == 'Workers') tenants.allowsWorkers = !(tenants.allowsWorkers ?? false);
    if (type == 'Families') tenants.allowsFamilies = !(tenants.allowsFamilies ?? false);
    if (type == 'Children') tenants.allowsChildren = !(tenants.allowsChildren ?? false);
    _refreshUI();
  }

  void updateRoomGender(int index, String gender) {
    _roomRequest.rooms![index].allowedTenants?.studentGender = gender;
    _roomRequest.rooms![index].allowedTenants?.workerGender = gender;
    _refreshUI();
  }

  // --- ORIGINAL APARTMENT METHODS ---

  void toggleFurnished({int? index}) {
    if (_selectedType == PropertyType.apartment) {
      _apartmentRequest.furnished = !(_apartmentRequest.furnished ?? true);
      log('🏢 Apartment Furnished toggled to: ${_apartmentRequest.furnished}');
    } else {
      final roomIndex = index ?? 0;
      final room = _roomRequest.rooms![roomIndex];
      room.furnished = !(room.furnished ?? true);
      log('🛋️ Room $roomIndex Furnished toggled to: ${room.furnished}');
    }
    _refreshUI();
  }

  void toggleGenderType({required String genderType}) {
    _apartmentRequest.allowedTenants?.studentGender = genderType;
    _apartmentRequest.allowedTenants?.workerGender = genderType;
    log('👥 gender Type Toggled: $genderType');
    _refreshUI();
  }

  void toggleTenantType(String type) {
    final t = _apartmentRequest.allowedTenants;
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

  void toggleAmenity(String key) {
    if (_selectedType == PropertyType.apartment) {
      final json = _apartmentRequest.amenities?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        _apartmentRequest.amenities = AddApartmentRequestAmenities.fromJson(json);
      }
    } else {
      final json = _roomRequest.amenities?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        _roomRequest.amenities = AddRoomRequestPropertyAmenities.fromJson(json);
      }
    }
    log('✨ Amenity Toggled: $key');
    _refreshUI();
  }

  void toggleNearbyServices(String key) {
    if (_selectedType == PropertyType.apartment) {
      final json = _apartmentRequest.nearbyServices?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        _apartmentRequest.nearbyServices =
            AddApartmentRequestNearbyServices.fromJson(json);
      }
    } else {
      final json = _roomRequest.nearbyServices?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        _roomRequest.nearbyServices = AddRoomRequestNearbyServices.fromJson(json);
      }
    }
    log('✨ Nearby Service Toggled: $key');
    _refreshUI();
  }

  void updateCounter(String key, bool increase) {
    int change = increase ? 1 : -1;
    switch (key) {
      case AppStrings.bedrooms:
        if (_apartmentRequest.numberOfBedrooms == 1 && !increase) break;
        _apartmentRequest.numberOfBedrooms = (_apartmentRequest.numberOfBedrooms ?? 1) + change;
        break;
      case AppStrings.livingRooms:
        if (_apartmentRequest.numberOfLivingRooms == 1 && !increase) break;
        _apartmentRequest.numberOfLivingRooms = (_apartmentRequest.numberOfLivingRooms ?? 1) + change;
        break;
      case 'Min Stay':
        if (_apartmentRequest.minimumStay == 1 && !increase) break;
        _apartmentRequest.minimumStay = (_apartmentRequest.minimumStay ?? 1) + change;
        break;
      case AppStrings.enSuiteBathrooms:
        if (_apartmentRequest.numberOfEnSuiteBathrooms == 0 && !increase) break;
        _apartmentRequest.numberOfEnSuiteBathrooms = (_apartmentRequest.numberOfEnSuiteBathrooms ?? 0) + change;
        break;
      case AppStrings.guestBathrooms:
        if (_apartmentRequest.numberOfGuestBathrooms == 0 && !increase) break;
        _apartmentRequest.numberOfGuestBathrooms = (_apartmentRequest.numberOfGuestBathrooms ?? 0) + change;
        break;
    }
    log('🔢 Counter Updated [$key]: Change $change');
    _refreshUI();
  }

  // --- SHARED ACTIONS ---

  void addRoom() {
    _roomRequest.rooms?.add(_createNewRoom((_roomRequest.rooms?.length ?? 0) + 1));
    _refreshUI();
  }

  void removeRoom(int index) {
    if ((_roomRequest.rooms?.length ?? 0) > 1) {
      _roomRequest.rooms?.removeAt(index);
      localRoomImages.remove(index);
      _refreshUI();
    }
  }

  void selectType(PropertyType type) {
    _selectedType = type;
    log('🏠 Property Type Selected: $type');
    _refreshUI();
  }

  void nextStep() { _currentStep++; log('➡️ Step Advanced: $_currentStep'); _refreshUI(); }
  void prevStep() { if (_currentStep > 0) { _currentStep--; log('⬅️ Step Reverted: $_currentStep'); } _refreshUI(); }

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
    _apartmentRequest.latitude = lat;
    _apartmentRequest.longitude = lng;
    _roomRequest.latitude = lat;
    _roomRequest.longitude = lng;
    _refreshUI();
  }

  Future<List<AddRoomRequestSharedPropertyImages>> _uploadSharedImages(
      List<File> files) async {
    List<AddRoomRequestSharedPropertyImages> results = [];
    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      if (!await file.exists()) {
        log('⚠️ Skipping missing file: ${file.path}');
        continue;
      }
      final res = await addPropertyRepo.uploadPropertyImg(
          file: file.path, isCover: i == 0);
      res.fold(
            (l) {
          log('❌ Upload failed for ${file.path}: ${l.errMessage}');
        },
            (r) {
          if (r.data?.imageUrl != null) {
            results.add(AddRoomRequestSharedPropertyImages(
                id: i, imageUrl: r.data!.imageUrl, isCover: i == 0));
            log('✅ Uploaded: ${r.data!.imageUrl}');
          }
        },
      );
    }
    return results;
  }

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

  Future<void> pickRoomImages(int index) async {
    final List<XFile> picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      localRoomImages[index] = [...(localRoomImages[index] ?? []), ...picked.map((x) => File(x.path))];
      _refreshUI();
    }
  }

  void removeImage(int index) { localImages.removeAt(index); _refreshUI(); }
  void removeLocalImage(int index) { localImages.removeAt(index); _refreshUI(); }

  void _refreshUI() {
    _apartmentRequest.propertyImages = localImages.asMap().entries.map((entry) {
      return AddApartmentRequestPropertyImages(imageUrl: entry.value.path, isCover: entry.key == 0);
    }).toList();

    _roomRequest.propertyImages = localImages.map((f) => AddRoomRequestSharedPropertyImages(imageUrl: f.path)).toList();

    localRoomImages.forEach((index, files) {
      if (index < (_roomRequest.rooms?.length ?? 0)) {
        _roomRequest.rooms![index].propertyImages = files.map((f) => AddRoomRequestSharedPropertyImages(imageUrl: f.path)).toList();
      }
    });

    emit(AddPropertyFormUpdated(DateTime.now()));
  }

  void resetAll() {
    _currentStep = 0;
    _selectedType = PropertyType.none;
    localImages.clear();
    localRoomImages.clear();
    _initializeRequest();
    emit(AddPropertyInitial());
    log('♻️ AddPropertyCubit: Reset to initial state');
  }


  // --- SHARED PROPERTY (STEP 1) METHODS ---

  void updateSharedPropertyBasicInfo({
    String? name,
    int? totalRooms,
    int? availableRooms,
    int? size,
    String? description,
  }) {
    if (name != null) _roomRequest.name = name;
    if (totalRooms != null) _roomRequest.totalRooms = totalRooms;
    if (size != null) _roomRequest.size = size;
    if (description != null) _roomRequest.description = description;

    // --- PUT THE NEW SYNC LOGIC HERE ---
    if (availableRooms != null) {
      _roomRequest.availableRooms = availableRooms;

      int currentLength = _roomRequest.rooms?.length ?? 0;

      // Don't do anything if it's already the right size
      if (currentLength != availableRooms) {
        if (availableRooms > currentLength) {
          // Add only the difference
          int roomsToAdd = availableRooms - currentLength;
          for (int i = 0; i < roomsToAdd; i++) {
            _roomRequest.rooms?.add(
                _createNewRoom((_roomRequest.rooms?.length ?? 0) + 1));
          }
        } else {
          // Trim the list if the number decreased
          while ((_roomRequest.rooms?.length ?? 0) > availableRooms) {
            _roomRequest.rooms?.removeLast();
            localRoomImages.remove(_roomRequest.rooms!.length);
          }
        }
      }
    }

    log('🏢 Updated Model -> Name: ${_roomRequest.name}, Avail: ${_roomRequest
        .availableRooms}, List Size: ${_roomRequest.rooms?.length}');
    _refreshUI();
  }

  void updateSharedPropertyLocation({
    String? state,
    String? city,
    String? street,
  }) {
    if (state != null) _roomRequest.government = state;
    if (city != null) _roomRequest.city = city;
    if (street != null) _roomRequest.street = street;

    log('📍 Shared Location Updated: $state, $city');
    _refreshUI();
  }

  Future<void> submitRoomProperty() async {
    emit(AddPropertyLoading());
    log('🚀 Publishing Shared Apartment with Rooms...');

    try {
      _roomRequest.propertyImages = await _uploadSharedImages(localImages);
      for (int i = 0; i < (_roomRequest.rooms?.length ?? 0); i++) {
        if (localRoomImages.containsKey(i) && localRoomImages[i]!.isNotEmpty) {
          log('📸 Uploading images for Room ${i + 1}');
          _roomRequest.rooms![i].propertyImages =
          await _uploadSharedImages(localRoomImages[i]!);
        }
      }
      final result = await addPropertyRepo.addRoom(request: _roomRequest);
      result.fold(
              (failure) =>
              emit(AddPropertyFailure(errMessage: failure.errMessage)),
              (success) {
                emit(AddPropertySuccess(
                    message: "Property published successfully!",
                    addRoomResponse: success));
                id = success.data?.propertyId;
            log(_roomRequest.toJson().toString(), name: "room request final");
          }
      );
    } catch (e) {
      log('❌ Submission Error: $e');
      emit(AddPropertyFailure(
          errMessage: "An error occurred during upload: $e"));
    }
  }
}