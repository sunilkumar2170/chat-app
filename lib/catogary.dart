import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class   catogory extends StatelessWidget {
  TextEditingController search = TextEditingController();

  final List<Map<String, String>> kitchen = [
    {"img": "image 21.png", "Text": "Vegetables & \nFruits"},
    {"img": "image 22.png", "Text": "Atta, Dal & \nRice"},
    {"img": "image 23.png", "Text": "Oil, Ghee & \nMasala"},
    {"img": "image 24.png", "Text": "Dairy, Bread & \nMilk"},
    {"img": "image 21.png", "Text": "Biscuits & \nBakery"},
  ];

  final List<Map<String, String>> second = [
    {"img": "image 41.png", "Text": "Dry Fruits & \nCereals"},
    {"img": "image 42.png", "Text": "Kitchen & \nAppliances"},
    {"img": "image 43.png", "Text": "Tea & \nCoffees"},
    {"img": "image 44.png", "Text": "Ice Creams & \nmuch more"},
    {"img": "image 45.png", "Text": "Noodles & \nPacket Food"},
  ];
  final List<Map<String, String>>  snacks = [
    {"img": "image 31.png", "Text": "Chips & \nNamkeens"},
    {"img": "image 32.png", "Text": "Sweets & \nChocalates"},
    {"img": "image 33.png", "Text": "Drinks & \nJuices"},
    {"img": "image 34.png", "Text": "Sauces & \nSpreads"},
    {"img": "image 35.png", "Text": "Beauty & \nCosmetics"},
  ];
  final List<Map<String, String>>  third = [
    {"img": "image 41.png", "Text": "Sweets & \nChocalates"},
    {"img": "image 42.png", "Text": "Oil, Ghee & \nMasala"},
    {"img": "image 43.png", "Text": "Sweets & \nChocalates"},
    {"img": "image 44.png", "Text": "Tea & \nCoffees"},
    {"img": "image 45.png", "Text": "Oil, Ghee &\n Masala"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          Stack(
            children: [
              Container(
                height: 190,
                width: double.infinity,
                color: const Color(0xFFF7CB45),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        SizedBox(width: 20),
                        Text("Blinkit in",
                            style: TextStyle(fontSize: 24, color: Colors.black)),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 20),
                        Text("16 minutes",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 20),
                        Text("Home",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        SizedBox(width: 10),
                        Text("- drug, Chhattisgarh, IIT Bhilai",
                            style: TextStyle(
                                color: Colors.black, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 20,
                bottom: 100,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.pink, size: 20),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
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
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              SizedBox(width: 20),
              Text("Grocery & Kitchen",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),


          SizedBox(
            height: 120, // Set a fixed height
            child: ListView.builder(
              itemCount: kitchen.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFD9EBEB),
                      ),
                      child: Image.asset(
                        'assets/images/${kitchen[index]["img"]}',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kitchen[index]["Text"].toString(),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 15),

          /// Second List - Second Category
          SizedBox(
            height: 120, // Set a fixed height
            child: ListView.builder(
              itemCount: second.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFD9EBEB),
                      ),
                      child: Image.asset(
                        'assets/images/${second[index]["img"]}',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      second[index]["Text"].toString(),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 20),
          const Row(
            children: [
              SizedBox(width: 20),
              Text("Snacks & Drinks",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 8,),

          SizedBox(
            height: 120, // Set a fixed height
            child: ListView.builder(
              itemCount: snacks.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFD9EBEB),
                      ),
                      child: Image.asset(
                        'assets/images/${snacks[index]["img"]}',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      snacks[index]["Text"].toString(),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),

                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
              child:
          SizedBox(
            height: 120, // Set a fixed height
            child: ListView.builder(
              itemCount: third.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFD9EBEB),
                      ),
                      child: Image.asset(
                        'assets/images/${third[index]["img"]}',
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      third[index]["Text"].toString(),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),

                  ],
                );
              },
            ),
          ),
          )
        ],
      ),
    );
  }
}
