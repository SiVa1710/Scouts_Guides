import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Flags(),
  ));
}

// Constants for text styles
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

// Constants for colors
const Color primaryColor = Color(0xFF0001cf);
const Color whiteColor = Colors.white;

class Flags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure portrait mode only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FLAGS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Sarabun',
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
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
    required this.flagImage,
    required this.flagName,
    required this.flagDescription,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: primaryColor,
          child: ListTile(
            leading: Icon(
              Icons.flag,
              color: whiteColor,
            ),
            title: Text(
              flagName,
              style: flagTitleStyle,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              flagImage,
              width: screenWidth - 32.0,
              height: screenWidth * 0.6,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Text('Error loading image');
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: flagDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: flagDescriptionStyle,
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
