import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstAid1 extends StatelessWidget {
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
              'INTRODUCTION',
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
                    children: IntroductionText.split('#').map((line) {
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
          name: 'AIM OF FIRST AID',
          description: AimOfFirstAid,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'GOLDEN RULES OF FIRST AID',
          description: Rules,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'CUTS AND SCRATCHES',
          description: Cuts,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'BLEEDING FROM NOSE',
          description: Bleeding,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
      ],
    );
  }

  Widget buildFirstAidCard({
    required String name,
    required String description,
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

final String IntroductionText = '''
#Introduction to First Aid:
#
# • First aid involves providing immediate care for an illness or injury, typically administered by a non-medical person to an affected individual until professional medical assistance is available. For some minor ailments or injuries, the initial first aid measures may be sufficient, obviating the need for further medical attention. This typically entails a set of uncomplicated, and sometimes crucial, techniques that can be learned by individuals with minimal equipment.
''';

final String AimOfFirstAid = '''
#1. Preserve life: The primary goal of all medical care, including first aid, is to save lives.
#
#2. Prevent further harm: This includes actions to avoid exacerbating the condition, such as removing the patient from danger and applying appropriate first aid techniques to mitigate risks.
#
#3. Promote recovery: First aid aims to initiate the healing process and facilitate recovery from illness or injury. This may involve administering treatments and providing support to the individual to aid in their recovery journey.
''';

final String Rules = '''
#1. Prioritize immediate action calmly and efficiently, without causing unnecessary panic.
#
#2. Stay composed and provide reassurance to the individual by calmly communicating with them, listening attentively, and offering words of comfort.
#
#3. Follow the ABC Rule: Assess the situation, ensure an open Airway, check for Breathing, and assess Circulation.
#
#4. Administer artificial respiration if the person has stopped breathing.
#
#5. Control any bleeding that may be present.
#
#6. Provide appropriate care for shock.
#
#7. Avoid excessive interference and focus on providing necessary aid.
#
#8. Keep the area clear and prevent crowding by bystanders.
#
#9. Refrain from unnecessarily removing clothing unless it is essential for treatment.
#
#10. Make arrangements for the transportation of the injured person to receive further medical attention, if needed.
''';

final String Cuts = '''
#Items Required:
#
# • Water
# • Soap
# • Antibiotic cream
# • Adhesive bandage
# • Antiseptic (optional)
#
#Step 1 - Know when to seek medical attention:
#
#Contact a doctor if:
#
# • The cut is deep, long, or jagged.
#
# • The injury involves a pet or wild animal.
#
# • It's a bite injury, human or animal.
#
# • Debris remains in the wound after cleansing.
#
# • The wound is bleeding heavily or won't stop after applying pressure.
#
# • It's a puncture wound.
#
# • You're overdue for a tetanus booster.
#
#Step 2 - First aid for minor bleeding:
# 
# • Clean the wound under running water with mild soap. Avoid strong soaps. Rinse thoroughly.
# 
#Step 3 - First aid for heavier bleeding:
# 
# • Apply direct pressure with clean gauze or cloth for several minutes. Elevate the injured area above heart level if possible.
#
#Step 4 - First aid for debris:
# 
# • Use a stronger stream of water to dislodge debris. Use clean tweezers to remove surface debris. Avoid digging for deeply embedded items.
# 
#Step 5 - First aid with antiseptic:
# 
# • Avoid hydrogen peroxide, as it can irritate and damage healthy cells. Thoroughly clean the wound with water and mild soap. Use antiseptic only if the wound is dirty.
#
#Step 6 - First aid with adhesive bandages:
# 
# • Bandage wounds in areas prone to dirt or irritation. Apply antibiotic cream before bandaging. Change bandages daily and apply new cream.
#
#Step 7 - Follow-up:
# 
# • Monitor the wound for signs of infection. Contact a doctor if you notice pain, redness, swelling, pus, red streaks, or fever.
''';

final String Bleeding = '''
#• Nosebleeds, or epistaxis, occur when a small vein in the lining of the nose bursts. While they may look alarming, most nosebleeds are harmless and can be treated at home, particularly common in children and the elderly.
#
#Causes: 
#
# • can be triggered by dryness, nose picking, forceful blowing of the nose, certain medications like aspirin, insertion of foreign objects into the nose (commonly seen in children), injuries, allergies, infections, and high blood pressure. Other underlying conditions such as atherosclerosis and blood-clotting disorders may also contribute.
#
#Symptoms: 
#
# • Nosebleeds typically manifest as bleeding from the nose, though sometimes bleeding from the ears or mouth may occur.
#
#Types:
#
# • Anterior Nosebleed: This type affects the lower part of the nasal septum, where blood vessels are located. It often results from trauma to the nose or fingernail injuries. The bleeding starts from the front of the nose and flows outward, particularly when the individual is sitting or standing. It's more common during dry seasons or harsh winters.
#
# • Posterior Nosebleed: Bleeding originates deep within the nose and flows down the back of the mouth and throat. It can occur regardless of the person's position and is often more severe. It's commonly seen in older individuals or those with high blood pressure or injuries.
#
#Treatment:
#
# 1. Sit down and lean forward to prevent blood from flowing down the throat.
#
# 2. Pinch the soft part of the nose (between the end and the bridge) with your thumb and index finger. Maintain pressure until the bleeding stops, without releasing it prematurely.
#
# 3. If bleeding persists, continue holding for an additional 10 minutes.
#
# 4. Distract children with activities like watching TV or storytelling.
#
# 5. Avoid nose picking, blowing, or rubbing for at least 2 days.
#
# 6. Apply an ice pack to the bridge of the nose to constrict blood vessels.
#
# 7. Seek medical attention if:
#
#  • The bleeding persists for more than 15 minutes.
#
#  • The nosebleed is caused by an injury.
#
#  • Nosebleeds recur frequently.
''';

void main() {
  runApp(MaterialApp(
    home: FirstAid1(),
  ));
}
