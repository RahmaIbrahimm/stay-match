/// isSuccess : true
/// message : "Success"
/// data : {"chatId":1,"otherUserFullName":"Abanoub Yousry","otherUserProfilePicture":null,"messages":[{"id":1,"content":"wetewqt","fileUrl":null,"type":"Text","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T00:58:31.128258"},{"id":2,"content":null,"fileUrl":"/uploads/65c49ab9-5f91-461f-959b-aa9d4801c1dd.png","type":"Image","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T00:59:40.5369375"},{"id":3,"content":null,"fileUrl":"/uploads/9d756426-dc89-4a94-927e-a2e153b63776.py","type":"File","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T01:00:49.1391621"},{"id":4,"content":"dfg","fileUrl":"/uploads/7ebdea4a-a9bf-4367-a1d5-02177ee3b540.py","type":"File","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T01:00:59.4425416"},{"id":5,"content":"dfg","fileUrl":"/uploads/c2f9e015-d0b8-417d-afd3-989576d78a32.py","type":"Voice","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T01:01:18.8804942"}]}

class StartChatResponse {
  StartChatResponse({
      this.isSuccess, 
      this.message, 
      this.data,});

  StartChatResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    data = json['data'] != null ? ChatData.fromJson(json['data']) : null;
  }
  bool? isSuccess;
  String? message;
  ChatData? data;

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
/// otherUserFullName : "Abanoub Yousry"
/// otherUserProfilePicture : null
/// messages : [{"id":1,"content":"wetewqt","fileUrl":null,"type":"Text","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T00:58:31.128258"},{"id":2,"content":null,"fileUrl":"/uploads/65c49ab9-5f91-461f-959b-aa9d4801c1dd.png","type":"Image","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T00:59:40.5369375"},{"id":3,"content":null,"fileUrl":"/uploads/9d756426-dc89-4a94-927e-a2e153b63776.py","type":"File","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T01:00:49.1391621"},{"id":4,"content":"dfg","fileUrl":"/uploads/7ebdea4a-a9bf-4367-a1d5-02177ee3b540.py","type":"File","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T01:00:59.4425416"},{"id":5,"content":"dfg","fileUrl":"/uploads/c2f9e015-d0b8-417d-afd3-989576d78a32.py","type":"Voice","senderId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","senderFullName":"You","senderProfileImageUrl":null,"sentAt":"2026-04-10T01:01:18.8804942"}]

class ChatData {
  ChatData({
      this.chatId, 
      this.otherUserFullName, 
      this.otherUserProfilePicture, 
      this.messages,});

  ChatData.fromJson(dynamic json) {
    chatId = json['chatId'];
    otherUserFullName = json['otherUserFullName'];
    otherUserProfilePicture = json['otherUserProfilePicture'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }
  int? chatId;
  String? otherUserFullName;
  dynamic otherUserProfilePicture;
  List<Messages>? messages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatId'] = chatId;
    map['otherUserFullName'] = otherUserFullName;
    map['otherUserProfilePicture'] = otherUserProfilePicture;
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// content : "wetewqt"
/// fileUrl : null
/// type : "Text"
/// senderId : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// senderFullName : "You"
/// senderProfileImageUrl : null
/// sentAt : "2026-04-10T00:58:31.128258"

class Messages {
  Messages({
      this.id, 
      this.content, 
      this.fileUrl, 
      this.type, 
      this.senderId, 
      this.senderFullName, 
      this.senderProfileImageUrl, 
      this.sentAt,});

  Messages.fromJson(dynamic json) {
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