import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A static data dictionary containing comprehensive details on the Patrol System.
///
/// This JSON-like structure serves as the primary content source for the screen.
/// Each entry defines a specific aspect of the Patrol System, including its 
/// organizational category, primary role/concept name, step-by-step responsibilities,
/// a specific Rajyapuraskar exam tip, and thematic UI properties (icons and colors).
final List<Map<String, dynamic>> patrolData = [
  {
    "category": "CORE PHILOSOPHY",
    "name": "THE PATROL SYSTEM",
    "icon": Icons.hub_rounded,
    "accent": const Color(0xFF4FC3F7),
    "examPoint": "Lord Baden-Powell stated the Patrol System is not just one method for Scouting; it is the SOLE method.",
    "bullets": [
      "The fundamental unit of Scouting for work, play, discipline, and duty.",
      "A representative form of government utilized to enhance the spirit, vitality, and welfare of the troop.",
      "Groups consist of 6 to 8 members, each under their own elected Patrol Leader.",
      "Emulation and competition between Patrols foster strong Patrol spirit and camaraderie.",
      "Instills individual responsibility; the honor of the group depends on every individual's contribution."
    ]
  },
  {
    "category": "LEADERSHIP ROLE",
    "name": "PATROL LEADER (PL)",
    "icon": Icons.military_tech_rounded,
    "accent": const Color(0xFFFFD54F),
    "examPoint": "The PL represents the patrol at the Court of Honor (COH) and is entirely responsible for the patrol's performance.",
    "bullets": [
      "Elected by patrol members to serve for a predetermined time.",
      "Conducts regular patrol meetings and learns about members' interests.",
      "Facilitates skill learning, assigns duties, and organizes tasks.",
      "Consults with troop leaders and upholds the Scout/Guide Promise and Law."
    ]
  },
  {
    "category": "LEADERSHIP ROLE",
    "name": "ASSISTANT PATROL LEADER",
    "icon": Icons.shield_rounded,
    "accent": const Color(0xFFB0BEC5),
    "examPoint": "The APL is selected/elected to assist the PL and takes absolute charge of the patrol in the PL's absence.",
    "bullets": [
      "Serves for the same term as the Patrol Leader.",
      "Carries out specific leadership responsibilities delegated by the PL (e.g., kaper charts, flag ceremonies).",
      "Helps the patrol transition from confusion to action swiftly."
    ]
  },
  {
    "category": "ORGANIZATION",
    "name": "COURT OF HONOR (COH)",
    "icon": Icons.gavel_rounded,
    "accent": const Color(0xFFBA68C8),
    "examPoint": "The COH is the core decision-making body of the Troop. It safeguards the honor and sets the standards of the Troop.",
    "bullets": [
      "Composed of all Patrol Leaders, Troop Secretary, Troop Treasurer, and the Troop Leader.",
      "Plans troop programs, activities, and camps based on patrol-submitted ideas.",
      "Evaluates proposed ideas for feasibility and organizes learning opportunities.",
      "Short meetings occur around regular troop meetings; detailed planning meetings happen every 2-3 months."
    ]
  },
  {
    "category": "ORGANIZATION",
    "name": "PATROL-IN-COUNCIL",
    "icon": Icons.groups_rounded,
    "accent": const Color(0xFF81C784),
    "examPoint": "This is an internal patrol meeting where EVERY member has a voice. It embodies the democratic nature of Scouting.",
    "bullets": [
      "Convenes to discuss upcoming activities, membership dues, and camping preferences.",
      "Led by the Patrol Leader.",
      "All members participate collectively to address the specific affairs and needs of their own patrol."
    ]
  },
  {
    "category": "PATROL DUTIES",
    "name": "FINANCE & RECORDS",
    "icon": Icons.account_balance_wallet_rounded,
    "accent": const Color(0xFF4DB6AC),
    "examPoint": "Every member must have a definite, permanent job so the patrol can whirl into action efficiently.",
    "bullets": [
      "PATROL TREASURER: Collects dues, manages transactions, and maintains detailed financial records.",
      "PATROL SECRETARY: Handles correspondence, logs attendance, maintains progress records, and manages permission slips.",
      "TROOP EQUIVALENTS: The Troop Secretary and Troop Treasurer perform these duties at the macro-level for the COH."
    ]
  },
  {
    "category": "PATROL DUTIES",
    "name": "MANAGERS & LOGISTICS",
    "icon": Icons.engineering_rounded,
    "accent": const Color(0xFFFF8A65),
    "examPoint": "Delegation of these duties teaches specialized life skills and prevents the PL from being overwhelmed.",
    "bullets": [
      "TRANSPORTATION: Oversees travel arrangements, researches costs, and coordinates with drivers.",
      "COMMISSARY: Coordinates food arrangements, assigns shoppers, and devises clean-up plans.",
      "EQUIPMENT: Acquires, packs, stores, and repairs patrol equipment (like stoves and tents).",
      "HEALTH & SAFETY: Maintains the First Aid kit and ensures safety protocol awareness."
    ]
  },
  {
    "category": "PATROL IDENTITY",
    "name": "NAME, EMBLEM & FLAG",
    "icon": Icons.tour_rounded,
    "accent": const Color(0xFFE57373),
    "examPoint": "A patrol flag is a white triangular pennant bearing the patrol's emblem in red. It is the pride of the patrol.",
    "bullets": [
      "NAME: Chosen from the Handbook, often based on animals, birds, or geographic interests.",
      "EMBLEM: The 'totem' design used on the flag, medallions, den decorations, and equipment.",
      "FLAG: Accompanies the patrol on all activities. Dates and locations are traditionally carved into its staff."
    ]
  },
  {
    "category": "PATROL IDENTITY",
    "name": "CALL, YELL & CORNER",
    "icon": Icons.record_voice_over_rounded,
    "accent": const Color(0xFF64B5F6),
    "examPoint": "A Scout must never use the call of another patrol. It is an exclusive identifier.",
    "bullets": [
      "CALL: Mimics the patrol's animal/bird name. Used by the PL to rally members or signal locations discreetly.",
      "YELL: A spirited cheer used to energize the group and build team spirit.",
      "CORNER: A designated space in the meeting room for the patrol's educational materials, records, and gear."
    ]
  }
];

/// The master catalog screen for the Patrol System module.
///
/// Features a dynamic search bar to filter entries by name or category. The results
/// are displayed using a highly complex "floating datapad" UI architecture that 
/// breaks standard container boundaries for a premium aesthetic.
class PatrolScreen extends StatefulWidget {
  const PatrolScreen({super.key});

  @override
  State<PatrolScreen> createState() => _PatrolScreenState();
}

class _PatrolScreenState extends State<PatrolScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Search filter logic applied to the static dictionary
    List<Map<String, dynamic>> displayedData = _searchQuery.isEmpty
        ? patrolData
        : patrolData.where((item) {
      final nameMatch = item['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final catMatch = item['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return nameMatch || catMatch;
    }).toList();

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
                        Text("PATROL SYSTEM", style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 16))),
                      ],
                    ),
                  ),

                  // Interactive Search Bar (Glassmorphic)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                              Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.4)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (val) => setState(() => _searchQuery = val),
                                  style: AppTheme.bodyText(width).copyWith(color: Colors.white, fontSize: AppTheme.scaleText(width, 16)),
                                  cursorColor: const Color(0xFF6BB8FF),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search patrol roles & duties...",
                                    hintStyle: AppTheme.bodyText(width).copyWith(color: Colors.white.withOpacity(0.3), fontSize: AppTheme.scaleText(width, 16)),
                                  ),
                                ),
                              ),
                              // Dynamic clear button
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
                    ),
                  ),

                  // Filtered Master List using the Floating Datapad layout
                  Expanded(
                    child: displayedData.isEmpty
                        ? Center(child: Text("No records found.", style: AppTheme.bodyText(width).copyWith(color: Colors.white54)))
                        : ListView.builder(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: _buildDetachedHeaderCard(displayedData[index], width),
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

  /// Builds a highly stylized UI card featuring a "detached" floating header.
  ///
  /// This layout utilizes a [Stack] with `clipBehavior: Clip.none` to allow the 
  /// header pill to break out of the main container's bounding box and float 
  /// above it, creating a deep 3D effect.
  Widget _buildDetachedHeaderCard(Map<String, dynamic> data, double width) {
    final Color accent = data['accent'];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        
        // ---------------------------------------------------
        // LAYER 1: THE MAIN DATA PANE (Background)
        // ---------------------------------------------------
        Container(
          // Top margin pushes the main body down to make room for the floating header above
          margin: const EdgeInsets.only(top: 35), 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 25, offset: const Offset(0, 15)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.02),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.2),
                ),
                child: Padding(
                  // Extra top padding ensures the text doesn't hide behind the overlapping header
                  padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24), 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Datalink Bullet List
                      Column(
                        children: (data['bullets'] as List).map((point) => IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              
                              // Vertical Connector Line & Node
                              Column(
                                children: [
                                  Container(
                                    width: 8, height: 8,
                                    margin: const EdgeInsets.only(top: 6),
                                    decoration: BoxDecoration(
                                      color: accent,
                                      shape: BoxShape.circle,
                                      boxShadow: [BoxShadow(color: accent.withOpacity(0.8), blurRadius: 6)],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 1.5,
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                      color: accent.withOpacity(0.2),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              
                              // Bullet Text
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    point.toString(),
                                    style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 15.5), height: 1.6, color: Colors.white.withOpacity(0.9)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),

                      const SizedBox(height: 10),

                      // EXAM POINT BADGE (Highly Contrasted Gold Panel)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft, end: Alignment.bottomRight,
                            colors: [const Color(0xFF2A220A).withOpacity(0.9), const Color(0xFF141002).withOpacity(0.9)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.5), width: 1.2),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFFFFD54F).withOpacity(0.15), blurRadius: 20),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFD54F).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.stars_rounded, color: Color(0xFFFFD54F), size: 18),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "EXAM POINT",
                                  style: AppTheme.badgeText(width, const Color(0xFFFFD54F)).copyWith(fontSize: AppTheme.scaleText(width, 12), letterSpacing: 2),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data['examPoint'],
                              style: AppTheme.bodyText(width).copyWith(
                                fontSize: AppTheme.scaleText(width, 14.5),
                                color: Colors.white,
                                height: 1.6,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // ---------------------------------------------------
        // LAYER 2: THE FLOATING COMMAND PILL (Header)
        // ---------------------------------------------------
        Positioned(
          top: 0, // Anchors to the absolute top of the Stack, floating over the main pane's margin
          left: 15,
          right: 15,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight,
                colors: [accent.withOpacity(0.25), Colors.white.withOpacity(0.08)],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accent.withOpacity(0.4), width: 1.5),
              boxShadow: [
                BoxShadow(color: accent.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8)),
                BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5)),
              ],
            ),
            child: Row(
              children: [
                
                // Glowing Icon Node
                Container(
                  height: 48, width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: accent.withOpacity(0.6)),
                    boxShadow: [BoxShadow(color: accent.withOpacity(0.4), blurRadius: 15)],
                  ),
                  child: Icon(data['icon'], color: accent, size: 24),
                ),
                const SizedBox(width: 16),

                // Titles
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['category'],
                        style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 10), letterSpacing: 2, color: accent.withOpacity(0.9)),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data['name'],
                        style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 18), color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
