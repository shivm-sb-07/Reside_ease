import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reside_ease/member_details.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Flat Members'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('members')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return Text(
                      'Members associated with society gets smooth sail into the society.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    );
                  }

                  return Column(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> member =
                          document.data() as Map<String, dynamic>;
                      return Container(
                        width: double.infinity,
                        child: Card(
                          color: Colors.blue.shade50,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${member['firstName']} ${member['middleName']} ${member['lastName']}',
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${member['relation']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('members')
                                        .doc(document.id)
                                        .delete();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MembersDetailsScreen(),
                  ),
                );

                if (result != null) {
                  FirebaseFirestore.instance.collection('members').add({
                    'userId': FirebaseAuth.instance.currentUser!.uid,
                    'firstName': result['firstName'],
                    'middleName': result['middleName'],
                    'lastName': result['lastName'],
                    'relation': result['relation'],
                  });
                }
              },
              icon: const Icon(
                Icons.person_add_alt,
                color: Colors.black,
              ),
              label: const Text(
                'Add Members',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
