import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: FirstAid4(),
  ));
}

class FirstAid4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
          buildIntroductionCard(screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.02),
          buildFirstAidCards(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget buildIntroductionCard(double screenWidth, double screenHeight) {
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
              'FRACTURE',
              style: TextStyle(
                fontSize: 20, // Adjusted font size to match Flags page
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
                    children: Fractures.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18, // Adjusted font size to match Flags page
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

  Widget buildFirstAidCards(double screenWidth, double screenHeight) {
    return Column(
      children: [
        buildFirstAidCard(
          name: 'ARM AND COLLARBONE',
          description: arm,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'LOWER LEG FRACTURE',
          description: leg,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'RESUSCITATION',
          description: mouth,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
      ],
    );
  }

  Widget buildFirstAidCard({
    String name,
    String description,
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
                fontSize: 20, // Adjusted font size to match Flags page
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
                    children: description.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18, // Adjusted font size to match Flags page
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

final String Fractures = '''
#Fractures are breaks in bones that require immediate medical attention. If the fracture is caused by significant trauma, it's crucial to call your local emergency number. Seek emergency help if the person is unresponsive, not breathing, or not moving, or if there is heavy bleeding.
#
#Here's what to do while waiting for medical help:
#
# 1. Stop Bleeding: Apply pressure to the wound with a sterile bandage or clean cloth to stop any bleeding.
#
# 2. Immobilize the Injured Area: Do not try to realign the bone or push any protruding bone back in. If you've been trained, apply a splint to the area above and below the fracture to immobilize it. Padding the splints can help reduce discomfort.
#
# 3. Apply Ice Packs: Use ice packs wrapped in a cloth to limit swelling and relieve pain until emergency personnel arrive. Do not apply ice directly to the skin.
#
# 4. Treat for Shock: If the person feels faint or is breathing rapidly, lay them down with the head slightly lower than the trunk and elevate the legs if possible.
#
#Signs and Symptoms of a Fracture include:
#
# • Pain at or around the site of the fracture.
#
# • Tenderness (pain on gentle pressure) over the area.
#
# • Swelling and discoloration.
#
# • Loss of normal movements.
#
# • Deformity of the limb.
#
# • Crepitus (grating sound) when moving the injured area.
#
# • Unnatural movements or instability at the site of the fracture.
#
#Management of Fractures aims to:
#
# • Prevent further damage.
#
# • Reduce pain.
#
# • Make the patient comfortable.
#
# • Seek medical aid as soon as possible.
#
#Remember to handle the patient gently and avoid unnecessary movement. Treat for shock if necessary and immobilize the fractured area. Do not attempt to wash the wound or apply antiseptics to the exposed bone. Avoid handling the fracture unnecessarily and do not attempt to realign the bone.
#
#Using Bandages:
#
# • Apply firm but not overly tight bandaging to immobilize the fractured ends.
#
# • Place padding material between limbs if they need to be tied together.
#
# • Tie knots on the uninjured side.
#
#Using Splints:
#
# • Splints are rigid supports applied to fractured limbs to prevent movement.
#
# • Use reasonably wide splints, padded for comfort.
#
# • Splints should extend beyond the joints above and below the fracture.
#
# • Splints can be improvised from various materials if necessary.
#
#Fractures involving the back (vertebral column) require special care, and the victim should not be allowed to move. Seek emergency medical help immediately.
#
''';

final String arm = '''
#Fractures can be classified into two types: closed fractures and open fractures. Closed fractures occur when the bone breaks but does not penetrate the skin, while open fractures involve the bone breaking through the skin, potentially leading to infection.
#
#Recognizing Fractures:
#
# • Symptoms of an open fracture include exposed bone, while clues of a closed fracture include hearing a bone break or experiencing a grating sensation upon movement.
#
# • Other signs include deformity, redness, inability to move a limb, loss of pulse or sensation, numbness or tingling, and muscle spasms.
#
#Initial Care for Fractures:
#
# • Check for other injuries and ensure someone is seeking medical help.
#
# • Control bleeding and protect open wounds from contamination.
#
# • Immobilize the fracture to prevent further injury, but do not attempt to straighten dislocations or angulations.
#
#First Aid for Collarbone Fractures:
#
# • Gently place the injured arm across the chest with fingertips near the opposite shoulder.
#
# • Use padding between the limb and chest for support.
#
# • Secure the limb with an elevation sling and additional support with a board bandage tied in front.
#
#First Aid for Arm Fractures:
#
# • Place a pad in the armpit.
#
# • Use a padded splint for support.
#
# • Support the lower arm with a narrow pad around the neck and wrist.
#
# • Bind the upper arm to the chest with a wide bandage.
''';

final String leg = '''
#Lower leg fractures can be painful and debilitating injuries that require immediate attention. Here's a guide on how to provide first aid for a lower leg fracture:
#
Assessment:
#
# • Approach the victim calmly and assess the situation. Check for any signs of bleeding, deformity, or swelling around the lower leg.
#
# • Ask the victim about the location and severity of the pain.
#
#Stabilization:
#
# • If possible, carefully assist the victim to sit or lie down in a comfortable position, preferably with the injured leg elevated.
#
# • Support the leg in the position that causes the least amount of pain. Avoid unnecessary movement or manipulation of the injured limb.
#
#Immobilization:
#
# • Use available materials to immobilize the injured leg. This can include towels, clothing, or splints.
#
# • Apply a splint to the injured leg by securing it to the leg with bandages or cloth strips. Ensure that the splint extends beyond the joints above and below the fracture site to prevent movement.
#
#Padding:
#
# • Pad the areas around the fracture site to provide cushioning and support. This can help alleviate pain and prevent further injury.
#
#Monitoring:
#
# • Keep the victim calm and reassure them while waiting for medical help to arrive.
#
# • Monitor the victim's vital signs, including breathing and pulse, and be prepared to administer first aid for shock if necessary.
#
#Seek Medical Attention:
#
# • Arrange for the victim to receive prompt medical care. Call emergency services or transport the victim to the nearest medical facility for further evaluation and treatment.
#
#Comfort Measures:
#
# • Offer pain relief measures such as applying ice packs to the injured area (if available) to help reduce swelling and alleviate pain.
#
# • Avoid giving the victim anything to eat or drink in case surgery is needed.
#
#Remember, providing first aid for a lower leg fracture involves stabilizing the injury and seeking professional medical help as soon as possible to ensure proper treatment and recovery.
''';

final String mouth = '''
#Mouth-to-mouth resuscitation is a critical technique that can potentially save someone's life. Here's a step-by-step guide on how to perform it:
#
#Assess Consciousness:
#
# • Gently tap the person on the shoulder and ask loudly, "Are you okay?" Repeat this while tapping to check for a response. If there is no response, proceed with mouth-to-mouth resuscitation.
#
#Head Tilt:
#
# • Tilt the person's head back by placing one hand on their forehead and using the first two fingers of your other hand to lift their chin. This helps to open the airway.
#
#Check for Breathing:
#
# • Bend your ear close to the person's mouth to listen, feel, and look for any signs of breathing. Also, observe if their chest is rising and falling. Continue to maintain the head tilt while assessing for breathing.
#
#Clear Airway:
#
# • If there is no airflow, check for any obstructions in the person's airway. Use your fingers to sweep the mouth and throat to remove any blockages while keeping the head tilted back.
#
#Provide Rescue Breaths:
#
# • Take a deep breath, then pinch the person's nose closed with the hand on their forehead. Seal your lips around their mouth and give several deep breaths, pausing briefly between each breath to inhale.
#
#Monitor Breathing:
#
# • Continuously observe for signs of breathing from the person. Provide mouth-to-mouth resuscitation at a steady rhythm, ensuring that their chest rises and falls with each breath you administer. Pause only to take your own breaths.
#
#Remember, maintaining a clear airway and providing effective rescue breaths are crucial during mouth-to-mouth resuscitation. Always prioritize the well-being of the individual and seek additional medical assistance as soon as possible.
''';
