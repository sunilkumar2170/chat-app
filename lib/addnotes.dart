import 'package:app_b/Next.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addnotes extends StatelessWidget{
  final TextEditingController notes=  TextEditingController();
  User? userid=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {

   return Scaffold(
     appBar: AppBar(
       title: Text("ADD NOTES"),
       centerTitle: true,
       backgroundColor: Colors.blue.shade400,
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

               }).then((onValue){
                 print("your note add succesful");
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>log()));
                 showDialog(context: context, builder: (context) => AlertDialog(title: Text('Your  data added ')));

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