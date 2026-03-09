/// isSuccess : true
/// message : "Request successful"
/// data : [{"id":76,"name":"Beshoydfaaff","monthlyRent":2000,"availableFrom":"2026-03-08T16:20:57.778","numberOfBedrooms":1,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"Street Name","city":"cairo","government":"cairo","latitude":0,"longitude":0,"size":120,"coverImageUrl":"https://graduationproject1.runasp.net/images/properties/28d48dd5-b759-4679-8c54-3cab1c3ef8f7_Screenshot 2026-03-01 200807.png","allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":true},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0},{"id":77,"name":"Beshoyddddddddd","monthlyRent":12222,"availableFrom":"2026-03-08T16:22:45.364","numberOfBedrooms":1,"numberOfLivingRooms":1,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"Street Name","city":"cairo","government":"cairo","latitude":0,"longitude":0,"size":123,"coverImageUrl":"https://graduationproject1.runasp.net/images/properties/6c448ecf-60b1-46e4-9f42-721ff9d39a75_Screenshot 2026-03-01 200807.png","allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":true},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0},{"id":70,"name":"شقة فيلات الياسمين - إطلالة على حديقة","monthlyRent":3000,"availableFrom":"2026-03-07T16:10:27.067","numberOfBedrooms":3,"numberOfLivingRooms":2,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"شارع الياسمين 7","city":"التجمع الأول\"","government":"القاهرة","latitude":30.0489,"longitude":31.4582,"size":150,"coverImageUrl":"/images/properties/bf1d73ec-5acd-4aff-ace7-6ad7fbde7a9a_3.jpg","allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"any","petsAllowed":true},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0},{"id":71,"name":"شقة فيلات الياسمين - إطلالة على حديقة","monthlyRent":3000,"availableFrom":"2026-03-07T16:10:27.067","numberOfBedrooms":3,"numberOfLivingRooms":2,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"شارع الياسمين 7","city":"التجمع الأول\"","government":"القاهرة","latitude":30.0489,"longitude":31.4582,"size":150,"coverImageUrl":"/images/properties/534ed8e1-6e96-4863-af10-65f80396a7a6_3.jpg","allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"any","petsAllowed":true},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0},{"id":72,"name":"شقة فيلات الياسمين - إطلالة على حديقة","monthlyRent":3000,"availableFrom":"2026-03-07T16:10:27.067","numberOfBedrooms":3,"numberOfLivingRooms":2,"numberOfEnSuiteBathrooms":1,"numberOfGuestBathrooms":1,"street":"شارع الياسمين 7","city":"التجمع الأول\"","government":"القاهرة","latitude":30.0489,"longitude":31.4582,"size":150,"coverImageUrl":"/images/properties/2849cca7-d9b9-4d00-ace8-4e3b4f388fc9_3.jpg","allowedTenants":{"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"any","allowsWorkers":true,"workerGender":"any","petsAllowed":true},"status":"Available","bookingFrom":null,"bookingTo":null,"distanceInKm":0}]

class GetAllApartments {
  GetAllApartments({
      this.isSuccess, 
      this.message, 
      this.data,});

  GetAllApartments.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? isSuccess;
  String? message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 76
/// name : "Beshoydfaaff"
/// monthlyRent : 2000
/// availableFrom : "2026-03-08T16:20:57.778"
/// numberOfBedrooms : 1
/// numberOfLivingRooms : 1
/// numberOfEnSuiteBathrooms : 1
/// numberOfGuestBathrooms : 1
/// street : "Street Name"
/// city : "cairo"
/// government : "cairo"
/// latitude : 0
/// longitude : 0
/// size : 120
/// coverImageUrl : "https://graduationproject1.runasp.net/images/properties/28d48dd5-b759-4679-8c54-3cab1c3ef8f7_Screenshot 2026-03-01 200807.png"
/// allowedTenants : {"allowsFamilies":true,"allowsChildren":true,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":true}
/// status : "Available"
/// bookingFrom : null
/// bookingTo : null
/// distanceInKm : 0

class Data {
  Data({
      this.id, 
      this.name, 
      this.monthlyRent, 
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

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    monthlyRent = json['monthlyRent'];
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
  int? monthlyRent;
  String? availableFrom;
  int? numberOfBedrooms;
  int? numberOfLivingRooms;
  int? numberOfEnSuiteBathrooms;
  int? numberOfGuestBathrooms;
  String? street;
  String? city;
  String? government;
  int? latitude;
  int? longitude;
  int? size;
  String? coverImageUrl;
  AllowedTenants? allowedTenants;
  String? status;
  dynamic bookingFrom;
  dynamic bookingTo;
  int? distanceInKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['monthlyRent'] = monthlyRent;
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
/// allowsChildren : true
/// allowsStudents : true
/// studentGender : "male"
/// allowsWorkers : true
/// workerGender : "male"
/// petsAllowed : true

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