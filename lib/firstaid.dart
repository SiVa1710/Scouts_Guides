import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouts_and_guides/firstaid1.dart';
import 'package:scouts_and_guides/firstaid2.dart';
import 'package:scouts_and_guides/firstaid3.dart';
import 'package:scouts_and_guides/firstaid4.dart';
import 'package:scouts_and_guides/firstaid5.dart';
import 'package:scouts_and_guides/firstaid6.dart';

class FirstAid extends StatelessWidget {
  final List<String> itemNames = [
    "FIRST AID KIT",
    "PART I",
    "PART II",
    "PART III",
    "PART IV",
    "PART V",
  ];

  final List<String> itemImages = [
    "assets/images/kit.png",
    "assets/images/bleed.png",
    "assets/images/wound.png",
    "assets/images/bandage.png",
    "assets/images/fracture.png",
    "assets/images/shock.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FIRST AID',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold, // Make the title bold
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5, // Increase the font size
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0), // Add padding around the grid
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 12.0, // Adjust the spacing between columns
            mainAxisSpacing: 12.0, // Adjust the spacing between rows
          ),
          itemBuilder: (context, index) {
            return ItemCard(
              name: itemNames[index],
              image: itemImages[index],
              onTap: () {
                // Navigate to different screens based on the index
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAidKit()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAid1()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAid2()),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAid3()),
                    );
                    break;
                  case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAid4()),
                    );
                    break;
                  case 5:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAid5()),
                    );
                    break;
                // Add more cases for additional screens
                  default:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstAid()),
                    );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  ItemCard({required this.name, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 9,
        color: Color(0xFF0001cf),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: Color(0xFF0001cf), // Border color
            width: 3.0, // Border width
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image, // Replace with your image assets
              width: MediaQuery.of(context).size.width * 0.15, // Adjust image width based on screen size
              height: MediaQuery.of(context).size.width * 0.15, // Adjust image height based on screen size
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              name, // Replace with category name
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.048, // Increased font size
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Sarabun',
                letterSpacing: 1.3, // Adjust text size based on screen size
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MaterialApp(
    home: FirstAid(),
  ));
}
