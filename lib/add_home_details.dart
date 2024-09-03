import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddHomeDetails extends StatefulWidget {
  @override
  _AddHomeDetailsState createState() => _AddHomeDetailsState();
}

class _AddHomeDetailsState extends State<AddHomeDetails> {
  String? _dropdownValueCity;
  String? _dropdownValueSociety;
  String? _dropdownValueTower;
  String? _dropdownValueFlatNumber;
  String? _dropdownValueOccupancyStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Home'),
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
                  // Your TextFormFields and DropdownButtonFormField here
                  const SizedBox(
                    height: 50,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValueCity,
                    decoration: InputDecoration(
                      labelText: 'City',
                      hintText: 'Select Your City',
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValueCity = newValue;
                      });
                    },
                    items: <String>[
                      'Ahmedabad',
                      'Pune',
                      'Surat',
                      'Vadodara',
                      'Mumbai',
                      'Nagpur'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValueSociety,
                    decoration: InputDecoration(
                      labelText: 'Society',
                      hintText: 'Select Your Society',
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValueSociety = newValue;
                      });
                    },
                    items: <String>[
                      'Ariana Lakeview society',
                      'GreenPalace society',
                      'Paradise society',
                      'Sunflower Society',
                      'GrandStar Society',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValueTower,
                    decoration: InputDecoration(
                      labelText: 'Tower',
                      hintText: 'Select Your Tower',
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValueTower = newValue;
                      });
                    },
                    items: <String>[
                      'Wing A',
                      'Wing B',
                      'Wing C',
                      'Wing D',
                      'Wing E'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValueFlatNumber,
                    decoration: InputDecoration(
                      labelText: 'Flat Number',
                      hintText: 'Select Your Flat Number',
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValueFlatNumber = newValue;
                      });
                    },
                    items: <String>['101', '102', '103', '104', '105']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _dropdownValueOccupancyStatus,
                    decoration: InputDecoration(
                      labelText: 'Occupancy Status',
                      hintText: 'Select Your Status',
                      labelStyle: const TextStyle(color: Colors.black87),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownValueOccupancyStatus = newValue;
                      });
                    },
                    items: <String>['Currently Residing', 'Moving In']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
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
                    // onPressed: () {
                    //   Navigator.pop(context, {
                    //     'City': _dropdownValueCity,
                    //     'Society': _dropdownValueSociety,
                    //     'Tower': _dropdownValueTower,
                    //     'Flat Number': _dropdownValueFlatNumber,
                    //     'Occupancy Status': _dropdownValueOccupancyStatus,
                    //   });
                    // },
                    onPressed: () {
                      FirebaseFirestore.instance.collection('homes').add({
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'City': _dropdownValueCity,
                        'Society': _dropdownValueSociety,
                        'Tower': _dropdownValueTower,
                        'Flat Number': _dropdownValueFlatNumber,
                        'Occupancy Status': _dropdownValueOccupancyStatus,
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
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
        ),
      ),
    );
  }
}
