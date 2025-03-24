import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class card extends StatelessWidget{

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          SizedBox(height: 10,),
          Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                color: const Color(0xFFF7CB45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Row(children: [
                      SizedBox(width: 30,),

                      Text("Blinkit in",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),

                    ],
                    ),

                    Row(children: [
                      SizedBox(width: 30,),

                      Text("16 minutes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),

                    ],
                    ),

                    Row(children: [
                      SizedBox(width: 10,),

                      Text("Home",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                      Text("- Sujal Dave, Ratanada, Jodhpur (Raj)",style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,color: Colors.black),),
                    ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 80,
                right: 20,

                child:   CircleAvatar(
                radius: 15,
backgroundColor: Colors.white,
                child: Icon(Icons.person,size: 20,color: Colors.black,),
              )
              )
            ],

          ),
    Positioned(
    bottom: 100,
    left: 15,
    right: 20,
    child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 7),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.red,
    boxShadow: [
    BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    blurRadius: 5,
    spreadRadius: 2),
    ],
    ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          Expanded(
            child: TextField(
              controller: search,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
              ),
            ),
          ),
          const Icon(Icons.mic, color: Colors.grey),
        ],
      ),
    ),
    ),

          SizedBox(height: 20,),
         Image.asset("assets/images/im.png"),
          SizedBox(width: 20,),

          Text("Reordering will be easy",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),),
          Text("Items you order will show up here so you can buy.",style: TextStyle(fontSize:12,fontWeight: FontWeight.normal,color: Colors.black),),
          Text(" them again easily.",style: TextStyle(fontSize:12,fontWeight: FontWeight.normal,color: Colors.black),),

          SizedBox(height: 10,),

          Row(
            children: [
              SizedBox(width: 20,),
              Text("Bestsellers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                child: Stack(
                  // Image ke end me center me lane ke liye
                  children: [
                    Image.asset("assets/images/2.png"),
                    Positioned(
                      bottom: -10, // Image ke bilkul neeche lane ke liye
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          side: BorderSide(color: Colors.green, width: 1), // Patla border
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Chhota button
                          minimumSize: Size(35, 25), // Fixed size
                        ),
                        child: Text("ADD", style: TextStyle(fontSize: 10)), // Chhota text
                      ),
                    ),
                  ],
                ),

              ),
              SizedBox(width: 2,),

              Expanded(
                child: Stack(
                  // Image ke end me center me lane ke liye
                  children: [
                    Image.asset("assets/images/1.png"),
                    Positioned(
                      bottom: -10, // Image ke bilkul neeche lane ke liye
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          side: BorderSide(color: Colors.green, width: 1), // Patla border
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Chhota button
                          minimumSize: Size(35, 25), // Fixed size
                        ),
                        child: Text("ADD", style: TextStyle(fontSize: 10)), // Chhota text
                      ),
                    ),
                  ],
                ),

              ),


            ],
          )






        ],
      )
    );
  }

}