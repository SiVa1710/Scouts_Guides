import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A static data dictionary containing comprehensive details on Scouting knots.
///
/// Each entry defines a specific knot, including its functional classification,
/// practical applications, a local video asset path for demonstrations, and 
/// a dedicated Rajyapuraskar exam tip.
final List<Map<String, dynamic>> knotData = [
  {
    "name": "REEF KNOT",
    "type": "JOINING KNOT",
    "videoAsset": "assets/videos/knotreef.mp4",
    "accent": const Color(0xFF4FC3F7),
    "icon": Icons.compare_arrows_rounded,
    "uses": [
      "Tying two ends of a rope together securely.",
      "Joining ropes of EQUAL thickness.",
      "Tying bandages in First Aid."
    ],
    "practical": "Securing packages, binding objects together, or joining fishing lines.",
    "examPoint": "Also known as the Square Knot. It lies perfectly flat, making it the only knot permitted for tying bandages in First Aid."
  },
  {
    "name": "BOWLINE KNOT",
    "type": "RESCUE KNOT",
    "videoAsset": "assets/videos/bowline.mp4",
    "accent": const Color(0xFFFF8A65),
    "icon": Icons.support_rounded,
    "uses": [
      "Forming a secure, fixed loop at the end of a rope.",
      "Lowering a person during rescue operations."
    ],
    "practical": "Tying safety lines, securing boats to docks, or throwing a lifeline for rescue operations.",
    "examPoint": "Known as the 'King of Knots'. It will never slip, tighten, or jam under tension, preventing it from choking the casualty."
  },
  {
    "name": "SHEET BEND",
    "type": "JOINING KNOT",
    "videoAsset": "assets/videos/sheetbend.mp4",
    "accent": const Color(0xFFBA68C8),
    "icon": Icons.merge_type_rounded,
    "uses": [
      "Joining two ropes of UNEQUAL diameters or materials.",
      "Joining a rope to an eye-splice or a loop."
    ],
    "practical": "Extending a rope, repairing a broken line, or creating a longer line for towing or hauling.",
    "examPoint": "When tying, the thicker rope must always form the simple 'bight' (the loop), and the thinner rope does the wrapping."
  },
  {
    "name": "SHEEP SHANK",
    "type": "UTILITY KNOT",
    "videoAsset": "assets/videos/sheapshank.mp4",
    "accent": const Color(0xFFFFD54F),
    "icon": Icons.compress_rounded,
    "uses": [
      "Temporarily shortening a rope or taking up slack.",
      "Bypassing a damaged or frayed section of a rope."
    ],
    "practical": "Rigging sails, securing a line to a cleat, or adjusting tension in a tent's rope system.",
    "examPoint": "It requires continuous tension to hold securely. If the tension is released, the Sheep Shank will naturally fall apart."
  },
  {
    "name": "FIREMAN'S CHAIR",
    "type": "RESCUE KNOT",
    "videoAsset": "assets/videos/firemanschairknot.mp4",
    "accent": const Color(0xFFE57373),
    "icon": Icons.local_fire_department_rounded,
    "uses": [
      "Creating a secure two-loop seat for emergency rappelling.",
      "Lowering an unconscious casualty from a building."
    ],
    "practical": "Swiftwater rescue, high-angle rescue, or emergency evacuation where a quick harness is needed.",
    "examPoint": "Must be finished with locking Half-Hitches on both sides of the central knot to prevent the loops from slipping."
  },
  {
    "name": "FISHERMAN'S KNOT",
    "type": "JOINING KNOT",
    "videoAsset": "assets/videos/fisherman'sknot.mp4",
    "accent": const Color(0xFF4DB6AC),
    "icon": Icons.waves_rounded,
    "uses": [
      "Joining two lines of similar diameter together securely.",
      "Joining wet, smooth, or slippery synthetic ropes."
    ],
    "practical": "Fishing, connecting leader lines, or repairing broken nylon fishing lines.",
    "examPoint": "It is essentially two simple overhand knots tied around each other's standing part. Pulling the lines draws them tightly together."
  },
  {
    "name": "FIGURE OF EIGHT",
    "type": "STOPPER KNOT",
    "videoAsset": "assets/videos/figure.mp4",
    "accent": const Color(0xFF9575CD),
    "icon": Icons.all_inclusive_rounded,
    "uses": [
      "Acting as a stopper to prevent a rope from unfraying.",
      "Preventing a rope from slipping through a pulley."
    ],
    "practical": "Climbing, securing safety lines, or stopping ropes from slipping through equipment blocks.",
    "examPoint": "It is bulkier and much easier to untie after being under extreme strain compared to a basic overhand knot."
  },
  {
    "name": "BOWLINE ON A BIGHT",
    "type": "RESCUE KNOT",
    "videoAsset": "assets/videos/bowlineonabight.mp4",
    "accent": const Color(0xFF64B5F6),
    "icon": Icons.link_rounded,
    "uses": [
      "Forming a fixed loop in the middle of a rope without access to the ends.",
      "Creating a comfortable two-loop seat."
    ],
    "practical": "Climbing, rescue operations from a crevasse, or creating secure attachment points in rigging.",
    "examPoint": "Unlike the standard Bowline, this is tied on the bight (the middle of the rope) giving double loops for extra safety and comfort."
  }
];

/// The master catalog screen for knots.
///
/// Features a dynamic search bar to filter knots by name or type. The results
/// are displayed using premium glassmorphic list cards.
class KnotsScreen extends StatefulWidget {
  const KnotsScreen({super.key});

  @override
  State<KnotsScreen> createState() => _KnotsScreenState();
}

class _KnotsScreenState extends State<KnotsScreen> {
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
        ? knotData
        : knotData.where((knot) {
      final nameMatch = knot['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final typeMatch = knot['type'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      return nameMatch || typeMatch;
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
                        Text("KNOTS MASTERCLASS", style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 15))),
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
                                hintText: "Search for a knot...",
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

                  // Filtered Master List
                  Expanded(
                    child: displayedData.isEmpty
                        ? Center(child: Text("No knots found.", style: AppTheme.bodyText(width).copyWith(color: Colors.white54)))
                        : ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildPremiumCard(displayedData[index], width, context),
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
    );
  }

  /// Builds a highly stylized, interactive list card for a single knot.
  ///
  /// Implements a custom [PageRouteBuilder] to create a sliding route transition 
  /// when the card is tapped, navigating the user to the detailed view smoothly.
  Widget _buildPremiumCard(Map<String, dynamic> data, double width, BuildContext context) {
    final Color accent = data['accent'];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 350),
              pageBuilder: (_, __, ___) => KnotDetailScreen(data: data),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuart)),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Row(
            children: [
              // Circular Icon Container
              Container(
                height: 60, width: 60,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: accent.withOpacity(0.4)),
                ),
                child: Icon(data['icon'], color: accent, size: 28),
              ),
              const SizedBox(width: 20),
              
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['type'],
                      style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 11), letterSpacing: 1.5),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data['name'],
                      style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 20), color: Colors.white),
                    ),
                  ],
                ),
              ),
              
              // Navigation Indicator
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The detail view for a specific knot, featuring a local video demonstration.
///
/// Manages the lifecycle of both the underlying [VideoPlayerController] and the 
/// high-level [ChewieController]. Gracefully handles missing assets and rendering 
/// the advanced, glassmorphic informational layout.
class KnotDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const KnotDetailScreen({super.key, required this.data});

  @override
  State<KnotDetailScreen> createState() => _KnotDetailScreenState();
}

class _KnotDetailScreenState extends State<KnotDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  /// Initializes the video pipeline and builds the custom Chewie UI configuration.
  Future<void> _initializePlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.asset(widget.data['videoAsset']);
      await _videoPlayerController.initialize();

      // Ensure widget is still mounted before proceeding to build the ChewieController
      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: true,
        allowFullScreen: false, // Safely blocks landscape mode to maintain UI integrity
        materialProgressColors: ChewieProgressColors(
          playedColor: widget.data['accent'],
          handleColor: widget.data['accent'],
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
        ),
        errorBuilder: (context, errorMessage) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Video file not found or couldn't be played.",
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      );

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Color accent = widget.data['accent'];

    return Scaffold(
      body: SmoothGradientBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  
                  // Top Navigation Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Text(
                          widget.data['name'],
                          style: AppTheme.navTitle(width).copyWith(
                            fontSize: AppTheme.scaleText(width, 16),
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Main Video Player Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: accent.withOpacity(0.2), blurRadius: 25, offset: const Offset(0, 10))
                      ],
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                      color: Colors.black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _hasError
                            ? const Center(
                          child: Text(
                            "Missing video asset.",
                            style: TextStyle(color: Colors.white54),
                          ),
                        )
                            : _isVideoInitialized && _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : Center(
                          child: CircularProgressIndicator(color: accent),
                        ),
                      ),
                    ),
                  ),

                  // Scrollable Detailed Content
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      children: [
                        
                        // Core Title & Badge Block
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data['type'],
                              style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 14), letterSpacing: 2),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.data['name'],
                              style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 36), fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),

                        // Uses Section (Bulleted List)
                        _buildSectionTitle("Main Uses", Icons.flag_rounded, accent, width),
                        const SizedBox(height: 16),
                        _buildGlassCard(
                          width: width,
                          child: Column(
                            children: (widget.data['uses'] as List).map((use) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4, right: 12),
                                    child: Icon(Icons.check_circle_rounded, color: accent.withOpacity(0.9), size: 20),
                                  ),
                                  Expanded(
                                    child: Text(
                                      use.toString(),
                                      style: AppTheme.bodyText(width).copyWith(
                                          fontSize: AppTheme.scaleText(width, 16),
                                          height: 1.5,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),
                        ),
                        const SizedBox(height: 35),

                        // Practical Setup Section
                        _buildSectionTitle("Practical Setup", Icons.handyman_rounded, accent, width),
                        const SizedBox(height: 16),
                        _buildGlassCard(
                          width: width,
                          child: Text(
                            widget.data['practical'],
                            style: AppTheme.bodyText(width).copyWith(
                                fontSize: AppTheme.scaleText(width, 16),
                                height: 1.6,
                                color: Colors.white.withOpacity(0.9)
                            ),
                          ),
                        ),
                        const SizedBox(height: 45),

                        // Highly Contrasted Rajyapuraskar Exam Point
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft, end: Alignment.bottomRight,
                              colors: [Color(0xFF2A220A), Color(0xFF141002)],
                            ),
                            borderRadius: BorderRadius.circular(24),
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
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD54F).withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.emoji_events_rounded, color: Color(0xFFFFD54F), size: 24),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    "RAJYAPURASKAR POINT",
                                    style: AppTheme.badgeText(width, const Color(0xFFFFD54F)).copyWith(
                                      fontSize: AppTheme.scaleText(width, 13), letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                widget.data['examPoint'],
                                style: AppTheme.bodyText(width).copyWith(
                                    fontSize: AppTheme.scaleText(width, 16),
                                    color: Colors.white,
                                    height: 1.6,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Specialized UI component to display supplemental knot context.
  Widget _buildKnotBadge(String label, String knotName, Color color, double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 11), color: Colors.white54, letterSpacing: 1),
          ),
          const SizedBox(height: 4),
          Text(
            knotName,
            style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 15), color: color),
          ),
        ],
      ),
    );
  }

  /// Encapsulates the core aesthetic of the detail screen sections inside a frosted glass layer.
  Widget _buildGlassCard({required Widget child, required double width}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, spreadRadius: 2)
              ]
          ),
          child: child,
        ),
      ),
    );
  }

  /// Reusable UI component for standardizing section headers throughout the detail screen.
  Widget _buildSectionTitle(String title, IconData icon, Color accent, double width) {
    return Row(
      children: [
        Icon(icon, color: accent, size: 22),
        const SizedBox(width: 12),
        Text(
          title.toUpperCase(),
          style: AppTheme.heading(width).copyWith(
            fontSize: AppTheme.scaleText(width, 16),
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
