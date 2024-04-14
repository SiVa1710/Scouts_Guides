import 'package:flutter/material.dart';
import 'package:scouts_and_guides/compass.dart';
import 'package:scouts_and_guides/lefthandshake.dart';
import 'package:scouts_and_guides/promiselaw.dart';
import 'package:scouts_and_guides/salutesign.dart';
import 'package:scouts_and_guides/signals.dart';
import 'motto.dart';

class Notes extends StatelessWidget {
  final List<String> itemNames = [
    "PROMISE & LAW",
    "SIGN & SALUTE",
    "MOTTO",
    "LEFT HAND SHAKE",
    "COMPASS",
    "SIGNALS"
  ];

  final List<String> itemImages = [
    "assets/icons/law.png",
    "assets/icons/sign.png",
    "assets/icons/motto.png",
    "assets/icons/hand.png",
    "assets/icons/compass.png",
    "assets/icons/signal.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTES',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,// Increase the font size
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),// Add padding around the grid
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
                      MaterialPageRoute(builder: (context) => PromiseAndLaw()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SaluteAndSign()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Motto()),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LeftHandShake()),
                    );
                    break;
                  case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Compass()),
                    );
                    break;
                  case 5:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signals()),
                    );
                    break;
                // Add more cases for additional screens
                  default:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notes()),
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

  ItemCard({this.name, this.image, this.onTap});

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
                fontSize: MediaQuery.of(context).size.width * 0.04, // Increased font size
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Sarabun',
                letterSpacing: 1.3,// Adjust text size based on screen size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
