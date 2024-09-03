import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reside_ease/firebase_options.dart';

// import 'package:reside_ease/home_screen.dart';
import 'package:reside_ease/introductory_screen.dart';
// import 'package:reside_ease/login_screen.dart';
import 'package:reside_ease/widgets/bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Widget _defaultHome = IntroductoryScreen(); // If the user is not logged in, the introductory screen is shown

  // Get the current user
  User? _user = FirebaseAuth.instance.currentUser;
  if (_user != null) {
    _defaultHome = ParentWidget(); // If the user is logged in, the home screen is shown
  }

  runApp(MyApp(home: _defaultHome,));
}

class MyApp extends StatelessWidget {
  final Widget? home;

  const MyApp({Key? key, this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(249, 249, 255, 1),
      ),
      home: this.home,
    );
  }
}