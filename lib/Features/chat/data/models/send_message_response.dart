/// isSuccess : true
/// message : "Message sent successfully."
/// data : {"id":7,"content":"string","fileUrl":"/uploads/851ffacd-bd4b-433a-8daf-2afdf6ee39be.png","type":"Text","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"Rahma Ibrahim","senderProfileImageUrl":null,"sentAt":"2026-04-11T20:57:08.4875467Z"}

class SendMessageResponse {
  SendMessageResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  SendMessageResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? SendMessageData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  SendMessageData? data;

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

/// id : 7
/// content : "string"
/// fileUrl : "/uploads/851ffacd-bd4b-433a-8daf-2afdf6ee39be.png"
/// type : "Text"
/// senderId : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// senderFullName : "Rahma Ibrahim"
/// senderProfileImageUrl : null
/// sentAt : "2026-04-11T20:57:08.4875467Z"

class SendMessageData {
  SendMessageData({
      this.id, 
      this.content, 
      this.fileUrl, 
      this.type, 
      this.senderId, 
      this.senderFullName, 
      this.senderProfileImageUrl, 
      this.sentAt,});

  SendMessageData.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    fileUrl = json['fileUrl'];
    type = json['type'];
    senderId = json['senderId'];
    senderFullName = json['senderFullName'];
    senderProfileImageUrl = json['senderProfileImageUrl'];
    sentAt = json['sentAt'];
  }
  int? id;
  String? content;
  String? fileUrl;
  String? type;
  String? senderId;
  String? senderFullName;
  String? senderProfileImageUrl;
  String? sentAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['fileUrl'] = fileUrl;
    map['type'] = type;
    map['senderId'] = senderId;
    map['senderFullName'] = senderFullName;
    map['senderProfileImageUrl'] = senderProfileImageUrl;
    map['sentAt'] = sentAt;
    return map;
  }

}