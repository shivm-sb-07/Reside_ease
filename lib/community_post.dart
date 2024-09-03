import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:reside_ease/widgets/message_card.dart';

class CommunityPost extends StatelessWidget {
  const CommunityPost({super.key});

  @override
  Widget build(BuildContext context) {
    final postController = TextEditingController();

    return Scaffold(
      // body: ListView(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 8.0,
      //   ),
      //   children: [
      //     CardNotice(
      //       leading: CircleAvatar(
      //         child: Text('A'),
      //       ),
      //       title: 'Ashish Patel, A-301',
      //       subtitle: '11 hours ago',
      //       description: "Looking to purchase a 3 BHK any leads???",
      //       onMessagePressed: () {
      //         // Add learn more logic here
      //       },
      //     ),

      //     CardNotice(
      //       leading: CircleAvatar(
      //         child: Text('B'), // You can place initials or an image here
      //       ),
      //       title: 'Varun Mandal, N-302',
      //       subtitle: '12 days ago',
      //       description:
      //           "Kudos to our amazing maintenance team for promptly fixing the elevator issue - your hard work doesn't go unnoticed!",
      //       onMessagePressed: () {
      //         // Add learn more logic here
      //       },
      //     ),

      //     CardNotice(
      //       leading: CircleAvatar(
      //         backgroundImage: AssetImage(
      //             'assets/icons/avatar1.jpg'), // You can place initials or an image here
      //       ),
      //       title: 'Aryan Lumrai, B-201',
      //       subtitle: '12 days ago',
      //       description:
      //           "Just moved in and already feeling warm welcome from our neighbors! Excited to be a part of this wonderful community",
      //       onMessagePressed: () {
      //         // Add learn more logic here
      //       },
      //     ),

      //     CardNotice(
      //       leading: CircleAvatar(
      //         backgroundImage: AssetImage(
      //             'assets/icons/avatar1.jpg'), // You can place initials or an image here
      //       ),
      //       title: 'Keisha Adebe, A-102',
      //       subtitle: '3 weeks ago',
      //       description:
      //           "A big thank you to whoever found my daughter's lost teddy bear near the playground and left it at the community center. Your kindness made her day, and we're grateful for this tight-knit community",
      //       onMessagePressed: () {
      //         // Add learn more logic here
      //       },
      //     ),

      //     CardNotice(
      //       leading: CircleAvatar(
      //         backgroundImage: AssetImage(
      //             'assets/icons/avatar1.jpg'), // You can place initials or an image here
      //       ),
      //       title: 'Manuel Ababio, F-101',
      //       subtitle: '14 weeks ago',
      //       description:
      //           "Shoutout to our vigilant neighbors who noticed a suspicious activity and promptly reported it to the authorities.",
      //       onMessagePressed: () {
      //         // Add learn more logic here
      //       },
      //     ),
      //     // Add more CardEvents as needed
      //   ],
      // ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(data['userId'])
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  Map<String, dynamic> userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CardNotice(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/icons/avatar1.jpg'), // You can place initials or an image here
                      ),
                      title: userData['name'], // Display the user's name
                      subtitle: DateFormat('yyyy-MM-dd, HH:mm')
                          .format(data['timestamp'].toDate()),
                      description: data['text'],
                      onMessagePressed: () {
                        // Add learn more logic here
                      },
                    ),
                  );
                },
              );
            }
            ).toList(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              Map<String, dynamic> userData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return ElevatedButton(
                                child: Text('Post'),
                                onPressed: () {
                                  String postText = postController.text;
                                  if (postText.isNotEmpty) {
                                    // Add the post to Firestore
                                    FirebaseFirestore.instance
                                        .collection('posts')
                                        .add({
                                      'text': postText,
                                      'userId': FirebaseAuth
                                          .instance.currentUser!.uid,
                                      'userName': userData[
                                          'name'], // Use the user's name from Firestore
                                      'timestamp':
                                          Timestamp.fromDate(DateTime.now()),
                                    }).then((value) {
                                      print("Post added");
                                      postController.clear(); // Clear the text
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                    }).catchError((error) {
                                      print("Failed to add post: $error");
                                    });
                                  } else {
                                    print('Post text is empty');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade900,
                                  foregroundColor: Colors.white,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                String name = data['name'] ?? '';
                                return CircleAvatar(
                                  backgroundColor: Colors.blue.shade100,
                                  radius: 20,
                                  child: Text(
                                    name.isNotEmpty
                                        ? name[0].toUpperCase()
                                        : '',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              return Text('Error: ${snapshot.error}');
                            },
                          ),
                          SizedBox(
                              width:
                                  10), // Add some spacing between the avatar and the text field
                          Expanded(
                            child: TextFormField(
                              controller: postController,
                              maxLines: 5,
                              maxLength: 200,
                              decoration: InputDecoration(
                                hintText: "What's happening?",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
      ),
    );
  }
}
