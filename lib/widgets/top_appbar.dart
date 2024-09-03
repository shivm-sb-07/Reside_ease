import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reside_ease/conversation_screen.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade200,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      // leading: IconButton(
      //   icon: const Icon(Icons.person_2_rounded, color: Colors.black),
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('Profile Clicked'),
      //       ),
      //     );
      //   },
      // ),
      title: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              'Hello, ${data['name']}',
              style: TextStyle(fontWeight: FontWeight.w500),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Text('Error: ${snapshot.error}');
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add_alert, color: Colors.black),
          tooltip: 'Show Snackbar',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notification Clicked'),
              ),
            );
          },
        ),
        const SizedBox(width: 10.0),
        IconButton(
          icon: const Icon(Icons.message_rounded, color: Colors.black),
          tooltip: 'Show Snackbar',
          onPressed: () {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: Text('Message Clicked'),
            //   ),
            // );
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConversationScreen()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
