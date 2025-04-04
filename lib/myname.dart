import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_b/profilepic.dart';

import 'package:app_b/mainpage.dart';

class myname extends StatelessWidget{
  final String pro;

  const myname({Key? key, required this.pro}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("welcome  $pro,",style:TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );

            }, child: Text("Continue")),
          ],

        ),
      ),

    );
  }
}