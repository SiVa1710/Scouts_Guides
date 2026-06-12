import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A comprehensive, searchable directory of First Aid guidelines.
///
/// This screen provides a highly interactive interface for users to browse and
/// search through emergency medical protocols. It utilizes a deep-search algorithm
/// to filter content and dynamically renders UI components based on a structured
/// data dictionary.
class FirstAidScreen extends StatefulWidget {
  const FirstAidScreen({super.key});

  @override
  State<FirstAidScreen> createState() => _FirstAidScreenState();
}

class _FirstAidScreenState extends State<FirstAidScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// The structured data dictionary powering the First Aid screen.
  ///
  /// Built using a nested JSON-like structure, this list defines the entire
  /// content of the screen. The custom parser in `SectionedGlassCard` reads 
  /// the "type" property of each block to dynamically generate the correct 
  /// Flutter widgets (e.g., timelines, checklists, alert boxes).
  final List<Map<String, dynamic>> firstAidData = const [
    {
      "title": "INTRODUCTION & RULES",
      "icon": Icons.health_and_safety_rounded,
      "accent": Color(0xFF4FC3F7),
      "sections": [
        {
          "tabName": "Aim",
          "blocks": [
            {
              "type": "bullets",
              "items": [
                "Preserve Life: The primary goal of all first aid is to save lives.",
                "Prevent Further Harm: Remove the casualty from danger and stabilize them.",
                "Promote Recovery: Provide reassurance and early treatment to aid healing."
              ]
            }
          ]
        },
        {
          "tabName": "Golden Rules",
          "blocks": [
            {
              "type": "timeline",
              "items": [
                {"title": "Act Calmly", "desc": "Prioritize immediate action without causing unnecessary panic."},
                {"title": "The ABC Rule", "desc": "Ensure an open Airway, check for Breathing, and assess Circulation."},
                {"title": "Control Bleeding", "desc": "Stop severe bleeding immediately and treat for shock."},
                {"title": "Do Not Move", "desc": "Never move a casualty with suspected spine or neck fractures unless in immediate danger."},
                {"title": "Reassure", "desc": "Keep the casualty warm, comfortable, and confident."}
              ]
            }
          ]
        }
      ]
    },
    {
      "title": "THE FIRST AID KIT",
      "icon": Icons.medical_services_rounded,
      "accent": Color(0xFFFF8A65),
      "sections": [
        {
          "tabName": "Kit Inventory",
          "blocks": [
            {
              "type": "alert",
              "text": "EXAM POINT: A Scout/Guide must always carry a clean, personal Triangular Bandage in their uniform."
            },
            {
              "heading": "Bandages & Dressings",
              "type": "checklist",
              "items": [
                "Roller Bandages (1\" & 2\")",
                "Triangular Bandages",
                "Sterile Gauze Pads (3x3\")",
                "Adhesive Plasters (Bandaids)",
                "Absorbent Cotton"
              ]
            },
            {
              "heading": "Instruments",
              "type": "checklist",
              "items": [
                "Medical Scissors",
                "Tweezers",
                "Safety Pins & Needles",
                "Clinical Thermometer",
                "Small Torch (w/ batteries)"
              ]
            },
            {
              "heading": "Medicines & Topicals",
              "type": "checklist",
              "items": [
                "Antiseptic (Dettol/Savlon)",
                "Burn Ointment",
                "Paracetamol & Ibuprofen",
                "ORS Packets",
                "Instant Ice Packs"
              ]
            }
          ]
        }
      ]
    },
    {
      "title": "WOUNDS & BLEEDING",
      "icon": Icons.bloodtype_rounded,
      "accent": Color(0xFFE57373),
      "sections": [
        {
          "tabName": "Types",
          "blocks": [
            {
              "type": "cards",
              "items": [
                {"title": "Incised (Clean Cut)", "desc": "Caused by sharp objects like knives or glass. Bleeds freely."},
                {"title": "Lacerated (Torn)", "desc": "Jagged edges caused by blunt trauma, machinery, or animal claws."},
                {"title": "Punctured (Stab)", "desc": "Deep, narrow hole (e.g., nail). High risk of tetanus and deep infection."},
                {"title": "Contused (Bruise)", "desc": "Damage to underlying tissues without breaking the skin surface."}
              ]
            }
          ]
        },
        {
          "tabName": "Treatment",
          "blocks": [
            {
              "type": "timeline",
              "items": [
                {"title": "Direct Pressure", "desc": "Apply firm, direct pressure over wound using a clean sterile pad."},
                {"title": "Elevation", "desc": "Elevate the injured limb above heart level to slow blood flow."},
                {"title": "Clean & Dress", "desc": "Wash minor wounds with soap/water. Apply antiseptic and bandage securely."},
                {"title": "Foreign Objects", "desc": "NEVER pull out deeply embedded objects. Pad around the object to stabilize it."}
              ]
            }
          ]
        },
        {
          "tabName": "Nosebleeds",
          "blocks": [
            {
              "type": "timeline",
              "heading": "Treatment Steps",
              "items": [
                {"title": "Sit & Lean Forward", "desc": "Prevents blood from flowing down the throat, which causes vomiting."},
                {"title": "Pinch the Nose", "desc": "Pinch the soft fleshy part of the nose for 10 continuous minutes."},
                {"title": "Breathe", "desc": "Instruct the casualty to breathe calmly through their mouth."},
                {"title": "Cooling", "desc": "Apply a cold compress or ice pack to the bridge of the nose or back of the neck."}
              ]
            }
          ]
        }
      ]
    },
    {
      "title": "BANDAGES & SLINGS",
      "icon": Icons.healing_rounded,
      "accent": Color(0xFFBA68C8),
      "sections": [
        {
          "tabName": "Bandages",
          "blocks": [
            {
              "type": "alert",
              "text": "EXAM POINT: All bandages in Scouting must be tied using a Reef Knot. It lies flat, is comfortable, and does not slip."
            },
            {
              "heading": "Triangular Bandage Folds",
              "type": "bullets",
              "items": [
                "Broad Bandage: Fold point to base, then fold in half again. Used to secure splints.",
                "Narrow Bandage: Fold a broad bandage in half again. Used for Collar & Cuff slings.",
                "Pad: Fold the two ends into the middle, and fold in half to form a compact pad for controlling bleeding."
              ]
            }
          ]
        },
        {
          "tabName": "Slings",
          "blocks": [
            {
              "type": "cards",
              "items": [
                {"title": "Large Arm Sling", "desc": "Supports the forearm horizontally. Used for forearm or wrist injuries. The point of the bandage is pinned at the elbow."},
                {"title": "St. John Sling", "desc": "Keeps the hand elevated securely towards the opposite shoulder. Used for collarbone fractures or bleeding hands."},
                {"title": "Collar & Cuff", "desc": "Uses a narrow bandage with a Clove Hitch around the wrist, tied around the neck. Allows the elbow to hang free. Used for upper arm fractures."}
              ]
            }
          ]
        },
        {
          "tabName": "Stretchers",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Improvised Stretchers",
              "items": [
                "Method 1: Pass two strong poles through the sleeves of two uniform shirts or heavy coats buttoned inside out.",
                "Method 2: Pass two poles through the bottom corners of strong jute sacks.",
                "Method 3: Roll the edges of a strong rug, carpet, or tarpaulin tightly around two poles."
              ]
            }
          ]
        }
      ]
    },
    {
      "title": "FRACTURES & SPRAINS",
      "icon": Icons.personal_injury_rounded,
      "accent": Color(0xFFFFD54F),
      "sections": [
        {
          "tabName": "Fractures",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Types & Signs",
              "items": [
                "Closed Fracture: Bone is broken, but skin is intact.",
                "Open (Compound): Broken bone pierces the skin. High infection risk.",
                "Signs: Severe pain, swelling, deformity, unnatural movement, and 'Crepitus' (grating sound of bones)."
              ]
            },
            {
              "type": "alert",
              "text": "CAUTION: Never attempt to realign or push a broken bone back into place. Immobilize it exactly as found."
            }
          ]
        },
        {
          "tabName": "Treatment",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Immobilization",
              "items": [
                "Collarbone: Support arm in a St. John Sling. Bind the arm gently to the chest with a broad bandage.",
                "Upper Arm: Apply a Collar & Cuff sling. Do not bandage the elbow.",
                "Leg: Gently tie the injured leg to the uninjured leg at the ankles and knees. Place thick padding between the legs.",
                "Splints: Rigid supports used to prevent movement. Must extend beyond the joints above and below the fracture."
              ]
            }
          ]
        },
        {
          "tabName": "Sprains",
          "blocks": [
            {
              "type": "timeline",
              "heading": "R.I.C.E Method",
              "items": [
                {"title": "Rest", "desc": "Stop activity and rest the injured joint immediately."},
                {"title": "Ice", "desc": "Apply a cold compress or ice pack wrapped in a cloth to reduce swelling. Never apply ice directly to skin."},
                {"title": "Compress", "desc": "Apply a firm figure-of-eight bandage to support the joint."},
                {"title": "Elevate", "desc": "Keep the sprained joint elevated above heart level if possible."}
              ]
            }
          ]
        }
      ]
    },
    {
      "title": "BURNS, BITES & STINGS",
      "icon": Icons.local_fire_department_rounded,
      "accent": Color(0xFFFF9800),
      "sections": [
        {
          "tabName": "Burns",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Degrees of Burns",
              "items": [
                "1st Degree: Superficial. Redness and pain (e.g., sunburn).",
                "2nd Degree: Partial-thickness. Severe pain and blister formation.",
                "3rd Degree: Full-thickness. Pale, waxy, or charred skin. Nerve damage may prevent pain."
              ]
            },
            {
              "type": "timeline",
              "heading": "Treatment Steps",
              "items": [
                {"title": "Cooling", "desc": "Flush the burn with gentle, cool running water for at least 15 minutes to stop the burning process in deeper tissues."},
                {"title": "Dress", "desc": "Cover lightly with a sterile, non-fluffy dressing or cling film to prevent infection."},
                {"title": "Don'ts", "desc": "NEVER burst blisters. NEVER apply butter, grease, or ointments. NEVER remove clothing stuck to the burn."}
              ]
            }
          ]
        },
        {
          "tabName": "Bites",
          "blocks": [
            {
              "type": "timeline",
              "heading": "Snake Bite First Aid",
              "items": [
                {"title": "Rest", "desc": "Lay the casualty down immediately. Keep them perfectly still to slow the spread of venom."},
                {"title": "Bandage", "desc": "Apply a broad constrictive bandage firmly over the bite and wrap the entire limb."},
                {"title": "Transport", "desc": "Rush to the hospital. DO NOT suck the venom out or cut the wound."}
              ]
            },
            {
              "type": "timeline",
              "heading": "Dog Bite First Aid",
              "items": [
                {"title": "Wash", "desc": "Wash the wound thoroughly with soap and running water for 15 minutes to flush out saliva."},
                {"title": "Dress", "desc": "Cover with a clean, dry, sterile dressing."},
                {"title": "Vaccinate", "desc": "Seek immediate medical attention for anti-rabies vaccination."}
              ]
            }
          ]
        },
        {
          "tabName": "Stings",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Bee & Wasp Stings",
              "items": [
                "Remove Stinger: Scrape stingers out with a blunt edge (like a card). Do not pinch them, as it injects more venom.",
                "Bee Stings: Bee venom is acidic. Neutralize the area with Bicarbonate of Soda (Baking Soda).",
                "Wasp Stings: Wasp venom is alkaline. Neutralize the area with a mild acid like Vinegar or Lemon juice.",
                "Allergies: Monitor for severe swelling or breathing issues. Seek urgent medical help if an allergic reaction occurs."
              ]
            }
          ]
        }
      ]
    },
    {
      "title": "SHOCK & EMERGENCIES",
      "icon": Icons.bolt_rounded,
      "accent": Color(0xFFF06292),
      "sections": [
        {
          "tabName": "Shock & Fainting",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Medical Shock",
              "items": [
                "Shock is a life-threatening drop in blood flow to the brain and organs. Caused by severe bleeding, burns, or trauma.",
                "Signs: Pale, cold, clammy skin. Rapid but weak pulse. Shallow, rapid breathing. Dizziness and thirst."
              ]
            },
            {
              "type": "timeline",
              "heading": "Treatment for Shock & Fainting",
              "items": [
                {"title": "Lay Flat", "desc": "Lay the casualty down on their back immediately."},
                {"title": "Elevate Legs", "desc": "Raise their legs 12 inches above heart level to force blood back to the brain."},
                {"title": "Warmth", "desc": "Loosen tight clothing around the neck/chest and cover them with a blanket to maintain body heat."},
                {"title": "Fresh Air", "desc": "Ensure the casualty has plenty of fresh air. Do not crowd them."}
              ]
            }
          ]
        },
        {
          "tabName": "Choking",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Prevention & Assessment",
              "items": [
                "Common in children due to swallowing toys, coins, or large pieces of food (nuts, grapes, hot dogs).",
                "If the casualty is coughing loudly, encourage them to keep coughing. Do not interfere.",
                "If they cannot speak, breathe, or turn blue (cyanosis), immediate intervention is required."
              ]
            },
            {
              "type": "timeline",
              "heading": "First Aid for Choking (Over 1 Year Old)",
              "items": [
                {"title": "Back Blows", "desc": "Give 5 sharp blows between the shoulder blades with the heel of your hand."},
                {"title": "Abdominal Thrusts", "desc": "If unsuccessful, perform the Heimlich maneuver. Stand behind them, make a fist above the navel, and pull inward and upward 5 times."},
                {"title": "Unconsciousness", "desc": "If they lose consciousness, lay them on their back. Open the mouth to check for the object. Begin CPR."}
              ]
            }
          ]
        },
        {
          "tabName": "CPR",
          "blocks": [
            {
              "type": "alert",
              "text": "EXAM POINT: Memorize the DRSABCD protocol for Cardiac Arrest and Unconsciousness."
            },
            {
              "type": "timeline",
              "heading": "The DRSABCD Protocol",
              "items": [
                {"title": "D - Danger", "desc": "Ensure the area is safe for you, bystanders, and the casualty."},
                {"title": "R - Response", "desc": "Check for response. Tap their shoulders and shout 'Are you okay?'"},
                {"title": "S - Send for Help", "desc": "Call emergency services immediately (112 or 108)."},
                {"title": "A - Airway", "desc": "Open the mouth, clear any visible blockages, and tilt the head back gently to open the airway."},
                {"title": "B - Breathing", "desc": "Look, listen, and feel for normal breathing for 10 seconds."},
                {"title": "C - CPR", "desc": "If not breathing, start CPR. Give 30 firm chest compressions followed by 2 rescue breaths."},
                {"title": "D - Defibrillation", "desc": "Attach an AED (Defibrillator) as soon as available and follow voice prompts."}
              ]
            }
          ]
        },
        {
          "tabName": "Electric Shock",
          "blocks": [
            {
              "type": "bullets",
              "heading": "Electric Shock First Aid",
              "items": [
                "Signs: Burns at entry/exit points, muscle spasms, numbness, and unconsciousness.",
                "Turn off the power source immediately.",
                "Do NOT touch the victim with bare hands if they are still in contact with the live current.",
                "Stand on non-conductive materials (wood, rubber) and use a dry wooden stick to separate the victim from the source.",
                "Check breathing and begin CPR if necessary. Treat visible burns with cool running water."
              ]
            }
          ]
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Deep Search Algorithm:
    // Filters the modules by cross-referencing the search query against the module title, 
    // tab names, and the deeply nested block content.
    List<Map<String, dynamic>> displayedData = _searchQuery.isEmpty
        ? firstAidData
        : firstAidData.where((module) {
      final titleMatch = module['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final contentMatch = (module['sections'] as List).any((section) {
        final tabMatch = (section['tabName'] ?? '').toString().toLowerCase().contains(_searchQuery.toLowerCase());
        final blocksMatch = (section['blocks'] as List).any((block) {
          return block.toString().toLowerCase().contains(_searchQuery.toLowerCase());
        });
        return tabMatch || blocksMatch;
      });
      return titleMatch || contentMatch;
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.pureBlack,
      body: Stack(
        children: [
          // Ambient Background Layer
          const Positioned.fill(child: SmoothGradientBackground(child: SizedBox())),

          SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    
                    // Navigation Header
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
                          Text("FIRST AID", style: AppTheme.navTitle(width)),
                        ],
                      ),
                    ),

                    // Interactive Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.15)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.5)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (val) => setState(() => _searchQuery = val),
                                style: AppTheme.bodyText(width).copyWith(
                                    color: Colors.white,
                                    fontSize: AppTheme.scaleText(width, 16)
                                ),
                                cursorColor: const Color(0xFF6BB8FF),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search First Aid guidelines...",
                                  hintStyle: AppTheme.bodyText(width).copyWith(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: AppTheme.scaleText(width, 16)
                                  ),
                                ),
                              ),
                            ),
                            // Clear Search Button
                            if (_searchQuery.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  _searchController.clear();
                                  setState(() => _searchQuery = "");
                                },
                                child: Icon(Icons.close_rounded, color: Colors.white.withOpacity(0.5), size: 20),
                              ),
                          ],
                        ),
                      ),
                    ),

                    // Filtered Content Module List
                    Expanded(
                      child: displayedData.isEmpty
                          ? Center(
                        child: Text(
                          "No results found for '$_searchQuery'",
                          style: AppTheme.bodyText(width).copyWith(
                              color: Colors.white54,
                              fontSize: AppTheme.scaleText(width, 16)
                          ),
                        ),
                      )
                          : ListView.builder(
                        padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 50),
                        physics: const BouncingScrollPhysics(),
                        itemCount: displayedData.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SectionedGlassCard(
                              key: ValueKey(displayedData[index]['title']),
                              data: displayedData[index],
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
        ],
      ),
      bottomNavigationBar: const BottomBannerAd(),
    );
  }
}

/// A highly reusable, animated glassmorphism card component.
///
/// This widget handles its own expansion state and internal tab navigation.
/// It delegates the rendering of its body content to a dynamic block parser 
/// (`_buildContentBlock`) which translates map structures into Flutter widgets.
class SectionedGlassCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final double width;

  const SectionedGlassCard({super.key, required this.data, required this.width});

  @override
  State<SectionedGlassCard> createState() => _SectionedGlassCardState();
}

class _SectionedGlassCardState extends State<SectionedGlassCard> {
  bool _isExpanded = false;
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color accent = widget.data['accent'] ?? Colors.blue;
    final IconData icon = widget.data['icon'] ?? Icons.health_and_safety_rounded;
    final String title = widget.data['title'] ?? 'Section';
    final List<dynamic> sections = widget.data['sections'] ?? [];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutQuart,
      decoration: BoxDecoration(
        color: _isExpanded ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isExpanded ? accent.withOpacity(0.6) : Colors.white.withOpacity(0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // Clickable Header (Toggles Expansion State)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _isExpanded = !_isExpanded);
              },
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isExpanded ? accent.withOpacity(0.25) : Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                        border: Border.all(color: _isExpanded ? accent.withOpacity(0.8) : Colors.white.withOpacity(0.15)),
                      ),
                      child: Icon(icon, color: _isExpanded ? Colors.white : accent, size: 24),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTheme.heading(widget.width).copyWith(
                          fontSize: AppTheme.scaleText(widget.width, 19),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: _isExpanded ? Colors.white : Colors.white70,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isExpanded ? -0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isExpanded ? Colors.white.withOpacity(0.1) : Colors.transparent
                        ),
                        child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white.withOpacity(0.6), size: 26),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Dynamic Tab & Content Body
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOutCubic,
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            child: SizedBox(
              width: double.infinity,
              child: _isExpanded && sections.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // Horizontal Tab Selector (Renders only if > 1 section exists)
                  if (sections.length > 1)
                    SizedBox(
                      height: 52,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: sections.length,
                        itemBuilder: (context, idx) {
                          bool isActive = _activeTabIndex == idx;
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              setState(() => _activeTabIndex = idx);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: isActive
                                    ? LinearGradient(colors: [accent, accent.withOpacity(0.7)])
                                    : null,
                                color: isActive ? null : Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isActive ? accent.withOpacity(0.8) : Colors.white.withOpacity(0.1)),
                                boxShadow: isActive ? [BoxShadow(color: accent.withOpacity(0.4), blurRadius: 10)] : [],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                sections[idx]['tabName'] ?? 'Tab $idx',
                                style: AppTheme.heading(widget.width).copyWith(
                                  fontSize: AppTheme.scaleText(widget.width, 16),
                                  fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                                  color: isActive ? AppTheme.pureBlack : Colors.white70,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                  // Active Tab Content Area
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 15, bottom: 24),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildTabContent(sections[_activeTabIndex]['blocks'] ?? [], widget.width, accent, ValueKey(_activeTabIndex)),
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  /// Maps a list of generic JSON blocks to their respective layout widgets.
  Widget _buildTabContent(List<dynamic> blocks, double width, Color accent, Key key) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.map((block) {
        if (block is Map) {
          return _buildContentBlock(Map<String, dynamic>.from(block), width, accent);
        }
        return const SizedBox.shrink();
      }).toList(),
    );
  }

  /// The Core Parser Engine. 
  /// 
  /// Acts as a factory returning specific UI compositions (`text`, `bullets`, 
  /// `checklist`, `timeline`, `cards`, `alert`) based on the 'type' attribute 
  /// provided in the data dictionary.
  Widget _buildContentBlock(Map<String, dynamic> block, double width, Color accent) {
    final heading = block['heading']?.toString() ?? '';
    final type = block['type']?.toString() ?? 'text';

    List<Widget> children = [];

    // Optional Accent Banner for subsections
    if (heading.isNotEmpty) {
      children.add(
          Container(
            margin: const EdgeInsets.only(bottom: 16, top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border(left: BorderSide(color: accent, width: 4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.label_important_rounded, color: accent, size: 20),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    heading.toUpperCase(),
                    style: AppTheme.heading(width).copyWith(
                      fontSize: AppTheme.scaleText(width, 16),
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    // Body Widget Routing
    if (type == 'text') {
      children.add(_buildParagraph(block['text']?.toString() ?? '', width));
    } else if (type == 'bullets') {
      children.add(_buildBullets(block['items'] ?? [], width, accent));
    } else if (type == 'checklist') {
      children.add(_buildChecklist(block['items'] ?? [], width, accent));
    } else if (type == 'timeline') {
      children.add(_buildTimeline(block['items'] ?? [], width, accent));
    } else if (type == 'cards') {
      children.add(_buildMiniCards(block['items'] ?? [], width, accent));
    } else if (type == 'alert') {
      children.add(_buildAlert(block['text']?.toString() ?? '', width));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // Helper methodologies for the Parser Engine

  Widget _buildParagraph(String text, double width) {
    return Text(
      text,
      style: AppTheme.bodyText(width).copyWith(
          fontSize: AppTheme.scaleText(width, 16),
          height: 1.6,
          color: Colors.white.withOpacity(0.85)
      ),
    );
  }

  /// Builds a responsive grid/list of checkmarked items. Splits into a 2-column layout on wider screens.
  Widget _buildChecklist(List<dynamic> items, double width, Color accent) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
      double itemWidth = (constraints.maxWidth / crossAxisCount) - 10;

      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: items.map((item) {
          return SizedBox(
            width: itemWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_rounded, color: accent.withOpacity(0.8), size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.toString(),
                    style: AppTheme.bodyText(width).copyWith(
                      fontSize: AppTheme.scaleText(width, 16),
                      color: Colors.white.withOpacity(0.95),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildBullets(List<dynamic> items, double width, Color accent) {
    return Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 6, right: 14),
                    child: Container(
                      width: 8, height: 8,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: accent.withOpacity(0.8), blurRadius: 6)]
                      ),
                    )
                ),
                Expanded(
                  child: Text(
                    item.toString(),
                    style: AppTheme.bodyText(width).copyWith(
                        fontSize: AppTheme.scaleText(width, 16),
                        height: 1.6,
                        color: Colors.white.withOpacity(0.9)
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList()
    );
  }

  Widget _buildTimeline(List<dynamic> items, double width, Color accent) {
    return Column(
      children: List.generate(items.length, (index) {
        if (items[index] is! Map) return const SizedBox.shrink();
        final Map<String, dynamic> step = Map<String, dynamic>.from(items[index]);
        bool isLast = index == items.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: 32, height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.25),
                      shape: BoxShape.circle,
                      border: Border.all(color: accent, width: 1.5),
                    ),
                    child: Text(
                      "${index + 1}",
                      style: AppTheme.heading(width).copyWith(
                          fontSize: AppTheme.scaleText(width, 15),
                          color: accent,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: accent.withOpacity(0.4),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                      ),
                    )
                ],
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['title'] ?? '',
                        style: AppTheme.heading(width).copyWith(
                            fontSize: AppTheme.scaleText(width, 18),
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        step['desc'] ?? '',
                        style: AppTheme.bodyText(width).copyWith(
                            fontSize: AppTheme.scaleText(width, 16),
                            color: Colors.white.withOpacity(0.85),
                            height: 1.6
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMiniCards(List<dynamic> items, double width, Color accent) {
    return Column(
      children: items.map((item) {
        if (item is! Map) return const SizedBox.shrink();
        final Map<String, dynamic> card = Map<String, dynamic>.from(item);

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(18),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border(left: BorderSide(color: accent, width: 4)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card['title'] ?? '',
                style: AppTheme.heading(width).copyWith(
                    fontSize: AppTheme.scaleText(width, 18),
                    color: Colors.white
                ),
              ),
              const SizedBox(height: 10),
              Text(
                card['desc'] ?? '',
                style: AppTheme.bodyText(width).copyWith(
                    fontSize: AppTheme.scaleText(width, 16),
                    color: Colors.white.withOpacity(0.85),
                    height: 1.6
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAlert(String text, double width) {
    Color boxColor = const Color(0xFFFFC107); // Amber alert color

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: boxColor.withOpacity(0.1),
        border: Border.all(color: boxColor.withOpacity(0.4), width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: boxColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "NOTE",
                    style: AppTheme.badgeText(width, boxColor).copyWith(fontSize: AppTheme.scaleText(width, 14))
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: AppTheme.bodyText(width).copyWith(
                      fontSize: AppTheme.scaleText(width, 16),
                      color: Colors.white.withOpacity(0.9),
                      height: 1.5
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
