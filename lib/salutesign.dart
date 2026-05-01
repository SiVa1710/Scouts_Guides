import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
    home: SaluteAndSign(),
  ));
}

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
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.03),
        children: [
          buildItem(
            itemName: 'SIGN',
            itemDescription: SignText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            iconPath: 'assets/icons/sign.png',
          ),
          SizedBox(height: screenHeight * 0.02),
          buildItem(
            itemName: 'SALUTE',
            itemDescription: SaluteText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            iconPath: 'assets/icons/sign.png',
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    required String itemName,
    required String itemDescription,
    required double screenWidth,
    required double screenHeight,
    required String iconPath,
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
              iconPath,
              width: 30,
              height: 30,
            ),
            title: Text(
              itemName,
              style: TextStyle(
                fontSize: 20,
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
                    children: itemDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0,
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
