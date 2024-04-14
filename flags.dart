import 'package:flutter/material.dart';

class Flags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FLAGS',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,// Increase the font size
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0001cf),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FlagItem(
            flagImage: 'assets/images/Indianflag.png',
            flagName: 'NATIONAL FLAG',
            flagDescription: NationalFlag,
          ),
          SizedBox(height: 16.0),
          FlagItem(
            flagImage: 'assets/images/worldscout.jpg',
            flagName: 'WORLD SCOUT FLAG',
            flagDescription: WorldScoutFlag,
          ),
          SizedBox(height: 16.0),
          FlagItem(
            flagImage: 'assets/images/guideflag.jpg',
            flagName: 'WORLD GUIDE FLAG',
            flagDescription: WorldGuideFlag,
          ),
          SizedBox(height: 16.0),
          FlagItem(
            flagImage: 'assets/images/bsg.jpg',
            flagName: 'BS&G FLAG',
            flagDescription: BSGFlag,
          ),
        ],
      ),
    );
  }
}

class FlagItem extends StatelessWidget {
  final String flagImage;
  final String flagName;
  final String flagDescription;

  FlagItem({
    this.flagImage,
    this.flagName,
    this.flagDescription,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2, // Add elevation for shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Add rounded corners to the card
          ),
          color: Color(0xFF0001cf), // Set card color to blue
          child: ListTile(
            leading: Icon(
              Icons.flag, // Add icon
              color: Colors.white, // Set icon color to white
            ),
            title: Text(
              flagName,
              style: TextStyle(
                fontSize: screenWidth * 0.05, // Increase text size
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0), // Add space between the Card and the image
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0), // Add equal horizontal padding
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10), // Add rounded corners to the image
            child: Image.asset(
              flagImage,
              width: MediaQuery.of(context).size.width - 32.0, // Adjust image width to fit screen
              height: MediaQuery.of(context).size.width * 0.6, // Set height based on screen width
              fit: BoxFit.cover, // Ensure the image covers the available space
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0), // Add space below the image
              Padding(
                padding: const EdgeInsets.only(left: 24.0), // Adjust left padding to align with image
                child: RichText(
                  text: TextSpan(
                    children: flagDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Lora',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,// Increase text size
                          color: Color(0xFF0001cf), // Set text color
                          height: 1.5, // Set line spacing multiplier (adjust as needed)
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


final String NationalFlag = '''
#• Shape - Rectangular
#• Ratio - 3:2
#• Size 180 cm X 120 cm
#• Color
  # • Saffron - Courage & Sacrifice
  # • White - Peace, Purity & Truth
  # • Green - Prosperity, Faith & Fertility
#• Emblem - Asoka Chakra with 24 Spokes
#• Adopted on 22nd July 1947
#• Designed by Mr. PingaliVenkayya.
''';

final String WorldScoutFlag = '''
#• Shape - Rectangular
#• Ratio - 3:2
#• Size 180 cm X 120 cm
#• Color of the flag - Purple
#• Color of the Emblem - White (Purity)
#• Rope with Reef Knot - The unity of World Brotherhood throughout the movement
#• 2 Stars - Scout Law & Promise
#• Needle - It shows the true way to go
#• Adopted on 1951 at Lisbon city in 18th World Jamboree.
''';

final String WorldGuideFlag = '''
#• Blue and golden background - Sun shining down on all the children of the world
#• Vein - Compass needle pointing the way
#• Two stars - Guides Law and Promise
#• Flame - Eternal love of humanity
#• Three trefoil leaves - Three fold promise
#• Flowing Border - Worldwide and growing movement
#• Three orange squares on the flag represent our Three fold Promise
#• White blaze in the corner is a symbol of world-wide peace which all Guides work for.
''';

final String BSGFlag = '''
#• C Shape - Rectangular
#• Ratio - 3:2
#• Size 
# • Association Flag 180 cm X 120 cm
# • Troop/Group Flag 120 cm X 80 cm
#• Size of the Emblem
# • Association Flag 45 cm X 30 cm
# • Troop/Group Flag 30 cm X 20 cm
#• Color of the Flag - Dark Sky Blue
#• Color of the Emblem - Yellow
#• Three Emblems Superimposed in it
# • Fleur-de-lis - Scout Movement (Three petals stand for the three parts of the Promise)
# • Tre foil - Guide Movement
# • Asoka Chakra - Bharat (India's Movement).
''';

void main() {
  runApp(MaterialApp(
    home: Flags(),
  ));
}
