import 'package:flutter/material.dart';

class FirstAid2 extends StatelessWidget {
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
              'KNOWLEDGE OF WOUNDS',
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
                    children: Knowledge.split('#').map((line) {
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
          name: 'BURNS AND SCALDS',
          description: Burns,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'SPRAINS',
          description: Sprains,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'STINGS',
          description: Stings,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'BITES',
          description: Bites,
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

final String Knowledge = '''
#Understanding Different Types of Wounds:
# 
# 1. Incised Wounds (Clean Cuts): These wounds result from sharp objects causing clean cuts on the skin.
#
# 2. Lacerated Wounds (Torn): Lacerations occur when the skin is torn or jagged due to trauma or force.
#
# 3. Punctured Wounds (Stab): Puncture wounds are caused by sharp objects piercing the skin and creating small, deep holes.
#
# 4. Contused Wounds (Hemorrhage Beneath): Contusions involve damage to underlying tissues, resulting in bruising and bleeding beneath the skin's surface.
#
#Dealing with Wounds:
#
# 1. Ensure the casualty lies flat and remains still.
#
# 2. Clean the wound thoroughly with plain water or soap and water to remove dirt and debris.
#
# 3. Apply antiseptic lotion or cream to the wound.
#
# 4. Cover the wound with a dressing and secure it with a bandage to keep it in place.
#
# 5. For minor scratches, apply antiseptic lotion directly.
#
#Note: Avoid applying antiseptic to large wounds, as it may be absorbed and cause adverse reactions.
''';

final String Burns = '''
#Burns can result from various sources, including dry heat, corrosive substances, friction, and wet heat such as hot liquids and vapors. Additionally, extreme cold and radiation, including sunlight, can also cause burns. It's important to note that burns may be associated with or triggered by life-threatening situations, such as accidents involving drug or alcohol overdose, explosions, or jumping from burning buildings. After initial treatment for burns, it's essential to conduct a thorough examination of the casualty.
#
#Types of Burns:
#
# 1. Superficial Burns (1st Degree): These affect only the outer layer of the skin, resulting in redness, swelling, and tenderness. Examples include mild sunburn or scalds from hot beverages. Superficial burns typically heal well with prompt first aid and often do not require medical treatment unless they are extensive.
#
# 2. Partial-thickness Burns (2nd Degree): These damage a partial thickness of the skin, causing raw skin and blister formation. While these burns usually heal effectively, they can be serious, especially if extensive. In adults, partial-thickness burns covering more than 50% of the body surface can be life-threatening, with a lower threshold in children and the elderly.
#
# 3. Full-thickness Burns (3rd Degree): These burns affect all layers of the skin and may extend beyond to affect nerves, muscles, and fat. The skin may appear pale, waxy, or charred. Full-thickness burns of any size require immediate medical attention and often specialized treatment.
#
#Treatment of Severe Burns and Scalds:
#
# • Avoid overcooling the casualty, as it may dangerously lower body temperature.
# 
# • Refrain from removing anything stuck to the burn to prevent further damage and infection.
#
# • Do not touch or disturb the injured area or burst blisters.
#
# • Avoid applying lotions, ointments, or fats to the burn.
#
# • Lay the casualty down, protecting the burned area from contact with the ground if possible.
#
# • Flush the burn with ample cold liquid for at least 10 minutes, ensuring it does not delay transportation to the hospital.
#
# • While cooling the burns, assess the casualty's airway, breathing, and pulse, and be prepared for resuscitation.
#
# • Gently remove any constricting items from the injured area before swelling occurs and carefully remove burned clothing if not adhered to the burn.
#
# • Cover the burn with a sterile burns sheet or non-fluffy material to prevent infection. Burns to the face should be cooled with water rather than covered.
#
# • Ensure emergency services are en route. While waiting, provide treatment for shock and monitor breathing and pulse, being prepared to resuscitate if necessary.
''';

final String Sprains = '''
#Sprains occur when the ligaments and tissues surrounding a joint are suddenly jerked, strained, or torn.
#
#Signs:
#
# • Pain experienced at the joint.
#
# • Inability to utilize the joint.
#
# • Swelling, followed by discoloration.
#
#Treatment:
#
# • Immobilize the joint and position it comfortably in an elevated position.
#
# • Expose the joint and apply a firm cold compress.
#
# • Keep the bandage wet to maintain a cold compress effect.
#
# • If the individual cannot tolerate cold treatment, consider using hot fomentation, such as bathing with water as hot as can be comfortably borne.
#
# • If an ankle sprain occurs during a walk, refrain from removing the shoes; instead, use them for support and apply a figure-of-eight bandage around the foot. The foot with the shoe still on can be submerged in cold water.
''';

final String Stings = '''
#Stings from wasps, bees, scorpions, and certain plants can cause discomfort.
#
# • If the sting is visible, carefully remove it using sterilized tweezers or a needle.
#
# • Wash the affected area with a solution of bicarbonate of soda for wasp stings. Vinegar and onion juice are effective remedies for some stings.
#
# • If the sting occurs inside the mouth, rinse the mouth with a solution of two teaspoons of bicarbonate of soda in one glass of water.
#
#It's important to note that some individuals may be allergic to stings. If there is excessive pain, swelling, or a rash on the body, prompt medical attention may be necessary for those who show signs of allergy.
''';

final String Bites = '''
#SNAKE BITE:
#
# • There are over 2500 different types of snakes, with only about 200 of them being poisonous. While most snake bites are not fatal, it's crucial to treat all cases as if they were bitten by venomous snakes.
#
#Objectives of First Aid:
#
# • Reassure the patient.
#
# • Prevent the spread of venom.
#
# • Seek medical assistance.
#
#Management:
#
# • Lay the patient down and ensure complete rest.
#
# • Calm and reassure the patient, avoiding any unnecessary movement or sleep.
#
# • If the bite is on an arm or leg, apply a constrictive bandage on the side of the bite towards the heart, with enough pressure to restrict blood flow.
# 
# • Wash the wound with soap and water, then flush it with plenty of water.
# 
# • Cover the wound with a sterilized dressing.
#
# • Transport the patient to a hospital as quickly as possible, or if the snake has been killed, bring it along for identification. If breathing stops, initiate artificial respiration.
#
#DOG BITE:
#
# • Dog bites can sometimes lead to serious infections, including rabies if the animal is infected. The condition, known as hydrophobia, can be transmitted to humans. It's important not to kill the dog but instead, keep it chained and under observation for ten days. Rabies can also be transmitted by infected cats, monkeys, and jackals.
#
#Objectives of First Aid:
#
# • Prevent rabies or other infections.
#
# • Seek medical assistance.
#
#Management:
#
# • Treat all dog bites as potential rabies exposures.
#
# • Wipe away saliva from the wound.
#
# • Thoroughly wash the wound with soap and water.
#
# • Cover the wound with a dry, sterile dressing.
#
# • Seek medical attention promptly or transport the patient to the hospital for proper treatment.
''';

void main() {
  runApp(MaterialApp(
    home: FirstAid2(),
  ));
}
