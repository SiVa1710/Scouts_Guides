import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A static data dictionary defining the official uniform regulations for Scouts.
///
/// Organized by anatomical category, this list provides detailed descriptions 
/// of required clothing and accessories, along with crucial, conditionally rendered 
/// Rajyapuraskar exam tips to highlight strict uniform compliance rules.
final List<Map<String, dynamic>> scoutUniformData = [
  {
    "category": "HEAD & NECK",
    "icon": Icons.face_rounded,
    "accent": const Color(0xFF64B5F6),
    "items": [
      {
        "title": "Head-Dress",
        "desc": "Dark blue beret cap with the official National Association badge. A Sikh may wear a blue turban with the official badge.",
        "exam": "The head-dress is strictly mandatory during all ceremonies."
      },
      {
        "title": "Scarf",
        "desc": "A triangular scarf (70cm to 80cm sides) in the Group's color (excluding green, purple, or yellow). Worn with shoulder straps and the Group woggle.",
      },
    ]
  },
  {
    "category": "TORSO & CLOTHING",
    "icon": Icons.checkroom_rounded,
    "accent": const Color(0xFF81C784),
    "items": [
      {
        "title": "Shirt",
        "desc": "Steel grey shirt with two patch pockets and shoulder straps. Sleeves can be half or rolled up.",
      },
      {
        "title": "Lower Body",
        "desc": "Navy blue shorts or trousers with two side pockets and one back pocket. Moderate fit.",
        "exam": "Trousers are compulsory during the Rashtrapati Scout Testing Camp and Award Rally."
      },
      {
        "title": "Belt",
        "desc": "Grey Nylex belt featuring the official buckle of the Bharat Scouts & Guides.",
      },
    ]
  },
  {
    "category": "BADGES (FRONT)",
    "icon": Icons.shield_rounded,
    "accent": const Color(0xFFFFD54F),
    "items": [
      {
        "title": "Membership Badge",
        "desc": "Green background with a yellow Fleur-de-lis, superimposed by the Trefoil and Ashoka Chakra.",
        "exam": "Worn in the center of the pleat of the LEFT pocket of the shirt."
      },
      {
        "title": "World Scout Badge",
        "desc": "The official WOSM badge.",
        "exam": "Worn in the center of the pleat of the RIGHT pocket of the shirt."
      },
      {
        "title": "BSG Stripe",
        "desc": "Size: 11 cm x 2 cm. Features the tricolor on the right corner.",
        "exam": "Worn just above the RIGHT pocket of the shirt."
      },
    ]
  },
  {
    "category": "SLEEVES & SHOULDERS",
    "icon": Icons.military_tech_rounded,
    "accent": const Color(0xFFBA68C8),
    "items": [
      {
        "title": "Shoulder Badge",
        "desc": "White background with a red border (6-8 cm x 1.5 cm) displaying the group name.",
        "exam": "Worn on both shoulders just below the seam with a slight curve."
      },
      {
        "title": "Shoulder Stripes",
        "desc": "Two stripes (5cm x 1.5cm) indicating the patrol color, stitched horizontally 2cm apart on a square steel grey cloth.",
        "exam": "Worn at the top of the LEFT sleeve, immediately below the Shoulder Badge."
      },
    ]
  },
  {
    "category": "FOOTWEAR",
    "icon": Icons.directions_walk_rounded,
    "accent": const Color(0xFFE57373),
    "items": [
      {
        "title": "Socks",
        "desc": "Black socks or stockings. If stockings are worn with shorts, they should be rolled down below the knees with green garter tabs visible.",
      },
      {
        "title": "Shoes",
        "desc": "Black leather or canvas shoes with laces.",
      },
    ]
  }
];

/// A static data dictionary defining the official uniform regulations for Guides.
///
/// Mirrors the structure of [scoutUniformData] but provides the specific apparel,
/// accessory, and badge placement guidelines unique to the Guide wing.
final List<Map<String, dynamic>> guideUniformData = [
  {
    "category": "CLOTHING OPTIONS",
    "icon": Icons.checkroom_rounded,
    "accent": const Color(0xFF4FC3F7),
    "items": [
      {
        "title": "Overall / Dress",
        "desc": "Deep sky blue overall/dress with two patch pockets, open sports collar, and epaulettes on both shoulders.",
      },
      {
        "title": "Salwar Kameez",
        "desc": "Deep sky blue Salwar and light blue Kameez (knee length) with a deep sky blue Dupatta.",
      },
      {
        "title": "Midi Skirt & Blouse",
        "desc": "Deep sky blue skirt (mid-calf length) with a white blouse (8cm below waistline).",
      },
    ]
  },
  {
    "category": "ACCESSORIES",
    "icon": Icons.stars_rounded,
    "accent": const Color(0xFFFFB74D),
    "items": [
      {
        "title": "Belt",
        "desc": "Brown Nylex belt with the official brass buckle.",
        "exam": "Scouts wear a Grey belt; Guides wear a Brown belt. Do not confuse the two."
      },
      {
        "title": "Scarf",
        "desc": "Triangular (70-80cm sides) in Group color (excluding green, purple, yellow). Worn with Group woggle.",
      },
      {
        "title": "Sash",
        "desc": "Deep sky blue sash, 10 cm in width. Displays Proficiency Badges in ascending order.",
        "exam": "Worn on the LEFT shoulder across the chest, resting below the hip on the right side."
      },
    ]
  },
  {
    "category": "BADGES",
    "icon": Icons.shield_rounded,
    "accent": const Color(0xFFF06292),
    "items": [
      {
        "title": "Membership Badge",
        "desc": "Green background with yellow Fleur-de-lis, Trefoil, and Ashoka Chakra.",
        "exam": "Guides wear this in the MIDDLE of the LEFT SLEEVE (Scouts wear it on the left pocket)."
      },
      {
        "title": "World Guide Badge",
        "desc": "The official WAGGGS badge.",
        "exam": "Worn in the MIDDLE of the RIGHT SLEEVE."
      },
      {
        "title": "Patrol Emblem",
        "desc": "Embroidered on a black background with a green border (4 cm in diameter).",
        "exam": "Worn in the CENTER of the TOP of the SASH."
      },
    ]
  },
  {
    "category": "FOOTWEAR & HAIR",
    "icon": Icons.face_retouching_natural_rounded,
    "accent": const Color(0xFF4DB6AC),
    "items": [
      {
        "title": "Socks & Shoes",
        "desc": "White socks with black leather or black canvas closed shoes with a buckle.",
      },
      {
        "title": "Hair Ribbon",
        "desc": "Black plain ribbon or black plain hair band without any design.",
      },
    ]
  }
];

/// A dual-mode screen detailing uniform specifications.
///
/// This widget acts as a unified hub for both Scout and Guide uniform rules. 
/// It utilizes a custom, animated tab switcher to toggle between the two data 
/// contexts dynamically, seamlessly swapping out content and theme colors.
class Uniform extends StatefulWidget {
  const Uniform({super.key});

  @override
  State<Uniform> createState() => _UniformState();
}

class _UniformState extends State<Uniform> {
  /// Core state variable dictating the active data source and theme colors.
  /// `true` equates to the Scout context, `false` equates to the Guide context.
  bool _isScout = true; 

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    // Dynamically assign the data source based on the active state
    List<Map<String, dynamic>> currentData = _isScout ? scoutUniformData : guideUniformData;

    // Dynamically assign theme colors (Deep Blue for Scouts, Sky Blue for Guides)
    Color activeThemeColor = _isScout ? const Color(0xFF2E6BFF) : const Color(0xFF03A9F4); 

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SmoothGradientBackground(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  
                  // Top Navigation Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24),
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Text(
                            "UNIFORM",
                            style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 16))
                        ),
                      ],
                    ),
                  ),

                  // Custom Animated Tab Switcher
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          
                          // Scout Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() => _isScout = true);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutQuart,
                                decoration: BoxDecoration(
                                  color: _isScout ? const Color(0xFF2E6BFF) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: _isScout ? [BoxShadow(color: const Color(0xFF2E6BFF).withOpacity(0.4), blurRadius: 15)] : [],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "SCOUT",
                                  style: AppTheme.heading(width).copyWith(
                                      fontSize: AppTheme.scaleText(width, 14),
                                      color: _isScout ? Colors.white : Colors.white54,
                                      fontWeight: _isScout ? FontWeight.w900 : FontWeight.w600,
                                      letterSpacing: 2
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          // Guide Tab
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                setState(() => _isScout = false);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutQuart,
                                decoration: BoxDecoration(
                                  color: !_isScout ? const Color(0xFF03A9F4) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(26),
                                  boxShadow: !_isScout ? [BoxShadow(color: const Color(0xFF03A9F4).withOpacity(0.4), blurRadius: 15)] : [],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "GUIDE",
                                  style: AppTheme.heading(width).copyWith(
                                      fontSize: AppTheme.scaleText(width, 14),
                                      color: !_isScout ? Colors.white : Colors.white54,
                                      fontWeight: !_isScout ? FontWeight.w900 : FontWeight.w600,
                                      letterSpacing: 2
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Scrollable Content Region
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      switchInCurve: Curves.easeOutQuart,
                      switchOutCurve: Curves.easeInQuart,
                      transitionBuilder: (child, animation) {
                        // Applies a synchronized fade and upward slide to the incoming list
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      
                      // Using ValueKey forces Flutter to destroy and rebuild the ListView 
                      // when the state changes, triggering the AnimatedSwitcher transition.
                      child: ListView.builder(
                        key: ValueKey<bool>(_isScout),
                        padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 50),
                        physics: const BouncingScrollPhysics(),
                        itemCount: currentData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: _buildUniformCard(currentData[index], width, activeThemeColor),
                          );
                        },
                      ),
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

  /// Constructs a premium, glassmorphic card for a specific uniform category.
  ///
  /// This component parses the underlying data dictionary, dynamically generating 
  /// layout blocks for the title, description, and applying conditional rendering 
  /// for high-contrast Rajyapuraskar exam badges if present in the dataset.
  Widget _buildUniformCard(Map<String, dynamic> data, double width, Color themeColor) {
    final Color accent = data['accent'];
    final List<dynamic> items = data['items'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.2),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Card Header (Title & Icon)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.08), width: 1.5)),
                    gradient: LinearGradient(
                      colors: [accent.withOpacity(0.15), Colors.transparent],
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                    )
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accent.withOpacity(0.5)),
                      ),
                      child: Icon(data['icon'], color: accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      data['category'],
                      style: AppTheme.heading(width).copyWith(
                          fontSize: AppTheme.scaleText(width, 16),
                          letterSpacing: 2,
                          fontWeight: FontWeight.w900,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),

              // Card Body (Sub-items and descriptions)
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: items.map((item) {
                    bool isLast = items.indexOf(item) == items.length - 1;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          // Item Title & Main Description
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5, right: 14),
                                child: Container(
                                  width: 8, height: 8,
                                  decoration: BoxDecoration(
                                      color: accent,
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(color: accent.withOpacity(0.8), blurRadius: 6)]
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: AppTheme.heading(width).copyWith(
                                        fontSize: AppTheme.scaleText(width, 18),
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item['desc'],
                                      style: AppTheme.bodyText(width).copyWith(
                                        fontSize: AppTheme.scaleText(width, 15),
                                        height: 1.5,
                                        color: Colors.white.withOpacity(0.75),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Conditional Rendering: Rajyapuraskar Exam Point
                          if (item.containsKey('exam'))
                            Padding(
                              padding: const EdgeInsets.only(top: 14, left: 22),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD54F).withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.3)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.stars_rounded, color: Color(0xFFFFD54F), size: 18),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "EXAM POINT",
                                            style: AppTheme.badgeText(width, const Color(0xFFFFD54F)).copyWith(
                                                fontSize: AppTheme.scaleText(width, 10),
                                                letterSpacing: 1.5
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item['exam'],
                                            style: AppTheme.bodyText(width).copyWith(
                                                fontSize: AppTheme.scaleText(width, 14),
                                                color: Colors.white.withOpacity(0.95),
                                                height: 1.4,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
