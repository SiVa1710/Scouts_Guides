import 'package:flutter/material.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A dynamic, paginated screen displaying detailed information about various Scouting and National flags.
///
/// This screen uses a [PageView] to allow users to swipe left and right between flags. 
/// It implements a "pseudo-infinite scroll" technique by setting a high initial page index, 
/// allowing the user to swipe backward infinitely without hitting a hard limit on index 0.
class FlagsScreen extends StatefulWidget {
  const FlagsScreen({super.key});

  @override
  State<FlagsScreen> createState() => _FlagsScreenState();
}

class _FlagsScreenState extends State<FlagsScreen> {
  late PageController _pageController;
  
  // Starting at 1000 allows for pseudo-infinite swiping in both directions
  final int _initialPage = 1000; 
  int _currentIndex = 0;

  /// The primary data source containing details, assets, and styling for each flag.
  ///
  /// Each flag map contains an `accentColor` which drives the theme of the entire page 
  /// (background gradients, badges, and bullet points) to create a cohesive visual experience.
  final List<Map<String, dynamic>> flagData = const [
    {
      "name": "NATIONAL FLAG",
      "ratio": "3:2",
      "asset": "assets/images/Indianflag.png",
      "accentColor": Color(0xFFFF9933),
      "bullets": [
        "[ DESIGN ] Shape is strictly Rectangular with a 3:2 ratio.",
        "[ DESIGN ] Standard display size is 180 cm X 120 cm.",
        "[ MATERIAL ] By law, the flag must be made of Khadi (hand-spun cotton/silk).",
        "[ SYMBOLISM ] Saffron (Top): Represents strength, courage, and sacrifice.",
        "[ SYMBOLISM ] White (Middle): Represents peace, purity, and truth.",
        "[ SYMBOLISM ] Green (Bottom): Represents fertility, growth, and auspiciousness.",
        "[ EMBLEM ] The Ashoka Chakra features 24 spokes, representing 24 hours of progress.",
        "[ HISTORY ] Adopted on 22nd July 1947; fundamental design by Pingali Venkayya.",
        "[ RULE ] In a line of multiple flags, the National Flag must be on the extreme right.",
        "[ TECHNIQUE ] It is 'Hoisted' on Aug 15 and 'Unfurled' (tied at top) on Jan 26.",
        "[ RULE ] The flag must always be hoisted briskly and lowered slowly and ceremoniously."
      ]
    },
    {
      "name": "WORLD SCOUT FLAG",
      "ratio": "3:2",
      "asset": "assets/images/worldscout.jpg",
      "accentColor": Color(0xFF702082),
      "bullets": [
        "[ DESIGN ] Features a pure white emblem on a Royal Purple background.",
        "[ SYMBOLISM ] Royal Purple represents leadership, service, and dignity.",
        "[ SYMBOLISM ] White represents ultimate purity of heart and intent.",
        "[ SYMBOLISM ] The encircling Rope represents the family of the World Scout Movement.",
        "[ SYMBOLISM ] The Reef Knot at the bottom symbolizes unbroken World Brotherhood.",
        "[ SYMBOLISM ] The Two Stars represent the Scout Law and the Scout Promise.",
        "[ SYMBOLISM ] The 10 points of the two stars represent the 10 original Scout Laws.",
        "[ SYMBOLISM ] The central Compass Needle always points upwards, showing the true way.",
        "[ HISTORY ] Officially adopted in 1951 at the 13th World Scout Conference in Lisbon."
      ]
    },
    {
      "name": "WORLD GUIDE FLAG",
      "ratio": "3:2",
      "asset": "assets/images/guideflag.jpg",
      "accentColor": Color(0xFFFFC400),
      "bullets": [
        "[ SYMBOLISM ] The Blue background represents the sky that covers all children.",
        "[ SYMBOLISM ] The Gold elements represent the sun shining over the world.",
        "[ SYMBOLISM ] The Central Vein acts as a compass needle pointing the way.",
        "[ SYMBOLISM ] The Base Flame represents the eternal love of humanity.",
        "[ DESIGN ] The Three Trefoils signify the three-fold Guide Promise.",
        "[ DESIGN ] The Three Squares embedded inside reinforce the 3-fold Promise.",
        "[ SYMBOLISM ] The White Blaze in the corner represents world-wide peace.",
        "[ SYMBOLISM ] The patterned Border symbolizes a constantly growing movement.",
        "[ HISTORY ] It represents the World Association of Girl Guides and Girl Scouts (WAGGGS)."
      ]
    },
    {
      "name": "BS&G FLAG",
      "ratio": "3:2",
      "asset": "assets/images/bsg.jpg",
      "accentColor": Color(0xFF0072C6),
      "bullets": [
        "[ COMPOSITION ] Union of the Fleur-de-lis (Scouts) and the Trefoil (Guides).",
        "[ EMBLEM ] Superimposed on the Ashoka Chakra to root the movement to Bharat (India).",
        "[ DESIGN ] Standard Association Size is 180 cm X 120 cm.",
        "[ DESIGN ] Standard Troop/Company Size is smaller at 120 cm X 80 cm.",
        "[ SYMBOLISM ] Dark Sky Blue background signifies vastness and inclusivity.",
        "[ SYMBOLISM ] The Yellow central emblem signifies optimism and energy.",
        "[ RULE ] This flag is hoisted at all official Bharat Scouts and Guides camps and rallies."
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    
    // Modulo operation ensures we map the infinite index back to our fixed list bounds
    _currentIndex = _initialPage % flagData.length;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureBlack,
      body: Center(
        child: ConstrainedBox(
          // Prevents the UI from stretching uncomfortably on wide tablet/web screens
          constraints: const BoxConstraints(maxWidth: 800),
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentIndex = index % flagData.length),
            itemBuilder: (context, index) {
              int actualIndex = index % flagData.length;
              return FlagReaderView(
                flagData: flagData[actualIndex],
                currentIndex: actualIndex,
                totalFlags: flagData.length,
                width: MediaQuery.of(context).size.width > 800 ? 800 : MediaQuery.of(context).size.width,
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A highly polished view rendering the details for a single flag.
///
/// Features include:
/// * Dynamic radial gradients based on the flag's specific accent color.
/// * A subtle, oversized background watermark of the flag behind the text.
/// * A custom text parser (`_buildRichBullet`) that automatically highlights tags (e.g., [ DESIGN ]).
/// * A `ShaderMask` to smoothly fade out the text at the top and bottom of the scroll view.
class FlagReaderView extends StatelessWidget {
  final Map<String, dynamic> flagData;
  final int currentIndex;
  final int totalFlags;
  final double width;

  const FlagReaderView({
    super.key, 
    required this.flagData, 
    required this.currentIndex, 
    required this.totalFlags, 
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final Color accent = flagData['accentColor'] ?? Colors.blue;

    return Stack(
      children: [
        // Dynamic Radial Gradient Background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.4),
                radius: 1.3,
                colors: [accent.withOpacity(0.35), AppTheme.pureBlack],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              
              // Top Navigation Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    Text("FLAGS", style: AppTheme.navTitle(width)),
                  ],
                ),
              ),
              
              // Hero Image Display
              SizedBox(
                height: height * 0.30,
                child: Center(
                  child: Container(
                    width: width * 0.70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: accent.withOpacity(0.25), blurRadius: 40, offset: const Offset(0, 10)),
                        BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 15, offset: const Offset(0, 10))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(flagData['asset'], fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              
              // Content Container (Bottom Sheet Style)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF14141A), // Deep off-black for premium contrast
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
                    border: Border(top: BorderSide(color: Colors.white.withOpacity(0.08), width: 1.5)),
                  ),
                  child: Stack(
                    children: [
                      
                      // Subtle watermark graphic in the bottom right
                      Positioned(
                        right: -50, bottom: -20,
                        child: Opacity(
                          opacity: 0.02,
                          child: Transform.rotate(
                            angle: -0.2,
                            child: Image.asset(flagData['asset'], width: width * 0.9, fit: BoxFit.contain),
                          ),
                        ),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildIndicator(accent),
                          
                          // Header Texts
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    flagData['name'],
                                    style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 28))
                                ),
                                const SizedBox(height: 10),
                                _buildRatioBadge(flagData['ratio'], width, accent),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          
                          // Scrollable Details List with Fade Effect
                          Expanded(
                            child: ShaderMask(
                              // Creates a soft fade-out at the top and bottom edges of the list
                              shaderCallback: (Rect rect) => const LinearGradient(
                                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                                stops: [0.0, 0.05, 0.95, 1.0],
                              ).createShader(rect),
                              blendMode: BlendMode.dstIn,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(left: 30, right: 20, bottom: 20),
                                physics: const BouncingScrollPhysics(),
                                itemCount: flagData['bullets'].length,
                                itemBuilder: (context, i) => _buildRichBullet(flagData['bullets'][i], width, accent),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a highly visible badge showcasing the official ratio of the flag.
  Widget _buildRatioBadge(String ratio, double width, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text("OFFICIAL RATIO $ratio", style: AppTheme.badgeText(width, color)),
    );
  }

  /// Renders the pagination dots, expanding and highlighting the active page.
  Widget _buildIndicator(Color color) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalFlags, (index) {
            bool active = currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              height: 6, width: active ? 24 : 8,
              decoration: BoxDecoration(
                color: active ? color : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                boxShadow: active ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8)] : [],
              ),
            );
          }),
        ),
      ),
    );
  }

  /// A custom text parser that extracts bracketed tags (e.g. `[ DESIGN ]`) 
  /// and applies distinct styling to them, separate from the rest of the text.
  Widget _buildRichBullet(String fullText, double width, Color accent) {
    String tag = "";
    String content = fullText;
    
    // Simple parsing logic to detect brackets at the start of the string
    if (fullText.startsWith("[")) {
      int closingBracket = fullText.indexOf("]");
      if (closingBracket != -1) {
        tag = fullText.substring(0, closingBracket + 1);
        content = fullText.substring(closingBracket + 1).trim();
      }
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom stylized bullet point arrow
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: accent.withOpacity(0.2), shape: BoxShape.circle),
              child: Icon(Icons.arrow_forward_ios_rounded, color: accent, size: 10),
            ),
          ),
          const SizedBox(width: 15),
          
          // RichText allows for combining multiple text styles within a single paragraph flow
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTheme.bodyText(width).copyWith(
                    fontSize: AppTheme.scaleText(width, 16),
                    height: 1.6,
                    color: Colors.white.withOpacity(0.85)
                ),
                children: [
                  if (tag.isNotEmpty)
                    TextSpan(
                      text: "$tag  ",
                      style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 14)),
                    ),
                  TextSpan(text: content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
