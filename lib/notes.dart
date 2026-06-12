import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A static data dictionary serving as the content management system for Study Notes.
///
/// This JSON-like structure is deeply nested to allow dynamic, programmatic UI 
/// generation. It contains a collection of topics, each possessing a title, subtitle, 
/// theme colors, and a `content` array. The custom parser in `_NoteDetailModal` 
/// iterates through this array to render corresponding Flutter widgets based on the 
/// `type` property (e.g., 'heading', 'text', 'bullets', 'alert', or 'compass_diagram').
final List<Map<String, dynamic>> notesData = [
  {
    "title": "PROMISE & LAW",
    "subtitle": "The Core Foundation",
    "icon": Icons.verified_user_rounded,
    "colors": [const Color(0xFFFFC266), const Color(0xFFFFA726)],
    "shadowColor": const Color(0xFFFFA726),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: The Promise is taken during Investiture. The 3 parts of the Promise represent: 1. Duty to God/Country, 2. Duty to Others, 3. Duty to Self (Obeying the Law)."
      },
      {
        "type": "heading",
        "text": "THE SCOUT / GUIDE PROMISE"
      },
      {
        "type": "text",
        "text": "“On my honour, I promise that I will do my best\nTo do my duty to God and my country,\nTo help other people and\nTo obey the Scout/Guide Law.”\n\n*Note: The word 'Dharma' may be substituted for 'God'."
      },
      {
        "type": "heading",
        "text": "THE 9 POINTS OF THE LAW"
      },
      {
        "type": "bullets",
        "items": [
          "1. A Scout/Guide is Trustworthy.",
          "2. A Scout/Guide is loyal.",
          "3. A Scout/Guide is a friend to all and a brother/sister to every other Scout/Guide.",
          "4. A Scout/Guide is courteous.",
          "5. A Scout/Guide is a friend to animals and loves nature.",
          "6. A Scout/Guide is disciplined and helps protect public property.",
          "7. A Scout/Guide is courageous.",
          "8. A Scout/Guide is thrifty.",
          "9. A Scout/Guide is pure in thought, word and deed."
        ]
      }
    ]
  },
  {
    "title": "SIGN & SALUTE",
    "subtitle": "Mark of Respect",
    "icon": Icons.back_hand_rounded,
    "colors": [const Color(0xFF64B5F6), const Color(0xFF42A5F5)],
    "shadowColor": const Color(0xFF42A5F5),
    "content": [
      {
        "type": "heading",
        "text": "THE SCOUT SIGN"
      },
      {
        "type": "bullets",
        "items": [
          "Raised right hand, level with the shoulder, palm to the front.",
          "Three fingers stretched together (representing the 3 parts of the promise).",
          "Thumb closing over the little finger (representing 'The Strong protecting the Weak' and the bond of brotherhood)."
        ]
      },
      {
        "type": "alert",
        "text": "EXAM POINT: The Sign is ONLY used during Investiture and when renewing the Scout/Guide Promise. It is not a greeting."
      },
      {
        "type": "heading",
        "text": "THE SALUTE"
      },
      {
        "type": "bullets",
        "items": [
          "Full Salute: Right hand brought smartly to the right eyebrow or brim of the hat. Used for National Anthem, Colours, and greeting officials.",
          "Staff Salute (Half Salute): When carrying a staff in the right hand, the left arm is brought across the chest horizontally to touch the staff."
        ]
      }
    ]
  },
  {
    "title": "THE MOTTO",
    "subtitle": "Taiyar / Be Prepared",
    "icon": Icons.local_fire_department_rounded,
    "colors": [const Color(0xFFD7CCC8), const Color(0xFFBCAAA4)],
    "shadowColor": const Color(0xFFBCAAA4),
    "content": [
      {
        "type": "heading",
        "text": "TAIYAR (BE PREPARED)"
      },
      {
        "type": "text",
        "text": "The official motto of the Bharat Scouts and Guides is 'Taiyar' (Be Prepared). Formulated by Lord Baden-Powell, it means a Scout must always be in a state of readiness in mind and body to do their duty."
      },
      {
        "type": "bullets",
        "items": [
          "Physically Strong: Fit and healthy to act swiftly in emergencies and rescues.",
          "Mentally Awake: Having the presence of mind and knowledge to know exactly what to do.",
          "Morally Straight: The discipline to always do the right thing, regardless of the situation."
        ]
      }
    ]
  },
  {
    "title": "LEFT HAND SHAKE",
    "subtitle": "Ultimate Trust",
    "icon": Icons.handshake_rounded,
    "colors": [const Color(0xFFFFFFFF), const Color(0xFFF0F4F8)],
    "shadowColor": const Color(0xFFB0BEC5),
    "content": [
      {
        "type": "heading",
        "text": "ORIGIN & MEANING"
      },
      {
        "type": "text",
        "text": "The left-handed handshake is the formal greeting used by Scouts and Guides worldwide. It is made with the hand nearest the heart."
      },
      {
        "type": "alert",
        "text": "EXAM POINT: Lord Baden-Powell learned this during the Ashanti campaign in Africa (1895). The Ashanti Chief, Prempeh, offered his left hand saying: 'The bravest of the brave shake with the left hand, because to do so they must drop their shields and their protection.' It signifies absolute vulnerability and ultimate trust."
      }
    ]
  },
  {
    "title": "COMPASS & NORTH",
    "subtitle": "Finding Direction",
    "icon": Icons.explore_rounded,
    "colors": [const Color(0xFFCE93D8), const Color(0xFFBA68C8)],
    "shadowColor": const Color(0xFFBA68C8),
    "content": [
      {
        "type": "compass_diagram"
      },
      {
        "type": "heading",
        "text": "THE 16 POINTS"
      },
      {
        "type": "bullets",
        "items": [
          "Cardinals: N (0°/360°), E (90°), S (180°), W (270°).",
          "Half-Cardinals: NE (45°), SE (135°), SW (225°), NW (315°).",
          "Intermediate: NNE (22.5°), ENE (67.5°), ESE (112.5°), SSE (157.5°), SSW (202.5°), WSW (247.5°), WNW (292.5°), NNW (337.5°)."
        ]
      },
      {
        "type": "alert",
        "text": "EXAM POINT: You must know how to calculate Back Bearing. If Forward Bearing is < 180°, ADD 180°. If > 180°, SUBTRACT 180°."
      },
      {
        "type": "heading",
        "text": "FINDING NORTH WITHOUT A COMPASS"
      },
      {
        "type": "bullets",
        "items": [
          "Watch Method (Northern Hemisphere): Point the hour hand directly at the sun. Bisect the angle between the hour hand and the 12 o'clock mark. That imaginary bisecting line points South. The opposite is North.",
          "Shadow Stick Method: Place a stick vertically. Mark the tip of the shadow. Wait 15 mins. Mark the new tip. Draw a line from the first mark to the second. This line points exactly West to East. North is exactly 90 degrees clockwise from West.",
          "Constellations: The two outer stars of the Great Bear (Saptarishi) point directly to the Pole Star (North)."
        ]
      }
    ]
  },
  {
    "title": "SIGNALS",
    "subtitle": "Silent Communication",
    "icon": Icons.sensors_rounded,
    "colors": [const Color(0xFFFF8A80), const Color(0xFFFF5252)],
    "shadowColor": const Color(0xFFFF5252),
    "content": [
      {
        "type": "heading",
        "text": "WHISTLE SIGNALS"
      },
      {
        "type": "bullets",
        "items": [
          "One Long Blast: Silence, Attention, or Halt.",
          "Series of Long Blasts: Advance, Extend, or Scatter.",
          "Series of Short Blasts: Rally, Close in, or Gather.",
          "Alternating Short & Long: Alarm! Be alert / Man your posts.",
          "Three Short, One Long: Patrol Leaders come here."
        ]
      },
      {
        "type": "heading",
        "text": "HAND SIGNALS"
      },
      {
        "type": "bullets",
        "items": [
          "Hand waved across face: 'No' or 'As you were'.",
          "Hand waved slowly side to side (high): 'Scatter' or 'Extend'.",
          "Hand waved quickly side to side (high): 'Gather' or 'Rally'.",
          "Fist jumping up and down: 'Run'.",
          "Hand straight up over head: 'Stop' or 'Halt'."
        ]
      }
    ]
  },
  {
    "title": "MAPPING",
    "subtitle": "Topography & Nav",
    "icon": Icons.map_rounded,
    "colors": [const Color(0xFFA5D6A7), const Color(0xFF66BB6A)],
    "shadowColor": const Color(0xFF66BB6A),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: Mapping is a crucial Rajyapuraskar requirement. You must know Map Setting, Scale, Grid References, and Conventional Signs."
      },
      {
        "type": "heading",
        "text": "BASIC DEFINITIONS"
      },
      {
        "type": "bullets",
        "items": [
          "Map: A miniature, proportional representation of a part of the Earth's surface on a flat plane.",
          "Scale: The proportion between the distance on the map and the actual distance on the ground (Represented as RF - Representative Fraction, e.g., 1:50,000).",
          "Setting a Map: Aligning the map flat on the ground so that the North on the map points exactly to the magnetic North."
        ]
      },
      {
        "type": "heading",
        "text": "CONVENTIONAL COLORS"
      },
      {
        "type": "text",
        "text": "Maps use standard colors to denote features:"
      },
      {
        "type": "bullets",
        "items": [
          "Blue: Water bodies (Rivers, lakes, wells).",
          "Green: Vegetation (Forests, orchards, trees).",
          "Brown: Contour lines, sand, and hills.",
          "Red: Roads, highways, grid lines.",
          "Black: Man-made features, railway lines, names/boundaries."
        ]
      },
      {
        "type": "heading",
        "text": "CONTOURS & GRIDS"
      },
      {
        "type": "bullets",
        "items": [
          "Contour Lines: Imaginary brown lines joining places of equal elevation above mean sea level. Close lines mean steep slopes; wide lines mean gentle slopes.",
          "Grid Reference: Used to pinpoint locations. Always read Eastings (vertical lines) first, then Northings (horizontal lines). Remember the rule: 'Along the corridor, then up the stairs'."
        ]
      }
    ]
  },
  {
    "title": "TRACKING SIGNS",
    "subtitle": "Woodcraft Signals",
    "icon": Icons.eco_rounded,
    "colors": [const Color(0xFFF48FB1), const Color(0xFFEC407A)],
    "shadowColor": const Color(0xFFEC407A),
    "content": [
      {
        "type": "heading",
        "text": "WOODCRAFT TRAIL SIGNS"
      },
      {
        "type": "text",
        "text": "Tracking signs are made using natural materials (stones, twigs, grass) to leave messages for patrols following behind."
      },
      {
        "type": "bullets",
        "items": [
          "Arrow (made of stones/twigs): 'Go in this direction'.",
          "An 'X' (crossed twigs): 'This path is not to be followed / Wrong way'.",
          "A circle of stones with a dot in the center: 'I have gone home'.",
          "A rectangle with a number inside: 'Message hidden X paces away in the direction of the arrow'.",
          "Grass tied in a knot: 'Danger / Warning'."
        ]
      },
      {
        "type": "alert",
        "text": "EXAM POINT: Never use artificial materials (chalk, paint, paper) for trail signs in the wilderness. Always destroy or scatter the signs once the last member of the patrol has passed."
      }
    ]
  },
  {
    "title": "ESTIMATION",
    "subtitle": "Distance & Height",
    "icon": Icons.straighten_rounded,
    "colors": [const Color(0xFF80CBC4), const Color(0xFF26A69A)],
    "shadowColor": const Color(0xFF26A69A),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: Estimation must be done without measuring tapes. A margin of 10% error is generally acceptable in the Rajyapuraskar practicals."
      },
      {
        "type": "heading",
        "text": "HEIGHT ESTIMATION"
      },
      {
        "type": "bullets",
        "items": [
          "Lumberman's Method: Use a stick exactly the length of your outstretched arm. Walk away from the tree until the tip of the stick covers the top of the tree, and your thumb covers the base. The distance you walked is the height of the tree.",
          "Shadow Method: Measure the shadow of a staff of known length. Measure the shadow of the tree. (Tree Height = Staff Height x Tree Shadow / Staff Shadow).",
          "Inch-to-Mile Method: Have a Scout of known height stand by the tree. Walk away, hold a ruler at arm's length. See how many inches the Scout measures. Then see how many inches the tree measures. Multiply accordingly."
        ]
      },
      {
        "type": "heading",
        "text": "WIDTH ESTIMATION"
      },
      {
        "type": "bullets",
        "items": [
          "Napoleon's Method: Stand on one bank of the river. Press your chin to your chest and tilt your hat brim down until it aligns with the opposite bank. Turn 90 degrees without changing your head tilt. Note where the brim hits the ground on your side. Pace out the distance.",
          "Pacing Method: Know your exact pace length. Step out distances to estimate width."
        ]
      }
    ]
  },
  {
    "title": "CAMP CRAFT",
    "subtitle": "Pitching & Hygiene",
    "icon": Icons.holiday_village_rounded,
    "colors": [const Color(0xFFFFCC80), const Color(0xFFFF9800)],
    "shadowColor": const Color(0xFFFF9800),
    "content": [
      {
        "type": "heading",
        "text": "TENT PITCHING"
      },
      {
        "type": "bullets",
        "items": [
          "Site Selection: Choose high, level ground. Avoid pitching directly under large trees (danger of falling branches/lightning).",
          "Wind Direction: Pitch the tent so the back faces the prevailing wind. The entrance should be on the sheltered side.",
          "Knots Used: Clove hitch for the main poles, Round Turn & Two Half Hitches for peg guy lines.",
          "Trenching: Dig a shallow 'V' shaped trench around the tent to channel rainwater away."
        ]
      },
      {
        "type": "heading",
        "text": "CAMP HYGIENE"
      },
      {
        "type": "bullets",
        "items": [
          "Wet Pit: A dug hole covered with twigs and dry grass. Used to filter out solid waste while allowing dirty water to drain.",
          "Dry Pit: Used for burning or burying combustible/biodegradable garbage.",
          "Latrines: Must be dug at least 50 meters away from the camp and water sources, preferably downwind."
        ]
      }
    ]
  },
  {
    "title": "WOODCRAFT & FIRE",
    "subtitle": "Backwoodsman Cooking",
    "icon": Icons.whatshot_rounded,
    "colors": [const Color(0xFFEF9A9A), const Color(0xFFE53935)],
    "shadowColor": const Color(0xFFE53935),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: You must know how to light a fire using only TWO matchsticks."
      },
      {
        "type": "heading",
        "text": "TYPES OF CAMP FIRES"
      },
      {
        "type": "bullets",
        "items": [
          "Trench Fire: Dug into the ground. Best for windy days and conserves fuel.",
          "Star Fire: Logs placed like a star meeting at the center. Good for overnight burning as logs are slowly pushed in.",
          "Altar Fire: Built on a raised platform of mud/stones. Saves your back while cooking and leaves no trace on the ground."
        ]
      },
      {
        "type": "heading",
        "text": "BACKWOODSMAN COOKING"
      },
      {
        "type": "text",
        "text": "Cooking food without using modern utensils (pots or pans)."
      },
      {
        "type": "bullets",
        "items": [
          "Twist/Damper: Dough wrapped spirally around a thick, bark-stripped green stick and baked over hot coals.",
          "Ash Roasting: Potatoes or onions coated in wet mud and buried directly in hot ashes.",
          "Frying on Stone: Using a flat, washed, non-porous rock heated over a fire."
        ]
      }
    ]
  },
  {
    "title": "PIONEERING",
    "subtitle": "Projects & Trestles",
    "icon": Icons.architecture_rounded,
    "colors": [const Color(0xFF9FA8DA), const Color(0xFF3F51B5)],
    "shadowColor": const Color(0xFF3F51B5),
    "content": [
      {
        "type": "heading",
        "text": "THE TRESTLE"
      },
      {
        "type": "text",
        "text": "The Trestle is the fundamental building block for pioneering projects, especially bridges and towers."
      },
      {
        "type": "bullets",
        "items": [
          "Components: Requires 6 spars. Two long legs, a transom (top), a ledger (bottom), and two diagonal braces.",
          "Lashings Used: 4 Square Lashings (for the transom and ledger) and 1 Diagonal Lashing (for the center cross).",
          "Order of Tying: 1. Transom to legs. 2. Ledger to legs. 3. Diagonals to legs. 4. Center diagonal lashing."
        ]
      },
      {
        "type": "heading",
        "text": "CAMP GADGETS"
      },
      {
        "type": "text",
        "text": "Small, practical structures built to make campsite life comfortable using wood and lashings."
      },
      {
        "type": "bullets",
        "items": [
          "Shoe Rack: Simple A-frame structure with horizontal bars.",
          "Wash Basin Stand: A Tripod lashing holding a basin.",
          "Altar Fire Stand: A heavy-duty table lashed together to hold mud and a fire."
        ]
      }
    ]
  },
  {
    "title": "ADV. SIGNALING",
    "subtitle": "Morse & Semaphore",
    "icon": Icons.waving_hand_rounded,
    "colors": [const Color(0xFFFFE082), const Color(0xFFFF8F00)],
    "shadowColor": const Color(0xFFFF8F00),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: For Rajyapuraskar, you must be able to send and receive simple messages in Semaphore."
      },
      {
        "type": "heading",
        "text": "SEMAPHORE"
      },
      {
        "type": "text",
        "text": "Visual signaling using two flags held in specific positions to represent letters."
      },
      {
        "type": "bullets",
        "items": [
          "Positioning: Arms must be kept straight and rigid. The flags must be clearly visible against the background.",
          "Circles: The alphabet is learned in 'Circles' based on arm positions (e.g., A to G involves one arm low, moving the other like a clock).",
          "Attention Sign: Both arms crossed overhead.",
          "Error/Erase Sign: Waving both flags in a figure-eight crossing low in front."
        ]
      },
      {
        "type": "heading",
        "text": "MORSE CODE"
      },
      {
        "type": "bullets",
        "items": [
          "Dots & Dashes: A 'Dot' is 1 unit of time. A 'Dash' is 3 units of time.",
          "Spacing: Space between parts of a letter is 1 unit. Space between letters is 3 units. Space between words is 7 units.",
          "SOS: The universal distress signal is • • • / – – – / • • • (Three dots, three dashes, three dots)."
        ]
      }
    ]
  },
  {
    "title": "ROPE CARE",
    "subtitle": "Whipping & Splicing",
    "icon": Icons.loop_rounded,
    "colors": [const Color(0xFFBCAAA4), const Color(0xFF8D6E63)],
    "shadowColor": const Color(0xFF8D6E63),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: You must know the difference between Whipping and Splicing. Whipping uses a separate string (twine), while Splicing uses the rope's own strands."
      },
      {
        "type": "heading",
        "text": "WHIPPING"
      },
      {
        "type": "text",
        "text": "The process of binding the end of a rope with a thin twine to prevent the strands from fraying or unravelling."
      },
      {
        "type": "bullets",
        "items": [
          "Simple Whipping: Used for standard twisted ropes. The twine is wrapped tightly around the rope end and pulled through its own loop to lock.",
          "Sailmaker's Whipping: A highly secure, advanced whip used for three-strand ropes. The twine is actually passed between the strands of the rope so it can never slide off."
        ]
      },
      {
        "type": "heading",
        "text": "SPLICING"
      },
      {
        "type": "bullets",
        "items": [
          "Eye Splice: Unlaying the end of a rope and weaving the strands back into the standing part to create a permanent, incredibly strong loop.",
          "Back Splice: Weaving the strands back into the rope itself (without making a loop) to create a thick, un-frayable end. Often started with a Crown Knot.",
          "Short Splice: Used to permanently join two ropes together by unlaying their ends and weaving the strands into each other."
        ]
      }
    ]
  },
  {
    "title": "SELF MEASUREMENT",
    "subtitle": "Human Ruler Tools",
    "icon": Icons.front_hand_rounded,
    "colors": [const Color(0xFF90CAF9), const Color(0xFF42A5F5)],
    "shadowColor": const Color(0xFF42A5F5),
    "content": [
      {
        "type": "alert",
        "text": "EXAM POINT: A Scout/Guide must memorize their personal measurements to calculate distances and heights during the Estimation practical."
      },
      {
        "type": "heading",
        "text": "KNOW YOUR MEASUREMENTS"
      },
      {
        "type": "bullets",
        "items": [
          "Pace: The length of one normal walking step (measured from heel to heel). Used for measuring distance on the ground.",
          "Span: The maximum distance from the tip of the thumb to the tip of the little finger when the hand is fully stretched.",
          "Cubit: The distance from the point of the elbow to the tip of the middle finger.",
          "Reach (Fathom): The distance from the fingertips of the right hand to the fingertips of the left hand when arms are stretched out horizontally. (Usually roughly equal to your height)."
        ]
      },
      {
        "type": "heading",
        "text": "HOW TO USE THEM"
      },
      {
        "type": "text",
        "text": "If your 'Span' is exactly 8 inches, and a log requires 6 full hand spans to cover its length, you can easily estimate the log is 48 inches (4 feet) long without a tape measure."
      }
    ]
  },
  {
    "title": "NATIONAL SYMBOLS",
    "subtitle": "General Knowledge",
    "icon": Icons.account_balance_rounded,
    "colors": [const Color(0xFF81C784), const Color(0xFF388E3C)],
    "shadowColor": const Color(0xFF388E3C),
    "content": [
      {
        "type": "heading",
        "text": "OUR IDENTITIES"
      },
      {
        "type": "bullets",
        "items": [
          "National Emblem: The Lion Capital of Ashoka at Sarnath (Features four Asiatic lions, Dharma Chakra, Bull, and Horse).",
          "National Motto: 'Satyameva Jayate' (Truth Alone Triumphs), taken from the Mundaka Upanishad.",
          "National Animal: The Royal Bengal Tiger (Panthera tigris).",
          "National Bird: The Indian Peacock (Pavo cristatus).",
          "National Flower: The Lotus (Nelumbo nucifera).",
          "National Tree: The Banyan Tree (Ficus benghalensis).",
          "National Anthem: 'Jana Gana Mana' by Rabindranath Tagore (Play time: 52 seconds).",
          "National Song: 'Vande Mataram' by Bankim Chandra Chatterjee."
        ]
      }
    ]
  }
];

/// The primary navigation screen for the Study Notes module.
///
/// Implements a highly responsive grid layout that adapts the cross-axis count 
/// based on the device width, ensuring a consistent premium look across mobile, 
/// tablet, and desktop views.
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  /// Opens the dynamic BottomSheet modal populated with the specific topic's data.
  void _openNoteDetails(Map<String, dynamic> data, double width) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NoteDetailModal(data: data, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      
      // Frosted Glass Custom App Bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.02),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text("STUDY NOTES", style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 16))),
              centerTitle: true,
            ),
          ),
        ),
      ),
      
      // Dynamic Grid Body
      body: SmoothGradientBackground(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > 600 ? 3 : 2, // Scales up for tablet/web
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: notesData.length,
                itemBuilder: (context, index) {
                  final item = notesData[index];
                  return _PremiumGlossyCard(
                    data: item,
                    width: width,
                    onTap: () => _openNoteDetails(item, width),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBannerAd(),
    );
  }
}

/// A highly stylized UI card representing a single study topic in the grid.
///
/// Utilizes a layered [Stack] architecture to create a glowing ambient "orb" 
/// in the top right corner of the card, derived from the topic's unique `shadowColor`.
class _PremiumGlossyCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final double width;
  final VoidCallback onTap;

  const _PremiumGlossyCard({
    required this.data,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color accent = data['shadowColor'];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              
              // Ambient Glow Orb
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 120, height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: accent.withOpacity(0.3), blurRadius: 50, spreadRadius: 20)
                    ],
                  ),
                ),
              ),
              
              // Text and Icon Content Layer
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    // Glass Icon Bubble
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: accent.withOpacity(0.5)),
                      ),
                      child: Icon(data['icon'], color: accent, size: 28),
                    ),

                    // Title Information
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'],
                          maxLines: 2,
                          style: AppTheme.heading(width).copyWith(
                              fontSize: AppTheme.scaleText(width, 16),
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              height: 1.2
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data['subtitle'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.bodyText(width).copyWith(
                              fontSize: AppTheme.scaleText(width, 12),
                              color: Colors.white54,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The interactive modal displaying the full content for a selected study topic.
///
/// This widget acts as the master framework, setting up the structural glassmorphism 
/// background and the fixed header. It delegates the actual rendering of the topic 
/// body to the `_buildContentParser` method.
class _NoteDetailModal extends StatelessWidget {
  final Map<String, dynamic> data;
  final double width;

  const _NoteDetailModal({required this.data, required this.width});

  @override
  Widget build(BuildContext context) {
    List<dynamic> contentBlocks = data['content'];
    Color themeColor = data['shadowColor']; 

    return Container(
      height: MediaQuery.of(context).size.height * 0.90, // Occupies 90% of screen height
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: Stack(
          children: [
            
            // Dark Gradient Base Background
            const Positioned.fill(
              child: SmoothGradientBackground(child: SizedBox()),
            ),

            // Oversized Background Watermark Icon
            Positioned(
              top: 80,
              right: -80,
              child: Opacity(
                opacity: 0.04,
                child: Transform.rotate(
                  angle: -0.2,
                  child: Icon(data['icon'], size: 350, color: themeColor),
                ),
              ),
            ),

            // Master Glassmorphism Filter
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    border: Border(top: BorderSide(color: Colors.white.withOpacity(0.2), width: 1.5)),
                  ),
                ),
              ),
            ),

            // Fixed Modal Header & Drag Handle
            Positioned(
              top: 16, left: 0, right: 0,
              child: Column(
                children: [
                  Container(
                    width: 50, height: 5,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: themeColor.withOpacity(0.15),
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: themeColor.withOpacity(0.3), blurRadius: 15)],
                              border: Border.all(color: themeColor.withOpacity(0.6), width: 1.5)
                          ),
                          child: Icon(data['icon'], color: themeColor, size: 28),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data['subtitle'].toString().toUpperCase(), style: AppTheme.badgeText(width, themeColor).copyWith(letterSpacing: 2, fontSize: 11)),
                              Text(data['title'], style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 24), fontWeight: FontWeight.w900)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.close_rounded, color: Colors.white, size: 24)
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.white.withOpacity(0.1), height: 1, thickness: 1),
                ],
              ),
            ),

            // Scrollable Content Region powered by the Content Parser
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
                itemCount: contentBlocks.length,
                itemBuilder: (context, index) {
                  return _buildContentParser(contentBlocks[index], width, themeColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The Core Content Parsing Engine.
  ///
  /// Analyzes the string value of the `type` key within the JSON-like data block 
  /// and translates it into the appropriate, fully styled Flutter layout widget.
  Widget _buildContentParser(Map<String, dynamic> block, double width, Color accent) {
    String type = block['type'] ?? 'text';

    if (type == 'heading') {
      return Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 16),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: accent.withOpacity(0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: accent.withOpacity(0.5))),
              child: Icon(Icons.menu_book_rounded, color: accent, size: 16),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                block['text'],
                style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 18), letterSpacing: 1.5, color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      );
    }
    else if (type == 'text') {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Text(
          block['text'],
          style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 16), height: 1.6, color: Colors.white.withOpacity(0.9)),
        ),
      );
    }
    else if (type == 'bullets') {
      List<dynamic> items = block['items'] ?? [];
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Column(
          children: items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 14),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: accent.withOpacity(0.2), shape: BoxShape.circle),
                    child: Icon(Icons.arrow_forward_ios_rounded, color: accent, size: 10),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.toString(),
                    style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 16), height: 1.5, color: Colors.white.withOpacity(0.9)),
                  ),
                ),
              ],
            ),
          )).toList(),
        ),
      );
    }
    else if (type == 'alert') {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [Color(0xFF2A220A), Color(0xFF141002)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.6), width: 1.5),
          boxShadow: [
            BoxShadow(color: const Color(0xFFFFD54F).withOpacity(0.15), blurRadius: 20, spreadRadius: 1)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD54F).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.stars_rounded, color: Color(0xFFFFD54F), size: 20),
                ),
                const SizedBox(width: 14),
                Text(
                  "RAJYAPURASKAR EXAM POINT",
                  style: AppTheme.badgeText(width, const Color(0xFFFFD54F)).copyWith(fontSize: AppTheme.scaleText(width, 12), letterSpacing: 1.5),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              // Removes redundant prefix from raw data if present
              block['text'].toString().replaceAll("EXAM POINT: ", ""),
              style: AppTheme.bodyText(width).copyWith(
                  fontSize: AppTheme.scaleText(width, 15),
                  color: Colors.white,
                  height: 1.6,
                  fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
      );
    }
    else if (type == 'compass_diagram') {
      return Container(
        height: 320,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
        ),
        child: CustomPaint(
          size: const Size(double.infinity, 320),
          painter: CompassRosePainter(color: accent, width: width),
        ),
      );
    }

    return const SizedBox.shrink(); // Fallback for undefined types
  }
}

/// A highly mathematical, programmatic custom painter that draws a complete 16-point 
/// Navigation Compass Rose dynamically via the Canvas API.
///
/// Eliminates the need for a static image asset, allowing the compass to infinitely 
/// scale and dynamically match the exact theme color of the active note.
class CompassRosePainter extends CustomPainter {
  final Color color;
  final double width;
  
  CompassRosePainter({required this.color, required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width > size.height ? size.height / 2.5 : size.width / 2.5;

    final strokePaint = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    // Outer and Inner Track Rings
    canvas.drawCircle(center, radius, strokePaint);
    canvas.drawCircle(center, radius * 0.9, strokePaint);
    canvas.drawCircle(center, radius * 0.2, fillPaint);
    canvas.drawCircle(center, radius * 0.2, strokePaint);

    // Minor Background Star (Ordinal Points: NE, SE, SW, NW)
    // Offset by 45 degrees (pi/4) from the primary axis
    _drawStar(canvas, center, radius * 0.65, radius * 0.15, math.pi / 4, color.withOpacity(0.5));

    // Major Foreground Star (Cardinal Points: N, E, S, W)
    _drawStar(canvas, center, radius * 0.9, radius * 0.15, 0.0, color);

    // Cardinal Text Label Placement
    _drawText(canvas, center, radius * 1.15, "N", -math.pi / 2, color);
    _drawText(canvas, center, radius * 1.15, "E", 0.0, color);
    _drawText(canvas, center, radius * 1.15, "S", math.pi / 2, color);
    _drawText(canvas, center, radius * 1.15, "W", math.pi, color);
  }

  /// Calculates and draws a complex 4-pointed star (an 8-point polygon) using sine and cosine trigonometry.
  void _drawStar(Canvas canvas, Offset center, double outerRadius, double innerRadius, double rotation, Color c) {
    final paint = Paint()
      ..color = c
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = color.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    Path path = Path();
    for (int i = 0; i < 8; i++) {
      double angle = rotation + (i * math.pi / 4);
      // Alternates between the outer peak radius and the inner valley radius
      double r = (i % 2 == 0) ? outerRadius : innerRadius;
      
      // Calculate cartesian coordinates from polar components
      Offset point = Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    
    // Renders the solid shape then overlays the border
    canvas.drawPath(path, paint);
    canvas.drawPath(path, stroke);
  }

  /// Calculates text bounds and paints the directional label relative to the center origin.
  void _drawText(Canvas canvas, Offset center, double radius, String text, double angle, Color c) {
    final textStyle = TextStyle(
      color: c,
      fontSize: AppTheme.scaleText(width, 22),
      fontWeight: FontWeight.w900,
    );
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    
    textPainter.layout();

    // Adjusts the exact position by subtracting half the text width/height to perfectly center the string
    final offset = Offset(
      center.dx + radius * math.cos(angle) - textPainter.width / 2,
      center.dy + radius * math.sin(angle) - textPainter.height / 2,
    );
    
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
