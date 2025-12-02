// class SupportMessageModel {
//   final int id;
//   final String message;
//   final bool isRead;
//   final String senderId;
//   final String receiverId;
//   final DateTime sentAt;
//   final bool isFromAdmin;

//   SupportMessageModel({
//     required this.id,
//     required this.message,
//     required this.isRead,
//     required this.senderId,
//     required this.receiverId,
//     required this.sentAt,
//     required this.isFromAdmin,
//   });

//   factory SupportMessageModel.fromJson(Map<String, dynamic> json) {
//     return SupportMessageModel(
//       id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
//       message: json['message'] as String,
//       isRead: json['isRead'] as bool,
//       senderId: json['senderId'] as String,
//       receiverId: json['receiverId'] as String,
//       sentAt: DateTime.parse(json['sentAt'] as String).toLocal(),
//       isFromAdmin: json['isFromAdmin'] as bool,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'message': message,
//       'isRead': isRead,
//       'senderId': senderId,
//       'receiverId': receiverId,
//       'sentAt': sentAt.toUtc().toIso8601String(),
//       'isFromAdmin': isFromAdmin,
//     };
//   }
// }
