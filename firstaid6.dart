import 'package:flutter/material.dart';

class FirstAid5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'ELECTRIC SHOCK',
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
                    children: shock.split('#').map((line) {
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

  Widget buildFirstAidCards(double screenWidth, double screenHeight) {
    return Column(
      children: [
        buildFirstAidCard(
          name: 'FAINTING',
          description: arm,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'CHOKING',
          description: choking,
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
                    children: description.split('#').map((line) {
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

final String shock = '''
#Electric shock occurs when an electric current passes through the body, potentially resulting in burns, internal organ damage, heart rhythm issues, or even death. Here's what you need to know about electric shock:
#
#Signs & Symptoms:
#
# • Shocking sensations, numbness, or tingling.
#
# • Changes in vision, speech, or sensation.
#
# • Burns or wounds where electricity enters/exits the body.
#
# • Muscle spasms, fractures, or sudden immobility.
#
# • Breathing interruptions, irregular heartbeats, chest pain, or seizures.
#
# • Unconsciousness.
#
#Causes:
#
# • Contact with high-voltage (over 1,000 volts) sources like fallen power lines or lightning.
#
# • Contact with low-voltage (under 1,000 volts) sources like electrical sockets or frayed cords.
#
# • Mixing water with electricity.
#
#Treatment:
#
# • High-voltage or lightning-related shocks require immediate medical attention.
#
# • Low-voltage shocks need urgent care if any symptoms occur.
#
# • Even without symptoms, a check-up is recommended for possible internal injuries.
#
# • For lightning safety, heed weather warnings, seek shelter, or stay low if outdoors.
#
#First Aid for Electric Shock:
#
# • Turn off the power and disconnect the source to separate the victim.
#
# • Avoid touching the victim with bare hands to prevent the current from passing through you.
#
# • Stand on non-conductive materials like wood or paper.
#
# • Use dry, nonconductive objects to separate the victim from the live current.
#
# • Check for breathing and administer CPR if necessary.
#
# • Keep the victim still and elevate their legs.
#
# • Treat burns with cool, running water and cover with a dressing.
#
# • Avoid applying ice, ointment, or cotton to burns.
#
# • Seek emergency medical attention promptly.
''';

final String arm = '''
#Fainting, or syncope, occurs when there's a temporary decrease in blood flow to the brain, often resulting in a brief loss of consciousness. Here's what you need to know:
#
#Common Causes:
#
# • Anxiety, emotional upset, stress, or severe pain.
#
# • Skipping meals or standing up too quickly.
#
# • Prolonged standing in crowds.
#
# • Certain medications, diabetes, or blood pressure issues.
#
#Symptoms:
#
# • Nausea, giddiness, excessive sweating.
#
# • Dim vision, rapid heartbeat, or palpitations.
#
#Treatment:
#
# • Fainting should be treated as a medical emergency until proven otherwise.
#
# • When someone feels faint, have them sit or lie down.
#
# • If sitting, position their head between their knees.
#
# • If they faint, lay them on their back and check airways.
#
# • Loosen tight clothing and elevate their feet above head level.
#
# • They should recover within a minute; if not, seek medical help.
#
# • Check breathing and pulse; if abnormal, perform CPR.
#
#Prevention:
#
# • When symptoms appear, lie down to prevent fainting.
#
# • Avoid stress, anxiety, and take care of underlying medical conditions.
#
# • Evaluate medications carefully for potential side effects.
''';

final String choking = '''
#Choking incidents, particularly in children, often occur due to ingestion of food, toys, or other household objects. Babies and toddlers, in particular, are prone to such incidents due to their tendency to explore objects with their mouths and their smaller airways. However, these incidents can be prevented with proper awareness and first aid knowledge. Here's what you should know:
#
#In an Emergency:
#
# • When a child experiences choking, vigorous coughing is often the initial response, which can clear the airway. Avoid slapping their back or inserting fingers into their mouth during this time.
#
# • If the child cannot speak, cough, or shows signs of cyanosis (bluish skin), immediate intervention is necessary.
#
#First Aid for an Older Child (Over One Year):
#
# • Perform the Heimlich maneuver by standing or kneeling behind the child, making a fist, and applying upward thrusts to the abdomen until the object is expelled.
#
# • If the object remains lodged and the child loses consciousness, lay them on their back, open their mouth, and carefully remove the obstruction with your finger.
#
# • Administer rescue breathing by opening the airway, pinching the child's nose shut, and giving two slow breaths. Repeat until normal breathing resumes or medical help arrives.
#
#Preventive Measures:
#
# • Keep potential choking hazards, such as small objects or toys, out of reach, especially for crawling babies.
#
# • Mash or cut food into small, manageable pieces and supervise meals to prevent choking incidents.
#
# • Avoid giving children foods known to pose choking risks, such as nuts, hard candy, grapes, and hot dogs.
#
# • Educate children about safe eating habits, discouraging behaviors like talking or laughing with food in their mouths.
#
# • Be cautious with toys and objects that have detachable parts or are small enough to fit through a toilet paper tube.
#
#Common Culprits:
#
# • Coins, rubber balloons, button batteries, marbles, small toys, jewelry, and household items like safety pins, tacks, and screws.
#
# • Foods like sunflower seeds, ice cubes, gum, popcorn, grapes, hot dogs, hard candy, nuts, and raw vegetables.
#
#By following these precautions and knowing how to respond in an emergency, choking incidents in children can be minimized, ensuring their safety and well-being.''';

void main() {
  runApp(MaterialApp(
    home: FirstAid5(),
  ));
}
