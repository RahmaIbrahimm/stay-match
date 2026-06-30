/// success : true
/// message : "User profile retrieved successfully"
/// data : {"hostInfo":{"hostId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","hostName":"Abanoub Yousry","hostImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","status":"Pending","rating":3.5555555555555554,"rentalsCount":11,"reviewsCount":6,"isSuperHost":false},"activeListings":[{"propertyId":110,"roomId":null,"title":"Luxury Cozy Apartment near City Center","city":"Basateen","government":"Cairo","image":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","type":"APARTMENT","rating":0,"beds":2,"baths":1,"size":120,"capacity":null,"sharedBathroom":null,"wifi":true},{"propertyId":111,"roomId":null,"title":"Luxury Cozy Apartment near City Center","city":"Basateen","government":"Cairo","image":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","type":"APARTMENT","rating":0,"beds":2,"baths":1,"size":120,"capacity":null,"sharedBathroom":null,"wifi":true}],"recentReviews":[{"reviewId":11,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3.3333333333333335,"comment":"new revie !!","createdAt":"2026-06-12T16:07:38.009313","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":10,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3.3333333333333335,"comment":"ffffff","createdAt":"2026-06-12T15:39:11.5022756","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":9,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3.1666666666666665,"comment":"cccccccccccccc","createdAt":"2026-06-11T22:18:34.0090645","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":6,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3,"comment":"great stay would do it again !!","createdAt":"2026-06-11T20:35:23.6468483","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":4,"reviewerName":"Beshoy roshdy","reviewerImage":null,"rating":3.5,"comment":"uoiuou","createdAt":"2026-05-12T14:27:17","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":3,"reviewerName":"Abanoub Yousry","reviewerImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","rating":5,"comment":"good goood","createdAt":"2026-05-10T11:00:10.3878531","hostResponse":null,"responseCreatedAt":null,"hostImage":null}],"totalListings":43,"totalProperties":13,"totalRooms":30}

class OtherUserProfileResponse {
  OtherUserProfileResponse({
      this.success, 
      this.message, 
      this.data,});

  OtherUserProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? OtherUserProfileResponseData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  OtherUserProfileResponseData? data;
OtherUserProfileResponse copyWith({  bool? success,
  String? message,
  OtherUserProfileResponseData? data,
}) => OtherUserProfileResponse(  success: success ?? this.success,
  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// hostInfo : {"hostId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","hostName":"Abanoub Yousry","hostImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","status":"Pending","rating":3.5555555555555554,"rentalsCount":11,"reviewsCount":6,"isSuperHost":false}
/// activeListings : [{"propertyId":110,"roomId":null,"title":"Luxury Cozy Apartment near City Center","city":"Basateen","government":"Cairo","image":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","type":"APARTMENT","rating":0,"beds":2,"baths":1,"size":120,"capacity":null,"sharedBathroom":null,"wifi":true},{"propertyId":111,"roomId":null,"title":"Luxury Cozy Apartment near City Center","city":"Basateen","government":"Cairo","image":"https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg","type":"APARTMENT","rating":0,"beds":2,"baths":1,"size":120,"capacity":null,"sharedBathroom":null,"wifi":true}]
/// recentReviews : [{"reviewId":11,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3.3333333333333335,"comment":"new revie !!","createdAt":"2026-06-12T16:07:38.009313","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":10,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3.3333333333333335,"comment":"ffffff","createdAt":"2026-06-12T15:39:11.5022756","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":9,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3.1666666666666665,"comment":"cccccccccccccc","createdAt":"2026-06-11T22:18:34.0090645","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":6,"reviewerName":"Rahma Ibrahim ","reviewerImage":"https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png","rating":3,"comment":"great stay would do it again !!","createdAt":"2026-06-11T20:35:23.6468483","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":4,"reviewerName":"Beshoy roshdy","reviewerImage":null,"rating":3.5,"comment":"uoiuou","createdAt":"2026-05-12T14:27:17","hostResponse":null,"responseCreatedAt":null,"hostImage":null},{"reviewId":3,"reviewerName":"Abanoub Yousry","reviewerImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","rating":5,"comment":"good goood","createdAt":"2026-05-10T11:00:10.3878531","hostResponse":null,"responseCreatedAt":null,"hostImage":null}]
/// totalListings : 43
/// totalProperties : 13
/// totalRooms : 30

class OtherUserProfileResponseData {
  OtherUserProfileResponseData({
      this.hostInfo, 
      this.activeListings, 
      this.recentReviews, 
      this.totalListings, 
      this.totalProperties, 
      this.totalRooms,});

  OtherUserProfileResponseData.fromJson(dynamic json) {
    hostInfo = json['hostInfo'] != null ? HostInfo.fromJson(json['hostInfo']) : null;
    if (json['activeListings'] != null) {
      activeListings = [];
      json['activeListings'].forEach((v) {
        activeListings?.add(ActiveListings.fromJson(v));
      });
    }
    if (json['recentReviews'] != null) {
      recentReviews = [];
      json['recentReviews'].forEach((v) {
        recentReviews?.add(RecentReviews.fromJson(v));
      });
    }
    totalListings = json['totalListings'];
    totalProperties = json['totalProperties'];
    totalRooms = json['totalRooms'];
  }
  HostInfo? hostInfo;
  List<ActiveListings>? activeListings;
  List<RecentReviews>? recentReviews;
  int? totalListings;
  int? totalProperties;
  int? totalRooms;
OtherUserProfileResponseData copyWith({  HostInfo? hostInfo,
  List<ActiveListings>? activeListings,
  List<RecentReviews>? recentReviews,
  int? totalListings,
  int? totalProperties,
  int? totalRooms,
}) => OtherUserProfileResponseData(  hostInfo: hostInfo ?? this.hostInfo,
  activeListings: activeListings ?? this.activeListings,
  recentReviews: recentReviews ?? this.recentReviews,
  totalListings: totalListings ?? this.totalListings,
  totalProperties: totalProperties ?? this.totalProperties,
  totalRooms: totalRooms ?? this.totalRooms,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hostInfo != null) {
      map['hostInfo'] = hostInfo?.toJson();
    }
    if (activeListings != null) {
      map['activeListings'] = activeListings?.map((v) => v.toJson()).toList();
    }
    if (recentReviews != null) {
      map['recentReviews'] = recentReviews?.map((v) => v.toJson()).toList();
    }
    map['totalListings'] = totalListings;
    map['totalProperties'] = totalProperties;
    map['totalRooms'] = totalRooms;
    return map;
  }

}

/// reviewId : 11
/// reviewerName : "Rahma Ibrahim "
/// reviewerImage : "https://graduationproject1.runasp.net/images/87fc98bc-09fa-4dc7-abe4-a60753c14308.png"
/// rating : 3.3333333333333335
/// comment : "new revie !!"
/// createdAt : "2026-06-12T16:07:38.009313"
/// hostResponse : null
/// responseCreatedAt : null
/// hostImage : null

class RecentReviews {
  RecentReviews({
      this.reviewId, 
      this.reviewerName, 
      this.reviewerImage, 
      this.rating, 
      this.comment, 
      this.createdAt, 
      this.hostResponse, 
      this.responseCreatedAt, 
      this.hostImage,});

  RecentReviews.fromJson(dynamic json) {
    reviewId = json['reviewId'];
    reviewerName = json['reviewerName'];
    reviewerImage = json['reviewerImage'];
    rating = json['rating'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    hostResponse = json['hostResponse'];
    responseCreatedAt = json['responseCreatedAt'];
    hostImage = json['hostImage'];
  }
  int? reviewId;
  String? reviewerName;
  String? reviewerImage;
  num? rating;
  String? comment;
  String? createdAt;
  dynamic hostResponse;
  dynamic responseCreatedAt;
  dynamic hostImage;
RecentReviews copyWith({  int? reviewId,
  String? reviewerName,
  String? reviewerImage,
  num? rating,
  String? comment,
  String? createdAt,
  dynamic hostResponse,
  dynamic responseCreatedAt,
  dynamic hostImage,
}) => RecentReviews(  reviewId: reviewId ?? this.reviewId,
  reviewerName: reviewerName ?? this.reviewerName,
  reviewerImage: reviewerImage ?? this.reviewerImage,
  rating: rating ?? this.rating,
  comment: comment ?? this.comment,
  createdAt: createdAt ?? this.createdAt,
  hostResponse: hostResponse ?? this.hostResponse,
  responseCreatedAt: responseCreatedAt ?? this.responseCreatedAt,
  hostImage: hostImage ?? this.hostImage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reviewId'] = reviewId;
    map['reviewerName'] = reviewerName;
    map['reviewerImage'] = reviewerImage;
    map['rating'] = rating;
    map['comment'] = comment;
    map['createdAt'] = createdAt;
    map['hostResponse'] = hostResponse;
    map['responseCreatedAt'] = responseCreatedAt;
    map['hostImage'] = hostImage;
    return map;
  }

}

/// propertyId : 110
/// roomId : null
/// title : "Luxury Cozy Apartment near City Center"
/// city : "Basateen"
/// government : "Cairo"
/// image : "https://graduationproject1.runasp.net/images/properties/2f50dc01-5dbc-409a-bc86-de7efabd336f_OIP.jpg"
/// type : "APARTMENT"
/// rating : 0
/// beds : 2
/// baths : 1
/// size : 120
/// capacity : null
/// sharedBathroom : null
/// wifi : true

class ActiveListings {
  ActiveListings({
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

  ActiveListings.fromJson(dynamic json) {
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
  int? propertyId;
  dynamic roomId;
  String? title;
  String? city;
  String? government;
  String? image;
  String? type;
  num? rating;
  int? beds;
  int? baths;
  num? size;
  dynamic capacity;
  dynamic sharedBathroom;
  bool? wifi;
ActiveListings copyWith({  int? propertyId,
  dynamic roomId,
  String? title,
  String? city,
  String? government,
  String? image,
  String? type,
  int? rating,
  int? beds,
  int? baths,
  num? size,
  dynamic capacity,
  dynamic sharedBathroom,
  bool? wifi,
}) => ActiveListings(  propertyId: propertyId ?? this.propertyId,
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

/// hostId : "1121c342-dd7a-4a29-bc66-c94f6aa43212"
/// hostName : "Abanoub Yousry"
/// hostImage : "https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg"
/// status : "Pending"
/// rating : 3.5555555555555554
/// rentalsCount : 11
/// reviewsCount : 6
/// isSuperHost : false

class HostInfo {
  HostInfo({
      this.hostId, 
      this.hostName, 
      this.hostImage, 
      this.status, 
      this.rating, 
      this.rentalsCount, 
      this.reviewsCount, 
      this.isSuperHost,});

  HostInfo.fromJson(dynamic json) {
    hostId = json['hostId'];
    hostName = json['hostName'];
    hostImage = json['hostImage'];
    status = json['status'];
    rating = json['rating'];
    rentalsCount = json['rentalsCount'];
    reviewsCount = json['reviewsCount'];
    isSuperHost = json['isSuperHost'];
  }
  String? hostId;
  String? hostName;
  String? hostImage;
  String? status;
  num? rating;
  int? rentalsCount;
  int? reviewsCount;
  bool? isSuperHost;
HostInfo copyWith({  String? hostId,
  String? hostName,
  String? hostImage,
  String? status,
  num? rating,
  int? rentalsCount,
  int? reviewsCount,
  bool? isSuperHost,
}) => HostInfo(  hostId: hostId ?? this.hostId,
  hostName: hostName ?? this.hostName,
  hostImage: hostImage ?? this.hostImage,
  status: status ?? this.status,
  rating: rating ?? this.rating,
  rentalsCount: rentalsCount ?? this.rentalsCount,
  reviewsCount: reviewsCount ?? this.reviewsCount,
  isSuperHost: isSuperHost ?? this.isSuperHost,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hostId'] = hostId;
    map['hostName'] = hostName;
    map['hostImage'] = hostImage;
    map['status'] = status;
    map['rating'] = rating;
    map['rentalsCount'] = rentalsCount;
    map['reviewsCount'] = reviewsCount;
    map['isSuperHost'] = isSuperHost;
    return map;
  }

}