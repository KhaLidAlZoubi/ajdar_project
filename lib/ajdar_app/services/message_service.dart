// import 'dart:async';
// import 'package:ajder_project/ajdar_app/data/model/home/message_model.dart';
// import 'package:signalr_core/signalr_core.dart';
// // import 'package:signalr_netcore/http_connection_options.dart';
// // import 'package:signalr_netcore/itransport.dart';
// // import 'support_message_model.dart';

// class MessagesService {
//   final String baseUrl;
//   final Future<String?> Function() getToken;
//   late final HubConnection _hub;

//   final _messageStream = StreamController<SupportMessageModel>.broadcast();
//   final _deletedStream = StreamController<int>.broadcast();

//   /// ستريم للرسائل الجديدة
//   Stream<SupportMessageModel> get onMessage => _messageStream.stream;

//   /// ستريم لحذف الرسائل
//   Stream<int> get onMessageDeleted => _deletedStream.stream;

//   MessagesService({required this.baseUrl, required this.getToken});

//   Future<void> init() async {
//     _hub = HubConnectionBuilder()
//         .withUrl(
//           '$baseUrl/hubs/messages',
//           HttpConnectionOptions(
//             accessTokenFactory: () async => await getToken() ?? '',
//             transport: HttpTransportType.webSockets,
//             skipNegotiation: true,
//           ),
//         )
//         .withAutomaticReconnect()
//         .build();

//     /// الاستماع للرسائل الواردة
//     _hub.on('ReceiveMessage', (args) {
//       if (args == null || args.isEmpty) return;
//       final data = args.first as Map<String, dynamic>;
//       final msg = SupportMessageModel.fromJson(Map<String, dynamic>.from(data));
//       _messageStream.add(msg);
//     });

//     /// الاستماع لحدث الحذف
//     _hub.on('MessageDeleted', (args) {
//       if (args == null || args.isEmpty) return;
//       final id = args.first;
//       final parsed = id is int ? id : int.parse(id.toString());
//       _deletedStream.add(parsed);
//     });
//   }

//   /// بدء الاتصال
//   Future<void> start() async {
//     if (_hub.state != HubConnectionState.connected) {
//       await _hub.start();
//     }
//   }

//   /// إيقاف الاتصال
//   Future<void> stop() async => await _hub.stop();

//   /// إرسال رسالة
//   Future<void> sendNewMessage(String otherId, String message) async {
//     await _hub.invoke('SendNewMessage', args: [otherId, message]);
//   }

//   /// جلب المحادثة مع مستخدم محدد
//   Future<List<SupportMessageModel>> getMessagesWithUser(String otherUserId) async {
//     final raw = await _hub.invoke<List<dynamic>>(
//       'GetMessagesWithUser',
//       args: [otherUserId],
//     );

//     final list = (raw ?? [])
//         .cast<Map<String, dynamic>>()
//         .map((m) => SupportMessageModel.fromJson(Map<String, dynamic>.from(m)))
//         .toList();

//     return list;
//   }

//   /// تعليم الرسائل كمقروءة
//   Future<void> markMessagesAsRead(String otherUserId) async {
//     await _hub.invoke('MarkMessagesAsRead', args: [otherUserId]);
//   }

//   /// للأدمن فقط: الانضمام إلى مجموعة مستخدم
//   Future<void> joinGroup(String id) async {
//     await _hub.invoke('joinGroup', args: [id]);
//   }
// }
