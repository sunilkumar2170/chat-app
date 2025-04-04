import 'package:app_b/Next.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final TextEditingController edit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    // Get the 'note' argument from the map
    String not = arguments?['note'] ?? '';
    String  id = arguments?['docid'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),  // Use the 'note' argument here
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: edit ..text="${not}",

            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: ()  async{

               FirebaseFirestore.instance.collection("note").doc(id.toString()).update({
       'keep':edit.text.trim(),

                 
               }).then((onValue){
                 print("update succesful");
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>log()));
               });

              },
              style: ElevatedButton.styleFrom(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded button
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
