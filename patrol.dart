import 'package:flutter/material.dart';

class Patrol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PATROL SYSTEM',
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
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFF0001cf),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/patrol.png',
              width: 30,
              height: 30,
            ),
            title: Text(
              'THE PATROL SYSTEM',
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
                    children: patrolsystem.split('#').map((line) {
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
          name: 'PATROLS',
          description: patrol,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'ASSISTANT PATROL LEADER',
          description: leader,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL TREASURER',
          description: treasurer,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL SECRETARY',
          description: Secretary,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'TRANSPORTATION MANAGER',
          description: Manager,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'COMMISSARY MANAGER',
          description: Commissary,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'EQUIPMENT MANAGER',
          description: Equipment,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'HEALTH & SAFETY MANAGER',
          description: Safety,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'COURT OF HONOR (COH)',
          description: COH,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'TROOP SECRETARY',
          description: Troop,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'TROOP TREASURER',
          description: TroopTreasurer,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL NAME',
          description: name,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL EMBLEMS',
          description: emblem,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'THE PATROL FLAG',
          description: flag,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL CALL',
          description: call,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL YELL',
          description: yell,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL CORNER',
          description: corner,
          screenWidth: screenWidth,
          screenHeight: screenHeight,
        ),
        SizedBox(height: screenHeight * 0.02),
        buildFirstAidCard(
          name: 'PATROL-IN-COUNCIL',
          description: Council,
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
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFF0001cf),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/patrol.png',
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

final String patrolsystem = '''
# • The Patrol System is a distinctive feature of Scout training, setting it apart from other organizations and ensuring success when properly implemented.
#
# • Forming boys into Patrols of six to eight members, each under its own leader, is crucial for a successful Troop.
#
# • The Patrol serves as the fundamental unit of Scouting, whether for work, play, discipline, or duty.
#
# • Instilling individual responsibility is essential for character training, achieved by appointing a Patrol Leader to command their Patrol.
#
# • The Patrol Leader is responsible for developing the qualities of each boy in their Patrol.
#
# • Emulation and competition between Patrols foster a strong Patrol spirit, raising efficiency and camaraderie among the boys.
#
# • Each boy realizes their responsibility within the Patrol and understands that the honor of the group depends on their individual contribution.
''';

final String patrol = '''
# • The Patrol System is a representative form of government utilized by Guides/Scouts, comprising patrols and the Court of Honor, aiming to enhance the spirit, vitality, and welfare of the troop.
#
# • Troops are divided into small groups, typically consisting of six to eight Guides/Scouts, known as patrols, with each patrol often choosing interesting names based on their interests or geographic location.
#
# • Patrols contribute to the richness of the troop through their strength and ingenuity, collaborating on troop plans.
#
# • Lord Baden-Powell, the founder of Scouting, emphasized the patrol system as the sole method for carrying out Scouting for boys.
#
# • Each patrol elects a patrol leader, who serves for a predetermined time, responsible for various duties crucial for the smooth functioning of the patrol.
#
# • The patrol leader conducts regular patrol meetings, learns about the patrol's interests, represents the patrol at Court of Honor meetings, works with the assistant patrol leader, facilitates skill learning within the patrol, assigns duties, organizes tasks, consults with troop leaders, and upholds the Scout/Guide Promise and Law.
#
# • While the responsibilities may seem extensive for one individual, the patrol leader receives cooperation from patrol members and can seek advice from troop leaders when needed. Additionally, older patrol leaders may handle more responsibility than younger ones.
''';

final String leader = '''
#Another Scouts / Guides elected by the patrol members is the assistant patrol leader. She serves for the same time as the patrol leader and her job is to help the patrol leader in every way she can. The assistant patrol leader does these things and others that she may be asked to do:
#
# • Takes over the job of the patrol leader in her absence.
#
# • Carries out leadership responsibilities delegated by the patrol leader – such as making a kaper chart or organizing a flag ceremony.
#
# • Every patrol needs a patrol leader and an assistant patrol leader, but a patrol that really gets things done sees that every member has a definite permanent job. This allows it to whirl into action, not confusion, to get the necessary things done quickly and save time for the real heart of a troop or patrol activity – to turn spur-of-the-moment ideas into fun-packed afternoons.''';

final String treasurer = '''
#The Patrol Treasurer or Finance Manager oversees all financial aspects within the patrol:
#
# • Collects troop dues from patrol members, maintains a record of troop dues, and transfers them to the Troop Treasurer.
#
# • Manages all financial transactions for the patrol.
#
# • Maintains a detailed financial record of patrol income and expenses.
''';

final String Secretary = '''
#The Patrol Secretary or Recorder is responsible for managing patrol records:
#
# • Handles patrol correspondence, including invitations and thank-you notes.
#
# • Maintains a log of patrol programs and attendance.
#
# • Completes required information on permission slips.
#
# • Maintains a written record of each Scout's/Guide's progress towards awards.
''';

final String Manager = '''
#The Transportation Manager oversees transportation arrangements for patrol events:
#
# • Ensures that drivers receive a thank-you note from the secretary.
#
# • Collaborates with the Health and Safety Manager to ensure that patrol members are aware of health and safety precautions for various modes of transportation, such as car, bicycle, foot, canoe, etc.
#
# • Researches interesting places for the patrol to visit, including transportation options and associated costs.
''';

final String Commissary = '''
#The Commissary Manager oversees patrol food arrangements:
#
# • Coordinates refreshments for special occasions.
#
# • Assigns shoppers for food procurement and ensures timely purchase.
#
# • Ensures on-time delivery, proper packing, and storage of food items.
#
# • Ensures attractive food presentation and devises a cleanup plan.
''';

final String Equipment = '''
#The Equipment Manager oversees patrol equipment:
#
# • Prepares a list of personal equipment required for the program and distributes copies to each Scout / Guide.
#
# • Compiles a list of necessary patrol equipment.
#
# • Acquires, distributes, packs, and stores patrol equipment.
#
# • Ensures equipment is properly labeled and maintained.
#
# • Initiates the creation of patrol equipment (such as tin-can stoves, cook kits, etc.).
#
# • Returns borrowed equipment.
''';

final String Safety = '''
#The Health and Safety Manager ensures health and safety within the patrol:
#
# • Ensures a first aid kit is accessible at all times.
#
# • Maintains the first aid kit, replenishing items as needed.
#
# • Informs the patrol about proper health and safety protocols.
#
# • Ensures patrol members are aware of procedures in case of fire, storms, accidents, lost individuals, etc.
#
# • Knows how to contact the nearest doctor, hospital, or emergency services number.
#
# • Establishes an emergency communication system for the patrol.
''';

final String COH = '''
#The Court of Honor (COH) serves as the core decision-making body within the troop:
#
# • Every patrol member contributes to the COH through their patrol leader.
#
# • The COH includes all patrol leaders, the Troop Secretary, the Troop Treasurer, and the troop leader.
#
# • Each patrol leader represents her patrol diligently at COH meetings and ensures representation if unable to attend.
#
# • Functions of the COH:
#
#   • Plans troop programs based on patrol-submitted ideas.
#
#   • Generates activity ideas and communicates them to patrols through patrol leaders.
#
#   • Receives reports from patrols via patrol leaders (and from committee chairmen when necessary).
#
#   • Organizes learning opportunities for patrol leaders to educate their members.
#
#   • Occasionally facilitates collaboration among Scouts / Guides from different patrols for special projects.
#
# • COH meetings can occur before, after, or during regular troop meetings, typically lasting from ten minutes to half an hour.
#
# • Special meetings, held every two or three months, delve into detailed planning for upcoming months and consider patrol-suggested ideas.
#
# • The COH evaluates proposed ideas, ensuring feasibility and planning for implementation.
#
# • Longer meetings are held at the beginning and end of the troop year:
#
#   • The initial meeting sets the agenda for the year by determining major events to include in the calendar.
#
#   • The final meeting assesses the troop's performance throughout the year.
#
# • An open COH meeting may be conducted to familiarize everyone with the system, with all troop members attending as "silent watchers."
''';

final String Troop = '''
#The Troop Secretary fulfills the role of official correspondent and secretary for the entire troop. Below are some proposed responsibilities for the Troop Secretary:
#
# • Records minutes and notes during Court of Honor and business meetings.
#
# • Manages troop correspondence.
#
# • Drafts invitations and expresses gratitude for gifts and services rendered to the troop.
#
# • Maintains up-to-date troop history, which may include documenting camping trips.
#
# • If the workload is substantial, the Troop Secretary may require an assistant. It's important for both individuals to possess neat, legible handwriting to ensure the clarity of their notes for others to read.
''';

final String TroopTreasurer = '''
#The Troop Treasurer, elected by the entire troop, assumes various responsibilities within the troop. These may include:
#
# • Maintaining an account book to record all funds collected and spent by the troop.
#
# • Collecting dues from patrol treasurers, documenting payments in the account book, and either depositing them in the troop's bank account or handing them over to the troop leader for deposit.
#
# • Providing financial data to the Court of Honor (COH) during the preparation of the troop's annual budget and to any group responsible for spending troop funds (such as food buyers for camping trips or the decorations committee for troop parties).
#
# • Presenting a financial report to the troop on a monthly basis.
#
# • Being ready to furnish a report on troop finances whenever requested.
#
# • Lord Baden-Powell introduced the patrol system along with the COH, a method embraced by Girl Scouts, Girl Guides, and Boy Scouts worldwide. In this system, every troop member plays a vital role in decision-making and execution. Each individual's contribution is essential for the success of the patrol system!
''';

final String name = '''
#• Upon the formation of a new Patrol with a new Patrol Leader, the first order of business typically involves selecting a name. At the initial meeting, the members consult the Handbook For Boys to peruse the list of Patrol names, choosing one that seems fitting and appealing.
''';

final String emblem = '''
#• Once the Patrol has a name, they proceed to select an emblem or "totem" design to represent their group. This emblem is then used on various items such as the Patrol flag, medallions worn on Scout shirts, decorations for the Patrol den, and markings on all Patrol equipment, serving as a unique identifier for the Patrol.
''';

final String flag = '''
#• A Patrol flag is an essential symbol for any Scout Patrol, symbolizing their unity and identity. Making the flag is a collective effort, involving the entire Patrol rather than just one individual. Once created, the flag accompanies the Patrol on all their activities, with dates and place names added to the staff to commemorate their adventures.
''';

final String call = '''
#• Each Scout Patrol has its unique Patrol call. If your Patrol's name is inspired by an animal or bird, your call naturally mirrors the sound made by that creature.
#
#• For Patrols with names unrelated to animals or birds, selecting an appropriate animal or bird call becomes necessary. Tribes often utilized such calls, a practice adopted by many explorers.
#
#• The Patrol call serves two main purposes: rallying the members together when given by the Patrol Leader and discreetly signaling a member's location without alerting others.
#
#• For instance, if you belong to the Owl Patrol, you'd mimic the hoot of an owl convincingly. While to an outsider it may sound like a real owl, your fellow Scouts will recognize it as the Patrol call and locate you accordingly.
#
#• It's advisable to enlist someone skilled in imitating animal and bird calls to teach the entire Patrol. Whether it's the bear's grunt, beaver's tail clap, bison's bellow, or the various calls of birds like eagles, hawks, foxes, ravens, etc.
#
#• Upon joining the Patrol, new members should promptly learn the call. Additionally, it's a fundamental Scouting rule that each Scout creates their own call and refrains from using another Patrol's call for any purpose whatsoever.
''';

final String yell = '''
#• Similar to the spirited cheers heard at college football games, a Patrol yell serves to energize and unify the group. Crafting and practicing a unique yell enhances camaraderie and team spirit among Patrol members, encouraging them to give their best efforts.
''';

final String corner = '''
#• The Patrol corner serves as a repository for interesting and educational materials that engage both Scouts and adult leaders alike, fostering learning and sharing within the Patrol.
''';

final String Council = '''
#• The Patrol-in-Council convenes when the Patrol gathers to discuss and make decisions on various matters such as upcoming activities, membership dues, camping preferences, and more. Led by the Patrol Leader, all Patrol members participate in these discussions, addressing the affairs and needs of the Patrol collectively.
''';

void main() {
  runApp(MaterialApp(
    home: Patrol(),
  ));
}
