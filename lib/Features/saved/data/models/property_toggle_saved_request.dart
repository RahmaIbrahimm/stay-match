/// propertyId : 0

class SavedPropertiesRequest {
  SavedPropertiesRequest({
      this.propertyId,});

  SavedPropertiesRequest.fromJson(dynamic json) {
    propertyId = json['propertyId'];
  }
  int? propertyId;
SavedPropertiesRequest copyWith({  int? propertyId,
}) => SavedPropertiesRequest(  propertyId: propertyId ?? this.propertyId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyId'] = propertyId;
    return map;
  }

}