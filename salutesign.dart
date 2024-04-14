import 'package:flutter/material.dart';

class SaluteAndSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGN & SALUTE',
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
          buildSignItem(
            signName: 'SIGN',
            signDescription: SignText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildSaluteItem(
            saluteName: 'SALUTE',
            saluteDescription: SaluteText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildSignItem({
    String signName,
    String signDescription,
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
            leading: Image.asset(
              'assets/icons/sign.png', // Replace with your image asset path
              width: 30, // Adjust image size
              height: 30,
            ),
            title: Text(
              signName,
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
                    children: signDescription.split('#').map((line) {
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

  Widget buildSaluteItem({
    String saluteName,
    String saluteDescription,
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
            leading: Image.asset(
              'assets/icons/sign.png', // Replace with your image asset path
              width: 30, // Adjust image size
              height: 30,
            ),
            title: Text(
              saluteName,
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
                    children: saluteDescription.split('#').map((line) {
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
}

final String SignText = '''
#• The Scout sign is given by raising the right hand in level with the shoulder, palm to the front with three fingers stretched together and the thumb closing on the little finger.
#
#• The sign is given at the time of Investiture and at the time of renewal of the Scout Promise.
#
#• The three upraised fingers stand for the three parts of the Scout Promise. The thumb and little finger together stand for the bond between all Scouts.
''';

final String SaluteText = '''
#• The three-finger salute is used by members of Scout and Guide organizations around the world when greeting other Scouts and in respect of a national flag at ceremonies. In most situations, the salute is made with the palm face out, the thumb holding down the little finger, and with the fingertips on the brow of the head.
# 
#Meaning of the three fingers:
#
#• In his book, Scouting for Boys, Robert Baden-Powell chose the three-finger salute for Scouts to represent the three aspects of the Scout Promise:
#
#1. Honour God and the King
#2. Help Others
#3. Obey the Scout Law
''';

void main() {
  runApp(MaterialApp(
    home: SaluteAndSign(),
  ));
}
