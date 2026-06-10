/// isSuccess : true
/// message : "Request successful"
/// data : {"id":88,"hostId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","hostName":"Abanoub Yousry","name":"شقة فاخرة للإيجار بالمعادي","description":"شقة واسعة ومفروشة بالكامل تقع في منطقة هادئة قريبة من المترو والخدمات.","monthlyRent":8500,"deposite":5000,"furnished":true,"availableFrom":"2026-03-15T00:00:00","availableTo":null,"numberOfBedrooms":3,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"allowedTenants":{"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false},"amenities":{"wifi":true,"tv":true,"cooktop":true,"oven":true,"kettle":true,"dishwasher":false,"refrigerator":true,"microwave":true,"washer":true,"freeParking":true,"airConditioning":true,"smokeAlarm":true,"fireExtinguisher":false},"nearbyServices":{"hasGroceryStore":true,"hasPharmacy":true,"hasHospital":true,"hasSchool":false,"hasUniversity":true,"hasPublicTransport":true,"hasParking":true,"hasMall":true,"hasRestaurants":true,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":true,"isQuietArea":true,"hasChurchNearby":true,"hasMosqueNearby":true},"street":"شارع 9","city":"المعادي","government":"القاهرة","latitude":29.9602,"longitude":31.2569,"size":120,"propertyImages":[{"id":400,"imageUrl":null,"isCover":true},{"id":401,"imageUrl":null,"isCover":false}],"minimumStay":6,"distanceInKm":0,"blockedPeriods":[]}

class PropertyDetailsResponse {
  PropertyDetailsResponse({this.isSuccess, this.message, this.data});

  PropertyDetailsResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null
        ? PropertyDetailsData.fromJson(json['data'])
        : null;
  }
  bool? isSuccess;
  String? message;
  PropertyDetailsData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : 88
/// hostId : "1121c342-dd7a-4a29-bc66-c94f6aa43212"
/// hostName : "Abanoub Yousry"
/// name : "شقة فاخرة للإيجار بالمعادي"
/// description : "شقة واسعة ومفروشة بالكامل تقع في منطقة هادئة قريبة من المترو والخدمات."
/// monthlyRent : 8500
/// deposite : 5000
/// furnished : true
/// availableFrom : "2026-03-15T00:00:00"
/// availableTo : null
/// numberOfBedrooms : 3
/// numberOfLivingRooms : 1
/// numberOfEnSuiteBathrooms : 1
/// numberOfGuestBathrooms : 1
/// allowedTenants : {"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false}
/// amenities : {"wifi":true,"tv":true,"cooktop":true,"oven":true,"kettle":true,"dishwasher":false,"refrigerator":true,"microwave":true,"washer":true,"freeParking":true,"airConditioning":true,"smokeAlarm":true,"fireExtinguisher":false}
/// nearbyServices : {"hasGroceryStore":true,"hasPharmacy":true,"hasHospital":true,"hasSchool":false,"hasUniversity":true,"hasPublicTransport":true,"hasParking":true,"hasMall":true,"hasRestaurants":true,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":true,"isQuietArea":true,"hasChurchNearby":true,"hasMosqueNearby":true}
/// street : "شارع 9"
/// city : "المعادي"
/// government : "القاهرة"
/// latitude : 29.9602
/// longitude : 31.2569
/// size : 120
/// propertyImages : [{"id":400,"imageUrl":null,"isCover":true},{"id":401,"imageUrl":null,"isCover":false}]
/// minimumStay : 6
/// distanceInKm : 0
/// blockedPeriods : []

class PropertyDetailsData {
  PropertyDetailsData({
    this.id,
    this.hostId,
    this.hostName,
    this.name,
    this.description,
    this.monthlyRent,
    this.deposite,
    this.furnished,
    this.isSaved,
    this.availableFrom,
    this.availableTo,
    this.numberOfBedrooms,
    this.numberOfLivingRooms,
    this.numberOfEnSuiteBathrooms,
    this.numberOfGuestBathrooms,
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
    this.distanceInKm,
    this.blockedPeriods,
  });

  PropertyDetailsData.fromJson(dynamic json) {
    id = json['id'];
    hostId = json['hostId'];
    hostName = json['hostName'];
    name = json['name'];
    description = json['description'];
    monthlyRent = json['monthlyRent'];
    deposite = json['deposite'];
    furnished = json['furnished'];
    isSaved = json['isSaved'];
    availableFrom = json['availableFrom'];
    availableTo = json['availableTo'];
    numberOfBedrooms = json['numberOfBedrooms'];
    numberOfLivingRooms = json['numberOfLivingRooms'];
    numberOfEnSuiteBathrooms = json['numberOfEnSuiteBathrooms'];
    numberOfGuestBathrooms = json['numberOfGuestBathrooms'];
    allowedTenants = json['allowedTenants'] != null
        ? PropertyDetailsAllowedTenants.fromJson(json['allowedTenants'])
        : null;
    amenities = json['amenities'] != null
        ? PropertyAmenities.fromJson(json['amenities'])
        : null;
    nearbyServices = json['nearbyServices'] != null
        ? PropertyDetailsNearbyServices.fromJson(json['nearbyServices'])
        : null;
    street = json['street'];
    city = json['city'];
    government = json['government'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    size = json['size'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(PropertyDetailsResponsePropertyImages.fromJson(v));
      });
    }
    minimumStay = json['minimumStay'];
    distanceInKm = json['distanceInKm'];
    if (json['blockedPeriods'] != null) {
      blockedPeriods = [];
      json['blockedPeriods'].forEach((v) {
        blockedPeriods?.add(BlockedPeriods.fromJson(v));
      });
    }
  }
  int? id;
  String? hostId;
  String? hostName;
  String? name;
  String? description;
  num? monthlyRent;
  num? deposite;
  bool? furnished;
  bool? isSaved;
  String? availableFrom;
  dynamic availableTo;
  num? numberOfBedrooms;
  num? numberOfLivingRooms;
  num? numberOfEnSuiteBathrooms;
  num? numberOfGuestBathrooms;
  PropertyDetailsAllowedTenants? allowedTenants;
  PropertyAmenities? amenities;
  PropertyDetailsNearbyServices? nearbyServices;
  String? street;
  String? city;
  String? government;
  double? latitude;
  double? longitude;
  num? size;
  List<PropertyDetailsResponsePropertyImages>? propertyImages;
  num? minimumStay;
  num? distanceInKm;
  List<BlockedPeriods>? blockedPeriods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['hostId'] = hostId;
    map['hostName'] = hostName;
    map['name'] = name;
    map['description'] = description;
    map['monthlyRent'] = monthlyRent;
    map['deposite'] = deposite;
    map['furnished'] = furnished;
    map['isSaved'] = isSaved;
    map['availableFrom'] = availableFrom;
    map['availableTo'] = availableTo;
    map['numberOfBedrooms'] = numberOfBedrooms;
    map['numberOfLivingRooms'] = numberOfLivingRooms;
    map['numberOfEnSuiteBathrooms'] = numberOfEnSuiteBathrooms;
    map['numberOfGuestBathrooms'] = numberOfGuestBathrooms;
    if (allowedTenants != null) {
      map['allowedTenants'] = allowedTenants?.toJson();
    }
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
    map['size'] = size;
    if (propertyImages != null) {
      map['propertyImages'] = propertyImages?.map((v) => v.toJson()).toList();
    }
    map['minimumStay'] = minimumStay;
    map['distanceInKm'] = distanceInKm;
    if (blockedPeriods != null) {
      map['blockedPeriods'] = blockedPeriods?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 400
/// imageUrl : null
/// isCover : true
class BlockedPeriods {
  BlockedPeriods({this.from, this.to});

  BlockedPeriods.fromJson(dynamic json) {
    from = json['from'];
    to = json['to'];
  }
  String? from;
  String? to;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['from'] = from;
    map['to'] = to;
    return map;
  }
}

class PropertyDetailsResponsePropertyImages {
  PropertyDetailsResponsePropertyImages({this.id, this.imageUrl, this.isCover});

  PropertyDetailsResponsePropertyImages.fromJson(dynamic json) {
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
/// hasSchool : false
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

class PropertyDetailsNearbyServices {
  PropertyDetailsNearbyServices({
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

  PropertyDetailsNearbyServices.fromJson(dynamic json) {
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
/// dishwasher : false
/// refrigerator : true
/// microwave : true
/// washer : true
/// freeParking : true
/// airConditioning : true
/// smokeAlarm : true
/// fireExtinguisher : false

class PropertyAmenities {
  PropertyAmenities({
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

  PropertyAmenities.fromJson(dynamic json) {
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

/// allowsFamilies : false
/// allowsChildren : false
/// allowsStudents : true
/// studentGender : "male"
/// allowsWorkers : true
/// workerGender : "male"
/// petsAllowed : false

class PropertyDetailsAllowedTenants {
  PropertyDetailsAllowedTenants({
    this.allowsFamilies,
    this.allowsChildren,
    this.allowsStudents,
    this.studentGender,
    this.allowsWorkers,
    this.workerGender,
    this.petsAllowed,
  });

  PropertyDetailsAllowedTenants.fromJson(dynamic json) {
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