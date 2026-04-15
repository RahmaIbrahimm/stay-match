// To parse this JSON data, do
//
//     final roomDetailsResponse = roomDetailsResponseFromJson(jsonString);

import 'dart:convert';

RoomDetailsResponse roomDetailsResponseFromJson(String str) =>
    RoomDetailsResponse.fromJson(json.decode(str));

String roomDetailsResponseToJson(RoomDetailsResponse data) =>
    json.encode(data.toJson());

class RoomDetailsResponse {
  final bool? isSuccess;
  final String? message;
  final RoomData? data;

  RoomDetailsResponse({this.isSuccess, this.message, this.data});

  factory RoomDetailsResponse.fromJson(Map<String, dynamic> json) =>
      RoomDetailsResponse(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: json["data"] == null ? null : RoomData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": data?.toJson(),
  };
}

class RoomData {
  final int? id;
  final String? hostId;
  final String? hostName;
  final String? roomName;
  final int? monthRent;
  final int? deposit;
  final bool? furnished;
  final String? availableFrom;
  final AllowedTenants? allowedTenants;
  final RoomAmenities? amenities;
  final NearbyServices? nearbyServices;
  final String? street;
  final String? city;
  final String? government;
  final double? latitude;
  final double? longitude;
  final int? size;
  final List<PropertyImage>? propertyImages;
  final int? minimumStay;
  final int? capacity;
  final int? capacityAvailable;
  final bool? enSuiteBathroom;
  final bool? sharedBathroom;
  final bool? balcony;
  final bool? window;
  final bool? petsAllowed;
  final List<BlockedPeriod>? blockedPeriods;
  final List<Bed>? beds;

  RoomData({
    this.id,
    this.hostId,
    this.hostName,
    this.roomName,
    this.monthRent,
    this.deposit,
    this.furnished,
    this.availableFrom,
    this.allowedTenants,
    this.amenities,
    this.nearbyServices,
    this.street,
    this.city,
    this.government,
    this.latitude,
    this.longitude,
    this.size,
    this.propertyImages,
    this.minimumStay,
    this.capacity,
    this.capacityAvailable,
    this.enSuiteBathroom,
    this.sharedBathroom,
    this.balcony,
    this.window,
    this.petsAllowed,
    this.blockedPeriods,
    this.beds,
  });

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
    id: json["id"],
    hostId: json["hostId"],
    hostName: json["hostName"],
    roomName: json["roomName"],
    monthRent: json["month_rent"],
    deposit: json["deposit"],
    furnished: json["furnished"],
    availableFrom: json["availableFrom"],
    allowedTenants: json["allowedTenants"] == null
        ? null
        : AllowedTenants.fromJson(json["allowedTenants"]),
    amenities: json["amenities"] == null
        ? null
        : RoomAmenities.fromJson(json["amenities"]),
    nearbyServices: json["nearbyServices"] == null
        ? null
        : NearbyServices.fromJson(json["nearbyServices"]),
    street: json["street"],
    city: json["city"],
    government: json["government"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    size: json["size"],
    propertyImages: json["propertyImages"] == null
        ? []
        : List<PropertyImage>.from(
            json["propertyImages"]!.map((x) => PropertyImage.fromJson(x)),
          ),
    minimumStay: json["minimumStay"],
    capacity: json["capacity"],
    capacityAvailable: json["capacityAvailable"],
    enSuiteBathroom: json["enSuiteBathroom"],
    sharedBathroom: json["sharedBathroom"],
    balcony: json["balcony"],
    window: json["window"],
    petsAllowed: json["petsAllowed"],
    blockedPeriods: json["blockedPeriods"] == null
        ? []
        : List<BlockedPeriod>.from(
            json["blockedPeriods"]!.map((x) => BlockedPeriod.fromJson(x)),
          ),
    beds: json["beds"] == null
        ? []
        : List<Bed>.from(json["beds"]!.map((x) => Bed.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hostId": hostId,
    "hostName": hostName,
    "roomName": roomName,
    "month_rent": monthRent,
    "deposit": deposit,
    "furnished": furnished,
    "availableFrom": availableFrom,
    "allowedTenants": allowedTenants?.toJson(),
    "amenities": amenities?.toJson(),
    "nearbyServices": nearbyServices?.toJson(),
    "street": street,
    "city": city,
    "government": government,
    "latitude": latitude,
    "longitude": longitude,
    "size": size,
    "propertyImages": propertyImages?.map((x) => x.toJson()).toList(),
    "minimumStay": minimumStay,
    "capacity": capacity,
    "capacityAvailable": capacityAvailable,
    "enSuiteBathroom": enSuiteBathroom,
    "sharedBathroom": sharedBathroom,
    "balcony": balcony,
    "window": window,
    "petsAllowed": petsAllowed,
    "blockedPeriods": blockedPeriods?.map((x) => x.toJson()).toList(),
    "beds": beds?.map((x) => x.toJson()).toList(),
  };
}

class AllowedTenants {
  final bool? allowsFamilies;
  final bool? allowsChildren;
  final bool? allowsStudents;
  final String? studentGender;
  final bool? allowsWorkers;
  final String? workerGender;
  final bool? petsAllowed;

  AllowedTenants({
    this.allowsFamilies,
    this.allowsChildren,
    this.allowsStudents,
    this.studentGender,
    this.allowsWorkers,
    this.workerGender,
    this.petsAllowed,
  });

  factory AllowedTenants.fromJson(Map<String, dynamic> json) => AllowedTenants(
    allowsFamilies: json["allowsFamilies"],
    allowsChildren: json["allowsChildren"],
    allowsStudents: json["allowsStudents"],
    studentGender: json["studentGender"],
    allowsWorkers: json["allowsWorkers"],
    workerGender: json["workerGender"],
    petsAllowed: json["petsAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "allowsFamilies": allowsFamilies,
    "allowsChildren": allowsChildren,
    "allowsStudents": allowsStudents,
    "studentGender": studentGender,
    "allowsWorkers": allowsWorkers,
    "workerGender": workerGender,
    "petsAllowed": petsAllowed,
  };
}

class RoomAmenities {
  final bool? wifi;
  final bool? tv;
  final bool? cooktop;
  final bool? oven;
  final bool? kettle;
  final bool? dishwasher;
  final bool? refrigerator;
  final bool? microwave;
  final bool? washer;
  final bool? freeParking;
  final bool? airConditioning;
  final bool? smokeAlarm;
  final bool? fireExtinguisher;

  RoomAmenities({
    this.wifi,
    this.tv,
    this.cooktop,
    this.oven,
    this.kettle,
    this.dishwasher,
    this.refrigerator,
    this.microwave,
    this.washer,
    this.freeParking,
    this.airConditioning,
    this.smokeAlarm,
    this.fireExtinguisher,
  });

  factory RoomAmenities.fromJson(Map<String, dynamic> json) => RoomAmenities(
    wifi: json["wifi"],
    tv: json["tv"],
    cooktop: json["cooktop"],
    oven: json["oven"],
    kettle: json["kettle"],
    dishwasher: json["dishwasher"],
    refrigerator: json["refrigerator"],
    microwave: json["microwave"],
    washer: json["washer"],
    freeParking: json["freeParking"],
    airConditioning: json["airConditioning"],
    smokeAlarm: json["smokeAlarm"],
    fireExtinguisher: json["fireExtinguisher"],
  );

  Map<String, dynamic> toJson() => {
    "wifi": wifi,
    "tv": tv,
    "cooktop": cooktop,
    "oven": oven,
    "kettle": kettle,
    "dishwasher": dishwasher,
    "refrigerator": refrigerator,
    "microwave": microwave,
    "washer": washer,
    "freeParking": freeParking,
    "airConditioning": airConditioning,
    "smokeAlarm": smokeAlarm,
    "fireExtinguisher": fireExtinguisher,
  };
}

class NearbyServices {
  final bool? hasGroceryStore;
  final bool? hasPharmacy;
  final bool? hasHospital;
  final bool? hasSchool;
  final bool? hasUniversity;
  final bool? hasPublicTransport;
  final bool? hasParking;
  final bool? hasMall;
  final bool? hasRestaurants;
  final bool? hasPark;
  final bool? hasGym;
  final bool? isSafeArea;
  final bool? hasPoliceStation;
  final bool? isQuietArea;
  final bool? hasChurchNearby;
  final bool? hasMosqueNearby;

  NearbyServices({
    this.hasGroceryStore,
    this.hasPharmacy,
    this.hasHospital,
    this.hasSchool,
    this.hasUniversity,
    this.hasPublicTransport,
    this.hasParking,
    this.hasMall,
    this.hasRestaurants,
    this.hasPark,
    this.hasGym,
    this.isSafeArea,
    this.hasPoliceStation,
    this.isQuietArea,
    this.hasChurchNearby,
    this.hasMosqueNearby,
  });

  factory NearbyServices.fromJson(Map<String, dynamic> json) => NearbyServices(
    hasGroceryStore: json["hasGroceryStore"],
    hasPharmacy: json["hasPharmacy"],
    hasHospital: json["hasHospital"],
    hasSchool: json["hasSchool"],
    hasUniversity: json["hasUniversity"],
    hasPublicTransport: json["hasPublicTransport"],
    hasParking: json["hasParking"],
    hasMall: json["hasMall"],
    hasRestaurants: json["hasRestaurants"],
    hasPark: json["hasPark"],
    hasGym: json["hasGym"],
    isSafeArea: json["isSafeArea"],
    hasPoliceStation: json["hasPoliceStation"],
    isQuietArea: json["isQuietArea"],
    hasChurchNearby: json["hasChurchNearby"],
    hasMosqueNearby: json["hasMosqueNearby"],
  );

  Map<String, dynamic> toJson() => {
    "hasGroceryStore": hasGroceryStore,
    "hasPharmacy": hasPharmacy,
    "hasHospital": hasHospital,
    "hasSchool": hasSchool,
    "hasUniversity": hasUniversity,
    "hasPublicTransport": hasPublicTransport,
    "hasParking": hasParking,
    "hasMall": hasMall,
    "hasRestaurants": hasRestaurants,
    "hasPark": hasPark,
    "hasGym": hasGym,
    "isSafeArea": isSafeArea,
    "hasPoliceStation": hasPoliceStation,
    "isQuietArea": isQuietArea,
    "hasChurchNearby": hasChurchNearby,
    "hasMosqueNearby": hasMosqueNearby,
  };
}

class PropertyImage {
  final int? id;
  final String? imageUrl;
  final bool? isCover;

  PropertyImage({this.id, this.imageUrl, this.isCover});

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
    id: json["id"],
    imageUrl: json["imageUrl"],
    isCover: json["isCover"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imageUrl": imageUrl,
    "isCover": isCover,
  };
}

class BlockedPeriod {
  final String? from;
  final String? to;

  BlockedPeriod({this.from, this.to});

  factory BlockedPeriod.fromJson(Map<String, dynamic> json) =>
      BlockedPeriod(from: json["from"], to: json["to"]);

  Map<String, dynamic> toJson() => {"from": from, "to": to};
}

class Bed {
  final int? bedNumber;
  final List<BlockedPeriod>? blockedPeriods;

  Bed({this.bedNumber, this.blockedPeriods});

  factory Bed.fromJson(Map<String, dynamic> json) => Bed(
    bedNumber: json["bedNumber"],
    blockedPeriods: json["blockedPeriods"] == null
        ? []
        : List<BlockedPeriod>.from(
            json["blockedPeriods"]!.map((x) => BlockedPeriod.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "bedNumber": bedNumber,
    "blockedPeriods": blockedPeriods?.map((x) => x.toJson()).toList(),
  };
}