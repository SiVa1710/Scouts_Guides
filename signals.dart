import 'package:flutter/material.dart';

class Signals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGNALS',
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
          buildHandSignalItem(
            handSignalName: 'HAND SIGNALS',
            handSignalDescription: HandSignalText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildWhistleSignalItem(
            whistleSignalName: 'WHISTLE SIGNALS',
            whistleSignalDescription: WhistleSignalText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildHandSignalItem({
    String handSignalName,
    String handSignalDescription,
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
            leading: Icon(
              Icons.signal_wifi_4_bar_rounded, // Change the icon to the desired one
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              handSignalName,
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
                    children: handSignalDescription.split('#').map((line) {
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

  Widget buildWhistleSignalItem({
    String whistleSignalName,
    String whistleSignalDescription,
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
            leading: Icon(
              Icons.signal_wifi_4_bar_rounded, // Change the icon to the desired one
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              whistleSignalName,
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
                    children: whistleSignalDescription.split('#').map((line) {
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

final String HandSignalText = '''
#• Hand signals, which can also be replicated by Patrol Leaders using their Patrol flags when necessary, convey various messages:
#
# 1. Waving the hand or flag several times across the face from side to side signifies "No," "Never mind," or "As you were."
#
# 2. Holding the hand or flag high and waving it slowly from side to side indicates "Extend," "Move farther out," or "Scatter."
#
# 3. Holding the hand or flag high and waving it quickly from side to side at full arm extension means "Gather," "Rally," or "Come here."
#
# 4. Pointing the hand or flag in any direction indicates "Proceed in that direction."
#
# 5. Rapidly jumping a clenched hand or flag up and down signifies "Run."
#
# 6. Holding the hand or flag straight up over the head signals "Stop" or "Halt."
''';

final String WhistleSignalText = '''
#• When a Scoutmaster needs to gather the Troop, they use either "The Scout Call" whistle or a special Troop call. Patrol Leaders then gather their Patrols by using their Patrol call and lead them quickly to the Scoutmaster. During Scout-wide games, whistle signals convey important instructions:
#
# 1. One long blast signals "Silence" or "Attention," indicating to be alert for the next command.
#
# 2. A series of long, slow blasts means "Advance," "Extend," or "Scatter," prompting Scouts to move away from the current position.
#
# 3. A sequence of short, sharp blasts signifies "Rally," "Gather," or "Close in," instructing Scouts to come together.
#
# 4. Alternating short and long blasts signal "Alarm," "Be alert," or "Man your alarm posts," indicating a potential emergency.
#
# 5. When the Scoutmaster emits three short blasts followed by one long blast, it summons the Patrol Leaders, meaning "Leaders come here."
#
#• It's essential for Scouts to respond immediately to any signal by running at top speed, regardless of their current task.
''';

void main() {
  runApp(MaterialApp(
    home: Signals(),
  ));
}
