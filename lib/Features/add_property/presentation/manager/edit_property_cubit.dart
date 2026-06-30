// lib/Features/add_property/presentation/manager/edit_property_cubit.dart

import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stay_match/Features/add_property/data/models/add_apartment_request.dart';
import 'package:stay_match/Features/add_property/data/models/add_room_request.dart';
import 'package:stay_match/Features/add_property/data/models/update_entire_property_request.dart';
import 'package:stay_match/Features/add_property/data/models/update_shared_property_request.dart';
import 'package:stay_match/Features/add_property/data/repos/add_property_repo.dart';
import 'package:stay_match/Features/my_properties/data/models/my_properties_response.dart';
import 'package:stay_match/Features/apartments/data/models/property_details_response.dart';
import 'package:stay_match/core/constants/app_strings.dart';

import '../../data/models/add_apartment_request.dart';
import '../../../filter/presentation/widgets/filter_helper.dart';
import '../../../apartments/data/models/property_details_response.dart';

part 'edit_property_state.dart';

class EditPropertyCubit extends Cubit<EditPropertyState> {
  final AddPropertyRepo addPropertyRepo;

  // ── identity ──
  int? propertyId;
  PropertyType propertyType = PropertyType.none;

  // ── requests (mirrors AddPropertyCubit) ──
  late AddApartmentRequest apartmentRequest;
  late AddRoomRequest roomRequest;

  // ── local images ──
  List<File> localImages = [];
  Map<int, List<File>> localRoomImages = {};

  // ── step tracking ──
  int _currentStep = 0;

  int get currentStep => _currentStep;

  EditPropertyCubit({required this.addPropertyRepo})
    : super(EditPropertyInitial());

  // ─────────────────────────────────────────────
  // LOAD
  // ─────────────────────────────────────────────

  Future<void> loadForEdit(Properties property) async {
    propertyId = property.id;
    propertyType = property.type?.toLowerCase() == 'shared'
        ? PropertyType.room
        : PropertyType.apartment;

    emit(EditPropertyLoading());

    final result = await addPropertyRepo.getPropertyDetails(id: property.id!);

    result.fold(
      (fail) => emit(EditPropertyFailure(errMessage: fail.errMessage)),
      (response) {
        final data = response.data;
        if (data == null) {
          emit(
            EditPropertyFailure(errMessage: 'Could not load property details'),
          );
          return;
        }

        if (propertyType == PropertyType.apartment) {
          _fillApartmentRequest(data);
        } else {
          _fillRoomRequest(data);
        }

        emit(EditPropertyLoaded(DateTime.now()));
      },
    );
  }

  void _fillApartmentRequest(PropertyDetailsData data) {
    apartmentRequest = AddApartmentRequest(
      name: data.name,
      description: data.description,
      monthlyRent: data.monthlyRent?.toInt() ?? 0,
      deposite: data.deposite?.toInt() ?? 0,
      furnished: data.furnished,
      availableFrom: data.availableFrom,
      numberOfBedrooms: data.numberOfBedrooms?.toInt() ?? 0,
      numberOfLivingRooms: data.numberOfLivingRooms?.toInt() ?? 0,
      numberOfEnSuiteBathrooms: data.numberOfEnSuiteBathrooms?.toInt() ?? 0,
      numberOfGuestBathrooms: data.numberOfGuestBathrooms?.toInt() ?? 0,
      street: data.street,
      city: data.city,
      government: data.government,
      latitude: data.latitude,
      longitude: data.longitude,
      size: data.size?.toInt() ?? 0,
      minimumStay: data.minimumStay?.toInt() ?? 1,
      isDraft: false,
      propertyImages:
          data.propertyImages?.map(
            (img) => AddApartmentRequestPropertyImages(
              id: img.id,
              imageUrl: img.imageUrl,
              isCover: img.isCover,
            ),
          ).toList() ??
          [],
      amenities: data.amenities != null
          ? AddApartmentRequestAmenities(
              wifi: data.amenities!.wifi,
              tv: data.amenities!.tv,
              cooktop: data.amenities!.cooktop,
              oven: data.amenities!.oven,
              kettle: data.amenities!.kettle,
              dishwasher: data.amenities!.dishwasher,
              refrigerator: data.amenities!.refrigerator,
              microwave: data.amenities!.microwave,
              washer: data.amenities!.washer,
              freeParking: data.amenities!.freeParking,
              airConditioning: data.amenities!.airConditioning,
              smokeAlarm: data.amenities!.smokeAlarm,
              fireExtinguisher: data.amenities!.fireExtinguisher,
            )
          : AddApartmentRequestAmenities(
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
      nearbyServices: data.nearbyServices != null
          ? AddApartmentRequestNearbyServices(
              hasGroceryStore: data.nearbyServices!.hasGroceryStore,
              hasPharmacy: data.nearbyServices!.hasPharmacy,
              hasHospital: data.nearbyServices!.hasHospital,
              hasSchool: data.nearbyServices!.hasSchool,
              hasUniversity: data.nearbyServices!.hasUniversity,
              hasPublicTransport: data.nearbyServices!.hasPublicTransport,
              hasParking: data.nearbyServices!.hasParking,
              hasMall: data.nearbyServices!.hasMall,
              hasRestaurants: data.nearbyServices!.hasRestaurants,
              hasPark: data.nearbyServices!.hasPark,
              hasGym: data.nearbyServices!.hasGym,
              isSafeArea: data.nearbyServices!.isSafeArea,
              hasPoliceStation: data.nearbyServices!.hasPoliceStation,
              isQuietArea: data.nearbyServices!.isQuietArea,
              hasChurchNearby: data.nearbyServices!.hasChurchNearby,
              hasMosqueNearby: data.nearbyServices!.hasMosqueNearby,
            )
          : AddApartmentRequestNearbyServices(
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
      allowedTenants: data.allowedTenants != null
          ? AddApartmentRequestAllowedTenants(
              allowsFamilies: data.allowedTenants!.allowsFamilies,
              allowsChildren: data.allowedTenants!.allowsChildren,
              allowsStudents: data.allowedTenants!.allowsStudents,
              studentGender: data.allowedTenants!.studentGender,
              allowsWorkers: data.allowedTenants!.allowsWorkers,
              workerGender: data.allowedTenants!.workerGender,
              petsAllowed: data.allowedTenants!.petsAllowed,
            )
          : AddApartmentRequestAllowedTenants(
              allowsFamilies: false,
              allowsChildren: false,
              allowsStudents: false,
              studentGender: 'any',
              allowsWorkers: false,
              workerGender: 'any',
              petsAllowed: false,
            ),
    );
    log('✅ Apartment request pre-filled: ${apartmentRequest.name}');
  }

  void _fillRoomRequest(PropertyDetailsData data) {
    roomRequest = AddRoomRequest(
      name: data.name,
      size: data.size?.toInt() ?? 0,
      description: data.description,
      totalRooms: data.numberOfBedrooms?.toInt() ?? 1,
      availableRooms: data.numberOfBedrooms?.toInt() ?? 1,
      street: data.street,
      city: data.city,
      government: data.government,
      latitude: data.latitude,
      longitude: data.longitude,
      isDraft: false,
      propertyImages:
          data.propertyImages
              ?.map(
                (img) => AddRoomRequestSharedPropertyImages(
                  id: img.id,
                  imageUrl: img.imageUrl,
                  isCover: img.isCover,
                ),
              )
              .toList() ??
          [],
      amenities: data.amenities != null
          ? AddRoomRequestPropertyAmenities(
              wifi: data.amenities!.wifi,
              tv: data.amenities!.tv,
              cooktop: data.amenities!.cooktop,
              oven: data.amenities!.oven,
              kettle: data.amenities!.kettle,
              dishwasher: data.amenities!.dishwasher,
              refrigerator: data.amenities!.refrigerator,
              microwave: data.amenities!.microwave,
              washer: data.amenities!.washer,
              freeParking: data.amenities!.freeParking,
              airConditioning: data.amenities!.airConditioning,
              smokeAlarm: data.amenities!.smokeAlarm,
              fireExtinguisher: data.amenities!.fireExtinguisher,
            )
          : AddRoomRequestPropertyAmenities(
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
      nearbyServices: AddRoomRequestNearbyServices(
        hasGroceryStore: data.nearbyServices?.hasGroceryStore ?? false,
        hasPharmacy: data.nearbyServices?.hasPharmacy ?? false,
        hasHospital: data.nearbyServices?.hasHospital ?? false,
        hasSchool: data.nearbyServices?.hasSchool ?? false,
        hasUniversity: data.nearbyServices?.hasUniversity ?? false,
        hasPublicTransport: data.nearbyServices?.hasPublicTransport ?? false,
        hasParking: data.nearbyServices?.hasParking ?? false,
        hasMall: data.nearbyServices?.hasMall ?? false,
        hasRestaurants: data.nearbyServices?.hasRestaurants ?? false,
        hasPark: data.nearbyServices?.hasPark ?? false,
        hasGym: data.nearbyServices?.hasGym ?? false,
        isSafeArea: data.nearbyServices?.isSafeArea ?? false,
        hasPoliceStation: data.nearbyServices?.hasPoliceStation ?? false,
        isQuietArea: data.nearbyServices?.isQuietArea ?? false,
        hasChurchNearby: data.nearbyServices?.hasChurchNearby ?? false,
        hasMosqueNearby: data.nearbyServices?.hasMosqueNearby ?? false,
      ),
      rooms: [
        AddRoomRequestRooms(
          roomName: data.name ?? 'Room 1',
          minimumStay: data.minimumStay?.toInt() ?? 1,
          monthRent: data.monthlyRent?.toInt() ?? 0,
          deposit: data.deposite?.toInt() ?? 0,
          furnished: data.furnished,
          availableFrom: data.availableFrom,
          capacity: 1,
          capacityAvailable: 1,
          enSuiteBathroom: false,
          sharedBathroom: true,
          balcony: false,
          window: true,
          petsAllowed: data.allowedTenants?.petsAllowed ?? false,
          propertyImages: [],
          roomAmenities: AddRoomRequestRoomAmenities(
            airConditioning: false,
            closet: false,
            mirror: false,
            fan: false,
          ),
          allowedTenants: AddRoomRequestAllowedTenants(
            allowsFamilies: data.allowedTenants?.allowsFamilies ?? false,
            allowsChildren: data.allowedTenants?.allowsChildren ?? false,
            allowsStudents: data.allowedTenants?.allowsStudents ?? false,
            studentGender: data.allowedTenants?.studentGender ?? 'any',
            allowsWorkers: data.allowedTenants?.allowsWorkers ?? false,
            workerGender: data.allowedTenants?.workerGender ?? 'any',
            petsAllowed: data.allowedTenants?.petsAllowed ?? false,
          ),
        ),
      ],
    );
    log('✅ Room request pre-filled: ${roomRequest.name}');
  }

  // ─────────────────────────────────────────────
  // SUBMIT (UPDATE)
  // ─────────────────────────────────────────────

  Future<void> submitUpdate() async {
    if (propertyId == null) return;
    if (propertyType == PropertyType.apartment) {
      await _updateApartment();
    } else {
      await _updateRoom();
    }
  }

  Future<void> _updateApartment() async {
    emit(EditPropertyLoading());

    // Keep existing remote images + upload new local ones
    final List<UpdateEntirePropertyRequestEntirePropertyImages> finalImages = [];

    for (var img in apartmentRequest.propertyImages ?? []) {
      if (img.imageUrl != null && img.imageUrl!.startsWith('http')) {
        finalImages.add(
          UpdateEntirePropertyRequestEntirePropertyImages(
            id: img.id,
            imageUrl: img.imageUrl,
            isCover: img.isCover,
          ),
        );
      }
    }

    for (int i = 0; i < localImages.length; i++) {
      final result = await addPropertyRepo.uploadPropertyImg(
        file: localImages[i].path,
        isCover: finalImages.isEmpty && i == 0,
      );
      result.fold((fail) => log('❌ Image upload failed: ${fail.errMessage}'), (
        resp,
      ) {
        if (resp.data?.imageUrl != null) {
          finalImages.add(
            UpdateEntirePropertyRequestEntirePropertyImages(
              imageUrl: resp.data!.imageUrl,
              isCover: finalImages.isEmpty,
            ),
          );
        }
      });
    }

    final request = UpdateEntirePropertyRequest(
      name: apartmentRequest.name,
      description: apartmentRequest.description,
      monthlyRent: apartmentRequest.monthlyRent?.toInt(),
      deposite: apartmentRequest.deposite?.toInt(),
      furnished: apartmentRequest.furnished,
      availableFrom: apartmentRequest.availableFrom,
      numberOfBedrooms: apartmentRequest.numberOfBedrooms,
      numberOfLivingRooms: apartmentRequest.numberOfLivingRooms,
      numberOfEnSuiteBathrooms: apartmentRequest.numberOfEnSuiteBathrooms,
      numberOfGuestBathrooms: apartmentRequest.numberOfGuestBathrooms,
      street: apartmentRequest.street,
      city: apartmentRequest.city,
      government: apartmentRequest.government,
      latitude: apartmentRequest.latitude?.toInt(),
      longitude: apartmentRequest.longitude?.toInt(),
      size: apartmentRequest.size?.toInt(),
      minimumStay: apartmentRequest.minimumStay,
      isDraft: false,
      propertyImages: finalImages,
      amenities: apartmentRequest.amenities != null
          ? UpdateEntirePropertyRequestAmenities(
              wifi: apartmentRequest.amenities!.wifi,
              tv: apartmentRequest.amenities!.tv,
              cooktop: apartmentRequest.amenities!.cooktop,
              oven: apartmentRequest.amenities!.oven,
              kettle: apartmentRequest.amenities!.kettle,
              dishwasher: apartmentRequest.amenities!.dishwasher,
              refrigerator: apartmentRequest.amenities!.refrigerator,
              microwave: apartmentRequest.amenities!.microwave,
              washer: apartmentRequest.amenities!.washer,
              freeParking: apartmentRequest.amenities!.freeParking,
              airConditioning: apartmentRequest.amenities!.airConditioning,
              smokeAlarm: apartmentRequest.amenities!.smokeAlarm,
              fireExtinguisher: apartmentRequest.amenities!.fireExtinguisher,
            )
          : null,
      nearbyServices: apartmentRequest.nearbyServices != null
          ? UpdateEntirePropertyRequestNearbyServices(
              hasGroceryStore: apartmentRequest.nearbyServices!.hasGroceryStore,
              hasPharmacy: apartmentRequest.nearbyServices!.hasPharmacy,
              hasHospital: apartmentRequest.nearbyServices!.hasHospital,
              hasSchool: apartmentRequest.nearbyServices!.hasSchool,
              hasUniversity: apartmentRequest.nearbyServices!.hasUniversity,
              hasPublicTransport:
                  apartmentRequest.nearbyServices!.hasPublicTransport,
              hasParking: apartmentRequest.nearbyServices!.hasParking,
              hasMall: apartmentRequest.nearbyServices!.hasMall,
              hasRestaurants: apartmentRequest.nearbyServices!.hasRestaurants,
              hasPark: apartmentRequest.nearbyServices!.hasPark,
              hasGym: apartmentRequest.nearbyServices!.hasGym,
              isSafeArea: apartmentRequest.nearbyServices!.isSafeArea,
              hasPoliceStation:
                  apartmentRequest.nearbyServices!.hasPoliceStation,
              isQuietArea: apartmentRequest.nearbyServices!.isQuietArea,
              hasChurchNearby: apartmentRequest.nearbyServices!.hasChurchNearby,
              hasMosqueNearby: apartmentRequest.nearbyServices!.hasMosqueNearby,
            )
          : null,
      allowedTenants: apartmentRequest.allowedTenants != null
          ? UpdateEntirePropertyRequestAllowedTenants(
              allowsFamilies: apartmentRequest.allowedTenants!.allowsFamilies,
              allowsChildren: apartmentRequest.allowedTenants!.allowsChildren,
              allowsStudents: apartmentRequest.allowedTenants!.allowsStudents,
              studentGender: apartmentRequest.allowedTenants!.studentGender,
              allowsWorkers: apartmentRequest.allowedTenants!.allowsWorkers,
              workerGender: apartmentRequest.allowedTenants!.workerGender,
              petsAllowed: apartmentRequest.allowedTenants!.petsAllowed,
            )
          : null,
    );

    final result = await addPropertyRepo.updateApartment(
      request: request,
      id: propertyId!,
    );
    result.fold(
      (fail) => emit(EditPropertyFailure(errMessage: fail.errMessage)),
      (success) {
        emit(
          EditPropertySuccess(
            message: 'Property updated successfully!',
            propertyId: success.data?.propertyId ?? propertyId!,
          ),
        );
      },
    );
  }

  Future<void> _updateRoom() async {
    emit(EditPropertyLoading());

    // Keep existing remote images + upload new local ones
    final List<UpdateSharedPropertyRequestSharedPropertyImages> finalImages = [];

    for (var img in roomRequest.propertyImages ?? []) {
      if (img.imageUrl != null && img.imageUrl!.startsWith('http')) {
        finalImages.add(
          UpdateSharedPropertyRequestSharedPropertyImages(
            id: img.id,
            imageUrl: img.imageUrl,
            isCover: img.isCover,
          ),
        );
      }
    }

    for (int i = 0; i < localImages.length; i++) {
      final result = await addPropertyRepo.uploadPropertyImg(
        file: localImages[i].path,
        isCover: finalImages.isEmpty && i == 0,
      );
      result.fold((fail) => log('❌ Image upload failed: ${fail.errMessage}'), (
        resp,
      ) {
        if (resp.data?.imageUrl != null) {
          finalImages.add(
            UpdateSharedPropertyRequestSharedPropertyImages(
              imageUrl: resp.data!.imageUrl,
              isCover: finalImages.isEmpty,
            ),
          );
        }
      });
    }

    // Upload room-level images
    final List<UpdateSharedPropertyRequestRooms> updatedRooms = [];
    for (int i = 0; i < (roomRequest.rooms?.length ?? 0); i++) {
      final room = roomRequest.rooms![i];
      final List<UpdateSharedPropertyRequestRoomPropertyImages> roomImages = [];

      // Keep existing remote room images
      for (var img in room.propertyImages ?? []) {
        if (img.imageUrl != null && img.imageUrl!.startsWith('http')) {
          roomImages.add(
            UpdateSharedPropertyRequestRoomPropertyImages(
              id: img.id,
              imageUrl: img.imageUrl,
              isCover: img.isCover,
            ),
          );
        }
      }

      // Upload new local room images
      if (localRoomImages.containsKey(i)) {
        for (int j = 0; j < localRoomImages[i]!.length; j++) {
          final result = await addPropertyRepo.uploadPropertyImg(
            file: localRoomImages[i]![j].path,
            isCover: roomImages.isEmpty && j == 0,
          );
          result.fold(
            (fail) => log('❌ Room image upload failed: ${fail.errMessage}'),
            (resp) {
              if (resp.data?.imageUrl != null) {
                roomImages.add(
                  UpdateSharedPropertyRequestRoomPropertyImages(
                    imageUrl: resp.data!.imageUrl,
                    isCover: roomImages.isEmpty,
                  ),
                );
              }
            },
          );
        }
      }

      updatedRooms.add(
        UpdateSharedPropertyRequestRooms(
          id: null,
          // backend handles room id matching
          roomName: room.roomName,
          monthRent: room.monthRent,
          deposit: room.deposit,
          furnished: room.furnished,
          availableFrom: room.availableFrom,
          minimumStay: room.minimumStay,
          capacity: room.capacity,
          capacityAvailable: room.capacityAvailable,
          enSuiteBathroom: room.enSuiteBathroom,
          sharedBathroom: room.sharedBathroom,
          balcony: room.balcony,
          window: room.window,
          petsAllowed: room.petsAllowed,
          propertyImages: roomImages,
          amenities: room.roomAmenities != null
              ? UpdateSharedPropertyRequestRoomAmenities(
                  airConditioning: room.roomAmenities!.airConditioning,
            wifi: roomRequest.amenities!.wifi,
            tv: roomRequest.amenities!.tv,
            cooktop: roomRequest.amenities!.cooktop,
            oven: roomRequest.amenities!.oven,
            kettle: roomRequest.amenities!.kettle,
            dishwasher: roomRequest.amenities!.dishwasher,
            refrigerator: roomRequest.amenities!.refrigerator,
            microwave: roomRequest.amenities!.microwave,
            washer: roomRequest.amenities!.washer,
            freeParking: roomRequest.amenities!.freeParking,
            smokeAlarm: roomRequest.amenities!.smokeAlarm,
            fireExtinguisher: roomRequest.amenities!.fireExtinguisher,
                )
              : null,
          allowedTenants: room.allowedTenants != null
              ? UpdateSharedPropertyRequestAllowedTenants(
                  allowsFamilies: room.allowedTenants!.allowsFamilies,
                  allowsChildren: room.allowedTenants!.allowsChildren,
                  allowsStudents: room.allowedTenants!.allowsStudents,
                  studentGender: room.allowedTenants!.studentGender,
                  allowsWorkers: room.allowedTenants!.allowsWorkers,
                  workerGender: room.allowedTenants!.workerGender,
                  petsAllowed: room.allowedTenants!.petsAllowed,
                )
              : null,
        ),
      );
    }

    final request = UpdateSharedPropertyRequest(
      name: roomRequest.name,
      size: roomRequest.size,
      description: roomRequest.description,
      totalRooms: roomRequest.totalRooms,
      availableRooms: roomRequest.availableRooms,
      street: roomRequest.street,
      city: roomRequest.city,
      government: roomRequest.government,
      latitude: roomRequest.latitude?.toInt(),
      longitude: roomRequest.longitude?.toInt(),
      isDraft: false,
      propertyImages: finalImages,
      rooms: updatedRooms,
      amenities: roomRequest.amenities != null
          ? UpdateSharedPropertyRequestPropertyAmenities(
              airConditioning: roomRequest.amenities!.airConditioning,
// todo: figure out why these aren't in anything
// closet: roomRequest.amenities!.closet,
//               mirror: roomRequest.amenities!.mirror,
//               fan: roomRequest.amenities!.fan,

            )
          : null,
      nearbyServices: roomRequest.nearbyServices != null
          ? UpdateSharedPropertyRequestNearbyServices(
              hasGroceryStore: roomRequest.nearbyServices!.hasGroceryStore,
              hasPharmacy: roomRequest.nearbyServices!.hasPharmacy,
              hasHospital: roomRequest.nearbyServices!.hasHospital,
              hasSchool: roomRequest.nearbyServices!.hasSchool,
              hasUniversity: roomRequest.nearbyServices!.hasUniversity,
              hasPublicTransport:
                  roomRequest.nearbyServices!.hasPublicTransport,
              hasParking: roomRequest.nearbyServices!.hasParking,
              hasMall: roomRequest.nearbyServices!.hasMall,
              hasRestaurants: roomRequest.nearbyServices!.hasRestaurants,
              hasPark: roomRequest.nearbyServices!.hasPark,
              hasGym: roomRequest.nearbyServices!.hasGym,
              isSafeArea: roomRequest.nearbyServices!.isSafeArea,
              hasPoliceStation: roomRequest.nearbyServices!.hasPoliceStation,
              isQuietArea: roomRequest.nearbyServices!.isQuietArea,
              hasChurchNearby: roomRequest.nearbyServices!.hasChurchNearby,
              hasMosqueNearby: roomRequest.nearbyServices!.hasMosqueNearby,
            )
          : null,
    );

    final result = await addPropertyRepo.updateRoom(
      request: request,
      id: propertyId!,
    );
    result.fold(
      (fail) => emit(EditPropertyFailure(errMessage: fail.errMessage)),
      (success) {
        emit(
          EditPropertySuccess(
            message: 'Property updated successfully!',
            propertyId: success.data?.propertyId ?? propertyId!,
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────
  // UI TOGGLE METHODS (mirrors AddPropertyCubit)
  // ─────────────────────────────────────────────

  void toggleFurnished({int? index}) {
    if (propertyType == PropertyType.apartment) {
      apartmentRequest.furnished = !(apartmentRequest.furnished ?? true);
    } else {
      final roomIndex = index ?? 0;
      roomRequest.rooms![roomIndex].furnished =
          !(roomRequest.rooms![roomIndex].furnished ?? true);
    }
    _refresh();
  }

  void toggleTenantType(String type) {
    final t = apartmentRequest.allowedTenants;
    if (t == null) return;
    switch (type) {
      case AppStrings.pets:
        t.petsAllowed = !(t.petsAllowed ?? false);
        break;
      case AppStrings.families:
        t.allowsFamilies = !(t.allowsFamilies ?? false);
        break;
      case AppStrings.children:
        t.allowsChildren = !(t.allowsChildren ?? false);
        break;
      case AppStrings.students:
        t.allowsStudents = !(t.allowsStudents ?? false);
        break;
      case AppStrings.workersProfessionals:
        t.allowsWorkers = !(t.allowsWorkers ?? false);
        break;
    }
    _refresh();
  }

  void toggleGenderType({required String genderType}) {
    apartmentRequest.allowedTenants?.studentGender = genderType;
    apartmentRequest.allowedTenants?.workerGender = genderType;
    _refresh();
  }

  void toggleAmenity(String key) {
    if (propertyType == PropertyType.apartment) {
      final json = apartmentRequest.amenities?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        apartmentRequest.amenities = AddApartmentRequestAmenities.fromJson(
          json,
        );
      }
    } else {
      final json = roomRequest.amenities?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        roomRequest.amenities = AddRoomRequestPropertyAmenities.fromJson(json);
      }
    }
    _refresh();
  }

  void toggleNearbyServices(String key) {
    if (propertyType == PropertyType.apartment) {
      final json = apartmentRequest.nearbyServices?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        apartmentRequest.nearbyServices = AddApartmentRequestNearbyServices.fromJson(
          json,
        );
      }
    } else {
      final json = roomRequest.nearbyServices?.toJson() ?? {};
      if (json.containsKey(key)) {
        json[key] = !(json[key] as bool);
        roomRequest.nearbyServices = AddRoomRequestNearbyServices.fromJson(
          json,
        );
      }
    }
    _refresh();
  }

  void updateCounter(String key, bool increase) {
    final change = increase ? 1 : -1;
    switch (key) {
      case AppStrings.bedrooms:
        if (apartmentRequest.numberOfBedrooms == 1 && !increase) break;
        apartmentRequest.numberOfBedrooms =
            (apartmentRequest.numberOfBedrooms ?? 1) + change;
        break;
      case AppStrings.livingRooms:
        if (apartmentRequest.numberOfLivingRooms == 1 && !increase) break;
        apartmentRequest.numberOfLivingRooms =
            (apartmentRequest.numberOfLivingRooms ?? 1) + change;
        break;
      case 'Min Stay':
        if (apartmentRequest.minimumStay == 1 && !increase) break;
        apartmentRequest.minimumStay =
            (apartmentRequest.minimumStay ?? 1) + change;
        break;
      case AppStrings.enSuiteBathrooms:
        if (apartmentRequest.numberOfEnSuiteBathrooms == 0 && !increase) break;
        apartmentRequest.numberOfEnSuiteBathrooms =
            (apartmentRequest.numberOfEnSuiteBathrooms ?? 0) + change;
        break;
      case AppStrings.guestBathrooms:
        if (apartmentRequest.numberOfGuestBathrooms == 0 && !increase) break;
        apartmentRequest.numberOfGuestBathrooms =
            (apartmentRequest.numberOfGuestBathrooms ?? 0) + change;
        break;
    }
    _refresh();
  }

  void updateRoomBasicData(
    int index, {
    int? minimumStay,
    String? name,
    int? rent,
    int? deposit,
    String? availableDate,
    bool? isEnSuite,
  }) {
    final room = roomRequest.rooms![index];
    if (name != null) room.roomName = name;
    if (rent != null) room.monthRent = rent;
    if (deposit != null) room.deposit = deposit;
    if (availableDate != null) room.availableFrom = availableDate;
    if (minimumStay != null) room.minimumStay = minimumStay;
    if (isEnSuite != null) {
      room.enSuiteBathroom = isEnSuite;
      room.sharedBathroom = !isEnSuite;
    }
    _refresh();
  }

  void updateRoomCapacity(int index, {int? total, int? available}) {
    final room = roomRequest.rooms![index];
    if (total != null) room.capacity = total;
    if (available != null) room.capacityAvailable = available;
    _refresh();
  }

  void toggleRoomKeyFeature(int index, String feature) {
    final room = roomRequest.rooms![index];
    if (feature == 'Balcony') room.balcony = !(room.balcony ?? false);
    if (feature == 'Window') room.window = !(room.window ?? false);
    if (feature == 'Pets') room.petsAllowed = !(room.petsAllowed ?? false);
    _refresh();
  }

  void toggleRoomAmenity(int index, String key) {
    final room = roomRequest.rooms![index];
    final json = room.roomAmenities?.toJson() ?? {};
    if (json.containsKey(key)) {
      json[key] = !(json[key] as bool);
      room.roomAmenities = AddRoomRequestRoomAmenities.fromJson(json);
      _refresh();
    }
  }

  void toggleRoomTenantType(int index, String type) {
    final tenants = roomRequest.rooms![index].allowedTenants;
    if (tenants == null) return;
    if (type == 'Students')
      tenants.allowsStudents = !(tenants.allowsStudents ?? false);
    if (type == 'Workers')
      tenants.allowsWorkers = !(tenants.allowsWorkers ?? false);
    if (type == 'Families')
      tenants.allowsFamilies = !(tenants.allowsFamilies ?? false);
    if (type == 'Children')
      tenants.allowsChildren = !(tenants.allowsChildren ?? false);
    _refresh();
  }

  void updateRoomGender(int index, String gender) {
    roomRequest.rooms![index].allowedTenants?.studentGender = gender;
    roomRequest.rooms![index].allowedTenants?.workerGender = gender;
    _refresh();
  }

  void updateLocation(double lat, double lng) {
    apartmentRequest.latitude = lat;
    apartmentRequest.longitude = lng;
    roomRequest.latitude = lat;
    roomRequest.longitude = lng;
    _refresh();
  }

  void updateSharedPropertyBasicInfo({
    String? name,
    int? totalRooms,
    int? availableRooms,
    int? size,
    String? description,
  }) {
    if (name != null) roomRequest.name = name;
    if (totalRooms != null) roomRequest.totalRooms = totalRooms;
    if (size != null) roomRequest.size = size;
    if (description != null) roomRequest.description = description;
    if (availableRooms != null) {
      roomRequest.availableRooms = availableRooms;
      int current = roomRequest.rooms?.length ?? 0;
      if (availableRooms > current) {
        for (int i = current; i < availableRooms; i++) {
          roomRequest.rooms?.add(
            AddRoomRequestRooms(
              roomName: 'Room ${i + 1}',
              minimumStay: 1,
              monthRent: 0,
              deposit: 0,
              furnished: true,
              availableFrom: DateTime.now().toIso8601String(),
              capacity: 1,
              capacityAvailable: 1,
              enSuiteBathroom: false,
              sharedBathroom: true,
              balcony: false,
              window: true,
              petsAllowed: false,
              propertyImages: [],
              roomAmenities: AddRoomRequestRoomAmenities(
                airConditioning: false,
                closet: false,
                mirror: false,
                fan: false,
              ),
              allowedTenants: AddRoomRequestAllowedTenants(
                allowsFamilies: false,
                allowsChildren: false,
                allowsStudents: false,
                studentGender: 'any',
                allowsWorkers: false,
                workerGender: 'Male',
                petsAllowed: false,
              ),
            ),
          );
        }
      } else {
        while ((roomRequest.rooms?.length ?? 0) > availableRooms) {
          roomRequest.rooms?.removeLast();
          localRoomImages.remove(roomRequest.rooms!.length);
        }
      }
    }
    _refresh();
  }

  void updateSharedPropertyLocation({
    String? state,
    String? city,
    String? street,
  }) {
    if (state != null) roomRequest.government = state;
    if (city != null) roomRequest.city = city;
    if (street != null) roomRequest.street = street;
    _refresh();
  }

  // ── images ──

  Future<void> pickImages() async {
    final List<XFile> picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      localImages.addAll(picked.map((x) => File(x.path)));
      _refresh();
    }
  }

  Future<void> pickRoomImages(int index) async {
    final List<XFile> picked = await ImagePicker().pickMultiImage();
    if (picked.isNotEmpty) {
      localRoomImages[index] = [
        ...(localRoomImages[index] ?? []),
        ...picked.map((x) => File(x.path)),
      ];
      _refresh();
    }
  }

  void removeImage(int index) {
    localImages.removeAt(index);
    _refresh();
  }

  // ── step ──

  void nextStep() {
    _currentStep++;
    _refresh();
  }

  void prevStep() {
    if (_currentStep > 0) _currentStep--;
    _refresh();
  }

  // ─────────────────────────────────────────────
  // PRIVATE
  // ─────────────────────────────────────────────

  void _refresh() => emit(EditPropertyLoaded(DateTime.now()));
}