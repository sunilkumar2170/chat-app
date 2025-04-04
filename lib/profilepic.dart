import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_b/myname.dart';

class ProfilePic extends StatefulWidget {
  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final TextEditingController name = TextEditingController();

  void check(String name) {
    if (name.isEmpty) {
      // Agar name empty hai to error dialog show karo.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please enter your name"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dialog band karo.
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => myname(pro: name)),
      );
      print("Sign up pressed with name: $name");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Profile"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ))),
              SizedBox(height: 20),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Enter your full name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                color: Colors.blue,
                child: Text("Sign up"),
                onPressed: () {
                  check(name.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
