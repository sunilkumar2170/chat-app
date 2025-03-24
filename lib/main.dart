import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_b/adddata.dart';
import 'package:app_b/notifaction.dart';
import 'package:app_b/notescheck user.dart';
import 'package:app_b/Next.dart';
import 'package:app_b/noteslogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAVWK6moxXzSz6Uva1wZPCUJsMUXMrdGtU",
        appId: "1:33260933732:android:ce2af2cc11adbad83d0571",
        messagingSenderId: "33260933732",
        projectId: "basic-app-2-e2e7c",
        storageBucket: "basic-app-2-e2e7c.appspot.com",
      ),
    );

    // Initialize Firebase Messaging (Push Notifications)
    await Noti.initialize();

    runApp(MyApp());
  } catch (e) {
    print("🔥 Firebase Initialization Error: $e");
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: user != null ? log() : NotesLogin(),
    );
  }
}
