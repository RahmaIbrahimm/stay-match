/// success : true
/// message : "Reviews retrieved successfully"
/// data : {"host":{"hostName":"Abanoub Yousry","hostId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","hostImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","isSuperHost":false,"yearsOfHosting":0,"responseRate":0,"responseTime":"No responses","isStayEaseProtected":true},"summary":{"averageRating":5,"totalReviews":1,"accuracy":5,"cleanliness":5,"location":5,"checkIn":5,"value":5,"communication":5,"distribution":{"5":1}},"reviews":[{"reviewId":3,"reviewerName":"Abanoub Yousry","reviewerImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","rating":5,"comment":"good goood","createdAt":"2026-05-10T11:00:10.3878531","hostResponse":null,"responseCreatedAt":null,"hostImage":null}]}

class GetPropertyReviews {
  GetPropertyReviews({this.success, this.message, this.data});

  GetPropertyReviews.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? GetApartmentReviewsData.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  GetApartmentReviewsData? data;

  GetPropertyReviews copyWith({bool? success, String? message, GetApartmentReviewsData? data}) =>
      GetPropertyReviews(
        success: success ?? this.success,
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

/// host : {"hostName":"Abanoub Yousry","hostId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","hostImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","isSuperHost":false,"yearsOfHosting":0,"responseRate":0,"responseTime":"No responses","isStayEaseProtected":true}
/// summary : {"averageRating":5,"totalReviews":1,"accuracy":5,"cleanliness":5,"location":5,"checkIn":5,"value":5,"communication":5,"distribution":{"5":1}}
/// reviews : [{"reviewId":3,"reviewerName":"Abanoub Yousry","reviewerImage":"https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg","rating":5,"comment":"good goood","createdAt":"2026-05-10T11:00:10.3878531","hostResponse":null,"responseCreatedAt":null,"hostImage":null}]

class GetApartmentReviewsData {
  GetApartmentReviewsData({this.host, this.summary, this.reviews});

  GetApartmentReviewsData.fromJson(dynamic json) {
    host = json['host'] != null ? Host.fromJson(json['host']) : null;
    summary = json['summary'] != null
        ? Summary.fromJson(json['summary'])
        : null;
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
  }

  Host? host;
  Summary? summary;
  List<Reviews>? reviews;

  GetApartmentReviewsData copyWith({Host? host, Summary? summary, List<Reviews>? reviews}) => GetApartmentReviewsData(
    host: host ?? this.host,
    summary: summary ?? this.summary,
    reviews: reviews ?? this.reviews,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (host != null) {
      map['host'] = host?.toJson();
    }
    if (summary != null) {
      map['summary'] = summary?.toJson();
    }
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// reviewId : 3
/// reviewerName : "Abanoub Yousry"
/// reviewerImage : "https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg"
/// rating : 5
/// comment : "good goood"
/// createdAt : "2026-05-10T11:00:10.3878531"
/// hostResponse : null
/// responseCreatedAt : null
/// hostImage : null

class Reviews {
  Reviews({
    this.reviewId,
    this.reviewerName,
    this.reviewerImage,
    this.rating,
    this.comment,
    this.createdAt,
    this.hostResponse,
    this.responseCreatedAt,
    this.hostImage,
  });

  Reviews.fromJson(dynamic json) {
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

  Reviews copyWith({
    int? reviewId,
    String? reviewerName,
    String? reviewerImage,
    num? rating,
    String? comment,
    String? createdAt,
    dynamic hostResponse,
    dynamic responseCreatedAt,
    dynamic hostImage,
  }) => Reviews(
    reviewId: reviewId ?? this.reviewId,
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

/// averageRating : 5
/// totalReviews : 1
/// accuracy : 5
/// cleanliness : 5
/// location : 5
/// checkIn : 5
/// value : 5
/// communication : 5
/// distribution : {"5":1}

class Summary {
  Summary({
    this.averageRating,
    this.totalReviews,
    this.accuracy,
    this.cleanliness,
    this.location,
    this.checkIn,
    this.value,
    this.communication,
    this.distribution,
  });

  Summary.fromJson(dynamic json) {
    averageRating = json['averageRating'];
    totalReviews = json['totalReviews'];
    accuracy = json['accuracy'];
    cleanliness = json['cleanliness'];
    location = json['location'];
    checkIn = json['checkIn'];
    value = json['value'];
    communication = json['communication'];
    distribution = json['distribution'] != null
        ? Distribution.fromJson(json['distribution'])
        : null;
  }

  num? averageRating;
  num? totalReviews;
  num? accuracy;
  num? cleanliness;
  num? location;
  num? checkIn;
  num? value;
  num? communication;
  Distribution? distribution;

  Summary copyWith({
    num? averageRating,
    num? totalReviews,
    num? accuracy,
    num? cleanliness,
    num? location,
    num? checkIn,
    num? value,
    num? communication,
    Distribution? distribution,
  }) => Summary(
    averageRating: averageRating ?? this.averageRating,
    totalReviews: totalReviews ?? this.totalReviews,
    accuracy: accuracy ?? this.accuracy,
    cleanliness: cleanliness ?? this.cleanliness,
    location: location ?? this.location,
    checkIn: checkIn ?? this.checkIn,
    value: value ?? this.value,
    communication: communication ?? this.communication,
    distribution: distribution ?? this.distribution,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['averageRating'] = averageRating;
    map['totalReviews'] = totalReviews;
    map['accuracy'] = accuracy;
    map['cleanliness'] = cleanliness;
    map['location'] = location;
    map['checkIn'] = checkIn;
    map['value'] = value;
    map['communication'] = communication;
    if (distribution != null) {
      map['distribution'] = distribution?.toJson();
    }
    return map;
  }
}

/// 5 : 1

class Distribution {
  Distribution({this.five, this.four, this.three, this.two, this.one});

  Distribution.fromJson(dynamic json) {
    one = json['1'];
    two = json['2'];
    three = json['3'];
    four = json['4'];
    five = json['5'];
  }

  int? one;
  int? two;
  int? three;
  int? four;
  int? five;

  Distribution copyWith({
    int? one,
    int? two,
    int? three,
    int? four,
    int? five,
  }) => Distribution();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['5'] = five;
    map['4'] = four;
    map['3'] = three;
    map['2'] = two;
    map['1'] = one;
    return map;
  }
}

/// hostName : "Abanoub Yousry"
/// hostId : "1121c342-dd7a-4a29-bc66-c94f6aa43212"
/// hostImage : "https://graduationproject1.runasp.net/images/ac9bf66b-fa35-4b6a-b148-2faf0d01a1b3.jpg"
/// isSuperHost : false
/// yearsOfHosting : 0
/// responseRate : 0
/// responseTime : "No responses"
/// isStayEaseProtected : true

class Host {
  Host({
    this.hostName,
    this.hostId,
    this.hostImage,
    this.isSuperHost,
    this.yearsOfHosting,
    this.responseRate,
    this.responseTime,
    this.isStayEaseProtected,
  });

  Host.fromJson(dynamic json) {
    hostName = json['hostName'];
    hostId = json['hostId'];
    hostImage = json['hostImage'];
    isSuperHost = json['isSuperHost'];
    yearsOfHosting = json['yearsOfHosting'];
    responseRate = json['responseRate'];
    responseTime = json['responseTime'];
    isStayEaseProtected = json['isStayEaseProtected'];
  }

  String? hostName;
  String? hostId;
  String? hostImage;
  bool? isSuperHost;
  int? yearsOfHosting;
  int? responseRate;
  String? responseTime;
  bool? isStayEaseProtected;

  Host copyWith({
    String? hostName,
    String? hostId,
    String? hostImage,
    bool? isSuperHost,
    int? yearsOfHosting,
    int? responseRate,
    String? responseTime,
    bool? isStayEaseProtected,
  }) => Host(
    hostName: hostName ?? this.hostName,
    hostId: hostId ?? this.hostId,
    hostImage: hostImage ?? this.hostImage,
    isSuperHost: isSuperHost ?? this.isSuperHost,
    yearsOfHosting: yearsOfHosting ?? this.yearsOfHosting,
    responseRate: responseRate ?? this.responseRate,
    responseTime: responseTime ?? this.responseTime,
    isStayEaseProtected: isStayEaseProtected ?? this.isStayEaseProtected,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hostName'] = hostName;
    map['hostId'] = hostId;
    map['hostImage'] = hostImage;
    map['isSuperHost'] = isSuperHost;
    map['yearsOfHosting'] = yearsOfHosting;
    map['responseRate'] = responseRate;
    map['responseTime'] = responseTime;
    map['isStayEaseProtected'] = isStayEaseProtected;
    return map;
  }
}