import 'package:flutter/material.dart';

class FirstAidKit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FIRST AID',
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
          buildFirstAidKitItem(
            name: 'FIRST AID KIT CONTENT LISTS',
            prayerDescription: FirstaidKit,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildFirstAidKitItem({
    String name,
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
            leading: Image.asset(
              'assets/icons/aid.png',
              width: 30,
              height: 30,
            ),
            title: Text(
              name,
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
}


final String FirstaidKit = '''
#Ensure your first aid kit is stocked with essential items to effectively treat injuries. Start by preparing a list of contents and verify it with a medical professional. Then, visit a local drug store to purchase the necessary supplies according to the list below:
#
#• Bar of soap
#• 2-inch roller bandage
#• 1-inch roller bandage
#• 1-inch adhesive strips
#• 3-by-3-inch sterile pads
#• Triangular bandage
#• Assorted gauze pads
#• Adhesive strips
#• Oral thermometer
#• Scissors
#• Tweezers
#• Sunburn lotion
#• Lip balm
#• Poison-ivy lotion
#• Small flashlight (with extra batteries and bulbs)
#• Absorbent cotton
#• Iodine tablets
#• Safety pins
#• Needles
#• Paper cups
#• Foot powder
#• Instant ice packs
#• Insect repellent
vInsect sting swabs
#• Matches
#• Oil of cloves
#• Hot-water bottle
#• Alcohol wipes
#• Acetaminophen and Ibuprofen
#• Gloves
#• 1 blanket (space blanket)
#• Antibiotic cream
#• Antiseptic solution (like hydrogen peroxide)
#• First aid instruction booklet
#• List of emergency phone numbers
#
#Once you've obtained all the items, assemble them in your first aid kit for easy access during emergencies.
''';

void main() {
  runApp(MaterialApp(
    home: FirstAidKit(),
  ));
}
