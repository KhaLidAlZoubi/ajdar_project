import 'dart:async';
import 'dart:convert';

import 'package:ajder_project/ajdar_app/data/model/message_model.dart';
import 'package:ajder_project/ajdar_app/data/model/notification_model.dart';
import 'package:ajder_project/ajdar_app/services/local_notificaion_services.dart';
import 'package:signalr_netcore/signalr_client.dart';

typedef TokenProvider = Future<String?> Function();

class SignalRService {
  final String baseUrl;
  final TokenProvider tokenProvider;

  HubConnection? _notificationsHub;
  HubConnection? _messagesHub;

  // Streams لبث الأحداث للـ UI
  final _notificationsController =
      StreamController<NotificationModel>.broadcast();
  Stream<NotificationModel> get notificationsStream =>
      _notificationsController.stream;

  final _messagesController = StreamController<SupportMessage>.broadcast();
  Stream<SupportMessage> get messagesStream => _messagesController.stream;

  final _onlineUsersController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get onlineUsersStream => _onlineUsersController.stream;

  SignalRService({required this.baseUrl, required this.tokenProvider});

  Future<void> initConnections() async {
    _notificationsHub = HubConnectionBuilder()
        .withUrl(
          '$baseUrl/hubs/notifications',
          options: HttpConnectionOptions(
            transport: HttpTransportType.LongPolling,
            accessTokenFactory: () async {
              final token =
                  await tokenProvider(); // tokenProvider() => Future<String?>
              if (token == null || token.isEmpty) {
                // اختَر سلوكاً مناسباً: إما تحاول تجديد التوكن هنا أو ترمي استثناء
                throw Exception('No access token available');
              }
              return token; // هنا يصبح النوع Future<String> كما هو مطلوب
            },
          ),
        )
        .build();

    _messagesHub = HubConnectionBuilder()
        .withUrl(
          '$baseUrl/hubs/messages',
          options: HttpConnectionOptions(
            transport: HttpTransportType.LongPolling,
            accessTokenFactory: () async {
              final token = await tokenProvider();
              if (token == null || token.isEmpty)
                throw Exception('No access token available');
              return token;
            },
          ),
        )
        .build();

    // === أحداث Notifications Hub ===
    // _notificationsHub!.on('ReceiveNotification', (args) {
    //   try {
    //     final raw = args?.isNotEmpty == true ? args!.first : null;
    //     final notif = _parseNotification(raw);
    //     if (notif != null) _notificationsController.add(notif);
    //   } catch (e, st) {
    //     print('ReceiveNotification parse error: $e\n$st');
    //   }
    // });
    _notificationsHub!.on('ReceiveNotification', (args) {
      try {
        final raw = args?.isNotEmpty == true ? args!.first : null;
        final notif = _parseNotification(raw);
        if (notif != null) {
          _notificationsController.add(notif);
          print("📩 Notification raw: $raw");

          // ⬅️ إظهار إشعار محلي
          // LocalNotificationService.showNotification(
          //   title: notif.title,
          //   body: notif.message,
          // );
        }
      } catch (e, st) {
        print('ReceiveNotification parse error: $e\n$st');
      }
    });
    _notificationsHub!.on('onlineUsers', (args) {
      final raw = args?.isNotEmpty == true ? args!.first : null;
      if (raw is List) {
        _onlineUsersController.add(raw.map((e) => e.toString()).toList());
      }
    });

    // === أحداث Messages Hub ===
    _messagesHub!.on('ReceiveMessage', (args) {
      try {
        final raw = args?.isNotEmpty == true ? args!.first : null;
        final msg = _parseMessage(raw);
        if (msg != null) {
          _messagesController.add(msg);

          // ⬅️ إظهار إشعار محلي عند استقبال رسالة
          // LocalNotificationService.showNotification(
          // title: "رسالة جديدة من ${msg.senderId}",
          // body: msg.message,
          // );
        }
      } catch (e) {
        print('ReceiveMessage parse error: $e');
      }
    });

    _messagesHub!.on('MessageDeleted', (args) {
      final id = args?.isNotEmpty == true ? args!.first : null;
      print('MessageDeleted event: $id');
      // لو تريد -> بثه للواجهة عبر StreamController آخر
    });

    // Start both connections
    await _startHub(_notificationsHub!);
    await _startHub(_messagesHub!);

    print('✅ SignalR hubs started');
  }

  Future<void> _startHub(HubConnection hub) async {
    if (hub.state == HubConnectionState.Disconnected) {
      try {
        await hub.start();
        print('Hub started successfully:');
      } catch (e) {
        print('Hub start error: $e — محاولة إعادة المحاولة بعد 2 ثانية');
        await Future.delayed(const Duration(seconds: 2));
        // if (hub.state != HubConnectionState.Disconnected) {
        //   await hub.stop();
        // }
        if (hub.state == HubConnectionState.Disconnected) {
          await hub.start();
        }
      }
    } else {
      print('Hub is already in state: ${hub.state}');
    }
  }

  // === parsers ===
  NotificationModel? _parseNotification(dynamic raw) {
    if (raw == null) return null;
    if (raw is Map)
      return NotificationModel.fromJson(Map<String, dynamic>.from(raw));
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is Map)
        return NotificationModel.fromJson(Map<String, dynamic>.from(decoded));
    }
    return null;
  }

  SupportMessage? _parseMessage(dynamic raw) {
    if (raw == null) return null;
    if (raw is Map)
      return SupportMessage.fromJson(Map<String, dynamic>.from(raw));
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is Map)
        return SupportMessage.fromJson(Map<String, dynamic>.from(decoded));
    }
    return null;
  }

  // === Notifications Hub methods ===
  Future<bool> deleteNotification(int notificationId) async {
    try {
      final result = await _notificationsHub!
          .invoke('DeleteNotification', args: [notificationId]);
      return result == true;
    } catch (e) {
      print('deleteNotification error: $e');
      return false;
    }
  }

  Future<List<NotificationModel>> getNotifications([String? status]) async {
    final result = await _notificationsHub!
        .invoke('GetNotifications', args: status != null ? [status] : []);
    if (result == null) return [];
    if (result is List) {
      return result
          .map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    if (result is String) {
      final decoded = jsonDecode(result);
      if (decoded is List) {
        return decoded
            .map(
                (e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    throw FormatException(
        'Unexpected GetNotifications reply: ${result.runtimeType}');
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    final result = await _notificationsHub!.invoke('GetAllNotifications');
    if (result == null) return [];
    if (result is List) {
      return result
          .map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    if (result is String) {
      final decoded = jsonDecode(result);
      if (decoded is List) {
        return decoded
            .map(
                (e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    throw FormatException(
        'Unexpected GetAllNotifications reply: ${result.runtimeType}');
  }

  Future<void> markAsRead() async {
    try {
      await _notificationsHub!.invoke('MarkAsRead');
    } catch (e) {
      print('markAsRead error: $e');
    }
  }

  Future<void> sendNotification(
      String userId, String title, String message) async {
    try {
      await _notificationsHub!
          .invoke('SendNotification', args: [userId, title, message]);
    } catch (e) {
      print('sendNotification error: $e');
    }
  }

  Future<void> sendAllUsersNotification(String title, String message) async {
    try {
      await _notificationsHub!
          .invoke('SendAllUsersNotification', args: [title, message]);
    } catch (e) {
      print('sendAllUsersNotification error: $e');
    }
  }

  // === Messages Hub methods ===
  Future<void> joinGroup(String userId) async {
    try {
      await _messagesHub!.invoke('joinGroup', args: [userId]);
    } catch (e) {
      print('joinGroup error: $e');
    }
  }

  Future<void> sendNewMessage(String otherUserId, String message) async {
    try {
      await _messagesHub!
          .invoke('SendNewMessage', args: [otherUserId, message]);
    } catch (e) {
      print('sendNewMessage error: $e');
    }
  }

  Future<List<SupportMessage>> getMessagesWithUser(String otherUserId) async {
    final result =
        await _messagesHub!.invoke('GetMessagesWithUser', args: [otherUserId]);
    if (result == null) return [];
    if (result is List) {
      return result
          .map((e) => SupportMessage.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    if (result is String) {
      final decoded = jsonDecode(result);
      if (decoded is List) {
        return decoded
            .map((e) => SupportMessage.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
    }
    throw FormatException(
        'Unexpected GetMessagesWithUser reply: ${result.runtimeType}');
  }

  Future<List<Map<String, dynamic>>> getContactedUsersOrdered() async {
    final result = await _messagesHub!.invoke('GetContactedUsersOrdered');
    if (result is List) {
      return result.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    if (result is String) {
      final decoded = jsonDecode(result);
      if (decoded is List)
        return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  Future<bool> deleteMessage(String otherUserId, int messageId) async {
    try {
      final result = await _messagesHub!
          .invoke('DeleteMessage', args: [otherUserId, messageId]);
      return result == true;
    } catch (e) {
      print('deleteMessage error: $e');
      return false;
    }
  }

  Future<void> markMessagesAsRead(String otherUserId) async {
    try {
      await _messagesHub!.invoke('MarkMessagesAsRead', args: [otherUserId]);
    } catch (e) {
      print('markMessagesAsRead error: $e');
    }
  }

  // === cleanup ===
  Future<void> stopConnections() async {
    try {
      await _notificationsHub?.stop();
    } catch (e) {}
    try {
      await _messagesHub?.stop();
    } catch (e) {}

    await _notificationsController.close();
    await _messagesController.close();
    await _onlineUsersController.close();
  }
}
