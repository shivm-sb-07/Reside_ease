import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:reside_ease/widgets/bottom_navigation.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isSignIn = true;
  bool _isVerifying = false;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isVerifying = true;
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Store additional details in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'username': _usernameController.text,
          'email': _emailController.text,
        });
        // Navigate to ParentWidget if registration is successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParentWidget()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An unknown error occurred.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unknown error occurred.')),
        );
      } finally {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isVerifying = true;
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Navigate to ParentWidget if sign in successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ParentWidget()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An unknown error occurred.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unknown error occurred.')),
        );
      } finally {
        setState(() {
          _isVerifying = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _isSignIn ? 'Sign In' : 'Sign Up',
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email', filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                enabled: !_isVerifying,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration:
                    InputDecoration(labelText: 'Password', filled: true),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                enabled: !_isVerifying,
              ),
              SizedBox(height: 10),
              if (!_isSignIn)
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name', filled: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  enabled: !_isVerifying,
                ),
              SizedBox(height: 10),
              if (!_isSignIn)
                TextFormField(
                  controller: _usernameController,
                  decoration:
                      InputDecoration(labelText: 'Username', filled: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  enabled: !_isVerifying,
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSignIn = !_isSignIn;
                  });
                },
                child: Text(_isSignIn
                    ? 'New user? Sign up instead'
                    : 'Already a user? Sign in instead'),
              ),
              ElevatedButton(
                onPressed:
                    _isVerifying ? null : (_isSignIn ? _signIn : _register),
                child: _isVerifying
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      )
                    : Text(_isSignIn ? 'Sign In' : 'Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
