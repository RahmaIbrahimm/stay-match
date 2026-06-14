/// name : "1 this is the new name for the updated property 1"
/// description : "strffffffing"
/// monthlyRent : 0
/// deposite : 0
/// furnished : true
/// availableFrom : "2026-08-29T00:59:21.073Z"
/// numberOfBedrooms : 0
/// numberOfLivingRooms : 0
/// numberOfEnSuiteBathrooms : 0
/// numberOfGuestBathrooms : 0
/// allowedTenants : {"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"female","petsAllowed":true}
/// amenities : {"wifi":true,"tv":true,"cooktop":true,"oven":true,"kettle":true,"dishwasher":true,"refrigerator":true,"microwave":true,"washer":true,"freeParking":true,"airConditioning":true,"smokeAlarm":true,"fireExtinguisher":true}
/// nearbyServices : {"hasGroceryStore":true,"hasPharmacy":true,"hasHospital":true,"hasSchool":true,"hasUniversity":true,"hasPublicTransport":true,"hasParking":true,"hasMall":true,"hasRestaurants":true,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":true,"isQuietArea":true,"hasChurchNearby":true,"hasMosqueNearby":true}
/// street : "string"
/// city : "string"
/// government : "string"
/// latitude : 0
/// longitude : 0
/// size : 0
/// propertyImages : [{"id":0,"imageUrl":"string","isCover":true}]
/// isDraft : true
/// minimumStay : 0

class UpdateEntirePropertyRequest {
  UpdateEntirePropertyRequest({
      this.name, 
      this.description, 
      this.monthlyRent, 
      this.deposite, 
      this.furnished, 
      this.availableFrom, 
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
      this.isDraft, 
      this.minimumStay,});

  UpdateEntirePropertyRequest.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    monthlyRent = json['monthlyRent'];
    deposite = json['deposite'];
    furnished = json['furnished'];
    availableFrom = json['availableFrom'];
    numberOfBedrooms = json['numberOfBedrooms'];
    numberOfLivingRooms = json['numberOfLivingRooms'];
    numberOfEnSuiteBathrooms = json['numberOfEnSuiteBathrooms'];
    numberOfGuestBathrooms = json['numberOfGuestBathrooms'];
    allowedTenants = json['allowedTenants'] != null ? UpdateEntirePropertyRequestAllowedTenants.fromJson(json['allowedTenants']) : null;
    amenities = json['amenities'] != null ? UpdateEntirePropertyRequestAmenities.fromJson(json['amenities']) : null;
    nearbyServices = json['nearbyServices'] != null ? UpdateEntirePropertyRequestNearbyServices.fromJson(json['nearbyServices']) : null;
    street = json['street'];
    city = json['city'];
    government = json['government'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    size = json['size'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(UpdateEntirePropertyRequestEntirePropertyImages.fromJson(v));
      });
    }
    isDraft = json['isDraft'];
    minimumStay = json['minimumStay'];
  }
  String? name;
  String? description;
  int? monthlyRent;
  int? deposite;
  bool? furnished;
  String? availableFrom;
  int? numberOfBedrooms;
  int? numberOfLivingRooms;
  int? numberOfEnSuiteBathrooms;
  int? numberOfGuestBathrooms;
  UpdateEntirePropertyRequestAllowedTenants? allowedTenants;
  UpdateEntirePropertyRequestAmenities? amenities;
  UpdateEntirePropertyRequestNearbyServices? nearbyServices;
  String? street;
  String? city;
  String? government;
  int? latitude;
  int? longitude;
  int? size;
  List<UpdateEntirePropertyRequestEntirePropertyImages>? propertyImages;
  bool? isDraft;
  int? minimumStay;
UpdateEntirePropertyRequest copyWith({  String? name,
  String? description,
  int? monthlyRent,
  int? deposite,
  bool? furnished,
  String? availableFrom,
  int? numberOfBedrooms,
  int? numberOfLivingRooms,
  int? numberOfEnSuiteBathrooms,
  int? numberOfGuestBathrooms,
  UpdateEntirePropertyRequestAllowedTenants? allowedTenants,
  UpdateEntirePropertyRequestAmenities? amenities,
  UpdateEntirePropertyRequestNearbyServices? nearbyServices,
  String? street,
  String? city,
  String? government,
  int? latitude,
  int? longitude,
  int? size,
  List<UpdateEntirePropertyRequestEntirePropertyImages>? propertyImages,
  bool? isDraft,
  int? minimumStay,
}) => UpdateEntirePropertyRequest(  name: name ?? this.name,
  description: description ?? this.description,
  monthlyRent: monthlyRent ?? this.monthlyRent,
  deposite: deposite ?? this.deposite,
  furnished: furnished ?? this.furnished,
  availableFrom: availableFrom ?? this.availableFrom,
  numberOfBedrooms: numberOfBedrooms ?? this.numberOfBedrooms,
  numberOfLivingRooms: numberOfLivingRooms ?? this.numberOfLivingRooms,
  numberOfEnSuiteBathrooms: numberOfEnSuiteBathrooms ?? this.numberOfEnSuiteBathrooms,
  numberOfGuestBathrooms: numberOfGuestBathrooms ?? this.numberOfGuestBathrooms,
  allowedTenants: allowedTenants ?? this.allowedTenants,
  amenities: amenities ?? this.amenities,
  nearbyServices: nearbyServices ?? this.nearbyServices,
  street: street ?? this.street,
  city: city ?? this.city,
  government: government ?? this.government,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  size: size ?? this.size,
  propertyImages: propertyImages ?? this.propertyImages,
  isDraft: isDraft ?? this.isDraft,
  minimumStay: minimumStay ?? this.minimumStay,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['monthlyRent'] = monthlyRent;
    map['deposite'] = deposite;
    map['furnished'] = furnished;
    map['availableFrom'] = availableFrom;
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
    map['isDraft'] = isDraft;
    map['minimumStay'] = minimumStay;
    return map;
  }

}

/// id : 0
/// imageUrl : "string"
/// isCover : true

class UpdateEntirePropertyRequestEntirePropertyImages {
  UpdateEntirePropertyRequestEntirePropertyImages({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  UpdateEntirePropertyRequestEntirePropertyImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;
UpdateEntirePropertyRequestEntirePropertyImages copyWith({  int? id,
  String? imageUrl,
  bool? isCover,
}) => UpdateEntirePropertyRequestEntirePropertyImages(  id: id ?? this.id,
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

class UpdateEntirePropertyRequestNearbyServices {
  UpdateEntirePropertyRequestNearbyServices({
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

  UpdateEntirePropertyRequestNearbyServices.fromJson(dynamic json) {
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
UpdateEntirePropertyRequestNearbyServices copyWith({  bool? hasGroceryStore,
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
}) => UpdateEntirePropertyRequestNearbyServices(  hasGroceryStore: hasGroceryStore ?? this.hasGroceryStore,
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

class UpdateEntirePropertyRequestAmenities {
  UpdateEntirePropertyRequestAmenities({
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

  UpdateEntirePropertyRequestAmenities.fromJson(dynamic json) {
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
UpdateEntirePropertyRequestAmenities copyWith({  bool? wifi,
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
}) => UpdateEntirePropertyRequestAmenities(  wifi: wifi ?? this.wifi,
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

/// allowsFamilies : true
/// allowsChildren : true
/// allowsStudents : true
/// studentGender : "male"
/// allowsWorkers : true
/// workerGender : "female"
/// petsAllowed : true

class UpdateEntirePropertyRequestAllowedTenants {
  UpdateEntirePropertyRequestAllowedTenants({
      this.allowsFamilies, 
      this.allowsChildren, 
      this.allowsStudents, 
      this.studentGender, 
      this.allowsWorkers, 
      this.workerGender, 
      this.petsAllowed,});

  UpdateEntirePropertyRequestAllowedTenants.fromJson(dynamic json) {
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
UpdateEntirePropertyRequestAllowedTenants copyWith({  bool? allowsFamilies,
  bool? allowsChildren,
  bool? allowsStudents,
  String? studentGender,
  bool? allowsWorkers,
  String? workerGender,
  bool? petsAllowed,
}) => UpdateEntirePropertyRequestAllowedTenants(  allowsFamilies: allowsFamilies ?? this.allowsFamilies,
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