/// isSuccess : true
/// message : "Request successful"
/// data : {"properties":[{"id":145,"type":"APARTMENT","status":"Pending_Approval","name":"adfgaagggg","city":"Abu Teeg","government":"Asyut","street":"retwq","coverImageUrl":"https://graduationproject1.runasp.net/images/properties/97d966d8-bfa7-4640-8fb3-fd7bfb068125_39.png","createdAt":"2026-04-18T00:00:00","lastModifiedAt":"2026-04-18T00:00:00"},{"id":144,"type":"APARTMENT","status":"active","name":"ffffffffffff","city":"Abu Teeg","government":"Asyut","street":"swdfsasdf","coverImageUrl":"/data/user/0/com.example.stay_match/cache/4cfacdad-cc6f-4caa-836c-66e8c890c9c0/36.png","createdAt":"2026-04-17T00:00:00","lastModifiedAt":"2026-04-17T00:00:00"},{"id":142,"type":"APARTMENT","status":"active","name":"Sunny Garden Apartment","city":"Ashmoun","government":"Menofia","street":"23 Nile Corniche","coverImageUrl":"https://example.com/images/cover.jpg","createdAt":"2026-04-16T00:00:00","lastModifiedAt":"2026-04-16T00:00:00"},{"id":143,"type":"APARTMENT","status":"active","name":"Sunny Garden Apartment","city":"Ashmoun","government":"Menofia","street":"23 Nile Corniche","coverImageUrl":"https://example.com/images/cover.jpg","createdAt":"2026-04-16T00:00:00","lastModifiedAt":"2026-04-16T00:00:00"},{"id":139,"type":"APARTMENT","status":"under_review","name":"property1234","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-13T00:00:00","lastModifiedAt":"2026-04-13T00:00:00"},{"id":140,"type":"Shared","status":"under_review","name":"room1234567","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-13T00:00:00","lastModifiedAt":"2026-04-13T00:00:00"},{"id":141,"type":"Shared","status":"under_review","name":"room1234567","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-13T00:00:00","lastModifiedAt":"2026-04-13T00:00:00"}],"totalCount":7,"page":1,"pageSize":10}

class MyPropertiesResponse {
  MyPropertiesResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  MyPropertiesResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? MyPropertiesData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  MyPropertiesData? data;

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

/// properties : [{"id":145,"type":"APARTMENT","status":"Pending_Approval","name":"adfgaagggg","city":"Abu Teeg","government":"Asyut","street":"retwq","coverImageUrl":"https://graduationproject1.runasp.net/images/properties/97d966d8-bfa7-4640-8fb3-fd7bfb068125_39.png","createdAt":"2026-04-18T00:00:00","lastModifiedAt":"2026-04-18T00:00:00"},{"id":144,"type":"APARTMENT","status":"active","name":"ffffffffffff","city":"Abu Teeg","government":"Asyut","street":"swdfsasdf","coverImageUrl":"/data/user/0/com.example.stay_match/cache/4cfacdad-cc6f-4caa-836c-66e8c890c9c0/36.png","createdAt":"2026-04-17T00:00:00","lastModifiedAt":"2026-04-17T00:00:00"},{"id":142,"type":"APARTMENT","status":"active","name":"Sunny Garden Apartment","city":"Ashmoun","government":"Menofia","street":"23 Nile Corniche","coverImageUrl":"https://example.com/images/cover.jpg","createdAt":"2026-04-16T00:00:00","lastModifiedAt":"2026-04-16T00:00:00"},{"id":143,"type":"APARTMENT","status":"active","name":"Sunny Garden Apartment","city":"Ashmoun","government":"Menofia","street":"23 Nile Corniche","coverImageUrl":"https://example.com/images/cover.jpg","createdAt":"2026-04-16T00:00:00","lastModifiedAt":"2026-04-16T00:00:00"},{"id":139,"type":"APARTMENT","status":"under_review","name":"property1234","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-13T00:00:00","lastModifiedAt":"2026-04-13T00:00:00"},{"id":140,"type":"Shared","status":"under_review","name":"room1234567","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-13T00:00:00","lastModifiedAt":"2026-04-13T00:00:00"},{"id":141,"type":"Shared","status":"under_review","name":"room1234567","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-13T00:00:00","lastModifiedAt":"2026-04-13T00:00:00"}]
/// totalCount : 7
/// page : 1
/// pageSize : 10

class MyPropertiesData {
  MyPropertiesData({
      this.properties, 
      this.totalCount, 
      this.page, 
      this.pageSize,});

  MyPropertiesData.fromJson(dynamic json) {
    if (json['properties'] != null) {
      properties = [];
      json['properties'].forEach((v) {
        properties?.add(Properties.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    page = json['page'];
    pageSize = json['pageSize'];
  }
  List<Properties>? properties;
  int? totalCount;
  int? page;
  int? pageSize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (properties != null) {
      map['properties'] = properties?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = totalCount;
    map['page'] = page;
    map['pageSize'] = pageSize;
    return map;
  }

}

/// id : 145
/// type : "APARTMENT"
/// status : "Pending_Approval"
/// name : "adfgaagggg"
/// city : "Abu Teeg"
/// government : "Asyut"
/// street : "retwq"
/// coverImageUrl : "https://graduationproject1.runasp.net/images/properties/97d966d8-bfa7-4640-8fb3-fd7bfb068125_39.png"
/// createdAt : "2026-04-18T00:00:00"
/// lastModifiedAt : "2026-04-18T00:00:00"

class Properties {
  Properties({
      this.id, 
      this.type, 
      this.status, 
      this.name, 
      this.city, 
      this.government, 
      this.monthlyRent,
      this.street,
      this.coverImageUrl, 
      this.createdAt, 
      this.lastModifiedAt,});

  Properties.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    name = json['name'];
    city = json['city'];
    monthlyRent = json['monthlyRent'];
    government = json['government'];
    street = json['street'];
    coverImageUrl = json['coverImageUrl'];
    createdAt = json['createdAt'];
    lastModifiedAt = json['lastModifiedAt'];
  }
  int? id;
  double? monthlyRent;
  String? type;
  String? status;
  String? name;
  String? city;
  String? government;
  String? street;
  String? coverImageUrl;
  String? createdAt;
  String? lastModifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['monthlyRent'] = monthlyRent;
    map['type'] = type;
    map['status'] = status;
    map['name'] = name;
    map['city'] = city;
    map['government'] = government;
    map['street'] = street;
    map['coverImageUrl'] = coverImageUrl;
    map['createdAt'] = createdAt;
    map['lastModifiedAt'] = lastModifiedAt;
    return map;
  }

}