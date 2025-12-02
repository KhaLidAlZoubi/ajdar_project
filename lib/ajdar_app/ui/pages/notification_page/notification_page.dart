import 'package:ajder_project/ajdar_app/data/model/message_model.dart';
import 'package:ajder_project/ajdar_app/data/model/notification_model.dart';
import 'package:ajder_project/main.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> notifications = [];
  List<SupportMessage> messages = [];
  List<String> onlineUsers = [];

  @override
  void initState() {
    super.initState();

    // الاستماع للإشعارات
    signalRService.notificationsStream.listen((notif) {
      setState(() {
        notifications.add(notif);
      });
    });

    // الاستماع للرسائل
    signalRService.messagesStream.listen((msg) {
      setState(() {
        messages.add(msg);
      });
    });

    // الاستماع للمستخدمين المتصلين
    signalRService.onlineUsersStream.listen((users) {
      setState(() {
        onlineUsers = users;
      });
    });
  }

  @override
  void dispose() {
    signalRService.stopConnections();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignalR Test')),
      body: Column(
        children: [
          // 🟢 عرض المستخدمين المتصلين
          if (onlineUsers.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.green[50],
              child: Text("المتصلون الآن: ${onlineUsers.join(", ")}"),
            ),

          Expanded(
            child: ListView(
              children: [
                const Text("📢 الإشعارات:", style: TextStyle(fontSize: 18)),
                ...notifications.map(
                  (n) => ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text(n.title),
                    subtitle: Text(n.message),
                  ),
                ),
                const Divider(),
                const Text("💬 الرسائل:", style: TextStyle(fontSize: 18)),
                ...messages.map(
                  (m) => ListTile(
                    leading: const Icon(Icons.message),
                    title: Text("من: ${m.senderId}"),
                    subtitle: Text(m.message),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 🟡 زر إرسال إشعار عام للتجربة
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await signalRService.sendAllUsersNotification(
            "إشعار تجريبي",
            "مرحباً! هذا إشعار من التطبيق",
          );
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
