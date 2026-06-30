/// success : true
/// message : "User listings retrieved successfully"
/// data : [{"propertyId":3,"roomId":1,"title":"Master Bedroom with En-Suite","city":"Maadi","government":"Cairo","image":"https://images.unsplash.com/photo-1616594039964-ae9021a400a0?q=80&w=1200&auto=format&fit=crop","type":"PRIVATE ROOM","rating":0,"beds":null,"baths":1,"size":160,"capacity":1,"sharedBathroom":false,"wifi":true},{"propertyId":3,"roomId":2,"title":"Premium Double Room (Shared Bathroom)","city":"Maadi","government":"Cairo","image":"https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=1200&auto=format&fit=crop","type":"PRIVATE ROOM","rating":0,"beds":null,"baths":0,"size":160,"capacity":1,"sharedBathroom":true,"wifi":true},{"propertyId":3,"roomId":3,"title":"Standard Single Room","city":"Maadi","government":"Cairo","image":"https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?q=80&w=1200&auto=format&fit=crop","type":"PRIVATE ROOM","rating":0,"beds":null,"baths":0,"size":160,"capacity":1,"sharedBathroom":true,"wifi":true}]

class UserListingsResponse {
  UserListingsResponse({
      this.success, 
      this.message, 
      this.data,});

  UserListingsResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<Data>? data;
UserListingsResponse copyWith({  bool? success,
  String? message,
  List<Data>? data,
}) => UserListingsResponse(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// propertyId : 3
/// roomId : 1
/// title : "Master Bedroom with En-Suite"
/// city : "Maadi"
/// government : "Cairo"
/// image : "https://images.unsplash.com/photo-1616594039964-ae9021a400a0?q=80&w=1200&auto=format&fit=crop"
/// type : "PRIVATE ROOM"
/// rating : 0
/// beds : null
/// baths : 1
/// size : 160
/// capacity : 1
/// sharedBathroom : false
/// wifi : true

class Data {
  Data({
      this.propertyId, 
      this.roomId, 
      this.title, 
      this.city, 
      this.government, 
      this.image, 
      this.type, 
      this.rating, 
      this.beds, 
      this.baths, 
      this.size, 
      this.capacity, 
      this.sharedBathroom, 
      this.wifi,});

  Data.fromJson(dynamic json) {
    propertyId = json['propertyId'];
    roomId = json['roomId'];
    title = json['title'];
    city = json['city'];
    government = json['government'];
    image = json['image'];
    type = json['type'];
    rating = json['rating'];
    beds = json['beds'];
    baths = json['baths'];
    size = json['size'];
    capacity = json['capacity'];
    sharedBathroom = json['sharedBathroom'];
    wifi = json['wifi'];
  }
  num? propertyId;
  num? roomId;
  String? title;
  String? city;
  String? government;
  String? image;
  String? type;
  num? rating;
  dynamic beds;
  num? baths;
  num? size;
  num? capacity;
  bool? sharedBathroom;
  bool? wifi;
Data copyWith({  num? propertyId,
  num? roomId,
  String? title,
  String? city,
  String? government,
  String? image,
  String? type,
  num? rating,
  dynamic beds,
  num? baths,
  num? size,
  num? capacity,
  bool? sharedBathroom,
  bool? wifi,
}) => Data(  propertyId: propertyId ?? this.propertyId,
  roomId: roomId ?? this.roomId,
  title: title ?? this.title,
  city: city ?? this.city,
  government: government ?? this.government,
  image: image ?? this.image,
  type: type ?? this.type,
  rating: rating ?? this.rating,
  beds: beds ?? this.beds,
  baths: baths ?? this.baths,
  size: size ?? this.size,
  capacity: capacity ?? this.capacity,
  sharedBathroom: sharedBathroom ?? this.sharedBathroom,
  wifi: wifi ?? this.wifi,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    map['roomId'] = roomId;
    map['title'] = title;
    map['city'] = city;
    map['government'] = government;
    map['image'] = image;
    map['type'] = type;
    map['rating'] = rating;
    map['beds'] = beds;
    map['baths'] = baths;
    map['size'] = size;
    map['capacity'] = capacity;
    map['sharedBathroom'] = sharedBathroom;
    map['wifi'] = wifi;
    return map;
  }

}