/// bookingId : 111
/// accuracy : 3
/// cleanliness : 2
/// location : 1
/// checkIn : 1
/// value : 4
/// communication : 5
/// comment : "this is a new comment on the property , kinda good idk? "

class WriteReviewRequest {
  WriteReviewRequest({
      this.bookingId, 
      this.accuracy, 
      this.cleanliness, 
      this.location, 
      this.checkIn, 
      this.value, 
      this.communication, 
      this.comment,});

  WriteReviewRequest.fromJson(dynamic json) {
    bookingId = json['bookingId'];
    accuracy = json['accuracy'];
    cleanliness = json['cleanliness'];
    location = json['location'];
    checkIn = json['checkIn'];
    value = json['value'];
    communication = json['communication'];
    comment = json['comment'];
  }
  int? bookingId;
  int? accuracy;
  int? cleanliness;
  int? location;
  int? checkIn;
  int? value;
  int? communication;
  String? comment;
WriteReviewRequest copyWith({  int? bookingId,
  int? accuracy,
  int? cleanliness,
  int? location,
  int? checkIn,
  int? value,
  int? communication,
  String? comment,
}) => WriteReviewRequest(  bookingId: bookingId ?? this.bookingId,
  accuracy: accuracy ?? this.accuracy,
  cleanliness: cleanliness ?? this.cleanliness,
  location: location ?? this.location,
  checkIn: checkIn ?? this.checkIn,
  value: value ?? this.value,
  communication: communication ?? this.communication,
  comment: comment ?? this.comment,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bookingId'] = bookingId;
    map['accuracy'] = accuracy;
    map['cleanliness'] = cleanliness;
    map['location'] = location;
    map['checkIn'] = checkIn;
    map['value'] = value;
    map['communication'] = communication;
    map['comment'] = comment;
    return map;
  }

}