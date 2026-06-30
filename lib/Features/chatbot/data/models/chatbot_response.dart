/// reply : "string"
/// response_type : "message"
/// pending_slot : "string"
/// filters : {"intent":"string","search_type":"string","housing_type":"string","city":"string","governorate":"string","min_price":0,"max_price":0,"tenant_type":"string","furnished":true,"wifi":true,"private_bathroom":true,"balcony":true,"air_conditioning":true,"gender":"string","shared_room":true,"sort_by":"string"}
/// suggestions : [{"label":"string","value":"string"}]
/// results : [{"id":0,"result_type":"string","title":"string","subtitle":"string","location":"string","price_text":"string","monthly_rent":0,"deposit":0,"details":["string"],"amenities":["string"],"attributes":{"additionalProp1":{}},"recommendation_score":0}]
/// pagination : {"page":1,"page_size":5,"has_more":false}

class ChatbotResponse {
  ChatbotResponse({
      this.reply, 
      this.responseType, 
      this.pendingSlot, 
      this.filters, 
      this.suggestions, 
      this.results, 
      this.pagination,});

  ChatbotResponse.fromJson(dynamic json) {
    reply = json['reply'];
    responseType = json['response_type'];
    pendingSlot = json['pending_slot'];
    filters = json['filters'] != null ? Filters.fromJson(json['filters']) : null;
    if (json['suggestions'] != null) {
      suggestions = [];
      json['suggestions'].forEach((v) {
        suggestions?.add(Suggestions.fromJson(v));
      });
    }
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  String? reply;
  String? responseType;
  String? pendingSlot;
  Filters? filters;
  List<Suggestions>? suggestions;
  List<Results>? results;
  Pagination? pagination;
ChatbotResponse copyWith({  String? reply,
  String? responseType,
  String? pendingSlot,
  Filters? filters,
  List<Suggestions>? suggestions,
  List<Results>? results,
  Pagination? pagination,
}) => ChatbotResponse(  reply: reply ?? this.reply,
  responseType: responseType ?? this.responseType,
  pendingSlot: pendingSlot ?? this.pendingSlot,
  filters: filters ?? this.filters,
  suggestions: suggestions ?? this.suggestions,
  results: results ?? this.results,
  pagination: pagination ?? this.pagination,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reply'] = reply;
    map['response_type'] = responseType;
    map['pending_slot'] = pendingSlot;
    if (filters != null) {
      map['filters'] = filters?.toJson();
    }
    if (suggestions != null) {
      map['suggestions'] = suggestions?.map((v) => v.toJson()).toList();
    }
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }

}

/// page : 1
/// page_size : 5
/// has_more : false

class Pagination {
  Pagination({
      this.page, 
      this.pageSize, 
      this.hasMore,});

  Pagination.fromJson(dynamic json) {
    page = json['page'];
    pageSize = json['page_size'];
    hasMore = json['has_more'];
  }
  int? page;
  int? pageSize;
  bool? hasMore;
Pagination copyWith({  int? page,
  int? pageSize,
  bool? hasMore,
}) => Pagination(  page: page ?? this.page,
  pageSize: pageSize ?? this.pageSize,
  hasMore: hasMore ?? this.hasMore,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['page_size'] = pageSize;
    map['has_more'] = hasMore;
    return map;
  }

}

/// id : 0
/// result_type : "string"
/// title : "string"
/// subtitle : "string"
/// location : "string"
/// price_text : "string"
/// monthly_rent : 0
/// deposit : 0
/// details : ["string"]
/// amenities : ["string"]
/// attributes : {"additionalProp1":{}}
/// recommendation_score : 0

class Results {
  Results({
      this.id, 
      this.propertyId,
      this.resultType,
      this.title, 
      this.subtitle, 
      this.location, 
      this.priceText, 
      this.monthlyRent, 
      this.deposit, 
      this.details, 
      this.amenities, 
      this.attributes, 
      this.recommendationScore,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    propertyId = json['property_id'];
    resultType = json['result_type'];
    title = json['title'];
    subtitle = json['subtitle'];
    location = json['location'];
    priceText = json['price_text'];
    monthlyRent = json['monthly_rent'];
    deposit = json['deposit'];
    details = json['details'] != null ? json['details'].cast<String>() : [];
    amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
    attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
    recommendationScore = json['recommendation_score'];
  }
  int? id;
  int? propertyId;
  String? resultType;
  String? title;
  String? subtitle;
  String? location;
  String? priceText;
  int? monthlyRent;
  int? deposit;
  List<String>? details;
  List<String>? amenities;
  Attributes? attributes;
  int? recommendationScore;
Results copyWith({
  int? id,
  int? propertyId,
  String? resultType,
  String? title,
  String? subtitle,
  String? location,
  String? priceText,
  int? monthlyRent,
  int? deposit,
  List<String>? details,
  List<String>? amenities,
  Attributes? attributes,
  int? recommendationScore,
}) => Results(
  id: id ?? this.id,
  propertyId: propertyId ?? this.propertyId,
  resultType: resultType ?? this.resultType,
  title: title ?? this.title,
  subtitle: subtitle ?? this.subtitle,
  location: location ?? this.location,
  priceText: priceText ?? this.priceText,
  monthlyRent: monthlyRent ?? this.monthlyRent,
  deposit: deposit ?? this.deposit,
  details: details ?? this.details,
  amenities: amenities ?? this.amenities,
  attributes: attributes ?? this.attributes,
  recommendationScore: recommendationScore ?? this.recommendationScore,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['property_id'] = propertyId;
    map['result_type'] = resultType;
    map['title'] = title;
    map['subtitle'] = subtitle;
    map['location'] = location;
    map['price_text'] = priceText;
    map['monthly_rent'] = monthlyRent;
    map['deposit'] = deposit;
    map['details'] = details;
    map['amenities'] = amenities;
    if (attributes != null) {
      map['attributes'] = attributes?.toJson();
    }
    map['recommendation_score'] = recommendationScore;
    return map;
  }

}

/// additionalProp1 : {}

class Attributes {
  Attributes({
      this.additionalProp1,});

  Attributes.fromJson(dynamic json) {
    additionalProp1 = json['additionalProp1'];
  }
  dynamic additionalProp1;
Attributes copyWith({  dynamic additionalProp1,
}) => Attributes(  additionalProp1: additionalProp1 ?? this.additionalProp1,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalProp1'] = additionalProp1;
    return map;
  }

}

/// label : "string"
/// value : "string"

class Suggestions {
  Suggestions({
      this.label, 
      this.value,});

  Suggestions.fromJson(dynamic json) {
    label = json['label'];
    value = json['value'];
  }
  String? label;
  String? value;
Suggestions copyWith({  String? label,
  String? value,
}) => Suggestions(  label: label ?? this.label,
  value: value ?? this.value,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['value'] = value;
    return map;
  }

}

/// intent : "string"
/// search_type : "string"
/// housing_type : "string"
/// city : "string"
/// governorate : "string"
/// min_price : 0
/// max_price : 0
/// tenant_type : "string"
/// furnished : true
/// wifi : true
/// private_bathroom : true
/// balcony : true
/// air_conditioning : true
/// gender : "string"
/// shared_room : true
/// sort_by : "string"

class Filters {
  Filters({
      this.intent, 
      this.searchType, 
      this.housingType, 
      this.city, 
      this.governorate, 
      this.minPrice, 
      this.maxPrice, 
      this.tenantType, 
      this.furnished, 
      this.wifi, 
      this.privateBathroom, 
      this.balcony, 
      this.airConditioning, 
      this.gender, 
      this.sharedRoom, 
      this.sortBy,});

  Filters.fromJson(dynamic json) {
    intent = json['intent'];
    searchType = json['search_type'];
    housingType = json['housing_type'];
    city = json['city'];
    governorate = json['governorate'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    tenantType = json['tenant_type'];
    furnished = json['furnished'];
    wifi = json['wifi'];
    privateBathroom = json['private_bathroom'];
    balcony = json['balcony'];
    airConditioning = json['air_conditioning'];
    gender = json['gender'];
    sharedRoom = json['shared_room'];
    sortBy = json['sort_by'];
  }
  String? intent;
  String? searchType;
  String? housingType;
  String? city;
  String? governorate;
  int? minPrice;
  int? maxPrice;
  String? tenantType;
  bool? furnished;
  bool? wifi;
  bool? privateBathroom;
  bool? balcony;
  bool? airConditioning;
  String? gender;
  bool? sharedRoom;
  String? sortBy;
Filters copyWith({  String? intent,
  String? searchType,
  String? housingType,
  String? city,
  String? governorate,
  int? minPrice,
  int? maxPrice,
  String? tenantType,
  bool? furnished,
  bool? wifi,
  bool? privateBathroom,
  bool? balcony,
  bool? airConditioning,
  String? gender,
  bool? sharedRoom,
  String? sortBy,
}) => Filters(  intent: intent ?? this.intent,
  searchType: searchType ?? this.searchType,
  housingType: housingType ?? this.housingType,
  city: city ?? this.city,
  governorate: governorate ?? this.governorate,
  minPrice: minPrice ?? this.minPrice,
  maxPrice: maxPrice ?? this.maxPrice,
  tenantType: tenantType ?? this.tenantType,
  furnished: furnished ?? this.furnished,
  wifi: wifi ?? this.wifi,
  privateBathroom: privateBathroom ?? this.privateBathroom,
  balcony: balcony ?? this.balcony,
  airConditioning: airConditioning ?? this.airConditioning,
  gender: gender ?? this.gender,
  sharedRoom: sharedRoom ?? this.sharedRoom,
  sortBy: sortBy ?? this.sortBy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['intent'] = intent;
    map['search_type'] = searchType;
    map['housing_type'] = housingType;
    map['city'] = city;
    map['governorate'] = governorate;
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['tenant_type'] = tenantType;
    map['furnished'] = furnished;
    map['wifi'] = wifi;
    map['private_bathroom'] = privateBathroom;
    map['balcony'] = balcony;
    map['air_conditioning'] = airConditioning;
    map['gender'] = gender;
    map['shared_room'] = sharedRoom;
    map['sort_by'] = sortBy;
    return map;
  }

}