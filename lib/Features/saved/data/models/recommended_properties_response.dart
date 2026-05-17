/// isSuccess : true
/// message : "Request successful"
/// data : {"title":"Recommended for You","subtitle":"Based on your saved listings","items":[{"id":161,"name":"Luxury Apartment in New Cairo","price":15000,"priceDisplay":"15,000/mo","address":"90 Street, Fifth Settlement, Amiriyyah","city":"Amiriyyah","government":"Cairo","propertyType":"Apartment","bedrooms":3,"bathrooms":2,"isFurnished":true,"distance":"Recommended for you","amenities":{"hasWifi":false,"hasAC":false,"hasParking":false,"hasGym":false},"imageUrl":"https://example.com/images/apartment-cover.jpg"},{"id":149,"name":"asdfasdasdf","price":234,"priceDisplay":"234/mo","address":"wsredfgadsf, Abou Simbel","city":"Abou Simbel","government":"Aswan","propertyType":"Apartment","bedrooms":1,"bathrooms":0,"isFurnished":true,"distance":"Recommended for you","amenities":{"hasWifi":false,"hasAC":false,"hasParking":false,"hasGym":false},"imageUrl":"https://graduationproject1.runasp.net/images/properties/fd9d2666-a48e-4e1d-8722-e5f843e7db33_38.png"}],"isFallback":true}

class RecommendedPropertiesResponse {
  RecommendedPropertiesResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  RecommendedPropertiesResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
RecommendedPropertiesResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => RecommendedPropertiesResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// title : "Recommended for You"
/// subtitle : "Based on your saved listings"
/// items : [{"id":161,"name":"Luxury Apartment in New Cairo","price":15000,"priceDisplay":"15,000/mo","address":"90 Street, Fifth Settlement, Amiriyyah","city":"Amiriyyah","government":"Cairo","propertyType":"Apartment","bedrooms":3,"bathrooms":2,"isFurnished":true,"distance":"Recommended for you","amenities":{"hasWifi":false,"hasAC":false,"hasParking":false,"hasGym":false},"imageUrl":"https://example.com/images/apartment-cover.jpg"},{"id":149,"name":"asdfasdasdf","price":234,"priceDisplay":"234/mo","address":"wsredfgadsf, Abou Simbel","city":"Abou Simbel","government":"Aswan","propertyType":"Apartment","bedrooms":1,"bathrooms":0,"isFurnished":true,"distance":"Recommended for you","amenities":{"hasWifi":false,"hasAC":false,"hasParking":false,"hasGym":false},"imageUrl":"https://graduationproject1.runasp.net/images/properties/fd9d2666-a48e-4e1d-8722-e5f843e7db33_38.png"}]
/// isFallback : true

class Data {
  Data({
      this.title, 
      this.subtitle, 
      this.items, 
      this.isFallback,});

  Data.fromJson(dynamic json) {
    title = json['title'];
    subtitle = json['subtitle'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
    isFallback = json['isFallback'];
  }
  String? title;
  String? subtitle;
  List<Items>? items;
  bool? isFallback;
Data copyWith({  String? title,
  String? subtitle,
  List<Items>? items,
  bool? isFallback,
}) => Data(  title: title ?? this.title,
  subtitle: subtitle ?? this.subtitle,
  items: items ?? this.items,
  isFallback: isFallback ?? this.isFallback,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['subtitle'] = subtitle;
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    map['isFallback'] = isFallback;
    return map;
  }

}

/// id : 161
/// name : "Luxury Apartment in New Cairo"
/// price : 15000
/// priceDisplay : "15,000/mo"
/// address : "90 Street, Fifth Settlement, Amiriyyah"
/// city : "Amiriyyah"
/// government : "Cairo"
/// propertyType : "Apartment"
/// bedrooms : 3
/// bathrooms : 2
/// isFurnished : true
/// distance : "Recommended for you"
/// amenities : {"hasWifi":false,"hasAC":false,"hasParking":false,"hasGym":false}
/// imageUrl : "https://example.com/images/apartment-cover.jpg"

class Items {
  Items({
      this.id, 
      this.name, 
      this.price, 
      this.priceDisplay, 
      this.address, 
      this.city, 
      this.government, 
      this.propertyType, 
      this.bedrooms, 
      this.bathrooms, 
      this.isFurnished, 
      this.distance, 
      this.amenities, 
      this.imageUrl,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    priceDisplay = json['priceDisplay'];
    address = json['address'];
    city = json['city'];
    government = json['government'];
    propertyType = json['propertyType'];
    bedrooms = json['bedrooms'];
    bathrooms = json['bathrooms'];
    isFurnished = json['isFurnished'];
    distance = json['distance'];
    amenities = json['amenities'] != null ? Amenities.fromJson(json['amenities']) : null;
    imageUrl = json['imageUrl'];
  }
  int? id;
  String? name;
  num? price;
  String? priceDisplay;
  String? address;
  String? city;
  String? government;
  String? propertyType;
  int? bedrooms;
  int? bathrooms;
  bool? isFurnished;
  String? distance;
  Amenities? amenities;
  String? imageUrl;
Items copyWith({  int? id,
  String? name,
  int? price,
  String? priceDisplay,
  String? address,
  String? city,
  String? government,
  String? propertyType,
  int? bedrooms,
  int? bathrooms,
  bool? isFurnished,
  String? distance,
  Amenities? amenities,
  String? imageUrl,
}) => Items(  id: id ?? this.id,
  name: name ?? this.name,
  price: price ?? this.price,
  priceDisplay: priceDisplay ?? this.priceDisplay,
  address: address ?? this.address,
  city: city ?? this.city,
  government: government ?? this.government,
  propertyType: propertyType ?? this.propertyType,
  bedrooms: bedrooms ?? this.bedrooms,
  bathrooms: bathrooms ?? this.bathrooms,
  isFurnished: isFurnished ?? this.isFurnished,
  distance: distance ?? this.distance,
  amenities: amenities ?? this.amenities,
  imageUrl: imageUrl ?? this.imageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['priceDisplay'] = priceDisplay;
    map['address'] = address;
    map['city'] = city;
    map['government'] = government;
    map['propertyType'] = propertyType;
    map['bedrooms'] = bedrooms;
    map['bathrooms'] = bathrooms;
    map['isFurnished'] = isFurnished;
    map['distance'] = distance;
    if (amenities != null) {
      map['amenities'] = amenities?.toJson();
    }
    map['imageUrl'] = imageUrl;
    return map;
  }

}

/// hasWifi : false
/// hasAC : false
/// hasParking : false
/// hasGym : false

class Amenities {
  Amenities({
      this.hasWifi, 
      this.hasAC, 
      this.hasParking, 
      this.hasGym,});

  Amenities.fromJson(dynamic json) {
    hasWifi = json['hasWifi'];
    hasAC = json['hasAC'];
    hasParking = json['hasParking'];
    hasGym = json['hasGym'];
  }
  bool? hasWifi;
  bool? hasAC;
  bool? hasParking;
  bool? hasGym;
Amenities copyWith({  bool? hasWifi,
  bool? hasAC,
  bool? hasParking,
  bool? hasGym,
}) => Amenities(  hasWifi: hasWifi ?? this.hasWifi,
  hasAC: hasAC ?? this.hasAC,
  hasParking: hasParking ?? this.hasParking,
  hasGym: hasGym ?? this.hasGym,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hasWifi'] = hasWifi;
    map['hasAC'] = hasAC;
    map['hasParking'] = hasParking;
    map['hasGym'] = hasGym;
    return map;
  }

}