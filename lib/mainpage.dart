import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'roomchat.dart';
import 'searchname.dart';

import 'noteslogin.dart';
import 'package:app_b/settinglogout.dart';
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Rooms"),
        backgroundColor: Colors.blue.shade500,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchName()),
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NotesLogin()),
              );
            },
          ),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    final currentUserEmail = _auth.currentUser?.email;
    if (currentUserEmail == null) {
      return Center(child: Text('Not authenticated'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('usersm')
          .where('email', isNotEqualTo: currentUserEmail)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No users found'));
        }

        return FutureBuilder<List<Widget>>(
          future: _getSortedUserList(snapshot.data!.docs, currentUserEmail),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (asyncSnapshot.hasError) {
              return Center(child: Text('Error loading chats'));
            }
            return ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: asyncSnapshot.data!.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) => asyncSnapshot.data![index],
            );
          },
        );
      },
    );
  }

  Future<List<Widget>> _getSortedUserList(List<DocumentSnapshot> docs, String currentUserEmail) async {
    List<Map<String, dynamic>> userDataWithTime = [];

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null || data.isEmpty) continue;

      final otherUserEmail = data['email'] ?? '';
      List<String> users = [currentUserEmail, otherUserEmail];
      users.sort();
      String chatRoomId = users.join("_");

      var lastMessage = await _firestore.collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      DateTime? lastMessageTime;
      if (lastMessage.docs.isNotEmpty) {
        lastMessageTime = lastMessage.docs.first.data()['timestamp']?.toDate();
      }

      userDataWithTime.add({
        'data': data,
        'lastMessageTime': lastMessageTime,
        'doc': doc,
      });
    }

    userDataWithTime.sort((a, b) {
      if (a['lastMessageTime'] == null && b['lastMessageTime'] == null) return 0;
      if (a['lastMessageTime'] == null) return 1;
      if (b['lastMessageTime'] == null) return -1;
      return b['lastMessageTime'].compareTo(a['lastMessageTime']);
    });

    return userDataWithTime.map((item) => _buildUserListItem(item['doc'], item['data'])).toList();
  }

  Widget _buildUserListItem(DocumentSnapshot document, Map<String, dynamic> data) {
    try {
      final currentUserEmail = _auth.currentUser?.email;
      if (currentUserEmail == null) {
        return ListTile(title: Text('Not authenticated'));
      }

      final otherUserEmail = data['email'] ?? '';
      List<String> users = [currentUserEmail, otherUserEmail];
      users.sort();
      String chatRoomId = users.join("_");

      return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chat_rooms')
            .doc(chatRoomId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .limit(1)
            .snapshots(),
        builder: (context, messageSnapshot) {
          String lastMessage = '';
          String lastMessageTime = '';
          bool hasMessages = false;
          String lastMessageStatus = '';

          if (messageSnapshot.hasData && messageSnapshot.data!.docs.isNotEmpty) {
            var messageData = messageSnapshot.data!.docs.first.data() as Map<String, dynamic>;
            lastMessage = messageData['message']?.toString() ?? '';
            hasMessages = lastMessage.isNotEmpty;
            lastMessageStatus = messageData['status']?.toString() ?? '';

            if (messageData['timestamp'] != null) {
              lastMessageTime = _formatTime(messageData['timestamp'].toDate());
            }
          }

          final username = data['username']?.toString() ?? 'Unknown';
          final initial = username.isNotEmpty ? username[0].toUpperCase() : '?';

          return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('chat_rooms')
                .doc(chatRoomId)
                .collection('messages')
                .where('sender', isEqualTo: otherUserEmail)
                .where('status', whereIn: ['sent', 'delivered'])
                .snapshots(),
            builder: (context, unreadSnapshot) {
              int unreadCount = unreadSnapshot.data?.docs.length ?? 0;

              return Container(
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: unreadCount > 0 ? Colors.blue.shade50 : Colors.grey.shade100,
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade200,
                    child: Text(initial, style: TextStyle(color: Colors.white)),
                  ),
                  title: Row(
                    children: [
                      Expanded(child: Text(username, style: TextStyle(fontWeight: FontWeight.bold))),
                      if (hasMessages && lastMessageStatus == 'seen')
                        Icon(Icons.done_all, size: 16, color: Colors.blue),
                    ],
                  ),
                  subtitle: Text(
                    hasMessages ? lastMessage : 'No messages yet',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasMessages)
                        Text(lastMessageTime, style: TextStyle(color: Colors.grey.shade600)),
                      if (unreadCount > 0)
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomChat(targetUser: data),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      return ListTile(
        title: Text('Error loading user'),
        subtitle: Text(e.toString()),
      );
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}