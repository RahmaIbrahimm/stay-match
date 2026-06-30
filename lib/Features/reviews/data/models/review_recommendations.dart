/// isSuccess : true
/// data : {"recommendedProperties":[{"id":137,"name":"غرفة مفروشة للبنات في شقة مشتركة","mainImage":"https://example.com/images/living-room.jpg","monthlyRent":4500,"rating":5,"city":"Amiriyyah"},{"id":138,"name":"شقة سكنية للطالبات - غرف مشتركة","mainImage":"https://example.com/images/property_cover.jpg","monthlyRent":0,"rating":0,"city":"Amiriyyah"},{"id":146,"name":"weraqweasd","mainImage":"https://graduationproject1.runasp.net/images/properties/95d1d455-0eb2-491d-9d16-7dfc792bd788_39.png","monthlyRent":345,"rating":0,"city":"Abou Simbel"}],"siteStats":{"totalReviews":6,"totalVerifiedHosts":0,"happyTenants":1}}

class ReviewRecommendations {
  ReviewRecommendations({
      this.isSuccess, 
      this.data,});

  ReviewRecommendations.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? ReviewRecommendationsData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  ReviewRecommendationsData? data;
ReviewRecommendations copyWith({  bool? isSuccess,
  ReviewRecommendationsData? data,
}) => ReviewRecommendations(  isSuccess: isSuccess ?? this.isSuccess,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// recommendedProperties : [{"id":137,"name":"غرفة مفروشة للبنات في شقة مشتركة","mainImage":"https://example.com/images/living-room.jpg","monthlyRent":4500,"rating":5,"city":"Amiriyyah"},{"id":138,"name":"شقة سكنية للطالبات - غرف مشتركة","mainImage":"https://example.com/images/property_cover.jpg","monthlyRent":0,"rating":0,"city":"Amiriyyah"},{"id":146,"name":"weraqweasd","mainImage":"https://graduationproject1.runasp.net/images/properties/95d1d455-0eb2-491d-9d16-7dfc792bd788_39.png","monthlyRent":345,"rating":0,"city":"Abou Simbel"}]
/// siteStats : {"totalReviews":6,"totalVerifiedHosts":0,"happyTenants":1}

class ReviewRecommendationsData {
  ReviewRecommendationsData({
      this.recommendedProperties, 
      this.siteStats,});

  ReviewRecommendationsData.fromJson(dynamic json) {
    if (json['recommendedProperties'] != null) {
      recommendedProperties = [];
      json['recommendedProperties'].forEach((v) {
        recommendedProperties?.add(RecommendedProperties.fromJson(v));
      });
    }
    siteStats = json['siteStats'] != null ? SiteStats.fromJson(json['siteStats']) : null;
  }
  List<RecommendedProperties>? recommendedProperties;
  SiteStats? siteStats;
ReviewRecommendationsData copyWith({  List<RecommendedProperties>? recommendedProperties,
  SiteStats? siteStats,
}) => ReviewRecommendationsData(  recommendedProperties: recommendedProperties ?? this.recommendedProperties,
  siteStats: siteStats ?? this.siteStats,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (recommendedProperties != null) {
      map['recommendedProperties'] = recommendedProperties?.map((v) => v.toJson()).toList();
    }
    if (siteStats != null) {
      map['siteStats'] = siteStats?.toJson();
    }
    return map;
  }

}

/// totalReviews : 6
/// totalVerifiedHosts : 0
/// happyTenants : 1

class SiteStats {
  SiteStats({
      this.totalReviews, 
      this.totalVerifiedHosts, 
      this.happyTenants,});

  SiteStats.fromJson(dynamic json) {
    totalReviews = json['totalReviews'];
    totalVerifiedHosts = json['totalVerifiedHosts'];
    happyTenants = json['happyTenants'];
  }
  int? totalReviews;
  int? totalVerifiedHosts;
  int? happyTenants;
SiteStats copyWith({  int? totalReviews,
  int? totalVerifiedHosts,
  int? happyTenants,
}) => SiteStats(  totalReviews: totalReviews ?? this.totalReviews,
  totalVerifiedHosts: totalVerifiedHosts ?? this.totalVerifiedHosts,
  happyTenants: happyTenants ?? this.happyTenants,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalReviews'] = totalReviews;
    map['totalVerifiedHosts'] = totalVerifiedHosts;
    map['happyTenants'] = happyTenants;
    return map;
  }

}

/// id : 137
/// name : "غرفة مفروشة للبنات في شقة مشتركة"
/// mainImage : "https://example.com/images/living-room.jpg"
/// monthlyRent : 4500
/// rating : 5
/// city : "Amiriyyah"

class RecommendedProperties {
  RecommendedProperties({
      this.id, 
      this.name, 
      this.mainImage, 
      this.monthlyRent, 
      this.rating, 
      this.city,this.isSaved});

  RecommendedProperties.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mainImage = json['mainImage'];
    monthlyRent = json['monthlyRent'];
    rating = json['rating'];
    city = json['city'];
    isSaved = json['isSaved'];
  }
  int? id;
  String? name;
  String? mainImage;
  num? monthlyRent;
  num? rating;
  String? city;
  bool? isSaved;

  RecommendedProperties copyWith({ int? id,
  String? name,
  String? mainImage,
  num? monthlyRent,
  num? rating,
  String? city,
    bool? isSaved,
}) => RecommendedProperties(  id: id ?? this.id,
  name: name ?? this.name,
  mainImage: mainImage ?? this.mainImage,
  monthlyRent: monthlyRent ?? this.monthlyRent,
  rating: rating ?? this.rating,
  city: city ?? this.city,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mainImage'] = mainImage;
    map['monthlyRent'] = monthlyRent;
    map['rating'] = rating;
    map['city'] = city;
    map['isSaved'] = isSaved;
    return map;
  }

}