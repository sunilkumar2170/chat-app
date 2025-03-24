import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Data"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("user").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // ✅ Loading indicator
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error.toString()}")); // ✅ Error handling
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data available")); // ✅ Handle empty data
          }

          // ✅ Display Firestore data
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];

              return ListTile(
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text("${doc["title"] ?? "No Title"}"), // ✅ Corrected interpolation
                subtitle: Text("${doc["description"] ?? "No Description"}"), // ✅ Corrected interpolation
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataScreen(),
  ));
}
