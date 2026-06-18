/// isSuccess : true
/// message : "Request successful"
/// data : {"id":184,"hostId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","hostName":"Rahma Ibrahim ","profilePicture":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","name":"test test 1","description":"cgvhhhfdfffgg","amenities":{"wifi":false,"tv":false,"cooktop":false,"oven":false,"kettle":false,"dishwasher":false,"refrigerator":false,"microwave":false,"washer":true,"freeParking":false,"airConditioning":false,"smokeAlarm":true,"fireExtinguisher":false},"nearbyServices":{"hasGroceryStore":false,"hasPharmacy":false,"hasHospital":false,"hasSchool":false,"hasUniversity":false,"hasPublicTransport":false,"hasParking":false,"hasMall":false,"hasRestaurants":false,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":false,"isQuietArea":false,"hasChurchNearby":false,"hasMosqueNearby":false},"street":"gshshjajaj","city":"Kantara West","government":"Ismailia","isSaved":false,"latitude":30.859202,"longitude":32.338991,"size":0,"isMyProperty":true,"propertyImages":[{"id":663,"imageUrl":"https://graduationproject1.runasp.net/images/properties/85f42311-3626-415e-ab30-95fd8be929b5_1000137404.jpg","isCover":true},{"id":664,"imageUrl":"https://graduationproject1.runasp.net/images/properties/5d0165a0-29a6-4015-a0e0-288d3f605c45_1000137407.jpg","isCover":false},{"id":665,"imageUrl":"https://graduationproject1.runasp.net/images/properties/83be206f-ef2b-4830-93bd-8a0c60e95af2_1000137401.jpg","isCover":false}],"minimumStay":null,"distanceInKm":0,"rooms":[{"id":245,"roomName":"master suiteeeee","month_rent":10000,"coverImageUrl":"https://graduationproject1.runasp.net/images/properties/f012d8dc-73b3-4666-b10e-9a73c78c5383_1000136238.jpg"}]}

class SharedApartmentDetails {
  SharedApartmentDetails({
      this.isSuccess, 
      this.message, 
      this.data,});

  SharedApartmentDetails.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? SharedApartmentDetailsData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  SharedApartmentDetailsData? data;
SharedApartmentDetails copyWith({  bool? isSuccess,
  String? message,
  SharedApartmentDetailsData? data,
}) => SharedApartmentDetails(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
  data: data ?? this.data,
);
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

/// id : 184
/// hostId : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// hostName : "Rahma Ibrahim "
/// profilePicture : "https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"
/// name : "test test 1"
/// description : "cgvhhhfdfffgg"
/// amenities : {"wifi":false,"tv":false,"cooktop":false,"oven":false,"kettle":false,"dishwasher":false,"refrigerator":false,"microwave":false,"washer":true,"freeParking":false,"airConditioning":false,"smokeAlarm":true,"fireExtinguisher":false}
/// nearbyServices : {"hasGroceryStore":false,"hasPharmacy":false,"hasHospital":false,"hasSchool":false,"hasUniversity":false,"hasPublicTransport":false,"hasParking":false,"hasMall":false,"hasRestaurants":false,"hasPark":true,"hasGym":true,"isSafeArea":true,"hasPoliceStation":false,"isQuietArea":false,"hasChurchNearby":false,"hasMosqueNearby":false}
/// street : "gshshjajaj"
/// city : "Kantara West"
/// government : "Ismailia"
/// isSaved : false
/// latitude : 30.859202
/// longitude : 32.338991
/// size : 0
/// isMyProperty : true
/// propertyImages : [{"id":663,"imageUrl":"https://graduationproject1.runasp.net/images/properties/85f42311-3626-415e-ab30-95fd8be929b5_1000137404.jpg","isCover":true},{"id":664,"imageUrl":"https://graduationproject1.runasp.net/images/properties/5d0165a0-29a6-4015-a0e0-288d3f605c45_1000137407.jpg","isCover":false},{"id":665,"imageUrl":"https://graduationproject1.runasp.net/images/properties/83be206f-ef2b-4830-93bd-8a0c60e95af2_1000137401.jpg","isCover":false}]
/// minimumStay : null
/// distanceInKm : 0
/// rooms : [{"id":245,"roomName":"master suiteeeee","month_rent":10000,"coverImageUrl":"https://graduationproject1.runasp.net/images/properties/f012d8dc-73b3-4666-b10e-9a73c78c5383_1000136238.jpg"}]

class SharedApartmentDetailsData {
  SharedApartmentDetailsData({
      this.id, 
      this.hostId, 
      this.hostName, 
      this.profilePicture, 
      this.name, 
      this.description, 
      this.amenities, 
      this.nearbyServices, 
      this.street, 
      this.city, 
      this.government, 
      this.isSaved, 
      this.latitude, 
      this.longitude, 
      this.size, 
      this.isMyProperty, 
      this.propertyImages, 
      this.minimumStay, 
      this.distanceInKm, 
      this.rooms,});

  SharedApartmentDetailsData.fromJson(dynamic json) {
    id = json['id'];
    hostId = json['hostId'];
    hostName = json['hostName'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    description = json['description'];
    amenities = json['amenities'] != null ? Amenities.fromJson(json['amenities']) : null;
    nearbyServices = json['nearbyServices'] != null ? NearbyServices.fromJson(json['nearbyServices']) : null;
    street = json['street'];
    city = json['city'];
    government = json['government'];
    isSaved = json['isSaved'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    size = json['size'];
    isMyProperty = json['isMyProperty'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(PropertyImages.fromJson(v));
      });
    }
    minimumStay = json['minimumStay'];
    distanceInKm = json['distanceInKm'];
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(Rooms.fromJson(v));
      });
    }
  }
  num? id;
  String? hostId;
  String? hostName;
  String? profilePicture;
  String? name;
  String? description;
  Amenities? amenities;
  NearbyServices? nearbyServices;
  String? street;
  String? city;
  String? government;
  bool? isSaved;
  num? latitude;
  num? longitude;
  num? size;
  bool? isMyProperty;
  List<PropertyImages>? propertyImages;
  dynamic minimumStay;
  num? distanceInKm;
  List<Rooms>? rooms;
SharedApartmentDetailsData copyWith({  num? id,
  String? hostId,
  String? hostName,
  String? profilePicture,
  String? name,
  String? description,
  Amenities? amenities,
  NearbyServices? nearbyServices,
  String? street,
  String? city,
  String? government,
  bool? isSaved,
  num? latitude,
  num? longitude,
  num? size,
  bool? isMyProperty,
  List<PropertyImages>? propertyImages,
  dynamic minimumStay,
  num? distanceInKm,
  List<Rooms>? rooms,
}) => SharedApartmentDetailsData(  id: id ?? this.id,
  hostId: hostId ?? this.hostId,
  hostName: hostName ?? this.hostName,
  profilePicture: profilePicture ?? this.profilePicture,
  name: name ?? this.name,
  description: description ?? this.description,
  amenities: amenities ?? this.amenities,
  nearbyServices: nearbyServices ?? this.nearbyServices,
  street: street ?? this.street,
  city: city ?? this.city,
  government: government ?? this.government,
  isSaved: isSaved ?? this.isSaved,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  size: size ?? this.size,
  isMyProperty: isMyProperty ?? this.isMyProperty,
  propertyImages: propertyImages ?? this.propertyImages,
  minimumStay: minimumStay ?? this.minimumStay,
  distanceInKm: distanceInKm ?? this.distanceInKm,
  rooms: rooms ?? this.rooms,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['hostId'] = hostId;
    map['hostName'] = hostName;
    map['profilePicture'] = profilePicture;
    map['name'] = name;
    map['description'] = description;
    if (amenities != null) {
      map['amenities'] = amenities?.toJson();
    }
    if (nearbyServices != null) {
      map['nearbyServices'] = nearbyServices?.toJson();
    }
    map['street'] = street;
    map['city'] = city;
    map['government'] = government;
    map['isSaved'] = isSaved;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['size'] = size;
    map['isMyProperty'] = isMyProperty;
    if (propertyImages != null) {
      map['propertyImages'] = propertyImages?.map((v) => v.toJson()).toList();
    }
    map['minimumStay'] = minimumStay;
    map['distanceInKm'] = distanceInKm;
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 245
/// roomName : "master suiteeeee"
/// month_rent : 10000
/// coverImageUrl : "https://graduationproject1.runasp.net/images/properties/f012d8dc-73b3-4666-b10e-9a73c78c5383_1000136238.jpg"

class Rooms {
  Rooms({
      this.id, 
      this.roomName, 
      this.monthRent, 
      this.coverImageUrl,});

  Rooms.fromJson(dynamic json) {
    id = json['id'];
    roomName = json['roomName'];
    monthRent = json['month_rent'];
    coverImageUrl = json['coverImageUrl'];
  }
  num? id;
  String? roomName;
  num? monthRent;
  String? coverImageUrl;
Rooms copyWith({  num? id,
  String? roomName,
  num? monthRent,
  String? coverImageUrl,
}) => Rooms(  id: id ?? this.id,
  roomName: roomName ?? this.roomName,
  monthRent: monthRent ?? this.monthRent,
  coverImageUrl: coverImageUrl ?? this.coverImageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roomName'] = roomName;
    map['month_rent'] = monthRent;
    map['coverImageUrl'] = coverImageUrl;
    return map;
  }

}

/// id : 663
/// imageUrl : "https://graduationproject1.runasp.net/images/properties/85f42311-3626-415e-ab30-95fd8be929b5_1000137404.jpg"
/// isCover : true

class PropertyImages {
  PropertyImages({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  PropertyImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  num? id;
  String? imageUrl;
  bool? isCover;
PropertyImages copyWith({  num? id,
  String? imageUrl,
  bool? isCover,
}) => PropertyImages(  id: id ?? this.id,
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

/// hasGroceryStore : false
/// hasPharmacy : false
/// hasHospital : false
/// hasSchool : false
/// hasUniversity : false
/// hasPublicTransport : false
/// hasParking : false
/// hasMall : false
/// hasRestaurants : false
/// hasPark : true
/// hasGym : true
/// isSafeArea : true
/// hasPoliceStation : false
/// isQuietArea : false
/// hasChurchNearby : false
/// hasMosqueNearby : false

class NearbyServices {
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
      this.hasMosqueNearby,});

  NearbyServices.fromJson(dynamic json) {
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
NearbyServices copyWith({  bool? hasGroceryStore,
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
}) => NearbyServices(  hasGroceryStore: hasGroceryStore ?? this.hasGroceryStore,
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

/// wifi : false
/// tv : false
/// cooktop : false
/// oven : false
/// kettle : false
/// dishwasher : false
/// refrigerator : false
/// microwave : false
/// washer : true
/// freeParking : false
/// airConditioning : false
/// smokeAlarm : true
/// fireExtinguisher : false

class Amenities {
  Amenities({
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

  Amenities.fromJson(dynamic json) {
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
Amenities copyWith({  bool? wifi,
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
}) => Amenities(  wifi: wifi ?? this.wifi,
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