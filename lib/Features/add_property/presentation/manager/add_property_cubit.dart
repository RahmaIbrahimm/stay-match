// import 'dart:developer';
// import 'dart:io';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:stay_match/Features/add_property/data/models/add_apartment_request.dart';
// import 'package:stay_match/Features/add_property/data/models/add_room_request.dart';
// import 'package:stay_match/Features/add_property/data/repos/add_property_repo.dart';
// import 'package:stay_match/core/constants/app_strings.dart';
//
// import '../../../filter/presentation/widgets/filter_helper.dart';
//
// part 'add_property_state.dart';
//
// class AddPropertyCubit extends Cubit<AddPropertyState> {
//   final AddPropertyRepo addPropertyRepo;
//
//   late AddApartmentRequest _apartmentRequest;
//   late AddRoomRequest _roomRequest;
//   int _currentStep = 0;
//   PropertyType _selectedType = PropertyType.none;
//   List<File> localImages = [];
//   Map<int, List<File>> localRoomImages = {};
//   AddPropertyCubit({required this.addPropertyRepo})
//       : super(AddPropertyInitial()) {
//     _initializeRequest();
//     log('🏢 AddPropertyCubit: Initialized');
//   }
//   // --- GETTERS ---
//   AddApartmentRequest get apartmentRequest => _apartmentRequest;
//   AddRoomRequest get roomRequest => _roomRequest;
//   int get currentStep => _currentStep;
//   PropertyType get selectedType => _selectedType;
//   // void _initializeRequest() {
//   //   _apartmentRequest = AddApartmentRequest(
//   //     name: "",
//   //     description: "",
//   //     monthlyRent: 0,
//   //     deposite: 0,
//   //     furnished: true,
//   //     availableFrom: DateTime.now().toIso8601String(),
//   //     numberOfBedrooms: 0,
//   //     numberOfLivingRooms: 0,
//   //     numberOfEnSuiteBathrooms: 0,
//   //     numberOfGuestBathrooms: 0,
//   //     street: "",
//   //     city: "",
//   //     government: "Cairo",
//   //     latitude: 0,
//   //     longitude: 0,
//   //     size: 0,
//   //     minimumStay: 1,
//   //     isDraft: false,
//   //     propertyImages: [],
//   //     amenities: AddApartmentAmenities(
//   //       wifi: false,
//   //       tv: false,
//   //       cooktop: false,
//   //       oven: false,
//   //       kettle: false,
//   //       dishwasher: false,
//   //       refrigerator: false,
//   //       microwave: false,
//   //       washer: false,
//   //       freeParking: false,
//   //       airConditioning: false,
//   //       smokeAlarm: false,
//   //       fireExtinguisher: false,
//   //     ),
//   //     nearbyServices: AddApartmentNearbyServices(
//   //       hasGroceryStore: false,
//   //       hasPharmacy: false,
//   //       hasHospital: false,
//   //       hasSchool: false,
//   //       hasUniversity: false,
//   //       hasPublicTransport: false,
//   //       hasParking: false,
//   //       hasMall: false,
//   //       hasRestaurants: false,
//   //       hasPark: false,
//   //       hasGym: false,
//   //       isSafeArea: false,
//   //       hasPoliceStation: false,
//   //       isQuietArea: false,
//   //       hasChurchNearby: false,
//   //       hasMosqueNearby: false,
//   //     ),
//   //     allowedTenants: AddApartmentAllowedTenants(
//   //       allowsFamilies: false,
//   //       allowsChildren: false,
//   //       allowsStudents: false,
//   //       studentGender: "any",
//   //       allowsWorkers: false,
//   //       workerGender: "any",
//   //       petsAllowed: false,
//   //     ),
//   //   );
//   //   log('📦 Request Model: Initialized with default values');
//   // }
//   void _initializeRequest() {
//     // --- APARTMENT REQUEST (LEAVING UNTOUCHED AS REQUESTED) ---
//     _apartmentRequest = AddApartmentRequest(
//       name: "",
//       description: "",
//       monthlyRent: 0,
//       deposite: 0,
//       furnished: true,
//       availableFrom: DateTime.now().toIso8601String(),
//       numberOfBedrooms: 0,
//       numberOfLivingRooms: 0,
//       numberOfEnSuiteBathrooms: 0,
//       numberOfGuestBathrooms: 0,
//       street: "",
//       city: "",
//       government: "Cairo",
//       latitude: 0,
//       longitude: 0,
//       size: 0,
//       minimumStay: 1,
//       isDraft: false,
//       propertyImages: [],
//       amenities: AddApartmentAmenities(
//         wifi: false, tv: false, cooktop: false, oven: false, kettle: false,
//         dishwasher: false, refrigerator: false, microwave: false, washer: false,
//         freeParking: false, airConditioning: false, smokeAlarm: false, fireExtinguisher: false,
//       ),
//       nearbyServices: AddApartmentNearbyServices(
//         hasGroceryStore: false, hasPharmacy: false, hasHospital: false,
//         hasSchool: false, hasUniversity: false, hasPublicTransport: false,
//         hasParking: false, hasMall: false, hasRestaurants: false,
//         hasPark: false, hasGym: false, isSafeArea: false,
//         hasPoliceStation: false, isQuietArea: false,
//         hasChurchNearby: false, hasMosqueNearby: false,
//       ),
//       allowedTenants: AddApartmentAllowedTenants(
//         allowsFamilies: false, allowsChildren: false, allowsStudents: false,
//         studentGender: "any", allowsWorkers: false, workerGender: "any", petsAllowed: false,
//       ),
//     );
//
//     // --- FIXED ROOM REQUEST ---
//     _roomRequest = AddRoomRequest(
//       name: "",
//       size: 0,
//       description: "",
//       totalRooms: 1,
//       availableRooms: 1,
//       street: "",
//       city: "",
//       government: "Cairo",
//       latitude: 0,
//       longitude: 0,
//       isDraft: false,
//       propertyImages: [],
//       amenities: Amenities(
//         wifi: false, tv: false, cooktop: false, oven: false, kettle: false,
//         dishwasher: false, refrigerator: false, microwave: false, washer: false,
//         freeParking: false, airConditioning: false, smokeAlarm: false, fireExtinguisher: false,
//       ),
//       nearbyServices: AddRoomNearbyServices(
//         hasGroceryStore: false, hasPharmacy: false, hasHospital: false,
//         hasSchool: false, hasUniversity: false, hasPublicTransport: false,
//         hasParking: false, hasMall: false, hasRestaurants: false,
//         hasPark: false, hasGym: false, isSafeArea: false,
//         hasPoliceStation: false, isQuietArea: false,
//         hasChurchNearby: false, hasMosqueNearby: false,
//       ),
//       rooms: [
//         Rooms(
//           roomName: "Room 1",
//           minimumStay: 1,
//           monthRent: 0,
//           deposit: 0,
//           furnished: true,
//           availableFrom: DateTime.now().toIso8601String(),
//           capacity: 1,
//           capacityAvailable: 1,
//           enSuiteBathroom: false,
//           sharedBathroom: true,
//           balcony: false,
//           window: true,
//           petsAllowed: false,
//           propertyImages: [],
//           roomAmenities: RoomAmenities(
//             airConditioning: false,
//             closet: false,
//             mirror: false,
//             fan: false,
//           ),
//           allowedTenants: AllowedTenants(
//             allowsFamilies: false,
//             allowsChildren: false,
//             allowsStudents: false,
//             studentGender: "any",
//             allowsWorkers: false,
//             workerGender: "any",
//             petsAllowed: false,
//           ),
//         ),
//       ],
//     );
//
//     log('📦 Request Models: Initialized with default values');
//   }
//   Future<void> submitApartment() async {
//     if (localImages.isEmpty) {
//       emit( AddPropertyFailure(errMessage: "Upload at least one image"));
//       return;
//     }
//
//     log('🚀 Starting Sequential Submission...');
//     emit(AddPropertyLoading());
//
//     List<PropertyImages> uploadedImages = [];
//     String? errorMessage;
//
//     // STEP 1: Loop through local files and upload
//     for (int i = 0; i < localImages.length; i++) {
//       final bool isCover = (i == 0);
//       log('📸 Uploading image $i: ${localImages[i].path}');
//
//       final result = await addPropertyRepo.uploadPropertyImg(
//         file: localImages[i].path,
//         isCover: isCover,
//       );
//
//       result.fold(
//             (failure) {
//           errorMessage = failure.errMessage;
//           log('❌ Upload Error: $errorMessage');
//         },
//             (uploadModel) {
//           if (uploadModel.isSuccess == true && uploadModel.data?.imageUrl != null) {
//             uploadedImages.add(PropertyImages(
//               id: i,
//               imageUrl: uploadModel.data!.imageUrl,
//               isCover: uploadModel.data!.isCover ?? isCover,
//             ));
//             log('✅ Image $i success: ${uploadModel.data!.imageUrl}');
//           } else {
//             errorMessage = uploadModel.message ?? "Server error on image $i";
//           }
//         },
//       );
//
//       if (errorMessage != null) break;
//     }
//
//     // STEP 2: Send final JSON
//     if (errorMessage == null) {
//       log('🔗 All images uploaded. Sending final data...');
//       _apartmentRequest.propertyImages = uploadedImages;
//
//       final finalResult = await addPropertyRepo.addApartment(request: _apartmentRequest);
//
//       finalResult.fold(
//             (failure) {
//           log('❌ Final Post Failed: ${failure.errMessage}');
//           emit(AddPropertyFailure(errMessage: failure.errMessage));
//         },
//             (success) {
//           log('🎉 SUCCESS!');
//           emit(AddPropertySuccess(message: "Property published successfully!"));
//         },
//       );
//     } else {
//       emit(AddPropertyFailure(errMessage: errorMessage!));
//     }
//   }
//   // --- LOCATION LOGIC ---
//   Future<void> determineCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) return;
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     updateLocation(position.latitude, position.longitude);
//   }
//
//   void updateLocation(double lat, double lng) {
//     _apartmentRequest.latitude = lat;
//     _apartmentRequest.longitude = lng;
//
//     // Update room request (casting to int because of your model definition)
//     _roomRequest.latitude = lat.toInt();
//     _roomRequest.longitude = lng.toInt();
//
//     _refreshUI();
//   }
//   // --- IMAGE HANDLING ---
//   Future<void> pickCoverImage() async {
//     final XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       if (localImages.isEmpty) {
//         localImages.add(File(picked.path));
//       } else {
//         localImages[0] = File(picked.path);
//       }
//       _refreshUI();
//     }
//   }
//
//   Future<void> pickImages() async {
//     final List<XFile> picked = await ImagePicker().pickMultiImage();
//     if (picked.isNotEmpty) {
//       localImages.addAll(picked.map((x) => File(x.path)));
//       _refreshUI();
//     }
//   }
//
//   void removeImage(int index) {
//     localImages.removeAt(index);
//     _refreshUI();
//   }
//
//   void removeLocalImage(int index) {
//     localImages.removeAt(index);
//     _refreshUI();
//   }
//
//   // --- UI ACTIONS & TOGGLES (STRICTLY AS PROVIDED) ---
//   void toggleFurnished() {
//     _apartmentRequest.furnished = !(_apartmentRequest.furnished ?? true);
//     log('🛋️ Furnished toggled to: ${_apartmentRequest.furnished}');
//     _refreshUI();
//   }
//
//   void toggleGenderType({required String genderType}) {
//     _apartmentRequest.allowedTenants?.studentGender = genderType;
//     _apartmentRequest.allowedTenants?.workerGender = genderType;
//     log('👥 gender Type Toggled: $genderType');
//     _refreshUI();
//   }
//
//   void toggleTenantType(String type) {
//     final t = _apartmentRequest.allowedTenants;
//     if (t == null) return;
//     switch (type) {
//       case AppStrings.pets: t.petsAllowed = !(t.petsAllowed ?? false); break;
//       case AppStrings.families: t.allowsFamilies = !(t.allowsFamilies ?? false); break;
//       case AppStrings.children: t.allowsChildren = !(t.allowsChildren ?? false); break;
//       case AppStrings.students: t.allowsStudents = !(t.allowsStudents ?? false); break;
//       case AppStrings.workersProfessionals: t.allowsWorkers = !(t.allowsWorkers ?? false); break;
//     }
//     log('👥 Tenant Type Toggled: $type');
//     _refreshUI();
//   }
//
//   void selectType(PropertyType type) {
//     _selectedType = type;
//     log('🏠 Property Type Selected: $type');
//     _refreshUI();
//   }
//
//   void nextStep() {
//     _currentStep++;
//     log('➡️ Step Advanced: $_currentStep');
//     _refreshUI();
//   }
//
//   void prevStep() {
//     if (_currentStep > 0) {
//       _currentStep--;
//       log('⬅️ Step Reverted: $_currentStep');
//     }
//     _refreshUI();
//   }
//
//   void toggleAmenity(String key) {
//     final json = _apartmentRequest.amenities?.toJson() ?? {};
//     if (json.containsKey(key)) {
//       json[key] = !(json[key] as bool);
//       _apartmentRequest.amenities = AddApartmentAmenities.fromJson(json);
//       log('✨ Amenity Toggled: $key -> ${json[key]}');
//       _refreshUI();
//     }
//   }
//
//   void toggleNearbyServices(String key) {
//     final json = _apartmentRequest.nearbyServices?.toJson() ?? {};
//     if (json.containsKey(key)) {
//       json[key] = !(json[key] as bool);
//       _apartmentRequest.nearbyServices = AddApartmentNearbyServices.fromJson(json);
//       log('✨ Amenity Toggled: $key -> ${json[key]}');
//       _refreshUI();
//     }
//   }
//
//   void updateGender(String gender, {bool isStudent = true}) {
//     if (isStudent) {
//       _apartmentRequest.allowedTenants?.studentGender = gender;
//     } else {
//       _apartmentRequest.allowedTenants?.workerGender = gender;
//     }
//     log('🚻 Gender Updated: ${isStudent ? "Student" : "Worker"} -> $gender');
//     _refreshUI();
//   }
//
//   void updateCounter(String key, bool increase) {
//     int change = increase ? 1 : -1;
//     switch (key) {
//       case AppStrings.bedrooms:
//         if (_apartmentRequest.numberOfBedrooms == 1 && !increase) break;
//         _apartmentRequest.numberOfBedrooms = (_apartmentRequest.numberOfBedrooms ?? 1) + change;
//         break;
//       case AppStrings.livingRooms:
//         if (_apartmentRequest.numberOfLivingRooms == 1 && !increase) break;
//         _apartmentRequest.numberOfLivingRooms = (_apartmentRequest.numberOfLivingRooms ?? 1) + change;
//         break;
//       case 'Min Stay':
//         if (_apartmentRequest.minimumStay == 1 && !increase) break;
//         _apartmentRequest.minimumStay = (_apartmentRequest.minimumStay ?? 1) + change;
//         break;
//       case AppStrings.enSuiteBathrooms:
//         if (_apartmentRequest.numberOfEnSuiteBathrooms == 0 && !increase) break;
//         _apartmentRequest.numberOfEnSuiteBathrooms = (_apartmentRequest.numberOfEnSuiteBathrooms ?? 0) + change;
//         break;
//       case AppStrings.guestBathrooms:
//         if (_apartmentRequest.numberOfGuestBathrooms == 0 && !increase) break;
//         _apartmentRequest.numberOfGuestBathrooms = (_apartmentRequest.numberOfGuestBathrooms ?? 0) + change;
//         break;
//     }
//     log('🔢 Counter Updated [$key]: Change $change');
//     _refreshUI();
//   }
// // [================= new code ====================================]
//
//
// // --- REFRESH UI & SYNC ---
//   void _refreshUI() {
//     // 💡 This part ensures your ValidationHelper.isLocationAndGalleryValid returns true!
//     _apartmentRequest.propertyImages = localImages.asMap().entries.map((entry) {
//       return PropertyImages(
//         imageUrl: entry.value.path, // Temporary local path for validation check
//         isCover: entry.key == 0,
//       );
//     }).toList();
//
//     emit(AddPropertyFormUpdated(DateTime.now()));
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stay_match/Features/add_property/data/models/add_apartment_request.dart';
import 'package:stay_match/Features/add_property/data/models/add_room_request.dart';
import 'package:stay_match/Features/add_property/data/repos/add_property_repo.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../../filter/presentation/widgets/filter_helper.dart';

part 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  final AddPropertyRepo addPropertyRepo;

  late AddApartmentRequest _apartmentRequest;
  late AddRoomRequest _roomRequest;
  int _currentStep = 0;
  PropertyType _selectedType = PropertyType.none;
  List<File> localImages = [];

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
      amenities: AddApartmentAmenities(
        wifi: false, tv: false, cooktop: false, oven: false, kettle: false,
        dishwasher: false, refrigerator: false, microwave: false, washer: false,
        freeParking: false, airConditioning: false, smokeAlarm: false, fireExtinguisher: false,
      ),
      nearbyServices: AddApartmentNearbyServices(
        hasGroceryStore: false, hasPharmacy: false, hasHospital: false,
        hasSchool: false, hasUniversity: false, hasPublicTransport: false,
        hasParking: false, hasMall: false, hasRestaurants: false,
        hasPark: false, hasGym: false, isSafeArea: false,
        hasPoliceStation: false, isQuietArea: false,
        hasChurchNearby: false, hasMosqueNearby: false,
      ),
      allowedTenants: AddApartmentAllowedTenants(
        allowsFamilies: false, allowsChildren: false, allowsStudents: false,
        studentGender: "any", allowsWorkers: false, workerGender: "any", petsAllowed: false,
      ),
    );

    // --- ROOM REQUEST ---
    _roomRequest = AddRoomRequest(
      name: "", size: 0, description: "", totalRooms: 1, availableRooms: 1,
      street: "", city: "", government: "Cairo", latitude: 0, longitude: 0,
      isDraft: false, propertyImages: [],
      amenities: Amenities(
        wifi: false, tv: false, cooktop: false, oven: false, kettle: false,
        dishwasher: false, refrigerator: false, microwave: false, washer: false,
        freeParking: false, airConditioning: false, smokeAlarm: false, fireExtinguisher: false,
      ),
      nearbyServices: AddRoomNearbyServices(
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

  Rooms _createNewRoom(int index) {
    return Rooms(
      roomName: "Room $index", minimumStay: 1, monthRent: 0, deposit: 0,
      furnished: true, availableFrom: DateTime.now().toIso8601String(),
      capacity: 1, capacityAvailable: 1, enSuiteBathroom: false, sharedBathroom: true,
      balcony: false, window: true, petsAllowed: false, propertyImages: [],
      roomAmenities: RoomAmenities(airConditioning: false, closet: false, mirror: false, fan: false),
      allowedTenants: AllowedTenants(
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

    List<PropertyImages> uploadedImages = [];
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
          emit(AddPropertySuccess(message: "Property published successfully!"));
        },
      );
    } else {
      emit(AddPropertyFailure(errMessage: errorMessage!));
    }
  }

  Future<void> submitRoomProperty() async {
    emit(AddPropertyLoading());
    try {
      _roomRequest.propertyImages = await _uploadSharedImages(localImages);
      for (int i = 0; i < (_roomRequest.rooms?.length ?? 0); i++) {
        if (localRoomImages.containsKey(i) && localRoomImages[i]!.isNotEmpty) {
          _roomRequest.rooms![i].propertyImages = await _uploadSharedImages(localRoomImages[i]!);
        }
      }
      final result = await addPropertyRepo.addRoom(request: _roomRequest);
      result.fold(
            (failure) => emit(AddPropertyFailure(errMessage: failure.errMessage)),
            (success) => emit(AddPropertySuccess(message: "Room Property Published!")),
      );
    } catch (e) {
      emit(AddPropertyFailure(errMessage: "Upload failed: $e"));
    }
  }

  Future<List<SharedPropertyImages>> _uploadSharedImages(List<File> files) async {
    List<SharedPropertyImages> results = [];
    for (int i = 0; i < files.length; i++) {
      final res = await addPropertyRepo.uploadPropertyImg(file: files[i].path, isCover: i == 0);
      res.fold(
            (l) => throw Exception(l.errMessage),
            (r) => results.add(SharedPropertyImages(id: i, imageUrl: r.data?.imageUrl, isCover: i == 0)),
      );
    }
    return results;
  }

  // --- ROOM UI METHODS ---

  void updateRoomBasicData(int index, {String? name, int? rent, int? deposit, String? availableDate, bool? isEnSuite}) {
    final room = _roomRequest.rooms![index];
    if (name != null) room.roomName = name;
    if (rent != null) room.monthRent = rent;
    if (deposit != null) room.deposit = deposit;
    if (availableDate != null) room.availableFrom = availableDate;
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
      room.roomAmenities = RoomAmenities.fromJson(json);
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

  // --- ORIGINAL APARTMENT METHODS (RESTORED) ---

  void toggleFurnished() {
    _apartmentRequest.furnished = !(_apartmentRequest.furnished ?? true);
    log('🛋️ Furnished toggled to: ${_apartmentRequest.furnished}');
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
    final json = _apartmentRequest.amenities?.toJson() ?? {};
    if (json.containsKey(key)) {
      json[key] = !(json[key] as bool);
      _apartmentRequest.amenities = AddApartmentAmenities.fromJson(json);
      log('✨ Amenity Toggled: $key -> ${json[key]}');
      _refreshUI();
    }
  }

  void toggleNearbyServices(String key) {
    final json = _apartmentRequest.nearbyServices?.toJson() ?? {};
    if (json.containsKey(key)) {
      json[key] = !(json[key] as bool);
      _apartmentRequest.nearbyServices = AddApartmentNearbyServices.fromJson(json);
      log('✨ Nearby Service Toggled: $key -> ${json[key]}');
      _refreshUI();
    }
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
    _roomRequest.latitude = lat.toInt();
    _roomRequest.longitude = lng.toInt();
    _refreshUI();
  }

  Future<void> pickCoverImage() async {
    final XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (localImages.isEmpty) localImages.add(File(picked.path));
      else localImages[0] = File(picked.path);
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
    // RESTORED: Specific Original Apartment mapping
    _apartmentRequest.propertyImages = localImages.asMap().entries.map((entry) {
      return PropertyImages(imageUrl: entry.value.path, isCover: entry.key == 0);
    }).toList();

    _roomRequest.propertyImages = localImages.map((f) => SharedPropertyImages(imageUrl: f.path)).toList();

    localRoomImages.forEach((index, files) {
      if (index < (_roomRequest.rooms?.length ?? 0)) {
        _roomRequest.rooms![index].propertyImages = files.map((f) => SharedPropertyImages(imageUrl: f.path)).toList();
      }
    });

    emit(AddPropertyFormUpdated(DateTime.now()));
  }
}