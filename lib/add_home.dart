import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_home_details.dart';

class AddHome extends StatefulWidget {
  const AddHome({super.key});

  @override
  _AddHomeState createState() => _AddHomeState();
}

class _AddHomeState extends State<AddHome> {
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
          title: const Text('Add Home'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('homes')
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
                        "You haven't added any additional properties yet!",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      );
                    }

                    return Column(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> home =
                            document.data() as Map<String, dynamic>;
                        return Container(
                          width: double.infinity,
                          child: Card(
                            color: Colors.blue.shade50,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${home['Society']}',
                                    style: TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${home['Tower']} - ${home['Flat Number']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${home['City']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${home['Occupancy Status']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('homes')
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
                      builder: (context) => AddHomeDetails(),
                    ),
                  );

                  if (result != null) {
                    FirebaseFirestore.instance.collection('homes').add({
                      'userId': FirebaseAuth.instance.currentUser!.uid,
                      'City': result['City'],
                      'Society': result['Society'],
                      'Tower': result['Tower'],
                      'Flat Number': result['Flat Number'],
                      'Occupancy Status': result['Occupancy Status'],
                    });
                  }
                },
                icon: const Icon(
                  Icons.add_home_outlined,
                  color: Colors.black,
                ),
                label: const Text(
                  'Add Homes',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
