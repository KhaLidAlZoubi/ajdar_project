class SupportMessage {
  final int? id;
  final String message;
  final bool isRead;
  final String senderId;
  final String receiverId;
  final DateTime sentAt;
  final bool isFromAdmin;

  SupportMessage({
    this.id,
    required this.message,
    required this.isRead,
    required this.senderId,
    required this.receiverId,
    required this.sentAt,
    required this.isFromAdmin,
  });

  factory SupportMessage.fromJson(Map<String, dynamic> json) {
    return SupportMessage(
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
      message: json['message']?.toString() ?? '',
      isRead: json['isRead'] == true,
      senderId: json['senderId']?.toString() ?? '',
      receiverId: json['receiverId']?.toString() ?? '',
      sentAt:
          DateTime.tryParse(json['sentAt']?.toString() ?? '') ?? DateTime.now(),
      isFromAdmin: json['isFromAdmin'] == true,
    );
  }
}
