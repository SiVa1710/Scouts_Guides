import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Compass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Ensure portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COMPASS',
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
          buildCompassItem(
            compassName: '16 POINTS OF COMPASS',
            compassDescription: compassText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildCompassTable(),
          SizedBox(height: screenHeight * 0.02),
          buildAdditionalContent(
            compassName: 'COMPASS',
            compassDescription: finalCompassText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildConstellationItem(
            compassName: 'CONSTELLATIONS',
            compassDescription: finalConstellationText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildCompassItem({
    required String compassName,
    required String compassDescription,
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
          color: Color(0xFF0001cf),
          child: ListTile(
            leading: Icon(
              Icons.explore,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              compassName,
              style: TextStyle(
                fontSize: 20, // Exactly same as Flags page
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/compass.png",
                  width: screenWidth - 32.0,
                  height: screenWidth * 0.90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: compassDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0, // Exactly same as Flags page
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

  Widget buildCompassTable() {
    return Table(
      border: TableBorder.all(color: Color(0xFF0001cf), width: 2.7),
      children: [
        _buildTableRow(['No', 'Point', 'Abbre.', 'Heading'], isHeader: true),
        _buildTableRow(['1', 'North', 'N', '0.00°/360.00°']),
        _buildTableRow(['2', 'North North East', 'NNE', '22.50°']),
        _buildTableRow(['3', 'North East', 'NE', '45.00°']),
        _buildTableRow(['4', 'East North East', 'ENE', '67.50°']),
        _buildTableRow(['5', 'East', 'E', '90.00°']),
        _buildTableRow(['6', 'East South East', 'ESE', '112.50°']),
        _buildTableRow(['7', 'South East', 'SE', '135.00°']),
        _buildTableRow(['8', 'South South East', 'SSE', '157.50°']),
        _buildTableRow(['9', 'South', 'S', '180.00°']),
        _buildTableRow(['10', 'South South West', 'SSW', '202.50°']),
        _buildTableRow(['11', 'South West', 'SW', '225.00°']),
        _buildTableRow(['12', 'West South West', 'WSW', '247.50°']),
        _buildTableRow(['13', 'West', 'W', '270.00°']),
        _buildTableRow(['14', 'West North West', 'WNW', '292.50°']),
        _buildTableRow(['15', 'North West', 'NW', '315.00°']),
        _buildTableRow(['16', 'North North West', 'NNW', '337.50°']),
      ],
    );
  }

  TableRow _buildTableRow(List<String> data, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Color(0xFF0001cf) : Colors.transparent,
      ),
      children: data
          .map(
            (item) => TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontFamily: 'Lora',
                fontWeight: isHeader ? FontWeight.w900 : FontWeight.w900,
                color: isHeader ? Colors.white : Color(0xFF0001cf),
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }

  Widget buildAdditionalContent({
    required String compassName,
    required String compassDescription,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: compassDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0, // Exactly same as Flags page
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

  Widget buildConstellationItem({
    required String compassName,
    required String compassDescription,
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
          color: Color(0xFF0001cf),
          child: ListTile(
            leading: Icon(
              Icons.explore,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              compassName,
              style: TextStyle(
                fontSize: 20, // Exactly same as Flags page
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
                    children: compassDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0, // Exactly same as Flags page
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

final String compassText = '''
#• Finding direction is one of the essential skills of map making and map reading. Even the early man managed to find the direction through sun and stars. Later on compass was invented.
#
#• Compass has dial and a magnetic needle suspended on the pivot in the watch like box. Needle of the compass always stands in North South directions. By which we can find the other directions, it has 360 degrees divided into 16 points.
#
#Cardinal Points
#
# • North, East, South, West are the four main cardinal points. It is denoted by single letter N E S W
#
# • There are four Sub/Semi cardinal points, they are denoted by two letters, the points are as NE, SE, SW, NW.
#
# • There are eight midway/intermediate cardinal points, they are denoted by three letters, the points are as NNE, ENE, ESE, SSE, SSW, WSW, WNW, NNW.
#
#• Compass is always read clock-wise. Total number of important points are sixteen.
''';

final String finalCompassText = '''
#Compass Setting
#
# • Aligning the compass so that the magnetic needle points to the North indicated on the compass dial is referred to as compass setting.
#
# • Before use, ensure to shake the compass to settle the magnetic needle.
#
# • Place the compass on a firm, level surface while in use.
#
# • Wait for the needle to stabilize before attempting to determine directions.
#
# • Prior to use, take precautions to keep the compass away from any magnetic influence, particularly iron.
#
#Bearing
#
# • A bearing is the angle from the North to the observed object, measured clockwise from the observation point. It is also known as a forward bearing.
#
#Back Bearing
#
# • A back bearing is the angle from the observed object back to the observation point, measured clockwise from the North.
''';

final String finalConstellationText = '''
#Determine the Direction Using Stars:
#
# • Some of the stars seen in our sky are helpful in determining the north direction in the night. Important and common among these were.
#
#Great Bear
#
# • Commonly observed in the northern polar region, the Great Bear constellation comprises seven stars arranged in a pattern resembling a cup or plough. By drawing an imaginary line from the first star to the second, then extending it five times the distance between these two stars, one can locate the pole star. The direction indicated by the pole star points towards true north.
#
#Orion
#
# •  Also referred to as the Hunter, the Orion constellation can be sighted in the middle of the polar region. Consisting of thirteen stars, it resembles a soldier adorned with a belt and sword. Drawing an imaginary line from the middle star to the head and sword of the constellation helps to identify the direction of the poles, aiding in determining the north.
#
#• Additionally, other celestial formations like the Southern Cross in the southern polar region and Cassiopeia in the shape of a 'W' also contribute to the determination of the north direction.
''';

void main() {
  runApp(MaterialApp(
    home: Compass(),
  ));
}
