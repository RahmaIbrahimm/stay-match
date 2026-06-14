/// name : "2 new string"
/// size : 30
/// description : "2 this is a new desc"
/// totalRooms : 2
/// availableRooms : 1
/// amenities : {"wifi":true,"tv":true,"cooktop":true,"oven":true,"kettle":true,"dishwasher":true,"refrigerator":true,"microwave":true,"washer":true,"freeParking":true,"airConditioning":true,"smokeAlarm":true,"fireExtinguisher":true}
/// nearbyServices : {"hasGroceryStore":true,"hasPharmacy":true,"hasHospital":true,"hasSchool":true,"hasUniversity":true,"hasPublicTransport":true,"hasParking":true,"hasMall":true,"hasRestaurants":true,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":true,"isQuietArea":true,"hasChurchNearby":true,"hasMosqueNearby":true}
/// street : "string"
/// city : "string"
/// government : "string"
/// latitude : 0
/// longitude : 0
/// propertyImages : [{"id":0,"imageUrl":"string","isCover":true}]
/// rooms : [{"id":0,"roomName":"string","month_rent":500,"deposit":0,"furnished":true,"availableFrom":"2026-05-29T01:05:31.378Z","minimumStay":1,"capacity":2,"capacityAvailable":1,"enSuiteBathroom":true,"sharedBathroom":true,"balcony":true,"window":true,"petsAllowed":true,"propertyImages":[{"id":0,"imageUrl":"string","isCover":true}],"amenities":{"airConditioning":true,"closet":true,"mirror":true,"fan":true},"allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"male","petsAllowed":true}}]
/// isDraft : false

class UpdateSharedPropertyRequest {
  UpdateSharedPropertyRequest({
      this.name, 
      this.size, 
      this.description, 
      this.totalRooms, 
      this.availableRooms, 
      this.amenities, 
      this.nearbyServices, 
      this.street, 
      this.city, 
      this.government, 
      this.latitude, 
      this.longitude, 
      this.propertyImages, 
      this.rooms, 
      this.isDraft,});

  UpdateSharedPropertyRequest.fromJson(dynamic json) {
    name = json['name'];
    size = json['size'];
    description = json['description'];
    totalRooms = json['totalRooms'];
    availableRooms = json['availableRooms'];
    amenities = json['amenities'] != null ? UpdateSharedPropertyRequestPropertyAmenities.fromJson(json['amenities']) : null;
    nearbyServices = json['nearbyServices'] != null ? UpdateSharedPropertyRequestNearbyServices.fromJson(json['nearbyServices']) : null;
    street = json['street'];
    city = json['city'];
    government = json['government'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(UpdateSharedPropertyRequestSharedPropertyImages.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(UpdateSharedPropertyRequestRooms.fromJson(v));
      });
    }
    isDraft = json['isDraft'];
  }
  String? name;
  int? size;
  String? description;
  int? totalRooms;
  int? availableRooms;
  UpdateSharedPropertyRequestPropertyAmenities? amenities;
  UpdateSharedPropertyRequestNearbyServices? nearbyServices;
  String? street;
  String? city;
  String? government;
  int? latitude;
  int? longitude;
  List<UpdateSharedPropertyRequestSharedPropertyImages>? propertyImages;
  List<UpdateSharedPropertyRequestRooms>? rooms;
  bool? isDraft;
UpdateSharedPropertyRequest copyWith({  String? name,
  int? size,
  String? description,
  int? totalRooms,
  int? availableRooms,
  UpdateSharedPropertyRequestPropertyAmenities? amenities,
  UpdateSharedPropertyRequestNearbyServices? nearbyServices,
  String? street,
  String? city,
  String? government,
  int? latitude,
  int? longitude,
  List<UpdateSharedPropertyRequestSharedPropertyImages>? propertyImages,
  List<UpdateSharedPropertyRequestRooms>? rooms,
  bool? isDraft,
}) => UpdateSharedPropertyRequest(  name: name ?? this.name,
  size: size ?? this.size,
  description: description ?? this.description,
  totalRooms: totalRooms ?? this.totalRooms,
  availableRooms: availableRooms ?? this.availableRooms,
  amenities: amenities ?? this.amenities,
  nearbyServices: nearbyServices ?? this.nearbyServices,
  street: street ?? this.street,
  city: city ?? this.city,
  government: government ?? this.government,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  propertyImages: propertyImages ?? this.propertyImages,
  rooms: rooms ?? this.rooms,
  isDraft: isDraft ?? this.isDraft,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['size'] = size;
    map['description'] = description;
    map['totalRooms'] = totalRooms;
    map['availableRooms'] = availableRooms;
    if (amenities != null) {
      map['amenities'] = amenities?.toJson();
    }
    if (nearbyServices != null) {
      map['nearbyServices'] = nearbyServices?.toJson();
    }
    map['street'] = street;
    map['city'] = city;
    map['government'] = government;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    if (propertyImages != null) {
      map['propertyImages'] = propertyImages?.map((v) => v.toJson()).toList();
    }
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    map['isDraft'] = isDraft;
    return map;
  }

}

/// id : 0
/// roomName : "string"
/// month_rent : 500
/// deposit : 0
/// furnished : true
/// availableFrom : "2026-05-29T01:05:31.378Z"
/// minimumStay : 1
/// capacity : 2
/// capacityAvailable : 1
/// enSuiteBathroom : true
/// sharedBathroom : true
/// balcony : true
/// window : true
/// petsAllowed : true
/// propertyImages : [{"id":0,"imageUrl":"string","isCover":true}]
/// amenities : {"airConditioning":true,"closet":true,"mirror":true,"fan":true}
/// allowedTenants : {"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"male","petsAllowed":true}

class UpdateSharedPropertyRequestRooms {
  UpdateSharedPropertyRequestRooms({
      this.id, 
      this.roomName, 
      this.monthRent, 
      this.deposit, 
      this.furnished, 
      this.availableFrom, 
      this.minimumStay, 
      this.capacity, 
      this.capacityAvailable, 
      this.enSuiteBathroom, 
      this.sharedBathroom, 
      this.balcony, 
      this.window, 
      this.petsAllowed, 
      this.propertyImages,
      this.amenities, 
      this.allowedTenants,});

  UpdateSharedPropertyRequestRooms.fromJson(dynamic json) {
    id = json['id'];
    roomName = json['roomName'];
    monthRent = json['month_rent'];
    deposit = json['deposit'];
    furnished = json['furnished'];
    availableFrom = json['availableFrom'];
    minimumStay = json['minimumStay'];
    capacity = json['capacity'];
    capacityAvailable = json['capacityAvailable'];
    enSuiteBathroom = json['enSuiteBathroom'];
    sharedBathroom = json['sharedBathroom'];
    balcony = json['balcony'];
    window = json['window'];
    petsAllowed = json['petsAllowed'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(UpdateSharedPropertyRequestRoomPropertyImages.fromJson(v));
      });
    }
    amenities = json['amenities'] != null ? UpdateSharedPropertyRequestRoomAmenities.fromJson(json['amenities']) : null;
    allowedTenants = json['allowedTenants'] != null ? UpdateSharedPropertyRequestAllowedTenants.fromJson(json['allowedTenants']) : null;
  }
  int? id;
  String? roomName;
  int? monthRent;
  int? deposit;
  bool? furnished;
  String? availableFrom;
  int? minimumStay;
  int? capacity;
  int? capacityAvailable;
  bool? enSuiteBathroom;
  bool? sharedBathroom;
  bool? balcony;
  bool? window;
  bool? petsAllowed;
  List<UpdateSharedPropertyRequestRoomPropertyImages>? propertyImages;
  UpdateSharedPropertyRequestRoomAmenities? amenities;
  UpdateSharedPropertyRequestAllowedTenants? allowedTenants;
UpdateSharedPropertyRequestRooms copyWith({  int? id,
  String? roomName,
  int? monthRent,
  int? deposit,
  bool? furnished,
  String? availableFrom,
  int? minimumStay,
  int? capacity,
  int? capacityAvailable,
  bool? enSuiteBathroom,
  bool? sharedBathroom,
  bool? balcony,
  bool? window,
  bool? petsAllowed,
  List<UpdateSharedPropertyRequestRoomPropertyImages>? propertyImages,
  UpdateSharedPropertyRequestRoomAmenities? amenities,
  UpdateSharedPropertyRequestAllowedTenants? allowedTenants,
}) => UpdateSharedPropertyRequestRooms(  id: id ?? this.id,
  roomName: roomName ?? this.roomName,
  monthRent: monthRent ?? this.monthRent,
  deposit: deposit ?? this.deposit,
  furnished: furnished ?? this.furnished,
  availableFrom: availableFrom ?? this.availableFrom,
  minimumStay: minimumStay ?? this.minimumStay,
  capacity: capacity ?? this.capacity,
  capacityAvailable: capacityAvailable ?? this.capacityAvailable,
  enSuiteBathroom: enSuiteBathroom ?? this.enSuiteBathroom,
  sharedBathroom: sharedBathroom ?? this.sharedBathroom,
  balcony: balcony ?? this.balcony,
  window: window ?? this.window,
  petsAllowed: petsAllowed ?? this.petsAllowed,
  propertyImages: propertyImages ?? this.propertyImages,
  amenities: amenities ?? this.amenities,
  allowedTenants: allowedTenants ?? this.allowedTenants,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roomName'] = roomName;
    map['month_rent'] = monthRent;
    map['deposit'] = deposit;
    map['furnished'] = furnished;
    map['availableFrom'] = availableFrom;
    map['minimumStay'] = minimumStay;
    map['capacity'] = capacity;
    map['capacityAvailable'] = capacityAvailable;
    map['enSuiteBathroom'] = enSuiteBathroom;
    map['sharedBathroom'] = sharedBathroom;
    map['balcony'] = balcony;
    map['window'] = window;
    map['petsAllowed'] = petsAllowed;
    if (propertyImages != null) {
      map['propertyImages'] = propertyImages?.map((v) => v.toJson()).toList();
    }
    if (amenities != null) {
      map['amenities'] = amenities?.toJson();
    }
    if (allowedTenants != null) {
      map['allowedTenants'] = allowedTenants?.toJson();
    }
    return map;
  }

}

/// allowsFamilies : true
/// allowsChildren : true
/// allowsStudents : true
/// studentGender : "any"
/// allowsWorkers : true
/// workerGender : "male"
/// petsAllowed : true

class UpdateSharedPropertyRequestAllowedTenants {
  UpdateSharedPropertyRequestAllowedTenants({
      this.allowsFamilies, 
      this.allowsChildren, 
      this.allowsStudents, 
      this.studentGender, 
      this.allowsWorkers, 
      this.workerGender, 
      this.petsAllowed,});

  UpdateSharedPropertyRequestAllowedTenants.fromJson(dynamic json) {
    allowsFamilies = json['allowsFamilies'];
    allowsChildren = json['allowsChildren'];
    allowsStudents = json['allowsStudents'];
    studentGender = json['studentGender'];
    allowsWorkers = json['allowsWorkers'];
    workerGender = json['workerGender'];
    petsAllowed = json['petsAllowed'];
  }
  bool? allowsFamilies;
  bool? allowsChildren;
  bool? allowsStudents;
  String? studentGender;
  bool? allowsWorkers;
  String? workerGender;
  bool? petsAllowed;
UpdateSharedPropertyRequestAllowedTenants copyWith({  bool? allowsFamilies,
  bool? allowsChildren,
  bool? allowsStudents,
  String? studentGender,
  bool? allowsWorkers,
  String? workerGender,
  bool? petsAllowed,
}) => UpdateSharedPropertyRequestAllowedTenants(  allowsFamilies: allowsFamilies ?? this.allowsFamilies,
  allowsChildren: allowsChildren ?? this.allowsChildren,
  allowsStudents: allowsStudents ?? this.allowsStudents,
  studentGender: studentGender ?? this.studentGender,
  allowsWorkers: allowsWorkers ?? this.allowsWorkers,
  workerGender: workerGender ?? this.workerGender,
  petsAllowed: petsAllowed ?? this.petsAllowed,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allowsFamilies'] = allowsFamilies;
    map['allowsChildren'] = allowsChildren;
    map['allowsStudents'] = allowsStudents;
    map['studentGender'] = studentGender;
    map['allowsWorkers'] = allowsWorkers;
    map['workerGender'] = workerGender;
    map['petsAllowed'] = petsAllowed;
    return map;
  }

}

/// airConditioning : true
/// closet : true
/// mirror : true
/// fan : true

class UpdateSharedPropertyRequestPropertyAmenities {
  UpdateSharedPropertyRequestPropertyAmenities({
      this.airConditioning, 
      this.closet, 
      this.mirror, 
      this.fan,});

  UpdateSharedPropertyRequestPropertyAmenities.fromJson(dynamic json) {
    airConditioning = json['airConditioning'];
    closet = json['closet'];
    mirror = json['mirror'];
    fan = json['fan'];
  }
  bool? airConditioning;
  bool? closet;
  bool? mirror;
  bool? fan;
UpdateSharedPropertyRequestPropertyAmenities copyWith({  bool? airConditioning,
  bool? closet,
  bool? mirror,
  bool? fan,
}) => UpdateSharedPropertyRequestPropertyAmenities(  airConditioning: airConditioning ?? this.airConditioning,
  closet: closet ?? this.closet,
  mirror: mirror ?? this.mirror,
  fan: fan ?? this.fan,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['airConditioning'] = airConditioning;
    map['closet'] = closet;
    map['mirror'] = mirror;
    map['fan'] = fan;
    return map;
  }

}

/// id : 0
/// imageUrl : "string"
/// isCover : true

class UpdateSharedPropertyRequestRoomPropertyImages {
  UpdateSharedPropertyRequestRoomPropertyImages({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  UpdateSharedPropertyRequestRoomPropertyImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;
UpdateSharedPropertyRequestRoomPropertyImages copyWith({  int? id,
  String? imageUrl,
  bool? isCover,
}) => UpdateSharedPropertyRequestRoomPropertyImages(  id: id ?? this.id,
  imageUrl: imageUrl ?? this.imageUrl,
  isCover: isCover ?? this.isCover,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['imageUrl'] = imageUrl;
    map['isCover'] = isCover;
    return map;
  }

}

/// id : 0
/// imageUrl : "string"
/// isCover : true

class UpdateSharedPropertyRequestSharedPropertyImages {
  UpdateSharedPropertyRequestSharedPropertyImages({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  UpdateSharedPropertyRequestSharedPropertyImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;
UpdateSharedPropertyRequestSharedPropertyImages copyWith({  int? id,
  String? imageUrl,
  bool? isCover,
}) => UpdateSharedPropertyRequestSharedPropertyImages(  id: id ?? this.id,
  imageUrl: imageUrl ?? this.imageUrl,
  isCover: isCover ?? this.isCover,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['imageUrl'] = imageUrl;
    map['isCover'] = isCover;
    return map;
  }

}

/// hasGroceryStore : true
/// hasPharmacy : true
/// hasHospital : true
/// hasSchool : true
/// hasUniversity : true
/// hasPublicTransport : true
/// hasParking : true
/// hasMall : true
/// hasRestaurants : true
/// hasPark : true
/// hasGym : true
/// isSafeArea : true
/// hasPoliceStation : true
/// isQuietArea : true
/// hasChurchNearby : true
/// hasMosqueNearby : true

class UpdateSharedPropertyRequestNearbyServices {
  UpdateSharedPropertyRequestNearbyServices({
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
      this.hasMosqueNearby,});

  UpdateSharedPropertyRequestNearbyServices.fromJson(dynamic json) {
    hasGroceryStore = json['hasGroceryStore'];
    hasPharmacy = json['hasPharmacy'];
    hasHospital = json['hasHospital'];
    hasSchool = json['hasSchool'];
    hasUniversity = json['hasUniversity'];
    hasPublicTransport = json['hasPublicTransport'];
    hasParking = json['hasParking'];
    hasMall = json['hasMall'];
    hasRestaurants = json['hasRestaurants'];
    hasPark = json['hasPark'];
    hasGym = json['hasGym'];
    isSafeArea = json['isSafeArea'];
    hasPoliceStation = json['hasPoliceStation'];
    isQuietArea = json['isQuietArea'];
    hasChurchNearby = json['hasChurchNearby'];
    hasMosqueNearby = json['hasMosqueNearby'];
  }
  bool? hasGroceryStore;
  bool? hasPharmacy;
  bool? hasHospital;
  bool? hasSchool;
  bool? hasUniversity;
  bool? hasPublicTransport;
  bool? hasParking;
  bool? hasMall;
  bool? hasRestaurants;
  bool? hasPark;
  bool? hasGym;
  bool? isSafeArea;
  bool? hasPoliceStation;
  bool? isQuietArea;
  bool? hasChurchNearby;
  bool? hasMosqueNearby;
UpdateSharedPropertyRequestNearbyServices copyWith({  bool? hasGroceryStore,
  bool? hasPharmacy,
  bool? hasHospital,
  bool? hasSchool,
  bool? hasUniversity,
  bool? hasPublicTransport,
  bool? hasParking,
  bool? hasMall,
  bool? hasRestaurants,
  bool? hasPark,
  bool? hasGym,
  bool? isSafeArea,
  bool? hasPoliceStation,
  bool? isQuietArea,
  bool? hasChurchNearby,
  bool? hasMosqueNearby,
}) => UpdateSharedPropertyRequestNearbyServices(  hasGroceryStore: hasGroceryStore ?? this.hasGroceryStore,
  hasPharmacy: hasPharmacy ?? this.hasPharmacy,
  hasHospital: hasHospital ?? this.hasHospital,
  hasSchool: hasSchool ?? this.hasSchool,
  hasUniversity: hasUniversity ?? this.hasUniversity,
  hasPublicTransport: hasPublicTransport ?? this.hasPublicTransport,
  hasParking: hasParking ?? this.hasParking,
  hasMall: hasMall ?? this.hasMall,
  hasRestaurants: hasRestaurants ?? this.hasRestaurants,
  hasPark: hasPark ?? this.hasPark,
  hasGym: hasGym ?? this.hasGym,
  isSafeArea: isSafeArea ?? this.isSafeArea,
  hasPoliceStation: hasPoliceStation ?? this.hasPoliceStation,
  isQuietArea: isQuietArea ?? this.isQuietArea,
  hasChurchNearby: hasChurchNearby ?? this.hasChurchNearby,
  hasMosqueNearby: hasMosqueNearby ?? this.hasMosqueNearby,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasGroceryStore'] = hasGroceryStore;
    map['hasPharmacy'] = hasPharmacy;
    map['hasHospital'] = hasHospital;
    map['hasSchool'] = hasSchool;
    map['hasUniversity'] = hasUniversity;
    map['hasPublicTransport'] = hasPublicTransport;
    map['hasParking'] = hasParking;
    map['hasMall'] = hasMall;
    map['hasRestaurants'] = hasRestaurants;
    map['hasPark'] = hasPark;
    map['hasGym'] = hasGym;
    map['isSafeArea'] = isSafeArea;
    map['hasPoliceStation'] = hasPoliceStation;
    map['isQuietArea'] = isQuietArea;
    map['hasChurchNearby'] = hasChurchNearby;
    map['hasMosqueNearby'] = hasMosqueNearby;
    return map;
  }

}

/// wifi : true
/// tv : true
/// cooktop : true
/// oven : true
/// kettle : true
/// dishwasher : true
/// refrigerator : true
/// microwave : true
/// washer : true
/// freeParking : true
/// airConditioning : true
/// smokeAlarm : true
/// fireExtinguisher : true

class UpdateSharedPropertyRequestRoomAmenities {
  UpdateSharedPropertyRequestRoomAmenities({
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
      this.fireExtinguisher,});

  UpdateSharedPropertyRequestRoomAmenities.fromJson(dynamic json) {
    wifi = json['wifi'];
    tv = json['tv'];
    cooktop = json['cooktop'];
    oven = json['oven'];
    kettle = json['kettle'];
    dishwasher = json['dishwasher'];
    refrigerator = json['refrigerator'];
    microwave = json['microwave'];
    washer = json['washer'];
    freeParking = json['freeParking'];
    airConditioning = json['airConditioning'];
    smokeAlarm = json['smokeAlarm'];
    fireExtinguisher = json['fireExtinguisher'];
  }
  bool? wifi;
  bool? tv;
  bool? cooktop;
  bool? oven;
  bool? kettle;
  bool? dishwasher;
  bool? refrigerator;
  bool? microwave;
  bool? washer;
  bool? freeParking;
  bool? airConditioning;
  bool? smokeAlarm;
  bool? fireExtinguisher;
UpdateSharedPropertyRequestRoomAmenities copyWith({  bool? wifi,
  bool? tv,
  bool? cooktop,
  bool? oven,
  bool? kettle,
  bool? dishwasher,
  bool? refrigerator,
  bool? microwave,
  bool? washer,
  bool? freeParking,
  bool? airConditioning,
  bool? smokeAlarm,
  bool? fireExtinguisher,
}) => UpdateSharedPropertyRequestRoomAmenities(  wifi: wifi ?? this.wifi,
  tv: tv ?? this.tv,
  cooktop: cooktop ?? this.cooktop,
  oven: oven ?? this.oven,
  kettle: kettle ?? this.kettle,
  dishwasher: dishwasher ?? this.dishwasher,
  refrigerator: refrigerator ?? this.refrigerator,
  microwave: microwave ?? this.microwave,
  washer: washer ?? this.washer,
  freeParking: freeParking ?? this.freeParking,
  airConditioning: airConditioning ?? this.airConditioning,
  smokeAlarm: smokeAlarm ?? this.smokeAlarm,
  fireExtinguisher: fireExtinguisher ?? this.fireExtinguisher,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wifi'] = wifi;
    map['tv'] = tv;
    map['cooktop'] = cooktop;
    map['oven'] = oven;
    map['kettle'] = kettle;
    map['dishwasher'] = dishwasher;
    map['refrigerator'] = refrigerator;
    map['microwave'] = microwave;
    map['washer'] = washer;
    map['freeParking'] = freeParking;
    map['airConditioning'] = airConditioning;
    map['smokeAlarm'] = smokeAlarm;
    map['fireExtinguisher'] = fireExtinguisher;
    return map;
  }

}