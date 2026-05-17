/// isSuccess : true
/// message : "Chats retrieved successfully."
/// errors : {"search":["The search field is required."]}
/// data : [{"chatId":4,"otherUserId":"9b1d8f47-3129-4753-ac61-7bd7ab4c600e","otherUserFullName":"You","otherUserProfileImageUrl":"https://graduationproject1.runasp.net/images/9f8001f0-41dc-4546-8227-dbf2776466cc.png","lastMessage":"asdfs","lastMessageTime":"2026-05-02T17:15:58.7972362","unreadCount":0},{"chatId":1,"otherUserId":"1121c342-dd7a-4a29-bc66-c94f6aa43212","otherUserFullName":"Abanoub Yousry","otherUserProfileImageUrl":"https://graduationproject1.runasp.net/images/13880c44-70ef-4d74-87d7-6b13e449f158.png","lastMessage":"Voice message","lastMessageTime":"2026-04-25T23:15:03.3410483","unreadCount":0}]

class SearchChatsResponse {
  SearchChatsResponse({
      this.isSuccess, 
      this.message, 
      this.errors, 
      this.data,});

  SearchChatsResponse.fromJson(dynamic json) {
    isSuccess = json['isSuccess'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SearchChatsData.fromJson(v));
      });
    }
  }
  bool? isSuccess;
  String? message;
  Errors? errors;
  List<SearchChatsData>? data;
SearchChatsResponse copyWith({  bool? isSuccess,
  String? message,
  Errors? errors,
  List<SearchChatsData>? data,
}) => SearchChatsResponse(  isSuccess: isSuccess ?? this.isSuccess,
  message: message ?? this.message,
  errors: errors ?? this.errors,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isSuccess'] = isSuccess;
    map['message'] = message;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// chatId : 4
/// otherUserId : "9b1d8f47-3129-4753-ac61-7bd7ab4c600e"
/// otherUserFullName : "You"
/// otherUserProfileImageUrl : "https://graduationproject1.runasp.net/images/9f8001f0-41dc-4546-8227-dbf2776466cc.png"
/// lastMessage : "asdfs"
/// lastMessageTime : "2026-05-02T17:15:58.7972362"
/// unreadCount : 0

class SearchChatsData {
  SearchChatsData({
      this.chatId, 
      this.otherUserId, 
      this.otherUserFullName, 
      this.otherUserProfileImageUrl, 
      this.lastMessage, 
      this.lastMessageTime, 
      this.unreadCount,});

  SearchChatsData.fromJson(dynamic json) {
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
SearchChatsData copyWith({  int? chatId,
  String? otherUserId,
  String? otherUserFullName,
  String? otherUserProfileImageUrl,
  String? lastMessage,
  String? lastMessageTime,
  int? unreadCount,
}) => SearchChatsData(  chatId: chatId ?? this.chatId,
  otherUserId: otherUserId ?? this.otherUserId,
  otherUserFullName: otherUserFullName ?? this.otherUserFullName,
  otherUserProfileImageUrl: otherUserProfileImageUrl ?? this.otherUserProfileImageUrl,
  lastMessage: lastMessage ?? this.lastMessage,
  lastMessageTime: lastMessageTime ?? this.lastMessageTime,
  unreadCount: unreadCount ?? this.unreadCount,
);
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

/// search : ["The search field is required."]

class Errors {
  Errors({
      this.search,});

  Errors.fromJson(dynamic json) {
    search = json['search'] != null ? json['search'].cast<String>() : [];
  }
  List<String>? search;
Errors copyWith({  List<String>? search,
}) => Errors(  search: search ?? this.search,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['search'] = search;
    return map;
  }

}