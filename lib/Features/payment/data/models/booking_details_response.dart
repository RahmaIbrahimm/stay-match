/// isSuccess : true
/// message : "Request successful"
/// data : {"id":117,"startDate":"2026-06-13T22:06:36.974","endDate":"2026-05-12T21:55:56","duration":3,"totalPrice":13500,"monthlyPrice":4500,"status":"Completed","bookingType":"Room","createdAt":"2026-06-11T22:07:28.1506725","property":{"id":127,"name":"Modern Shared Apartment - El Shorouk City","street":"El Horreya Road","city":"Basateen","government":"Cairo","propertyType":"Shared","images":[{"id":514,"imageUrl":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","isCover":true}]},"room":{"id":201,"roomName":"Master Bedroom with Balcony","month_rent":4500,"capacity":2,"capacityAvailable":1,"images":[{"id":515,"imageUrl":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","isCover":true}]},"renter":{"id":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","name":"Rahma Ibrahim","email":"rahmaibrahim315@gmail.com","phoneNumber":"01064097980","profilePicture":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"},"host":{"id":"1121c342-dd7a-4a29-bc66-c94f6aa43212","name":"abanoub yousry","email":"user@example.com","phoneNumber":""}}

class BookingDetailsResponse {
  BookingDetailsResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  BookingDetailsResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? BookingDetailsResponseData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  BookingDetailsResponseData? data;
BookingDetailsResponse copyWith({  bool? isSuccess,
  String? message,
  BookingDetailsResponseData? data,
}) => BookingDetailsResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// id : 117
/// startDate : "2026-06-13T22:06:36.974"
/// endDate : "2026-05-12T21:55:56"
/// duration : 3
/// totalPrice : 13500
/// monthlyPrice : 4500
/// status : "Completed"
/// bookingType : "Room"
/// createdAt : "2026-06-11T22:07:28.1506725"
/// property : {"id":127,"name":"Modern Shared Apartment - El Shorouk City","street":"El Horreya Road","city":"Basateen","government":"Cairo","propertyType":"Shared","images":[{"id":514,"imageUrl":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","isCover":true}]}
/// room : {"id":201,"roomName":"Master Bedroom with Balcony","month_rent":4500,"capacity":2,"capacityAvailable":1,"images":[{"id":515,"imageUrl":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","isCover":true}]}
/// renter : {"id":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","name":"Rahma Ibrahim","email":"rahmaibrahim315@gmail.com","phoneNumber":"01064097980","profilePicture":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"}
/// host : {"id":"1121c342-dd7a-4a29-bc66-c94f6aa43212","name":"abanoub yousry","email":"user@example.com","phoneNumber":""}

class BookingDetailsResponseData {
  BookingDetailsResponseData({
      this.id, 
      this.startDate, 
      this.endDate, 
      this.duration, 
      this.totalPrice, 
      this.monthlyPrice, 
      this.status, 
      this.bookingType, 
      this.createdAt, 
      this.property, 
      this.room, 
      this.renter, 
      this.host,});

  BookingDetailsResponseData.fromJson(dynamic json) {
    id = json['id'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    duration = json['duration'];
    totalPrice = json['totalPrice'];
    monthlyPrice = json['monthlyPrice'];
    status = json['status'];
    bookingType = json['bookingType'];
    createdAt = json['createdAt'];
    property = json['property'] != null ? Property.fromJson(json['property']) : null;
    room = json['room'] != null ? Room.fromJson(json['room']) : null;
    renter = json['renter'] != null ? Renter.fromJson(json['renter']) : null;
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
  }
  int? id;
  String? startDate;
  String? endDate;
  int? duration;
  num? totalPrice;
  num? monthlyPrice;
  String? status;
  String? bookingType;
  String? createdAt;
  Property? property;
  Room? room;
  Renter? renter;
  Host? host;
BookingDetailsResponseData copyWith({  int? id,
  String? startDate,
  String? endDate,
  int? duration,
  num? totalPrice,
  num? monthlyPrice,
  String? status,
  String? bookingType,
  String? createdAt,
  Property? property,
  Room? room,
  Renter? renter,
  Host? host,
}) => BookingDetailsResponseData(  id: id ?? this.id,
  startDate: startDate ?? this.startDate,
  endDate: endDate ?? this.endDate,
  duration: duration ?? this.duration,
  totalPrice: totalPrice ?? this.totalPrice,
  monthlyPrice: monthlyPrice ?? this.monthlyPrice,
  status: status ?? this.status,
  bookingType: bookingType ?? this.bookingType,
  createdAt: createdAt ?? this.createdAt,
  property: property ?? this.property,
  room: room ?? this.room,
  renter: renter ?? this.renter,
  host: host ?? this.host,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['duration'] = duration;
    map['totalPrice'] = totalPrice;
    map['monthlyPrice'] = monthlyPrice;
    map['status'] = status;
    map['bookingType'] = bookingType;
    map['createdAt'] = createdAt;
    if (property != null) {
      map['property'] = property?.toJson();
    }
    if (room != null) {
      map['room'] = room?.toJson();
    }
    if (renter != null) {
      map['renter'] = renter?.toJson();
    }
    if (host != null) {
      map['host'] = host?.toJson();
    }
    return map;
  }

}

/// id : "1121c342-dd7a-4a29-bc66-c94f6aa43212"
/// name : "abanoub yousry"
/// email : "user@example.com"
/// phoneNumber : ""

class Host {
  Host({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNumber,});

  Host.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
Host copyWith({  String? id,
  String? name,
  String? email,
  String? phoneNumber,
}) => Host(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  phoneNumber: phoneNumber ?? this.phoneNumber,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    return map;
  }

}

/// id : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// name : "Rahma Ibrahim"
/// email : "rahmaibrahim315@gmail.com"
/// phoneNumber : "01064097980"
/// profilePicture : "https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"

class Renter {
  Renter({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNumber, 
      this.profilePicture,});

  Renter.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    profilePicture = json['profilePicture'];
  }
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profilePicture;
Renter copyWith({  String? id,
  String? name,
  String? email,
  String? phoneNumber,
  String? profilePicture,
}) => Renter(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  profilePicture: profilePicture ?? this.profilePicture,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['profilePicture'] = profilePicture;
    return map;
  }

}

/// id : 201
/// roomName : "Master Bedroom with Balcony"
/// month_rent : 4500
/// capacity : 2
/// capacityAvailable : 1
/// images : [{"id":515,"imageUrl":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","isCover":true}]

class Room {
  Room({
      this.id, 
      this.roomName, 
      this.monthRent, 
      this.capacity, 
      this.capacityAvailable, 
      this.images,});

  Room.fromJson(dynamic json) {
    id = json['id'];
    roomName = json['roomName'];
    monthRent = json['month_rent'];
    capacity = json['capacity'];
    capacityAvailable = json['capacityAvailable'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(RoomImages.fromJson(v));
      });
    }
  }
  int? id;
  String? roomName;
  num? monthRent;
  int? capacity;
  int? capacityAvailable;
  List<RoomImages>? images;
Room copyWith({  int? id,
  String? roomName,
  num? monthRent,
  int? capacity,
  int? capacityAvailable,
  List<RoomImages>? images,
}) => Room(  id: id ?? this.id,
  roomName: roomName ?? this.roomName,
  monthRent: monthRent ?? this.monthRent,
  capacity: capacity ?? this.capacity,
  capacityAvailable: capacityAvailable ?? this.capacityAvailable,
  images: images ?? this.images,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['roomName'] = roomName;
    map['month_rent'] = monthRent;
    map['capacity'] = capacity;
    map['capacityAvailable'] = capacityAvailable;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 515
/// imageUrl : "https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg"
/// isCover : true

class Images {
  Images({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  Images.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;
Images copyWith({  int? id,
  String? imageUrl,
  bool? isCover,
}) => Images(  id: id ?? this.id,
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

/// id : 127
/// name : "Modern Shared Apartment - El Shorouk City"
/// street : "El Horreya Road"
/// city : "Basateen"
/// government : "Cairo"
/// propertyType : "Shared"
/// images : [{"id":514,"imageUrl":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","isCover":true}]

class Property {
  Property({
      this.id, 
      this.name, 
      this.street, 
      this.city, 
      this.government, 
      this.propertyType, 
      this.images,});

  Property.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    street = json['street'];
    city = json['city'];
    government = json['government'];
    propertyType = json['propertyType'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(RoomImages.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? street;
  String? city;
  String? government;
  String? propertyType;
  List<RoomImages>? images;
Property copyWith({  int? id,
  String? name,
  String? street,
  String? city,
  String? government,
  String? propertyType,
  List<RoomImages>? images,
}) => Property(  id: id ?? this.id,
  name: name ?? this.name,
  street: street ?? this.street,
  city: city ?? this.city,
  government: government ?? this.government,
  propertyType: propertyType ?? this.propertyType,
  images: images ?? this.images,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['street'] = street;
    map['city'] = city;
    map['government'] = government;
    map['propertyType'] = propertyType;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 514
/// imageUrl : "https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg"
/// isCover : true

class RoomImages {
  RoomImages({
      this.id, 
      this.imageUrl, 
      this.isCover,});

  RoomImages.fromJson(dynamic json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    isCover = json['isCover'];
  }
  int? id;
  String? imageUrl;
  bool? isCover;
RoomImages copyWith({  int? id,
  String? imageUrl,
  bool? isCover,
}) => RoomImages(  id: id ?? this.id,
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