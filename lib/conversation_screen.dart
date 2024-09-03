import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:reside_ease/services/firestore_service.dart';
import 'package:reside_ease/chat_screen.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  List<String> chats = [];

  @override
  void initState() {
    super.initState();
    fetchChatHistory();
  }

  void fetchChatHistory() async {
    print('Fetching chat history...');
    FirestoreService firestoreService = FirestoreService();
    List<String> fetchedChatHistory = await firestoreService
        .getChatHistory(FirebaseAuth.instance.currentUser!.uid);
    print('Fetched chat history: $fetchedChatHistory');
    setState(() {
      chats = fetchedChatHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: chats.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            )
          : ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      chats[index].substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    chats[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Tap to open chat',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                            userId: FirebaseAuth.instance.currentUser!.uid,
                            receiverId: chats[index]),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UsersScreen()),
          );

          if (result != null) {
            final Map<String, dynamic> selectedUser = result;
            if (!chats.contains(selectedUser['name'])) {
              setState(() {
                chats.add(selectedUser['name']);
              });
            }
          }
        },
      ),
    );
  }
}

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reside-Ease Users'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final List<DocumentSnapshot> users = snapshot.data!.docs
              .where((user) => user.id != currentUserId)
              .toList();
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(users[index]['name']),
                onTap: () {
                  Navigator.pop(context,
                      {'id': users[index].id, 'name': users[index]['name']});
                },
              );
            },
          );
        },
      ),
    );
  }
}
