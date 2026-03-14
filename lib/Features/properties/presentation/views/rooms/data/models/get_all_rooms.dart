/// isSuccess : true
/// message : "Request successful"
/// data : [{"id":75,"name":"سكن المنار المشترك - الحي السابع","street":"شارع ذاكر حسين","city":"مدينة نصر","government":"القاهرة","latitude":30.0561,"longitude":31.3415,"size":20,"coverImageUrl":"https://api.roomrent.com/images/shared_living_main.jpg","rooms":[{"id":162,"roomName":"غرفة ماستر مكيفة (A)","month_rent":5000,"isAvailable":true,"availableFrom":"2026-03-07T00:00:00","allowedTenants":{"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false},"capacityAvailable":1,"createdAt":"2026-03-07T00:00:00","status":"Occupied","bookingFrom":"2026-03-07T00:00:00","bookingTo":"2026-06-06T00:00:00"},{"id":163,"roomName":"غرفة فردية هادئة (B)","month_rent":3500,"isAvailable":true,"availableFrom":"2026-03-15T00:00:00","allowedTenants":{"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false},"capacityAvailable":1,"createdAt":"2026-03-07T00:00:00","status":"Available","bookingFrom":null,"bookingTo":null}],"distanceInKm":0}]

class GetAllRooms {
  GetAllRooms({
      this.isSuccess, 
      this.message, 
      this.data,});

  GetAllRooms.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RoomData.fromJson(v));
      });
    }
  }
  bool? isSuccess;
  String? message;
  List<RoomData>? data;

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

/// id : 75
/// name : "سكن المنار المشترك - الحي السابع"
/// street : "شارع ذاكر حسين"
/// city : "مدينة نصر"
/// government : "القاهرة"
/// latitude : 30.0561
/// longitude : 31.3415
/// size : 20
/// coverImageUrl : "https://api.roomrent.com/images/shared_living_main.jpg"
/// rooms : [{"id":162,"roomName":"غرفة ماستر مكيفة (A)","month_rent":5000,"isAvailable":true,"availableFrom":"2026-03-07T00:00:00","allowedTenants":{"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false},"capacityAvailable":1,"createdAt":"2026-03-07T00:00:00","status":"Occupied","bookingFrom":"2026-03-07T00:00:00","bookingTo":"2026-06-06T00:00:00"},{"id":163,"roomName":"غرفة فردية هادئة (B)","month_rent":3500,"isAvailable":true,"availableFrom":"2026-03-15T00:00:00","allowedTenants":{"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false},"capacityAvailable":1,"createdAt":"2026-03-07T00:00:00","status":"Available","bookingFrom":null,"bookingTo":null}]
/// distanceInKm : 0

class RoomData {
  RoomData({
      this.id, 
      this.name, 
      this.street, 
      this.city, 
      this.government, 
      this.latitude, 
      this.longitude, 
      this.size, 
      this.coverImageUrl, 
      this.rooms, 
      this.distanceInKm,});

  RoomData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    city = json['city'];
    government = json['government'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    size = json['size'];
    coverImageUrl = json['coverImageUrl'];
    if (json['rooms'] != null) {
      rooms = [];
      json['rooms'].forEach((v) {
        rooms?.add(Rooms.fromJson(v));
      });
    }
    distanceInKm = json['distanceInKm'];
  }
  int? id;
  String? name;
  String? street;
  String? city;
  String? government;
  num? latitude;
  num? longitude;
  num? size;
  String? coverImageUrl;
  List<Rooms>? rooms;
  num? distanceInKm;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['street'] = street;
    map['city'] = city;
    map['government'] = government;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['size'] = size;
    map['coverImageUrl'] = coverImageUrl;
    if (rooms != null) {
      map['rooms'] = rooms?.map((v) => v.toJson()).toList();
    }
    map['distanceInKm'] = distanceInKm;
    return map;
  }

}

/// id : 162
/// roomName : "غرفة ماستر مكيفة (A)"
/// month_rent : 5000
/// isAvailable : true
/// availableFrom : "2026-03-07T00:00:00"
/// allowedTenants : {"allowsFamilies":false,"allowsChildren":false,"allowsStudents":true,"studentGender":"male","allowsWorkers":true,"workerGender":"male","petsAllowed":false}
/// capacityAvailable : 1
/// createdAt : "2026-03-07T00:00:00"
/// status : "Occupied"
/// bookingFrom : "2026-03-07T00:00:00"
/// bookingTo : "2026-06-06T00:00:00"

class Rooms {
  Rooms({
      this.id, 
      this.roomName, 
      this.monthRent, 
      this.isAvailable, 
      this.availableFrom, 
      this.allowedTenants, 
      this.capacityAvailable, 
      this.createdAt, 
      this.status, 
      this.bookingFrom, 
      this.bookingTo,});

  Rooms.fromJson(dynamic json) {
    id = json['id'];
    roomName = json['roomName'];
    monthRent = json['month_rent'];
    isAvailable = json['isAvailable'];
    availableFrom = json['availableFrom'];
    allowedTenants = json['allowedTenants'] != null ? AllowedTenants.fromJson(json['allowedTenants']) : null;
    capacityAvailable = json['capacityAvailable'];
    createdAt = json['createdAt'];
    status = json['status'];
    bookingFrom = json['bookingFrom'];
    bookingTo = json['bookingTo'];
  }
  int? id;
  String? roomName;
  num? monthRent;
  bool? isAvailable;
  String? availableFrom;
  AllowedTenants? allowedTenants;
  num? capacityAvailable;
  String? createdAt;
  String? status;
  String? bookingFrom;
  String? bookingTo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roomName'] = roomName;
    map['month_rent'] = monthRent;
    map['isAvailable'] = isAvailable;
    map['availableFrom'] = availableFrom;
    if (allowedTenants != null) {
      map['allowedTenants'] = allowedTenants?.toJson();
    }
    map['capacityAvailable'] = capacityAvailable;
    map['createdAt'] = createdAt;
    map['status'] = status;
    map['bookingFrom'] = bookingFrom;
    map['bookingTo'] = bookingTo;
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