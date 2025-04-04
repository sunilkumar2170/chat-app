import 'package:app_b/noteslogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_b/noteslogin.dart';
class  logoutse extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout,color: Colors.pink,),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NotesLogin()),
                  );
                }, child: Text("Logout")),
              ],
            ),
          ),
        ),
      ),

    );
  }

}