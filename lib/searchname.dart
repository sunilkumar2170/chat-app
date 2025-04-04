import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'roomchat.dart';

class SearchName extends StatefulWidget {
  @override
  State<SearchName> createState() => _SearchNameState();
}

class _SearchNameState extends State<SearchName> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.blue.shade400,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Email Address",
                prefixIcon: Icon(Icons.email),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState(() {}); // Refresh UI on button press
              },
              child: Text("Search"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("usersm")
                  .where("email", isEqualTo: searchController.text)
                  .where('email', isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    var userData = snapshot.data!.docs[0].data() as Map<String, dynamic>;
                    var username = userData['username'] ?? 'No username available';
                    var email = userData['email'] ?? 'No email available';
                    var phone = userData['phone'] ?? 'No phone available';

                    return ListTile(
                      onTap: () {
Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoomChat(targetUser: userData),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      ),
                      title: Text(username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(email, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    );
                  } else if (snapshot.hasError) {
                    return Text("An error occurred");
                  } else {
                    return Text("No result found");
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
