import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_b/s.dart';
import 'package:app_b/log.dart';

class CheckUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => checkUser(context)); // ✅ Calls function after build

    return Scaffold(); // ✅ Keeps Scaffold as you requested
  }

  void checkUser(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>next()), // ✅ Navigates to Log()
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Log()), // ✅ Navigates to NextScreen()
      );
    }
  }
}
