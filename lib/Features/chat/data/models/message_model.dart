class MessageModel {
  final int id;
  final String content;
  final String? fileUrl;
  final String type;
  final String senderId;
  final String sentAt;

  MessageModel({required this.id, required this.content, this.fileUrl, required this.type, required this.senderId, required this.sentAt});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['content'] ?? "",
      fileUrl: json['fileUrl'],
      type: json['type'],
      senderId: json['senderId'],
      sentAt: json['sentAt'],
    );
  }
}