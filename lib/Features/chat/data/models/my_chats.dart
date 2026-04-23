/// isSuccess : true
/// message : "Chats retrieved successfully"
/// data : [{"chatId":1,"otherUserId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","otherUserFullName":"Abanoub Yousry","otherUserProfileImageUrl":null,"lastMessage":"Voice message","lastMessageTime":"2026-04-10T01:01:18.8804942","unreadCount":0}]

class MyChats {
  MyChats({this.isSuccess, this.message, this.data});

  MyChats.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MyChatsData.fromJson(v));
      });
    }
  }
  bool? isSuccess;
  String? message;
  List<MyChatsData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// chatId : 1
/// otherUserId : "1121c342-dd7a-4a29-bc66-c94f6aa43212"
/// otherUserFullName : "Abanoub Yousry"
/// otherUserProfileImageUrl : null
/// lastMessage : "Voice message"
/// lastMessageTime : "2026-04-10T01:01:18.8804942"
/// unreadCount : 0

class MyChatsData {
  MyChatsData({
    this.chatId,
    this.otherUserId,
    this.otherUserFullName,
    this.otherUserProfileImageUrl,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount,
  });

  MyChatsData.fromJson(dynamic json) {
    chatId = json['chatId'];
    otherUserId = json['otherUserId'];
    otherUserFullName = json['otherUserFullName'];
    otherUserProfileImageUrl = json['otherUserProfileImageUrl'];
    lastMessage = json['lastMessage'];
    lastMessageTime = json['lastMessageTime'];
    unreadCount = json['unreadCount'];
  }
  int? chatId;
  String? otherUserId;
  String? otherUserFullName;
  String? otherUserProfileImageUrl;
  String? lastMessage;
  String? lastMessageTime;
  int? unreadCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatId'] = chatId;
    map['otherUserId'] = otherUserId;
    map['otherUserFullName'] = otherUserFullName;
    map['otherUserProfileImageUrl'] = otherUserProfileImageUrl;
    map['lastMessage'] = lastMessage;
    map['lastMessageTime'] = lastMessageTime;
    map['unreadCount'] = unreadCount;
    return map;
  }
}