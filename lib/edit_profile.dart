import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // experimental code
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final locationController = TextEditingController();
  final dobNode = FocusNode();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumberController.text);
    prefs.setString('dob', dobController.text);
    prefs.setString('gender', genderController.text);
    prefs.setString('location', locationController.text);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    phoneNumberController.text = prefs.getString('phoneNumber') ?? '';
    dobController.text = prefs.getString('dob') ?? '';
    genderController.text = prefs.getString('gender') ?? '';
    locationController.text = prefs.getString('location') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.0444,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.05),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  String name = data['name'] ?? '';
                  return CircleAvatar(
                    radius: 50,
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : '',
                      style: TextStyle(fontSize: 40),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return Text('Error: ${snapshot.error}');
              },
            ),
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenWidth * 0.05),
                      topRight: Radius.circular(screenWidth * 0.05),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text('Open Camera'),
                          onTap: () {
                            // Add your functionality for opening the camera here
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Open Gallery'),
                          onTap: () {
                            // Add your functionality for opening the gallery here
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.delete),
                          title: Text('Remove Current Picture'),
                          iconColor: Colors.red,
                          textColor: Colors.red,
                          onTap: () {
                            // Add your functionality for removing the current picture here
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Edit profile picture',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.03055,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                TextField(
                                  controller:
                                      TextEditingController(text: data['name']),
                                  decoration: InputDecoration(
                                    // filled: true,
                                    labelText: 'Name',
                                    // Rest of your code...
                                  ),
                                ),
                                // const SizedBox(height: 10),
                                TextField(
                                  controller: TextEditingController(
                                      text: data['email']),
                                  decoration: InputDecoration(
                                    // filled: true,
                                    labelText: 'Email',
                                    // Rest of your code...
                                  ),
                                ),
                                // const SizedBox(height: 10),

                                TextField(
                                  controller: TextEditingController(
                                      text: data['username']),
                                  decoration: InputDecoration(
                                    // filled: true,
                                    labelText: 'Username',
                                    // Rest of your code...
                                  ),
                                ),
                                // const SizedBox(height: 10),

                                // Rest of your code...
                              ],
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          return Text('Error: ${snapshot.error}');
                        },
                      ),
                      TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: 'Phone Number',
                        ),
                      ),
                      // const SizedBox(height: 10),
                      TextFormField(
                        controller: dobController,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: 'Date of Birth',
                        ),
                        focusNode: dobNode,
                        onTap: () async {
                          // Prevent the keyboard from showing
                          FocusScope.of(context).requestFocus(new FocusNode());

                          // Show the date picker
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          // Update the text of the controller with the selected date
                          if (date != null) {
                            dobController.text =
                                DateFormat('yyyy-MM-dd').format(date);
                          }

                          // Prevent the form from validating when the date picker is shown
                          dobNode.unfocus();
                        },
                      ),
                      // const SizedBox(height: 10),
                      TextField(
                        controller: genderController,
                        decoration: InputDecoration(
                          // filled: true,
                          labelText: 'Gender',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          saveData();
                        },
                        child: Text('Save Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
