import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constants {
  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Colors
  static const Color primaryColor = Color(0xFF0001cf);
}

class GoodTurn extends StatelessWidget {
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
          'GOOD TURN',
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
          buildFormatCard(screenWidth: screenWidth),
          SizedBox(height: screenHeight * 0.02),
          buildRoundedImage(screenWidth: screenWidth),
        ],
      ),
    );
  }

  Widget buildFormatCard({required double screenWidth}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Constants.primaryColor,
      child: ListTile(
        leading: Icon(
          Icons.format_align_left,
          color: Colors.white,
          size: 30, // Adjust icon size
        ),
        title: Text(
          'FORMAT',
          style: Constants.titleStyle,
        ),
      ),
    );
  }

  Widget buildRoundedImage({required double screenWidth}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/good.png', // Replace 'your_image.jpg' with your image path
          width: screenWidth * 0.8, // Adjust image width based on screen size
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GoodTurn(),
  ));
}
