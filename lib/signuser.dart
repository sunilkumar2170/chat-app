import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import'package:app_b/noteslogin.dart';


Future<void> signUser(String user, String number, String em, String pa, BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    // अगर user logged in नहीं है, तो error handle करें
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No user is currently logged in.")),
    );
    return;
  }

  try {
    await FirebaseFirestore.instance.collection("usersm").doc(currentUser.uid).set({
      'username': user,
      'phone': number,
      'email': em,
      'createdAt': DateTime.now(),  // सही लिखावट
      'userId': currentUser.uid,
    });

    print("User created successfully!");

    // Signup सफल होने पर Login Page पर वापस जाएँ
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NotesLogin()),
    );

  } catch (error) {
    print("Error: ${error.toString()}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Signup failed: ${error.toString()}")),
    );
  }
}
