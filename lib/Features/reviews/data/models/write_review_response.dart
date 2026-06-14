/// isSuccess : true
/// message : "Review added successfully"

class WriteReviewResponse {
  WriteReviewResponse({
      this.isSuccess, 
      this.message,});

  WriteReviewResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
  }
  bool? isSuccess;
  String? message;
WriteReviewResponse copyWith({  bool? isSuccess,
  String? message,
}) => WriteReviewResponse(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    return map;
  }

}