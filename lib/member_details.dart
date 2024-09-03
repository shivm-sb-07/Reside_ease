import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MembersDetailsScreen extends StatefulWidget {
  @override
  _MembersDetailsScreenState createState() => _MembersDetailsScreenState();
}

class _MembersDetailsScreenState extends State<MembersDetailsScreen> {
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Details'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      hintText: 'Enter First Name',
                      focusColor: Colors.black,
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    cursorColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _middleNameController,
                    decoration: InputDecoration(
                      labelText: 'Middle Name',
                      hintText: 'Enter Middle Name',
                      focusColor: Colors.black,
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    cursorColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      hintText: 'Enter Last Name',
                      focusColor: Colors.black,
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    cursorColor: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValue,
                    decoration: InputDecoration(
                      labelText: 'Relation',
                      hintText: 'Select Relationship with Person',
                      focusColor: Colors.black,
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Mother',
                      'Father',
                      'Sibling',
                      'Cousin',
                      'Wife',
                      'Husband',
                      'Tenant'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    onPressed: () {
                      CollectionReference members =
                          FirebaseFirestore.instance.collection('members');
                      members.add({
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'firstName': _firstNameController.text,
                        'middleName': _middleNameController.text,
                        'lastName': _lastNameController.text,
                        'relation': _dropdownValue,
                      }).then((value) {
                        print("Member Added");
                      }).catchError((error) {
                        print("Failed to add member: $error");
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
