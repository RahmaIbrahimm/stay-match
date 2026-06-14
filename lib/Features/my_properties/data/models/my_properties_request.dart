/// properties : [{"id":0,"type":"string","status":"active","name":"string","city":"string","government":"string","street":"string","coverImageUrl":"string","createdAt":"2026-04-18T07:57:00.711Z","lastModifiedAt":"2026-04-18T07:57:00.711Z"}]
/// totalCount : 0
/// page : 0
/// pageSize : 0

class MyPropertiesRequest {
  MyPropertiesRequest({
      this.properties, 
      this.totalCount, 
      this.page, 
      this.pageSize,});

  MyPropertiesRequest.fromJson(dynamic json) {
    if (json['properties'] != null) {
      properties = [];
      json['properties'].forEach((v) {
        properties?.add(PropertiesRequest.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    page = json['page'];
    pageSize = json['pageSize'];
  }
  List<PropertiesRequest>? properties;
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

/// id : 0
/// type : "string"
/// status : "active"
/// name : "string"
/// city : "string"
/// government : "string"
/// street : "string"
/// coverImageUrl : "string"
/// createdAt : "2026-04-18T07:57:00.711Z"
/// lastModifiedAt : "2026-04-18T07:57:00.711Z"

class PropertiesRequest {
  PropertiesRequest({
      this.id, 
      this.type, 
      this.status, 
      this.name, 
      this.city, 
      this.government, 
      this.street, 
      this.coverImageUrl, 
      this.createdAt, 
      this.lastModifiedAt,});

  PropertiesRequest.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    status = json['status'];
    name = json['name'];
    city = json['city'];
    government = json['government'];
    street = json['street'];
    coverImageUrl = json['coverImageUrl'];
    createdAt = json['createdAt'];
    lastModifiedAt = json['lastModifiedAt'];
  }
  int? id;
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