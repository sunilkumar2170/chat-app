import 'package:app_b/edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_b/noteslogin.dart';
import 'package:app_b/addnotes.dart';
import 'package:app_b/edit.dart';
import 'package:app_b/image.dart';
import 'package:app_b/text.dart';
class log extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final TextEditingController notes = TextEditingController();
    User? userId = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Notes App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotesLogin()));
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("note")
              .where("Userid", isEqualTo: userId?.uid) // 🔥 Fix field name
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No data found"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var note = snapshot.data!.docs[index]['keep'];
                var noteid = snapshot.data!.docs[index]['Userid'];
                var docid = snapshot.data!.docs[index].id;
                return Card(
                  child: ListTile(
                    title: Text(note),
                    subtitle: Text(noteid),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print(docid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Edit(),
                                settings: RouteSettings(arguments: {
                                  'note': note,
                                  'docid': docid
                                }),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                           await  FirebaseFirestore.instance.collection("note").doc(docid).delete();
                           showDialog(context: context, builder: (context) => AlertDialog(title: Text('your data delete succesfull')));

                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => addnotes()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
