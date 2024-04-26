import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstAid3 extends StatelessWidget {
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
              'BANDAGES',
              style: TextStyle(
                fontSize: 20, // Maintain font size consistency
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
                    children: Bandages.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18, // Maintain font size consistency
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
          name: 'ROLLER BANDAGE',
          description: Roller,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'TRIANGULAR BANDAGES',
          description: Triangular,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'HEAD BANDAGE',
          description: Head,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'KNEE OR ELBOW BANDAGE',
          description: Knee,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'FOOT OR PALM BANDAGE',
          description: Foot,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'THE LARGE ARM SLING',
          description: arm,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'ST JOHN SLING',
          description: John,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'COLLAR & CUFF SLING',
          description: Collar,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'IMPROVISE A STRETCHER:',
          description: stretcher,
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
                fontSize: 20, // Maintain font size consistency
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
                          fontSize: 18, // Maintain font size consistency
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

final String Bandages = '''
#A bandage serves multiple purposes, functioning as a supportive layer for medical appliances like dressings or splints, offering support to body parts independently, and occasionally restricting movement in specific areas of the body.
''';

final String Roller = '''
#Roller bandages come in various sizes depending on the severity of the injury. They are carefully stored by rolling them up. These bandages can be used for nearly any type of wound on the human body. Additionally, elastic crape bandages are specifically designed for sprains and are used to wrap around swollen areas.
#
# • Finger - 2.5 cm (1 inch)
#
# • Hand - 5 cm (2 inch)
#
# • Arm - 5 or 6 cm (2 or 2.50 inch)
#
# • Leg - 7.5 or 9 cm (3 or 3.5 inch)
#
# • Trunk - 10 or 15 cm (4 or 6 inch)
#
#Different Techniques for Applying Roller Bandages:
#
# • Simple Spiral
#
# • Reverse Spiral
#
# • Figure of Eight Spiral
''';

final String Triangular = '''
#Triangular bandages are crucial components of a first aid kit. These large pieces of material are triangular in shape, with two sides measuring about 1 meter long and the third side about 1.4 meters long.
#
#Broad Bandage:
#
# • A broad bandage is created by folding a triangular bandage in half, from point to base, and then folding it in half again. This folded bandage is used for securing splints and dressings.
#
#Narrow Bandage:
#
# • A narrow bandage is made by folding one or more broad bandages. Initially, the bandage is folded in half, from point to base, and then folded again to create a broad bandage. This broad bandage is then folded in half once more to produce a narrow bandage, suitable for collar and cuff slings.
#
#Pad:
#
# • In the absence of a sterile pad in your first aid kit, a triangular bandage can be used. To create a pad, fold the two ends of the bandage into the middle, and then fold both ends into the middle again. Fold the remaining portion in half to form a pad. This folding method ensures that the pad is compact and easy to store in a first aid kit. These pads are utilized for controlling bleeding.
''';

final String Head = '''
# • To apply a head bandage, stand behind the casualty and unfold a triangular bandage, ensuring it has a narrow hem folded along the base. Position the center of the base at the middle of the forehead, near the eyebrows.
#
# • Next, bring the point of the bandage over the top of the head to cover the dressing, and then down the back of the head. Cross over the point and wrap the bandage around the head to the front. Tie the ends together using a reef knot, securing it low on the forehead.
#
# • With one hand, stabilize the head and gently pull the point of the bandage down to apply the desired pressure on the dressing. Fold the point upward toward the top of the head and carefully secure it with a safety pin or tuck it under the back crisscross for additional support.
''';

final String Knee = '''
# • To bandage a knee or elbow, start by using a triangular bandage with a narrow hem folded along the base. Position the center of the base on the leg just below the kneecap, with the point facing toward the top of the leg. Alternatively, if bandaging an elbow, position the base on the forearm with the point facing toward the shoulder.
#
# • Wrap the ends of the bandage around the joint, crossing over the point either in front of the elbow or at the back of the knee.
#
# • Bring the ends up and tie them off over the point. Adjust the tension to apply the right amount of pressure on the dressing. Then, pull the point up and fold it down, securing it with a safety pin or tucking it under the knot for added stability.
''';

final String Foot = '''
# • To bandage a foot or palm, begin by using a triangular bandage as a whole cloth, placing it on a flat surface with the point facing away from the casualty.
#
# • Position the foot or hand on the triangular bandage with the toes or fingers pointing toward the point, ensuring there is enough bandage at the ankle or wrist to fully cover the area. Bring the point of the bandage up and over the foot or hand to rest on the lower leg or wrist.
#
# • Next, bring the ends of the bandage alongside the foot or hand, crisscrossing the folded ends up and around the ankle or wrist. Cross over the point and wrap any excess bandage before tying it off securely.
#
# • After tying off the bandage over the point, adjust the tension as needed for the desired pressure. If the point extends beyond the knot, pull it up before folding it downward and tucking it under the knot for added stability.
''';

final String arm = '''
# • To create a large arm sling, first position the injured forearm so that it is approximately parallel to the ground, with the wrist slightly elevated above the elbow.
#
# • Place an open triangular bandage between the body and the arm, ensuring that the apex of the bandage points towards the elbow. Extend the upper point of the bandage over the shoulder on the injured side.
#
# • Bring the lower point of the bandage up over the arm, crossing it across the shoulder on the injured side to meet the upper point. Secure the points together firmly with a reef knot.
#
# • To secure the elbow, fold any excess bandage over the elbow and fasten it in place with a safety pin. This will help provide support and stability to the injured arm.
''';

final String John = '''
# • The St. John sling is beneficial for a casualty who has sustained an injury to the shoulder, collarbone, hand, or fingers. It is considered one of the most effective slings for injured limbs as it provides comprehensive support to the entire arm and alleviates the weight from the injured area. Additionally, in cases of hand or finger injuries, it can be utilized to elevate the affected part.# • Bring the ends up and tie them off over the point. Adjust the tension to apply the right amount of pressure on the dressing. Then, pull the point up and fold it down, securing it with a safety pin or tucking it under the knot for added stability.
''';

final String Collar = '''
# • The Collar & Cuff sling is beneficial for a casualty with an upper arm fracture or an injured hand. To apply it, let the elbow hang naturally at the side and extend the hand towards the shoulder on the injured side. Create a clove hitch by forming two loops—one towards you and one away from you. Bring the loops together by sliding your hands under them and closing with a clapping motion. Then, apply a clove hitch directly onto the wrist, ensuring not to disturb the injured arm. Slide the clove hitch over the hand and gently pull it firmly to secure the wrist. Extend the ends of the bandage to each side of the neck and tie them securely with a reef knot, allowing the arm to hang comfortably.
''';

final String stretcher = '''
#When a ready-made stretcher isn't available, improvisation becomes essential for carrying a casualty, especially during accidents. Here are some innovative ideas for improvising a stretcher:
#
# • Use a window panel, shutter, or door panel covered with straw, hay, clothing, or sacking.
#
# • Lay out a piece of carpet, blanket, or tarpaulin and roll up two staves on the sides. Add clothes for padding.
#
# • Utilize two coats with the sleeves turned inside out; pass two poles through the sleeves and button the coats over them.
#
# • Pass two poles through a couple of sacks, threading through holes at the bottom corners of each.
''';

void main() {
  runApp(MaterialApp(
    home: FirstAid3(),
  ));
}
