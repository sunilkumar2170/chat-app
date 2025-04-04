import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomChat extends StatefulWidget {
  final Map<String, dynamic> targetUser;

  RoomChat({required this.targetUser});

  @override
  _RoomChatState createState() => _RoomChatState();
}

class _RoomChatState extends State<RoomChat> {
  final TextEditingController messageController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late String chatRoomId;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    chatRoomId =
        getChatRoomId(auth.currentUser!.email!, widget.targetUser['email']);
    _scrollController = ScrollController();
    _updateLastSeen();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String getChatRoomId(String user1, String user2) {
    List<String> users = [user1, user2];
    users.sort();
    return users.join("_");
  }

  void _updateLastSeen() async {
    try {
      await firestore.collection('chat_rooms').doc(chatRoomId).set({
        '${auth.currentUser!.email}_lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating last seen: $e');
    }
  }

  void sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      final message = {
        'sender': auth.currentUser!.email,
        'receiver': widget.targetUser['email'],
        'message': messageController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'sent',
      };

      try {
        await firestore
            .collection('chat_rooms')
            .doc(chatRoomId)
            .collection('messages')
            .add(message);

        _updateLastSeen();
        _markMessagesAsDelivered();
        messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  Future<void> _markMessagesAsDelivered() async {
    try {
      final messages = await firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .where('sender', isEqualTo: auth.currentUser!.email)
          .where('status', isEqualTo: 'sent')
          .get();

      final batch = firestore.batch();
      for (var doc in messages.docs) {
        batch.update(doc.reference, {'status': 'delivered'});
      }
      await batch.commit();
    } catch (e) {
      print('Error marking messages as delivered: $e');
    }
  }

  Future<void> _markMessagesAsSeen() async {
    try {
      final messages = await firestore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .where('sender', isEqualTo: widget.targetUser['email'])
          .where('status', whereIn: ['sent', 'delivered'])
          .get();

      final batch = firestore.batch();
      for (var doc in messages.docs) {
        batch.update(doc.reference, {'status': 'seen'});
      }
      await batch.commit();
    } catch (e) {
      print('Error marking messages as seen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: firestore.collection('chat_rooms').doc(chatRoomId).snapshots(),
          builder: (context, snapshot) {
            String status = 'Offline';
            if (snapshot.hasData && snapshot.data != null) {
              // सुरक्षित तरीके से document data निकालें
              Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;
              if (data != null &&
                  data.containsKey('${widget.targetUser['email']}_lastSeen')) {
                var lastSeenField = data['${widget.targetUser['email']}_lastSeen'];
                Timestamp? lastSeenTimestamp =
                lastSeenField is Timestamp ? lastSeenField : null;
                if (lastSeenTimestamp != null) {
                  final diff =
                  DateTime.now().difference(lastSeenTimestamp.toDate());
                  if (diff.inMinutes < 2) {
                    status = 'Online';
                  } else {
                    status = 'Last seen ${_formatLastSeen(diff)}';
                  }
                }
              }
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.targetUser['username'] ?? 'Chat'),
                Text(
                  status,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection('chat_rooms')
                  .doc(chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  // Frame callback में messages की स्थिति अपडेट और scroll
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _markMessagesAsSeen();
                    _updateLastSeen();
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  });

                  var messages = snapshot.data!.docs;
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var messageData =
                      messages[index].data() as Map<String, dynamic>;
                      bool isMe =
                          messageData['sender'] == auth.currentUser!.email;
                      // सुरक्षित तरीके से timestamp निकालें
                      Timestamp? timestamp = messageData['timestamp'] is Timestamp
                          ? messageData['timestamp']
                          : null;
                      String timeText = timestamp != null
                          ? _formatTime(timestamp.toDate())
                          : '';

                      return Align(
                        alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: isMe
                                ? Colors.blue.shade100
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              // Message text null-safe check
                              Text(messageData['message'] ?? ''),
                              SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    timeText,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  if (isMe) SizedBox(width: 4),
                                  if (isMe)
                                  // यदि status null हो तो default 'sent' पास करें
                                    _buildStatusIcon(messageData['status'] ?? 'sent'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Center(child: Text('No messages'));
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: Icon(Icons.send),
                  color: Colors.blue.shade400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    switch (status) {
      case 'seen':
        return Icon(Icons.done_all, size: 14, color: Colors.blue);
      case 'delivered':
        return Icon(Icons.done_all, size: 14, color: Colors.grey);
      default: // 'sent'
        return Icon(Icons.done, size: 14, color: Colors.grey);
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatLastSeen(Duration diff) {
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} hours ago';
    } else {
      return '${diff.inDays} days ago';
    }
  }
}
