import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scouts_and_guides/compass.dart';
import 'package:scouts_and_guides/lefthandshake.dart';
import 'package:scouts_and_guides/promiselaw.dart';
import 'package:scouts_and_guides/salutesign.dart';
import 'package:scouts_and_guides/signals.dart';
import 'package:scouts_and_guides/motto.dart';

class Notes extends StatelessWidget {
  final List<String> itemNames = [
    "PROMISE & LAW",
    "SIGN & SALUTE",
    "MOTTO",
    "LEFTHAND SHAKE",
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
    // Ensure portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTES',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
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
            color: Color(0xFF0001cf),
            width: 3.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 18, // Adjusted font size to match the style
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Sarabun',
                letterSpacing: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
