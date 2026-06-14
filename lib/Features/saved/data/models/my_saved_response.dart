/// isSuccess : true
/// message : "Request successful"
/// data : {"profileViews":124,"status":"Active","stats":{"rooms":1,"wholeApartments":1,"sharedHouses":0},"savedItems":[{"id":54,"propertyId":138,"roomId":221,"itemName":"الغرفة الأولى (الزهور)","itemType":"room","displayType":"Room","price":3000,"priceDisplay":"3,000/mo","address":"شارع النيل, Amiriyyah","imageUrl":"https://example.com/images/room1_1.jpg","savedAt":"2026-04-29T18:57:36.5818888","isAvailable":true,"bathrooms":1,"bedrooms":1,"furnished":true},{"id":53,"propertyId":149,"roomId":null,"itemName":"asdfasdasdf","itemType":"property","displayType":"Whole Apartment","price":234,"priceDisplay":"234/mo","address":"wsredfgadsf, Abou Simbel","imageUrl":"https://graduationproject1.runasp.net/images/properties/fd9d2666-a48e-4e1d-8722-e5f843e7db33_38.png","savedAt":"2026-04-29T18:54:53.8812347","isAvailable":true,"bathrooms":0,"bedrooms":1,"furnished":true}],"pagination":{"currentPage":1,"pageSize":4,"totalCount":2,"totalPages":1,"hasMore":false,"showMoreLabel":"No more properties"},"currentFilter":"all","searchTerm":null}

class MySavedResponse {
  MySavedResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  MySavedResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  Data? data;
MySavedResponse copyWith({  bool? isSuccess,
  String? message,
  Data? data,
}) => MySavedResponse(  isSuccess: isSuccess ?? this.isSuccess,
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

/// profileViews : 124
/// status : "Active"
/// stats : {"rooms":1,"wholeApartments":1,"sharedHouses":0}
/// savedItems : [{"id":54,"propertyId":138,"roomId":221,"itemName":"الغرفة الأولى (الزهور)","itemType":"room","displayType":"Room","price":3000,"priceDisplay":"3,000/mo","address":"شارع النيل, Amiriyyah","imageUrl":"https://example.com/images/room1_1.jpg","savedAt":"2026-04-29T18:57:36.5818888","isAvailable":true,"bathrooms":1,"bedrooms":1,"furnished":true},{"id":53,"propertyId":149,"roomId":null,"itemName":"asdfasdasdf","itemType":"property","displayType":"Whole Apartment","price":234,"priceDisplay":"234/mo","address":"wsredfgadsf, Abou Simbel","imageUrl":"https://graduationproject1.runasp.net/images/properties/fd9d2666-a48e-4e1d-8722-e5f843e7db33_38.png","savedAt":"2026-04-29T18:54:53.8812347","isAvailable":true,"bathrooms":0,"bedrooms":1,"furnished":true}]
/// pagination : {"currentPage":1,"pageSize":4,"totalCount":2,"totalPages":1,"hasMore":false,"showMoreLabel":"No more properties"}
/// currentFilter : "all"
/// searchTerm : null

class Data {
  Data({
      this.profileViews, 
      this.status, 
      this.stats, 
      this.savedItems, 
      this.pagination, 
      this.currentFilter, 
      this.searchTerm,});

  Data.fromJson(dynamic json) {
    profileViews = json['profileViews'];
    status = json['status'];
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['savedItems'] != null) {
      savedItems = [];
      json['savedItems'].forEach((v) {
        savedItems?.add(SavedItems.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    currentFilter = json['currentFilter'];
    searchTerm = json['searchTerm'];
  }
  int? profileViews;
  String? status;
  Stats? stats;
  List<SavedItems>? savedItems;
  Pagination? pagination;
  String? currentFilter;
  dynamic searchTerm;
Data copyWith({  int? profileViews,
  String? status,
  Stats? stats,
  List<SavedItems>? savedItems,
  Pagination? pagination,
  String? currentFilter,
  dynamic searchTerm,
}) => Data(  profileViews: profileViews ?? this.profileViews,
  status: status ?? this.status,
  stats: stats ?? this.stats,
  savedItems: savedItems ?? this.savedItems,
  pagination: pagination ?? this.pagination,
  currentFilter: currentFilter ?? this.currentFilter,
  searchTerm: searchTerm ?? this.searchTerm,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profileViews'] = profileViews;
    map['status'] = status;
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    if (savedItems != null) {
      map['savedItems'] = savedItems?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    map['currentFilter'] = currentFilter;
    map['searchTerm'] = searchTerm;
    return map;
  }

}

/// currentPage : 1
/// pageSize : 4
/// totalCount : 2
/// totalPages : 1
/// hasMore : false
/// showMoreLabel : "No more properties"

class Pagination {
  Pagination({
      this.currentPage, 
      this.pageSize, 
      this.totalCount, 
      this.totalPages, 
      this.hasMore, 
      this.showMoreLabel,});

  Pagination.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    hasMore = json['hasMore'];
    showMoreLabel = json['showMoreLabel'];
  }
  int? currentPage;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool? hasMore;
  String? showMoreLabel;
Pagination copyWith({  int? currentPage,
  int? pageSize,
  int? totalCount,
  int? totalPages,
  bool? hasMore,
  String? showMoreLabel,
}) => Pagination(  currentPage: currentPage ?? this.currentPage,
  pageSize: pageSize ?? this.pageSize,
  totalCount: totalCount ?? this.totalCount,
  totalPages: totalPages ?? this.totalPages,
  hasMore: hasMore ?? this.hasMore,
  showMoreLabel: showMoreLabel ?? this.showMoreLabel,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['pageSize'] = pageSize;
    map['totalCount'] = totalCount;
    map['totalPages'] = totalPages;
    map['hasMore'] = hasMore;
    map['showMoreLabel'] = showMoreLabel;
    return map;
  }

}

/// id : 54
/// propertyId : 138
/// roomId : 221
/// itemName : "الغرفة الأولى (الزهور)"
/// itemType : "room"
/// displayType : "Room"
/// price : 3000
/// priceDisplay : "3,000/mo"
/// address : "شارع النيل, Amiriyyah"
/// imageUrl : "https://example.com/images/room1_1.jpg"
/// savedAt : "2026-04-29T18:57:36.5818888"
/// isAvailable : true
/// bathrooms : 1
/// bedrooms : 1
/// furnished : true

class SavedItems {
  SavedItems({
      this.id, 
      this.propertyId, 
      this.roomId, 
      this.itemName, 
      this.itemType, 
      this.displayType, 
      this.price, 
      this.priceDisplay, 
      this.address, 
      this.imageUrl, 
      this.savedAt, 
      this.isAvailable, 
      this.bathrooms, 
      this.bedrooms, 
      this.furnished,});

  SavedItems.fromJson(dynamic json) {
    id = json['id'];
    propertyId = json['propertyId'];
    roomId = json['roomId'];
    itemName = json['itemName'];
    itemType = json['itemType'];
    displayType = json['displayType'];
    price = json['price'];
    priceDisplay = json['priceDisplay'];
    address = json['address'];
    imageUrl = json['imageUrl'];
    savedAt = json['savedAt'];
    isAvailable = json['isAvailable'];
    bathrooms = json['bathrooms'];
    bedrooms = json['bedrooms'];
    furnished = json['furnished'];
  }
  int? id;
  int? propertyId;
  int? roomId;
  String? itemName;
  String? itemType;
  String? displayType;
  num? price;
  String? priceDisplay;
  String? address;
  String? imageUrl;
  String? savedAt;
  bool? isAvailable;
  int? bathrooms;
  int? bedrooms;
  bool? furnished;
SavedItems copyWith({  int? id,
  int? propertyId,
  int? roomId,
  String? itemName,
  String? itemType,
  String? displayType,
  int? price,
  String? priceDisplay,
  String? address,
  String? imageUrl,
  String? savedAt,
  bool? isAvailable,
  int? bathrooms,
  int? bedrooms,
  bool? furnished,
}) => SavedItems(  id: id ?? this.id,
  propertyId: propertyId ?? this.propertyId,
  roomId: roomId ?? this.roomId,
  itemName: itemName ?? this.itemName,
  itemType: itemType ?? this.itemType,
  displayType: displayType ?? this.displayType,
  price: price ?? this.price,
  priceDisplay: priceDisplay ?? this.priceDisplay,
  address: address ?? this.address,
  imageUrl: imageUrl ?? this.imageUrl,
  savedAt: savedAt ?? this.savedAt,
  isAvailable: isAvailable ?? this.isAvailable,
  bathrooms: bathrooms ?? this.bathrooms,
  bedrooms: bedrooms ?? this.bedrooms,
  furnished: furnished ?? this.furnished,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['propertyId'] = propertyId;
    map['roomId'] = roomId;
    map['itemName'] = itemName;
    map['itemType'] = itemType;
    map['displayType'] = displayType;
    map['price'] = price;
    map['priceDisplay'] = priceDisplay;
    map['address'] = address;
    map['imageUrl'] = imageUrl;
    map['savedAt'] = savedAt;
    map['isAvailable'] = isAvailable;
    map['bathrooms'] = bathrooms;
    map['bedrooms'] = bedrooms;
    map['furnished'] = furnished;
    return map;
  }

}

/// rooms : 1
/// wholeApartments : 1
/// sharedHouses : 0

class Stats {
  Stats({
      this.rooms, 
      this.wholeApartments, 
      this.sharedHouses,});

  Stats.fromJson(dynamic json) {
    rooms = json['rooms'];
    wholeApartments = json['wholeApartments'];
    sharedHouses = json['sharedHouses'];
  }
  int? rooms;
  int? wholeApartments;
  int? sharedHouses;
Stats copyWith({  int? rooms,
  int? wholeApartments,
  int? sharedHouses,
}) => Stats(  rooms: rooms ?? this.rooms,
  wholeApartments: wholeApartments ?? this.wholeApartments,
  sharedHouses: sharedHouses ?? this.sharedHouses,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rooms'] = rooms;
    map['wholeApartments'] = wholeApartments;
    map['sharedHouses'] = sharedHouses;
    return map;
  }

}