import 'package:flutter/material.dart';

class LeftHandShake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NOTES',
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
          buildMottoItem(
            handshakeName: 'LEFT HAND SHAKE',
            handshakeDescription: handshakeText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildMottoItem({
    String handshakeName,
    String handshakeDescription,
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
              'assets/icons/hand.png', // Replace with your image asset path
              width: 30, // Adjust image size
              height: 30,
            ),
            title: Text(
              handshakeName,
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
                    children: handshakeDescription.split('#').map((line) {
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

final String handshakeText = '''
#• The left-handed Scout handshake is a formal way of greeting other Scouts of both genders used by members of Scout and Guide organizations around the world when greeting other Scouts. 
#
#• The handshake is made with the hand nearest the heart and is offered as a token of friendship.
''';

void main() {
  runApp(MaterialApp(
    home: LeftHandShake(),
  ));
}
