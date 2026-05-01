import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

void main() {
  runApp(MaterialApp(
    home: Exercises(),
  ));
}

class Exercises extends StatelessWidget {
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
          'EXERCISES',
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
          buildExerciseCard(
            exerciseImage: 'assets/images/exercise1.png',
            exerciseName: 'EXERCISE I',
            exerciseDescription: HEAD,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildExerciseCard(
            exerciseImage: 'assets/images/exercise2.png',
            exerciseName: 'EXERCISE II',
            exerciseDescription: CHEST,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildExerciseCard(
            exerciseImage: 'assets/images/exercise3.png',
            exerciseName: 'EXERCISE III',
            exerciseDescription: STOMACH,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildExerciseCard(
            exerciseImage: 'assets/images/exercise4.png',
            exerciseName: 'EXERCISE IV',
            exerciseDescription: TRUNK,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildExerciseCard(
            exerciseImage: 'assets/images/exercise5.png',
            exerciseName: 'EXERCISE V',
            exerciseDescription: LOWER,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildExerciseCard(
            exerciseImage: 'assets/images/exercise6.png',
            exerciseName: 'EXERCISE VI',
            exerciseDescription: LEGS,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildExerciseCard({
    required String exerciseImage,
    required String exerciseName,
    required String exerciseDescription,
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
              'assets/icons/exercise.png',
              width: 30,
              height: 30,
            ),
            title: Text(
              exerciseName,
              style: flagTitleStyle,
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              exerciseImage,
              width: screenWidth - screenWidth * 0.06,
              height: screenWidth * 0.6,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: exerciseDescription.split('#').map((line) {
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

final String HEAD = '''
#HEAD EXERCISE
#
# • Rub your head and face firmly with the palms and fingers of both hands. Massage the muscles of the neck and throat with your thumbs.
''';

final String CHEST = '''
#CHEST EXERCISE
#
# • Stand upright, bend forward, arms stretched downwards, with the back of your hands together in front of your knees. Exhale as you raise your arms gradually over your head and lean back as far as possible. Inhale deeply through the nose as you do. Lower your arms gradually to the sides, exhaling and saying "Thanks" through your mouth. Bend forward again, exhaling fully and count the repetitions.
#
#Repeat this exercise 12 times.
''';

final String STOMACH = '''
#STOMACH EXERCISE
#
# • Stand upright and extend both arms straight in front of you. Slowly swing to the right from the hips without moving your feet, pointing your right arm as far behind you as possible while keeping both arms level or slightly higher than your shoulders. Pause, then swing to the left as far as you can, breathing in as you point left and exhaling as you point right. Repeat six times on each side.
''';

final String TRUNK = '''
#TRUNK EXERCISE
#
# • Stand at attention, raise both hands as high as possible over your head, and interlock your fingers. Lean backward, then sway your arms slowly in a wide circle above and around your body, turning from the hips and leaning over one side, then to the front, then to the other side, and back. Complete the circle and repeat six times in each direction. Inhale as you lean backward and exhale as you lean forward.
''';

final String LOWER = '''
#LOWER BODY EXERCISE
#  
# • Stand with feet slightly apart, touch your head with both hands, and look up into the sky while leaning back as far as possible. Then, bend forward until your fingers touch your toes without bending your knees. Repeat 12 times.
''';

final String LEGS = '''
#LEGS AND FEET EXERCISE
# 
# • Stand at attention, place your hands on your hips, stand on tiptoe, turn your knees outwards, and slowly bend them down to a squatting position while keeping your heels off the ground. Gradually raise your body back to the starting position. Repeat 12 times, inhaling as your body rises and exhaling as your body sinks.
''';
