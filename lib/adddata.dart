import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  void adddata(String title, String desc) async {
    if (title.isEmpty || desc.isEmpty) {
      log("Enter Required details");
      return;
    } else {
      FirebaseFirestore.instance.collection("Users").doc(title).set({
        "Title": title,
        "Description": desc,
      }).then((_) {
        log("Details sent successfully");
      }).catchError((error) {
        log("Failed to send details: $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: "Enter Title",
                suffixIcon: Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: desc,
              decoration: InputDecoration(
                hintText: "Enter Description",
                suffixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                adddata(title.text.trim(), desc.text.trim());
              },
              child: Text("Save Data"),
            ),
          ],
        ),
      ),
    );
  }
}
