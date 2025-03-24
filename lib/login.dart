import 'package:flutter/material.dart';
import 'package:app_b/uihelper.dart';
import 'package:app_b/navbutton.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          children: [
            Image.asset("assets/images/p.png"),
         SizedBox(height: 20,),

            Image.asset("assets/images/img.png"),

            SizedBox(height: 30,),
Text("India's last mintue app",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "bold"),),
            SizedBox(height: 20,),

        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),

        child:   Container(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white

              ),

child: Column(
  children: [
    SizedBox(height: 10,),

    Text("Sunil",style: TextStyle(fontFamily: " regular",color: Colors.black,fontWeight: FontWeight.normal),),
    SizedBox(height: 5,),
    Text("784335xxxx",style: TextStyle(fontFamily: " bold",color: Colors.black,fontWeight: FontWeight.bold),),
    SizedBox(height: 20,),


    Container(
      width: 295,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.red, // Change this to any color you want
        borderRadius: BorderRadius.circular(8), // Optional: Adds rounded corners
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Navbutton()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Makes button inherit Container color
          shadowColor: Colors.transparent, // Removes default shadow
        ),
        child: Text(
          "Login With Zomato",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    SizedBox(height: 5,),
    Text("Access your saved addresses from Zomato !",
      style: TextStyle(
        color: Color(0xFF9C9C9C),
        fontWeight: FontWeight.normal,

      ),
    ),
    SizedBox(height: 10,),
Text("or login with phone number",
style:TextStyle(
  color: Color(0xFF269237),
  fontWeight: FontWeight.normal,
  fontSize: 15
) ,
)
  ],
),
            )
        )
          ],
        ),
      ),
    );
  }
}
