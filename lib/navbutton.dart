import 'package:app_b/card.dart';
import 'package:app_b/catogary.dart';
import 'package:app_b/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_b/print.dart';

class Navbutton extends StatefulWidget{
  @override
  State<Navbutton> createState() => _NavbuttonState();
}

class _NavbuttonState extends State<Navbutton> {
  int currentindex=0;
  List<Widget>pages=[
    home(),
    card(),
    catogory(),
    print(),

  ];
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index:currentindex ,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon:Image.asset("assets/images/home 1.png"),label: "Home"),
        BottomNavigationBarItem(icon:Image.asset("assets/images/shopping-bag 1.png"),label: "Card"),
        BottomNavigationBarItem(icon:Image.asset("assets/images/category 1.png"),label: "Catogary"),

        BottomNavigationBarItem(icon:Image.asset("assets/images/printer 1.png"),label: "Print")


      ] ,type: BottomNavigationBarType.fixed,currentIndex: currentindex,onTap: (index){
        setState(() {
          currentindex=index;
        });
      },),
    );

  }
}