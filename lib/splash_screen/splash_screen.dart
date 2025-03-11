import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_app/view/authentication/login.dart';
import 'package:sneakers_app/view/navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  /// Check if the user is already logged in
  Future<void> _checkUserStatus() async {
    await Future.delayed(
      Duration(seconds: 2),
    ); // Optional delay for splash effect
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is already logged in, navigate to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigator()),
      );
    } else {
      // User is NOT logged in, show login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // Loading indicator
    );
  }
}
