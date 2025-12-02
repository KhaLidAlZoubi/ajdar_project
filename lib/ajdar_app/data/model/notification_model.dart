class NotificationModel {
  final String userId;
  final String title;
  final String message;
  final DateTime createdAt;
  final String status;
  final int? id; // لو يعطيك id من الباك اند

  NotificationModel({
    required this.userId,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.status,
    this.id,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      userId: json['userId']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      status: json['status']?.toString() ?? '',
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'title': title,
        'message': message,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
        if (id != null) 'id': id,
      };
}
