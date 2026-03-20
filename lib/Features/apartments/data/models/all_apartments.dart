/// isSuccess : true
/// message : "Request successful"
/// data : {"totalCount":22,"page":1,"pageSize":2,"totalPages":11,"hasNext":true,"hasPrevious":false,"items":[{"id":92,"name":"Beshoysososooop","monthlyRent":1200,"furnished":false,"availableFrom":"2026-03-12T10:39:41.242","numberOfBedrooms":1,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":0,"numberOfGuestBathrooms":0,"street":"xxxxxxxxxxxxxxxo","city":"cairo","government":"xxxxxxxvxxs","latitude":30.0444,"longitude":31.2357,"size":120,"coverImageUrl":"[object Object]","allowedTenants":{"allowsFamilies":true,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":false,"workerGender":"male","petsAllowed":false},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0},{"id":93,"name":"Beshoysososoosa","monthlyRent":1200,"furnished":false,"availableFrom":"2026-03-12T10:58:24.256","numberOfBedrooms":1,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"dddddddddddda","city":"cairo","government":"xxxxxxxvxxs","latitude":30.0444,"longitude":31.2357,"size":120,"coverImageUrl":"https://graduationproject1.runasp.net/images/properties/b99c7cf2-ee2f-4db2-b3f4-7da0bcbfb9a0_Screenshot 2026-02-10 143849.png","allowedTenants":{"allowsFamilies":true,"allowsChildren":false,"allowsStudents":false,"studentGender":"male","allowsWorkers":false,"workerGender":"male","petsAllowed":false},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0}]}

class AllApartmentsResponse {
  AllApartmentsResponse({
      this.isSuccess,
      this.message,
      this.data,});

  AllApartmentsResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? ApartmentData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  ApartmentData? data;

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

/// totalCount : 22
/// page : 1
/// pageSize : 2
/// totalPages : 11
/// hasNext : true
/// hasPrevious : false
/// items : [{"id":92,"name":"Beshoysososooop","monthlyRent":1200,"furnished":false,"availableFrom":"2026-03-12T10:39:41.242","numberOfBedrooms":1,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":0,"numberOfGuestBathrooms":0,"street":"xxxxxxxxxxxxxxxo","city":"cairo","government":"xxxxxxxvxxs","latitude":30.0444,"longitude":31.2357,"size":120,"coverImageUrl":"[object Object]","allowedTenants":{"allowsFamilies":true,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":false,"workerGender":"male","petsAllowed":false},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0},{"id":93,"name":"Beshoysososoosa","monthlyRent":1200,"furnished":false,"availableFrom":"2026-03-12T10:58:24.256","numberOfBedrooms":1,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"dddddddddddda","city":"cairo","government":"xxxxxxxvxxs","latitude":30.0444,"longitude":31.2357,"size":120,"coverImageUrl":"https://graduationproject1.runasp.net/images/properties/b99c7cf2-ee2f-4db2-b3f4-7da0bcbfb9a0_Screenshot 2026-02-10 143849.png","allowedTenants":{"allowsFamilies":true,"allowsChildren":false,"allowsStudents":false,"studentGender":"male","allowsWorkers":false,"workerGender":"male","petsAllowed":false},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0}]

class ApartmentData {
  ApartmentData({
      this.totalCount,
      this.page,
      this.pageSize,
      this.totalPages,
      this.hasNext,
      this.hasPrevious,
      this.items,});

  ApartmentData.fromJson(dynamic json) {
    totalCount = json['totalCount'];
    page = json['page'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    hasNext = json['hasNext'];
    hasPrevious = json['hasPrevious'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(AllApartmentsItems.fromJson(v));
      });
    }
  }
  num? totalCount;
  num? page;
  num? pageSize;
  num? totalPages;
  bool? hasNext;
  bool? hasPrevious;
  List<AllApartmentsItems>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = totalCount;
    map['page'] = page;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    map['hasNext'] = hasNext;
    map['hasPrevious'] = hasPrevious;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 92
/// name : "Beshoysososooop"
/// monthlyRent : 1200
/// furnished : false
/// availableFrom : "2026-03-12T10:39:41.242"
/// numberOfBedrooms : 1
/// numberOfLivingRooms : 1
/// numberOfEnSuiteBathrooms : 0
/// numberOfGuestBathrooms : 0
/// street : "xxxxxxxxxxxxxxxo"
/// city : "cairo"
/// government : "xxxxxxxvxxs"
/// latitude : 30.0444
/// longitude : 31.2357
/// size : 120
/// coverImageUrl : "[object Object]"
/// allowedTenants : {"allowsFamilies":true,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":false,"workerGender":"male","petsAllowed":false}
/// status : "Available"
/// bookingFrom : null
/// bookingTo : null
/// distanceInKm : 0

class AllApartmentsItems {
  AllApartmentsItems({
      this.id,
      this.name,
      this.monthlyRent,
      this.furnished,
      this.availableFrom,
      this.numberOfBedrooms,
      this.numberOfLivingRooms,
      this.numberOfEnSuiteBathrooms,
      this.numberOfGuestBathrooms,
      this.street,
      this.city,
      this.government,
      this.latitude,
      this.longitude,
      this.size,
      this.coverImageUrl,
      this.allowedTenants,
      this.status,
      this.bookingFrom,
      this.bookingTo,
      this.distanceInKm,});

  AllApartmentsItems.fromJson(dynamic json) {
    id = json['id'];
    monthlyRent = json['monthlyRent'];
    furnished = json['furnished'];
    availableFrom = json['availableFrom'];
    numberOfBedrooms = json['numberOfBedrooms'];
    numberOfLivingRooms = json['numberOfLivingRooms'];
    numberOfEnSuiteBathrooms = json['numberOfEnSuiteBathrooms'];
    numberOfGuestBathrooms = json['numberOfGuestBathrooms'];
    street = json['street'];
    city = json['city'];
    government = json['government'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    size = json['size'];
    coverImageUrl = json['coverImageUrl'];
    allowedTenants = json['allowedTenants'] != null ? AllowedTenants.fromJson(json['allowedTenants']) : null;
    status = json['status'];
    bookingFrom = json['bookingFrom'];
    bookingTo = json['bookingTo'];
    distanceInKm = json['distanceInKm'];
  }
  int? id;
  String? name;
  num? monthlyRent;
  bool? furnished;
  String? availableFrom;
  num? numberOfBedrooms;
  num? numberOfLivingRooms;
  num? numberOfEnSuiteBathrooms;
  num? numberOfGuestBathrooms;
  String? street;
  String? city;
  String? government;
  num? latitude;
  num? longitude;
  num? size;
  String? coverImageUrl;
  AllowedTenants? allowedTenants;
  String? status;
  dynamic bookingFrom;
  dynamic bookingTo;
  num? distanceInKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['monthlyRent'] = monthlyRent;
    map['furnished'] = furnished;
    map['availableFrom'] = availableFrom;
    map['numberOfBedrooms'] = numberOfBedrooms;
    map['numberOfLivingRooms'] = numberOfLivingRooms;
    map['numberOfEnSuiteBathrooms'] = numberOfEnSuiteBathrooms;
    map['numberOfGuestBathrooms'] = numberOfGuestBathrooms;
    map['street'] = street;
    map['city'] = city;
    map['government'] = government;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['size'] = size;
    map['coverImageUrl'] = coverImageUrl;
    if (allowedTenants != null) {
      map['allowedTenants'] = allowedTenants?.toJson();
    }
    map['status'] = status;
    map['bookingFrom'] = bookingFrom;
    map['bookingTo'] = bookingTo;
    map['distanceInKm'] = distanceInKm;
    return map;
  }

}

/// allowsFamilies : true
/// allowsChildren : false
/// allowsStudents : true
/// studentGender : "male"
/// allowsWorkers : false
/// workerGender : "male"
/// petsAllowed : false

class AllowedTenants {
  AllowedTenants({
      this.allowsFamilies,
      this.allowsChildren,
      this.allowsStudents,
      this.studentGender,
      this.allowsWorkers,
      this.workerGender,
      this.petsAllowed,});

  AllowedTenants.fromJson(dynamic json) {
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