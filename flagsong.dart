import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constants {
  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle descriptionStyle = TextStyle(
    fontSize: 18.0,
    fontFamily: 'Lora',
    fontWeight: FontWeight.w900,
    letterSpacing: 1.5,
    color: Color(0xFF0001cf),
    height: 1.5,
  );

  // Colors
  static const Color primaryColor = Color(0xFF0001cf);
}

class FlagSong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FLAG SONG',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.03),
        children: [
          buildPrayerItem(
            composer: 'DAYAL SHANKAR BHAT',
            prayerDescription: PrayerSong,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.01),
          buildTimeCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildPrayerItem({
    required String composer,
    required String prayerDescription,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Constants.primaryColor,
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              composer,
              style: Constants.titleStyle,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: prayerDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: Constants.descriptionStyle,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTimeCard({
    required double screenWidth,
    required double screenHeight,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Constants.primaryColor,
      child: ListTile(
        leading: Icon(
          Icons.access_time_rounded,
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          '40-45 SECONDS',
          style: Constants.titleStyle,
        ),
      ),
    );
  }
}

final String PrayerSong = '''
#Bharat Scout Guide
#Jhanda Uncha Sada Rahega
#Uncha Sada Rahega Jhanda
#Uncha Sada Rahega
#Neela Rang Gagan Ka Visrit
#Bhratru Bhav Phailata
#Tridal Kamal Nit Teen
#Pratignaon Ki Yaad Dilata
#Aur Chakra Kehta Hai Pratpal
#Age Kadam Badega
#Uncha Sada Rahega
#Jhanda Uncha Sada Rahega
#Bharat Scout Guide
#Jhanda Uncha Sada Rahega
#Uncha Sada Rahega
''';

void main() {
  runApp(MaterialApp(
    home: FlagSong(),
  ));
}
