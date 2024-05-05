import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class History extends StatelessWidget {
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
          'HISTORY',
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
          buildHistoryItem(
            HistoryName: 'HISTORY OF THE MOVEMENT',
            HistoryDescription: HistoryText,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          SizedBox(height: screenHeight * 0.02),
          buildHistory1Item(
            History1Name: 'SCOUTING IN INDIA',
            History1Description: History1Text,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget buildHistoryItem({
    required String HistoryName,
    required String HistoryDescription,
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
            leading: Icon(
              Icons.history_sharp, // Change the icon to the desired one
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              HistoryName,
              style: TextStyle(
                fontSize: 20, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: HistoryDescription.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0, // Adjusted font size
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

  Widget buildHistory1Item({
    required String History1Name,
    required String History1Description,
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
            leading: Icon(
              Icons.history_sharp, // Change the icon to the desired one
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              History1Name,
              style: TextStyle(
                fontSize: 20, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: RichText(
                  text: TextSpan(
                    children: History1Description.split('#').map((line) {
                      return TextSpan(
                        text: line,
                        style: TextStyle(
                          fontSize: 18.0, // Adjusted font size
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

final String HistoryText = '''
#• In 1907, Robert Stephenson Smyth Baden-Powell initiated the Scout organization. Born on February 22, 1857, in London, he hailed from Paddington, specifically Standhop Street. He was the sixth son of Herbert George Baden Powell and Henrietta Grace Smyth, and the grandson of Joseph Boyer Smith. His father, a professor at Oxford University, passed away when Baden-Powell was just three years old, leaving him with his only sister, Agnes. Baden-Powell was affectionately called "Steffy" by his mother.
#
#• Baden-Powell began his education at Helensburgh, later attending Rose Hill and graduating from Charterhouse in 1876 at the age of 19. He then joined the British Army's 13th Hussars regiment as a sub-lieutenant, eventually rising to the rank of captain by the age of 26. Alongside his military career, Baden-Powell pursued various hobbies such as pigstalking, boating, fishing, horse riding, and pig hunting.
#
#• The small town of Mafeking in South Africa played a significant role in Baden-Powell's life during the Boer War of 1887. Leading the defense against the Boer tribes during a 217-day siege, Baden-Powell's tactics and leadership skills earned him acclaim. He organized the Mafeking Cadet Corps, comprising boys aged nine and above, who played crucial roles in the defense efforts, impressing Baden-Powell with their courage and resourcefulness.
#
#• Upon his return to England as a national hero, Baden-Powell was promoted to Lieutenant General. He observed that his military handbook, "Aids to Scouting," was being used to teach observation and woodcraft to boys' clubs and the Boys' Brigade. This led him to rewrite the book specifically for boys, laying the foundation for what would become the Boy Scouts movement.
#
#• In 1907, Baden-Powell conducted an experimental camp on Brownsea Island to test his ideas about scouting. Recruiting boys from diverse backgrounds, the camp was a resounding success, demonstrating the appeal of outdoor activities and the effectiveness of the patrol system in teaching scoutcraft.
#
#• Following the camp's success, Baden-Powell revised his handbook and published it as "Scouting for Boys" in 1908. The popularity of the book led to the rapid spread of the Boy Scouts movement across the United Kingdom and beyond. The first recognized overseas unit was chartered in Gibraltar in 1908, marking the beginning of scouting's global expansion.
#
#• In 1909, the first gathering of Scouts at Crystal Palace in London saw over 11,000 participants, including girls who expressed their desire to join the movement. Baden-Powell responded by establishing the Girl Guides, led by his sister Agnes, thus launching the guiding movement for girls.
#
#• Despite the challenges posed by the First World War, scouting persevered, with patrol leaders stepping up to fill the void left by adult leaders who volunteered for active service. The movement continued to grow, culminating in the first World Jamboree in 1920, where Baden-Powell was hailed as the Chief Scout of the world.
#
#• As scouting spread to various countries, the need for a global organization led to the formation of the World Organization of the Scout Movement (WOSM) and the World Association of Girl Guides and Girl Scouts (WAGGGS).
#
#• Today, scouting thrives worldwide, with millions of members in over 200 countries and territories, embodying Baden-Powell's vision of developing character and leadership skills in young people.
''';

final String History1Text = '''
#• Scouting was officially introduced to British India in 1909, initially limited to European and Anglo-Indian boys. However, in 1913, prominent figures such as Justice Vivian Bose, Pandit Madan Mohan Malaviya, Pandit Hridayanath Kunzru, Girija Shankar Bajpai, Annie Besant, and George Arundale advocated for the inclusion of native Indian boys in Scouting. Consequently, Scouting for native Indians commenced, with the establishment of various Scout organizations.
#
#• In 1916, Senior Deputy Commissioner of Police J. S. Wilson pioneered the use of "Scouting for Boys" as a textbook in the Calcutta Police Training School, marking the beginning of formal Scouting activities in India. Despite initial resistance due to government orders fearing the potential revolutionary influence of Scouting, Wilson and Alfred Pickford tirelessly worked towards integrating Indian boys into the Boy Scouts Association. Various Scout organizations emerged across India, including the Indian Boy Scouts Association, Boy Scouts of Mysore, Boy Scouts of Baroda, Nizam's Scouts in Hyderabad, and others.
#
#• In 1921, Lord Baden-Powell's visit to India led to the consolidation of these Scout organizations into The Boy Scouts Association in India, except for the Seva Samiti Scout Association. The Hindustan Scout Association was formed in 1938 by members who departed from the Boy Scouts Association in India amidst a nationalist wave. This marked the inception of the first coeducational Scouting and Guiding organization in India.
#
#• Following India's independence, efforts were made to unify the country's Scouts and Guides. In 1950, the Boy Scouts Association in India and the Hindustan Scout Association merged to form The Bharat Scouts and Guides, followed by the inclusion of the All India Girl Guides Association in 1951.
#
#• Today, both the Scout wing and Guide wing operate under The Bharat Scouts and Guides banner, with the Scout wing affiliated with WOSM and the Guide wing affiliated with WAGGGS.
''';

void main() {
  runApp(MaterialApp(
    home: History(),
  ));
}
