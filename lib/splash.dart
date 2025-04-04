import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_b/navbutton.dart';
import 'package:app_b/noteslogin.dart'; // लॉगिन पेज का आयात

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 4), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // यदि उपयोगकर्ता साइन इन नहीं है, तो लॉगिन पेज पर जाएं
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NotesLogin()),
        );
      } else {
        // यदि उपयोगकर्ता साइन इन है, तो होम पेज पर जाएं
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  Navbutton()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.flash_on, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "Welcome to My  chat app App",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
