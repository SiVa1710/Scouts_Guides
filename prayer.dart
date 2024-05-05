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

class Prayer extends StatelessWidget {
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
          'PRAYER SONG',
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
            composer: 'VEER DEV VEER',
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
          '90 SECONDS',
          style: Constants.titleStyle,
        ),
      ),
    );
  }
}

final String PrayerSong = '''
#Daya kar dann Bhakti ka
#Hamain Paramatma Dena
#Daya Karna Hamari Atma main
#Shudhata Dena
# 
#Hamare Dyan main Auvo
#Prabhu Ankho main Bas Jao
#Andhere Dil main aakar Ke
#Param Jyoti Jaga Dena
# 
#Bahado Prem Ki Ganga
#Dilo main Prem Ka Sagar
#Hamain Aapas main miljul Kar
#Prabhu Rahana Sikha Dena
# 
#Hamara Karma Ho Seva
#Hamara Dharma Ho Seva
#Sada Eeman Ho Seva
#Va Sevak Char Bana Dena
# 
#Vatan Kay Vaste Jeena
#Vatan Kay Vaste Marna
#Vatan Par Jaan Fida Karna
#Prabhu Ham Ko Sikha Dena
#
#Daya kar dann Bhakti ka
#Hamain Paramatam Dena
#Daya Karna Hamari Atma main
#Shudhata Dena.
''';

void main() {
  runApp(MaterialApp(
    home: Prayer(),
  ));
}
