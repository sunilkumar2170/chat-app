import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forget extends StatefulWidget {
  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  TextEditingController emailcontroller = TextEditingController();

  Future<void> forgot(String email) async {
    if (email.isEmpty) {
      alertbox(context, "Please enter your email");
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        alertbox(context, "Password reset link sent to your email.");
      } catch (e) {
        alertbox(context, "Error: ${e.toString()}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forget Password"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                labelText: "Enter your email",
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                forgot(emailcontroller.text.trim());
              },
              child: const Text(
                "Reset Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> alertbox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
