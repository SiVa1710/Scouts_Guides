import 'package:flutter/material.dart';

class NationalAnthem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NATIONAL ANTHEM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.03),
        children: [
          buildPrayerItem(
            Composer: 'RABINDRANATH TAGORE',
            prayerDescription: PrayerSong,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildTimeCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildPrayerItem({
    String Composer,
    String prayerDescription,
    double screenWidth,
    double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFF0001cf),
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              Composer,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                        style: TextStyle(
                          fontSize: screenWidth * 0.048,
                          fontFamily: 'Lora',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Color(0xFF0001cf),
                          height: 1.5,
                        ),
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
    double screenWidth,
    double screenHeight,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Color(0xFF0001cf),
      child: ListTile(
        leading: Icon(
          Icons.access_time_rounded,
          color: Colors.white,
          size: 30,
        ),
        title: Text(
          '52 SECONDS',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

final String PrayerSong = '''
#Jana Gana Mana Adhinaayaka Jaya Hey,
#Bharata Bhaagya Vidhaataa
#Punjab Sindhu Gujarat Maraatha,
#Draavid Utkal Banga
#Vindhya Himaachal Yamuna Ganga,
#Uchchhal Jaladhi Taranga
#Tav Shubh Naamey Jaagey,
#Tav Shubh Aashish Maange
#Gaahey Tav Jayagaathaa
#Jana Gana Mangal Daayaka,
#Jaya Hey Bhaarat Bhaagya Vidhaataa
#Jaya Hey, Jaya Hey, Jaya Hey,
#Jaya Jaya Jaya, Jaya Hey
''';

void main() {
  runApp(MaterialApp(
    home: NationalAnthem(),
  ));
}
