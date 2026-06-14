/// name : "room1234567"
/// size : 0
/// description : "string"
/// totalRooms : 0
/// availableRooms : 0
/// amenities : {"wifi":true,"tv":true,"cooktop":true,"oven":true,"kettle":true,"dishwasher":true,"refrigerator":true,"microwave":true,"washer":true,"freeParking":true,"airConditioning":true,"smokeAlarm":true,"fireExtinguisher":true}
/// nearbyServices : {"hasGroceryStore":true,"hasPharmacy":true,"hasHospital":true,"hasSchool":true,"hasUniversity":true,"hasPublicTransport":true,"hasParking":true,"hasMall":true,"hasRestaurants":true,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":true,"isQuietArea":true,"hasChurchNearby":true,"hasMosqueNearby":true}
/// street : "string"
/// city : "string"
/// government : "string"
/// latitude : 0
/// longitude : 0
/// propertyImages : [{"id":0,"imageUrl":"string","isCover":true}]
/// rooms : [{"roomName":"string","minimumStay":0,"month_rent":0,"deposit":0,"furnished":true,"availableFrom":"2026-04-12T22:15:07.100Z","capacity":0,"capacityAvailable":0,"enSuiteBathroom":true,"sharedBathroom":true,"balcony":true,"window":true,"petsAllowed":true,"propertyImages":[{"id":0,"imageUrl":"string","isCover":true}],"amenities":{"airConditioning":true,"closet":true,"mirror":true,"fan":true},"allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"Male","petsAllowed":true}}]
/// isDraft : true

class AddRoomRequest {
  AddRoomRequest({
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

  AddRoomRequest.fromJson(dynamic json) {
    name = json['name'];
    size = json['size'];
    description = json['description'];
    totalRooms = json['totalRooms'];
    availableRooms = json['availableRooms'];
    amenities = json['amenities'] != null ? AddRoomRequestPropertyAmenities.fromJson(json['amenities']) : null;
    nearbyServices = json['nearbyServices'] != null ? AddRoomRequestNearbyServices.fromJson(json['nearbyServices']) : null;
    street = json['street'];
    city = json['city'];
    government = json['government'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(AddRoomRequestSharedPropertyImages.fromJson(v));
      });
    }
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(AddRoomRequestRooms.fromJson(v));
      });
    }
    isDraft = json['isDraft'];
  }
  String? name;
  int? size;
  String? description;
  int? totalRooms;
  int? availableRooms;
  AddRoomRequestPropertyAmenities? amenities;
  AddRoomRequestNearbyServices? nearbyServices;
  String? street;
  String? city;
  String? government;
  double? latitude;
  double? longitude;
  List<AddRoomRequestSharedPropertyImages>? propertyImages;
  List<AddRoomRequestRooms>? rooms;
  bool? isDraft;

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

/// roomName : "string"
/// minimumStay : 0
/// month_rent : 0
/// deposit : 0
/// furnished : true
/// availableFrom : "2026-04-12T22:15:07.100Z"
/// capacity : 0
/// capacityAvailable : 0
/// enSuiteBathroom : true
/// sharedBathroom : true
/// balcony : true
/// window : true
/// petsAllowed : true
/// propertyImages : [{"id":0,"imageUrl":"string","isCover":true}]
/// amenities : {"airConditioning":true,"closet":true,"mirror":true,"fan":true}
/// allowedTenants : {"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"Male","petsAllowed":true}

class AddRoomRequestRooms {
  AddRoomRequestRooms({
      this.roomName, 
      this.minimumStay, 
      this.monthRent, 
      this.deposit, 
      this.furnished, 
      this.availableFrom, 
      this.capacity, 
      this.capacityAvailable, 
      this.enSuiteBathroom, 
      this.sharedBathroom, 
      this.balcony, 
      this.window, 
      this.petsAllowed, 
      this.propertyImages, 
      this.roomAmenities,
      this.allowedTenants,});

  AddRoomRequestRooms.fromJson(dynamic json) {
    roomName = json['roomName'];
    minimumStay = json['minimumStay'];
    monthRent = json['month_rent'];
    deposit = json['deposit'];
    furnished = json['furnished'];
    availableFrom = json['availableFrom'];
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
        propertyImages?.add(AddRoomRequestSharedPropertyImages.fromJson(v));
      });
    }
    roomAmenities = json['amenities'] != null ? AddRoomRequestRoomAmenities.fromJson(json['amenities']) : null;
    allowedTenants = json['allowedTenants'] != null ? AddRoomRequestAllowedTenants.fromJson(json['allowedTenants']) : null;
  }
  String? roomName;
  int? minimumStay;
  int? monthRent;
  int? deposit;
  bool? furnished;
  String? availableFrom;
  int? capacity;
  int? capacityAvailable;
  bool? enSuiteBathroom;
  bool? sharedBathroom;
  bool? balcony;
  bool? window;
  bool? petsAllowed;
  List<AddRoomRequestSharedPropertyImages>? propertyImages;
  AddRoomRequestRoomAmenities? roomAmenities;
  AddRoomRequestAllowedTenants? allowedTenants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roomName'] = roomName;
    map['minimumStay'] = minimumStay;
    map['month_rent'] = monthRent;
    map['deposit'] = deposit;
    map['furnished'] = furnished;
    map['availableFrom'] = availableFrom;
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
    if (roomAmenities != null) {
      map['amenities'] = roomAmenities?.toJson();
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
/// workerGender : "Male"
/// petsAllowed : true

class AddRoomRequestAllowedTenants {
  AddRoomRequestAllowedTenants({
      this.allowsFamilies, 
      this.allowsChildren, 
      this.allowsStudents, 
      this.studentGender, 
      this.allowsWorkers, 
      this.workerGender, 
      this.petsAllowed,});

  AddRoomRequestAllowedTenants.fromJson(dynamic json) {
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

class AddRoomRequestRoomAmenities {
  AddRoomRequestRoomAmenities({
      this.airConditioning, 
      this.closet, 
      this.mirror, 
      this.fan,});

  AddRoomRequestRoomAmenities.fromJson(dynamic json) {
    airConditioning = json['airConditioning'];
    closet = json['closet'];
    mirror = json['mirror'];
    fan = json['fan'];
  }
  bool? airConditioning;
  bool? closet;
  bool? mirror;
  bool? fan;

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

class AddRoomRequestSharedPropertyImages {
  AddRoomRequestSharedPropertyImages({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  AddRoomRequestSharedPropertyImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;

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

class AddRoomRequestRoomImages {
  AddRoomRequestRoomImages({
      this.id,
      this.imageUrl,
      this.isCover,});

  AddRoomRequestRoomImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;

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

class AddRoomRequestNearbyServices {
  AddRoomRequestNearbyServices({
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

  AddRoomRequestNearbyServices.fromJson(dynamic json) {
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

class AddRoomRequestPropertyAmenities {
  AddRoomRequestPropertyAmenities({
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

  AddRoomRequestPropertyAmenities.fromJson(dynamic json) {
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