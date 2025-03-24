import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_b/noteslogin.dart';
class log extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController notes=TextEditingController();
    User? userid=FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Notes App"),
        centerTitle: true,
       actions: [

         IconButton(onPressed: (){

           Navigator.push(context, MaterialPageRoute(builder: (context)=>NotesLogin()));
         }, icon: Icon(Icons.logout))
       ],

      ),
      body: Column(
        children: [
          TextField(
            controller: notes,
            decoration: InputDecoration(
              hintText: "Add Note",
              border: UnderlineInputBorder(

              )
            ),

          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            var note=notes.text.trim();
            if( note!=""){
              try
                  {
                    await FirebaseFirestore.instance.collection("note").doc().set({
                      "keep":note,
                      "created":DateTime.now(),
                      "Userid":userid?.uid,

                    });
                    print("succesful");
                  }
                  catch(e){
                print("error $e");
                  }

            }

          }, child:Text("ADD Note "))

        ],
      ),


    );
  }
}
