/// isSuccess : true
/// message : "Request successful"
/// data : {"id":245,"hostId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","hostName":"Rahma Ibrahim ","roomName":"master suiteeeee","month_rent":10000,"deposit":100,"furnished":true,"availableFrom":"2026-06-10T22:14:26.550775","allowedTenants":{"allowsFamilies":false,"allowsChildren":false,"allowsStudents":false,"studentGender":"female","allowsWorkers":true,"workerGender":"female","petsAllowed":false},"amenities":{"airConditioning":true,"closet":true,"mirror":false,"fan":true},"street":"gshshjajaj","city":"Kantara West","government":"Ismailia","isSaved":false,"isPaid":false,"propertyImages":[{"id":666,"imageUrl":"https://graduationproject1.runasp.net/images/properties/f012d8dc-73b3-4666-b10e-9a73c78c5383_1000136238.jpg","isCover":true},{"id":667,"imageUrl":"https://graduationproject1.runasp.net/images/properties/9e79ec03-913f-4360-9f76-d4adf8d5d35a_1000137401.jpg","isCover":false}],"minimumStay":1,"capacity":3,"capacityAvailable":2,"enSuiteBathroom":false,"sharedBathroom":true,"balcony":false,"window":true,"profilePicture":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","petsAllowed":true,"blockedPeriods":[],"beds":[{"bedNumber":1,"blockedPeriods":[]},{"bedNumber":2,"blockedPeriods":[]},{"bedNumber":3,"blockedPeriods":[]}]}

class RoomDetailsResponse {
  RoomDetailsResponse({
      this.isSuccess,
      this.message,
      this.data,});

  RoomDetailsResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? RoomDetailsResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  RoomDetailsResponseData? data;
RoomDetailsResponse copyWith({  bool? isSuccess,
  String? message,
  RoomDetailsResponseData? data,
}) => RoomDetailsResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// id : 245
/// hostId : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// hostName : "Rahma Ibrahim "
/// roomName : "master suiteeeee"
/// month_rent : 10000
/// deposit : 100
/// furnished : true
/// availableFrom : "2026-06-10T22:14:26.550775"
/// allowedTenants : {"allowsFamilies":false,"allowsChildren":false,"allowsStudents":false,"studentGender":"female","allowsWorkers":true,"workerGender":"female","petsAllowed":false}
/// amenities : {"airConditioning":true,"closet":true,"mirror":false,"fan":true}
/// street : "gshshjajaj"
/// city : "Kantara West"
/// government : "Ismailia"
/// isSaved : false
/// isPaid : false
/// propertyImages : [{"id":666,"imageUrl":"https://graduationproject1.runasp.net/images/properties/f012d8dc-73b3-4666-b10e-9a73c78c5383_1000136238.jpg","isCover":true},{"id":667,"imageUrl":"https://graduationproject1.runasp.net/images/properties/9e79ec03-913f-4360-9f76-d4adf8d5d35a_1000137401.jpg","isCover":false}]
/// minimumStay : 1
/// capacity : 3
/// capacityAvailable : 2
/// enSuiteBathroom : false
/// sharedBathroom : true
/// balcony : false
/// window : true
/// profilePicture : "https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"
/// petsAllowed : true
/// blockedPeriods : []
/// beds : [{"bedNumber":1,"blockedPeriods":[]},{"bedNumber":2,"blockedPeriods":[]},{"bedNumber":3,"blockedPeriods":[]}]

class RoomDetailsResponseData {
  RoomDetailsResponseData({
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
      this.street,
      this.city,
      this.government,
      this.isSaved,
      this.isPaid,
      this.propertyImages,
      this.minimumStay,
      this.capacity,
      this.capacityAvailable,
      this.enSuiteBathroom,
      this.sharedBathroom,
      this.balcony,
      this.window,
      this.profilePicture,
      this.petsAllowed,
      this.blockedPeriods,
      this.beds,});

  RoomDetailsResponseData.fromJson(dynamic json) {
    id = json['id'];
    hostId = json['hostId'];
    hostName = json['hostName'];
    roomName = json['roomName'];
    monthRent = json['month_rent'];
    deposit = json['deposit'];
    furnished = json['furnished'];
    availableFrom = json['availableFrom'];
    allowedTenants = json['allowedTenants'] != null ? AllowedTenants.fromJson(json['allowedTenants']) : null;
    amenities = json['amenities'] != null ? Amenities.fromJson(json['amenities']) : null;
    street = json['street'];
    city = json['city'];
    government = json['government'];
    isSaved = json['isSaved'];
    isPaid = json['isPaid'];
    if (json['propertyImages'] != null) {
      propertyImages = [];
      json['propertyImages'].forEach((v) {
        propertyImages?.add(PropertyImages.fromJson(v));
      });
    }
    minimumStay = json['minimumStay'];
    capacity = json['capacity'];
    capacityAvailable = json['capacityAvailable'];
    enSuiteBathroom = json['enSuiteBathroom'];
    sharedBathroom = json['sharedBathroom'];
    balcony = json['balcony'];
    window = json['window'];
    profilePicture = json['profilePicture'];
    petsAllowed = json['petsAllowed'];
    if (json['blockedPeriods'] != null) {
      blockedPeriods = [];
      json['blockedPeriods'].forEach((v) {
        blockedPeriods?.add(BlockedPeriod.fromJson(v));
      });
    }
    if (json['beds'] != null) {
      beds = [];
      json['beds'].forEach((v) {
        beds?.add(Beds.fromJson(v));
      });
    }
  }
  num? id;
  String? hostId;
  String? hostName;
  String? roomName;
  num? monthRent;
  num? deposit;
  bool? furnished;
  String? availableFrom;
  AllowedTenants? allowedTenants;
  Amenities? amenities;
  String? street;
  String? city;
  String? government;
  bool? isSaved;
  bool? isPaid;
  List<PropertyImages>? propertyImages;
  num? minimumStay;
  num? capacity;
  num? capacityAvailable;
  bool? enSuiteBathroom;
  bool? sharedBathroom;
  bool? balcony;
  bool? window;
  String? profilePicture;
  bool? petsAllowed;
  List<dynamic>? blockedPeriods;
  List<Beds>? beds;
RoomDetailsResponseData copyWith({  num? id,
  String? hostId,
  String? hostName,
  String? roomName,
  num? monthRent,
  num? deposit,
  bool? furnished,
  String? availableFrom,
  AllowedTenants? allowedTenants,
  Amenities? amenities,
  String? street,
  String? city,
  String? government,
  bool? isSaved,
  bool? isPaid,
  List<PropertyImages>? propertyImages,
  num? minimumStay,
  num? capacity,
  num? capacityAvailable,
  bool? enSuiteBathroom,
  bool? sharedBathroom,
  bool? balcony,
  bool? window,
  String? profilePicture,
  bool? petsAllowed,
  List<BlockedPeriod>? blockedPeriods,
  List<Beds>? beds,
}) => RoomDetailsResponseData(  id: id ?? this.id,
  hostId: hostId ?? this.hostId,
  hostName: hostName ?? this.hostName,
  roomName: roomName ?? this.roomName,
  monthRent: monthRent ?? this.monthRent,
  deposit: deposit ?? this.deposit,
  furnished: furnished ?? this.furnished,
  availableFrom: availableFrom ?? this.availableFrom,
  allowedTenants: allowedTenants ?? this.allowedTenants,
  amenities: amenities ?? this.amenities,
  street: street ?? this.street,
  city: city ?? this.city,
  government: government ?? this.government,
  isSaved: isSaved ?? this.isSaved,
  isPaid: isPaid ?? this.isPaid,
  propertyImages: propertyImages ?? this.propertyImages,
  minimumStay: minimumStay ?? this.minimumStay,
  capacity: capacity ?? this.capacity,
  capacityAvailable: capacityAvailable ?? this.capacityAvailable,
  enSuiteBathroom: enSuiteBathroom ?? this.enSuiteBathroom,
  sharedBathroom: sharedBathroom ?? this.sharedBathroom,
  balcony: balcony ?? this.balcony,
  window: window ?? this.window,
  profilePicture: profilePicture ?? this.profilePicture,
  petsAllowed: petsAllowed ?? this.petsAllowed,
  blockedPeriods: blockedPeriods ?? this.blockedPeriods,
  beds: beds ?? this.beds,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['hostId'] = hostId;
    map['hostName'] = hostName;
    map['roomName'] = roomName;
    map['month_rent'] = monthRent;
    map['deposit'] = deposit;
    map['furnished'] = furnished;
    map['availableFrom'] = availableFrom;
    if (allowedTenants != null) {
      map['allowedTenants'] = allowedTenants?.toJson();
    }
    if (amenities != null) {
      map['amenities'] = amenities?.toJson();
    }
    map['street'] = street;
    map['city'] = city;
    map['government'] = government;
    map['isSaved'] = isSaved;
    map['isPaid'] = isPaid;
    if (propertyImages != null) {
      map['propertyImages'] = propertyImages?.map((v) => v.toJson()).toList();
    }
    map['minimumStay'] = minimumStay;
    map['capacity'] = capacity;
    map['capacityAvailable'] = capacityAvailable;
    map['enSuiteBathroom'] = enSuiteBathroom;
    map['sharedBathroom'] = sharedBathroom;
    map['balcony'] = balcony;
    map['window'] = window;
    map['profilePicture'] = profilePicture;
    map['petsAllowed'] = petsAllowed;
    if (blockedPeriods != null) {
      map['blockedPeriods'] = blockedPeriods?.map((v) => v.toJson()).toList();
    }
    if (beds != null) {
      map['beds'] = beds?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
class BlockedPeriod {
  final String? from;
  final String? to;

  BlockedPeriod({this.from, this.to});

  factory BlockedPeriod.fromJson(Map<String, dynamic> json) =>
      BlockedPeriod(from: json["from"], to: json["to"]);

  Map<String, dynamic> toJson() => {"from": from, "to": to};
}

/// bedNumber : 1
/// blockedPeriods : []

class Beds {
  Beds({
      this.bedNumber,
      this.blockedPeriods,});

  Beds.fromJson(dynamic json) {
    bedNumber = json['bedNumber'];
    if (json['blockedPeriods'] != null) {
      blockedPeriods = [];
      json['blockedPeriods'].forEach((v) {
        blockedPeriods?.add(BlockedPeriod.fromJson(v));
      });
    }
  }
  num? bedNumber;
  List<BlockedPeriod>? blockedPeriods;
Beds copyWith({  num? bedNumber,
  List<BlockedPeriod>? blockedPeriods,
}) => Beds(  bedNumber: bedNumber ?? this.bedNumber,
  blockedPeriods: blockedPeriods ?? this.blockedPeriods,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bedNumber'] = bedNumber;
    if (blockedPeriods != null) {
      map['blockedPeriods'] = blockedPeriods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 666
/// imageUrl : "https://graduationproject1.runasp.net/images/properties/f012d8dc-73b3-4666-b10e-9a73c78c5383_1000136238.jpg"
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

/// airConditioning : true
/// closet : true
/// mirror : false
/// fan : true

class Amenities {
  Amenities({
      this.airConditioning,
      this.closet,
      this.mirror,
      this.fan,});

  Amenities.fromJson(dynamic json) {
    airConditioning = json['airConditioning'];
    closet = json['closet'];
    mirror = json['mirror'];
    fan = json['fan'];
  }
  bool? airConditioning;
  bool? closet;
  bool? mirror;
  bool? fan;
Amenities copyWith({  bool? airConditioning,
  bool? closet,
  bool? mirror,
  bool? fan,
}) => Amenities(  airConditioning: airConditioning ?? this.airConditioning,
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

/// allowsFamilies : false
/// allowsChildren : false
/// allowsStudents : false
/// studentGender : "female"
/// allowsWorkers : true
/// workerGender : "female"
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
AllowedTenants copyWith({  bool? allowsFamilies,
  bool? allowsChildren,
  bool? allowsStudents,
  String? studentGender,
  bool? allowsWorkers,
  String? workerGender,
  bool? petsAllowed,
}) => AllowedTenants(  allowsFamilies: allowsFamilies ?? this.allowsFamilies,
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