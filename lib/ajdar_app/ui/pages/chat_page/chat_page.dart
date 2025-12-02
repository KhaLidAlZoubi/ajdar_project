import 'package:ajder_project/ajdar_app/data/model/message_model.dart';
import 'package:ajder_project/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:ajder_project/services/signalr_service.dart';

class ChatPage extends StatefulWidget {
  final String otherUserId; // معرف المسؤول أو الطرف الآخر
  final String currentUserId;

  const ChatPage({
    super.key,
    required this.otherUserId,
    required this.currentUserId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<SupportMessage> _messages = [];

  @override
  void initState() {
    super.initState();

    // تحميل المحادثة السابقة
    signalRService.getMessagesWithUser(widget.otherUserId).then((msgs) {
      setState(() {
        _messages = msgs;
      });
      _scrollToBottom();
    });

    // الاستماع للرسائل الجديدة
    signalRService.messagesStream.listen((msg) {
      if (msg.senderId == widget.otherUserId ||
          msg.receiverId == widget.otherUserId) {
        setState(() {
          _messages.add(msg);
        });
        _scrollToBottom();
      }
    });
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    signalRService.sendNewMessage(widget.otherUserId, text);

    final newMessage = SupportMessage(
      id: null,
      message: text,
      isRead: false,
      senderId: widget.currentUserId,
      receiverId: widget.otherUserId,
      sentAt: DateTime.now(),
      isFromAdmin: false,
    );

    setState(() {
      _messages.add(newMessage);
    });

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Widget _buildMessage(SupportMessage msg) {
    final isMe = msg.senderId == widget.currentUserId;
    final time = DateFormat.Hm().format(msg.sentAt);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              msg.message,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
                if (isMe) ...[
                  const SizedBox(width: 4),
                  Icon(
                    msg.isRead ? Icons.done_all : Icons.done,
                    size: 16,
                    color: msg.isRead ? Colors.blue : Colors.black54,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    signalRService.stopConnections();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الدعم الفني"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "اكتب رسالة...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
