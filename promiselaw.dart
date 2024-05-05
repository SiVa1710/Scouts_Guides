import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MaterialApp(
    home: PromiseAndLaw(),
  ));
}

class PromiseAndLaw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Constants for text styles
    const TextStyle pageTitleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'Sarabun',
      letterSpacing: 1.5,
    );

    const TextStyle flagTitleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    const TextStyle flagDescriptionStyle = TextStyle(
      fontSize: 18.0,
      fontFamily: 'Lora',
      fontWeight: FontWeight.w900,
      letterSpacing: 1.5,
      color: Color(0xFF0001cf),
      height: 1.5,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PROMISE AND LAW',
          style: pageTitleStyle,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.03),
        children: [
          buildItem(
            itemName: 'PROMISE',
            itemDescription: PromiseText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            iconPath: 'assets/icons/sign.png',
          ),
          SizedBox(height: screenHeight * 0.02),
          buildItem(
            itemName: 'LAW',
            itemDescription: LawText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            iconPath: 'assets/icons/law.png',
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
                fontSize: 20, // Same as flagTitleStyle
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
                          fontSize: 18.0, // Same as flagDescriptionStyle
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

final String PromiseText = '''
#“On my honour, I promise that I will do my best
#To do my duty to God* and my country,
#To help other people and
#To obey the Scout/Guide Law”
''';

final String LawText = '''
#1. A Scout/Guide is Trustworthy.
#2. A Scout/Guide is loyal.
#3. A Scout/Guide is a friend to all and a brother to every other Scout/Guide.
#4. A Scout/Guide is courteous.
#5. A Scout/Guide is a friend to animals and loves nature.
#6. A Scout/Guide is disciplined and helps protect public property.
#7. A Scout/Guide is courageous.
#8. A Scout/Guide is thrifty.
#9. A Scout/Guide is pure in thought, word and deed.
''';

