/// isSuccess : true
/// message : "Chat marked as read successfully"
/// data : {"chatId":1}

class MarkRead {
  MarkRead({
      this.isSuccess, 
      this.message, 
      this.data,});

  MarkRead.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? MarkReadData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  MarkReadData? data;

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

/// chatId : 1

class MarkReadData {
  MarkReadData({
      this.chatId,});

  MarkReadData.fromJson(dynamic json) {
    chatId = json['chatId'];
  }
  int? chatId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatId'] = chatId;
    return map;
  }

}