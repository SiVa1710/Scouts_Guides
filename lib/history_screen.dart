import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A visually engaging, chronological timeline screen displaying the history 
/// of the Scouting and Guiding movement.
///
/// This screen utilizes a staggered entrance animation to present a static 
/// data dictionary of historical milestones. It is built with a responsive 
/// [ConstrainedBox] to maintain optimal readability on tablet and web platforms.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  /// The primary data source for the historical timeline.
  ///
  /// Each map entry represents a distinct chronological milestone, providing 
  /// the year, title, descriptive body, a dedicated exam tip for the Rajyapuraskar,
  /// and thematic UI properties (icons and accent colors).
  final List<Map<String, dynamic>> historyData = const [
    {
      "year": "1857",
      "title": "BIRTH OF THE FOUNDER",
      "body": "Robert Stephenson Smyth Baden-Powell was born on Feb 22, 1857, at 81 Stanhope Street, London. He was the 6th son of Rev. H.G. Baden-Powell.",
      "point": "Exam Point: Feb 22 is celebrated globally as World Thinking Day & Founder's Day.",
      "icon": Icons.cake_rounded,
      "color": Color(0xFF64B5F6)
    },
    {
      "year": "1899",
      "title": "THE SIEGE OF MAFEKING",
      "body": "During the Boer War, BP successfully defended the town of Mafeking for 217 days. He utilized the 'Mafeking Cadet Corps'—boys used as messengers and lookouts.",
      "point": "Exam Point: The siege lasted exactly 217 days. This proved youth could take on serious responsibilities.",
      "icon": Icons.fort_rounded,
      "color": Color(0xFF81C784)
    },
    {
      "year": "1907",
      "title": "BROWNSEA ISLAND CAMP",
      "body": "BP held the first experimental Scout camp from Aug 1 to Aug 9 at Brownsea Island, Poole Harbour, England, with 20 boys from different social backgrounds.",
      "point": "Exam Point: Original Patrols were Wolves, Ravens, Curlews, and Bulls.",
      "icon": Icons.landscape_rounded,
      "color": Color(0xFFFFB74D)
    },
    {
      "year": "1908",
      "title": "SCOUTING FOR BOYS",
      "body": "BP published 'Scouting for Boys' in six fortnightly parts. It became one of the best-selling books of the 20th century and officially launched the movement.",
      "point": "Exam Point: Introduced the Scout Promise and the 10 original Scout Laws.",
      "icon": Icons.menu_book_rounded,
      "color": Color(0xFFBA68C8)
    },
    {
      "year": "1909",
      "title": "SCOUTING REACHES INDIA",
      "body": "Captain T.H. Baker established the first Scout troop in Bangalore. Initially, it was restricted to European and Anglo-Indian boys.",
      "point": "Exam Point: Crystal Palace Rally also happened in 1909, where Girls demanded to be Scouts.",
      "icon": Icons.location_on_rounded,
      "color": Color(0xFF4DB6AC)
    },
    {
      "year": "1910",
      "title": "GIRL GUIDES FOUNDED",
      "body": "Agnes Baden-Powell (BP's sister) became the first president of the Girl Guides. In 1911, Dr. McDougall started the first Guide Company in Jabalpur, India.",
      "point": "Exam Point: Olave Baden-Powell (BP's wife) later became World Chief Guide.",
      "icon": Icons.female_rounded,
      "color": Color(0xFFF06292)
    },
    {
      "year": "1916",
      "title": "DR. ANNIE BESANT",
      "body": "Dr. Annie Besant, with the help of Dr. G.S. Arundale, founded the 'Indian Boy Scouts Association' in Madras to allow native Indian youth to participate.",
      "point": "Exam Point: She strongly advocated for Indians to wear the Scout uniform.",
      "icon": Icons.groups_rounded,
      "color": Color(0xFFFF8A65)
    },
    {
      "year": "1918",
      "title": "SEVA SAMITHI ASSOCIATION",
      "body": "Pt. Madan Mohan Malaviya and Pt. Hridayanath Kunzru started the 'Seva Samithi Scout Association' in Allahabad with a strong focus on Indian culture.",
      "point": "Exam Point: They popularized the singing of 'Vande Mataram' in camps.",
      "icon": Icons.volunteer_activism_rounded,
      "color": Color(0xFFDCE775)
    },
    {
      "year": "1950",
      "title": "THE BHARAT MERGER",
      "body": "On November 7th, 1950, various scouting factions merged to form 'The Bharat Scouts and Guides' (BS&G) under the leadership of Tara Ali Baig.",
      "point": "Exam Point: Nov 7th is officially BS&G Foundation Day / Flag Day.",
      "icon": Icons.handshake_rounded,
      "color": Color(0xFF7986CB)
    },
    {
      "year": "1951",
      "title": "UNIFIED GUIDING",
      "body": "On August 15, 1951, the All India Girl Guides Association formally joined the BS&G, creating a powerful unified co-educational structure.",
      "point": "Exam Point: India is unique for having a fully integrated Scout and Guide association.",
      "icon": Icons.verified_user_rounded,
      "color": Color(0xFF4FC3F7)
    },
    {
      "year": "AWARD",
      "title": "RAJYAPURASKAR",
      "body": "The Governor's Award. To qualify, a Scout/Guide must complete Tritiya Sopan, hold specific proficiency badges, and pass the state-level testing camp.",
      "point": "Exam Point: The badge features the state emblem and is worn on the left sleeve.",
      "icon": Icons.military_tech_rounded,
      "color": Color(0xFFFFF176)
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SmoothGradientBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              // Prevents horizontal stretching on wide desktop/tablet displays
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  
                  // Navigation Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        Text("HISTORY", style: AppTheme.navTitle(width)),
                      ],
                    ),
                  ),
                  
                  // Timeline List with Staggered Entrance Animations
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: historyData.length,
                      itemBuilder: (context, index) {
                        
                        // TweenAnimationBuilder calculates a sequential delay based on the index 
                        // to cascade the timeline cards onto the screen smoothly.
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: Duration(milliseconds: 500 + (index * 100).clamp(0, 500)),
                          curve: Curves.easeOutQuart,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 50 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: HistoryTimelineCard(
                            data: historyData[index],
                            isLast: index == historyData.length - 1,
                            width: width,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBannerAd(),
    );
  }
}

/// A highly customized, responsive timeline node widget.
///
/// It utilizes [IntrinsicHeight] to ensure the vertical connecting timeline 
/// accurately scales to match the dynamic height of the text content inside 
/// the glassmorphism card. 
class HistoryTimelineCard extends StatelessWidget {
  final Map<String, dynamic> data;
  
  /// Determines whether to draw the descending vertical connection line.
  final bool isLast;
  
  final double width;

  const HistoryTimelineCard({
    super.key, 
    required this.data, 
    required this.isLast, 
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor = data['color'] ?? Colors.blue;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          
          // Left Column: Timeline Node and Connection Line
          Column(
            children: [
              // Circular Icon Node
              Container(
                height: 54, width: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withOpacity(0.15),
                  border: Border.all(color: accentColor.withOpacity(0.8), width: 2),
                  boxShadow: [BoxShadow(color: accentColor.withOpacity(0.4), blurRadius: 20)],
                ),
                child: Icon(data['icon'], color: Colors.white, size: 24),
              ),
              
              // Gradient Vertical Timeline Line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [accentColor.withOpacity(0.8), Colors.white24],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          
          // Right Column: Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: Stack(
                // Allows the overlapping Year Badge to break out of the container constraints
                clipBehavior: Clip.none, 
                children: [
                  
                  // Main Glassmorphism Card Body
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.12)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 2)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text(
                              data['title'],
                              style: AppTheme.heading(width).copyWith(
                                  fontSize: AppTheme.scaleText(width, 20),
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              data['body'],
                              style: AppTheme.bodyText(width).copyWith(
                                  fontSize: AppTheme.scaleText(width, 16),
                                  height: 1.6,
                                  color: Colors.white.withOpacity(0.9)
                              ),
                            ),
                            const SizedBox(height: 25),
                            
                            // Highlighted Exam Point Box
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: accentColor.withOpacity(0.3)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.tips_and_updates_rounded, color: accentColor, size: 20),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      data['point'],
                                      style: AppTheme.bodyText(width).copyWith(
                                          fontSize: AppTheme.scaleText(width, 14),
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white70
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Overlapping Year Badge
                  Positioned(
                    top: -12, left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentColor, borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: accentColor.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
                      ),
                      child: Text(
                        data['year'],
                        style: AppTheme.badgeText(width, AppTheme.pureBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
