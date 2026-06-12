import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A static data dictionary containing comprehensive details on Pioneering lashings.
///
/// Each entry defines a specific structural lashing, including its functional classification,
/// step-by-step procedures, starting/ending knots, a local video asset path for demonstrations, 
/// and a dedicated Rajyapuraskar exam tip.
final List<Map<String, dynamic>> lashingData = [
  {
    "name": "SQUARE LASHING",
    "type": "90° BINDING",
    "startingKnot": "Clove Hitch",
    "endingKnot": "Clove Hitch",
    "videoAsset": "assets/videos/sqaurelashing.mp4", 
    "accent": const Color(0xFF4FC3F7),
    "icon": Icons.add_box_rounded,
    "steps": [
      "Start with a Clove Hitch on the vertical spar, just below the crossing point.",
      "Wrap the rope in front of the horizontal, behind the vertical, down in front of the horizontal, and behind the vertical.",
      "Complete 3 to 4 neat, parallel wrapping turns. Do not let the ropes cross over each other.",
      "Apply 2 to 3 tight Frapping turns (pulling the wraps together between the spars) to lock the tension.",
      "Finish with a tight Clove Hitch on the horizontal spar."
    ],
    "practical": "Building frameworks for shelters, camp tables, or structural right angles.",
    "examPoint": "Examiners will check if your wraps are parallel (not crossing) and if the frapping turns are tight enough to prevent any shifting."
  },
  {
    "name": "DIAGONAL LASHING",
    "type": "CROSS BINDING",
    "startingKnot": "Timber Hitch",
    "endingKnot": "Clove Hitch",
    "videoAsset": "assets/videos/diagonal.mp4",
    "accent": const Color(0xFFFF8A65),
    "icon": Icons.close_rounded,
    "steps": [
      "Start with a Timber Hitch diagonally across the two spars to spring them tightly together.",
      "Make 3 to 4 vertical wrapping turns, keeping them neat and tight.",
      "Make 3 to 4 horizontal wrapping turns across the opposite diagonal.",
      "Apply 2 to 3 tight Frapping turns between the spars to cinch the wraps.",
      "Finish with a Clove Hitch on any convenient spar."
    ],
    "practical": "Used when spars cross at an angle other than 90°, or to bind spars that are under tension and springing apart (like an X-brace).",
    "examPoint": "This is the ONLY lashing that officially starts with a Timber Hitch. Remembering this is a guaranteed mark in the exam."
  },
  {
    "name": "ROUND LASHING",
    "type": "PARALLEL BINDING",
    "startingKnot": "Clove Hitch",
    "endingKnot": "Clove Hitch",
    "videoAsset": "assets/videos/roundlashing.mp4",
    "accent": const Color(0xFFBA68C8),
    "icon": Icons.drag_handle_rounded,
    "steps": [
      "Place the two spars parallel to each other with sufficient overlap.",
      "Start with a Clove Hitch around BOTH spars at one end of the overlap.",
      "Make 7 to 10 tight wrapping turns around both spars tightly.",
      "Finish with a Clove Hitch around both spars at the other end.",
      "Note: A second round lashing is usually required at the other end of the overlap for stability."
    ],
    "practical": "Splicing or extending the length of two poles, such as creating a long flag mast.",
    "examPoint": "Standard Round Lashing does NOT use frapping turns. The strength comes from the tight, continuous wrapping."
  },
  {
    "name": "SHEAR LASHING",
    "type": "A-FRAME BINDING",
    "startingKnot": "Clove Hitch",
    "endingKnot": "Clove Hitch",
    "videoAsset": "assets/videos/shearlashing.mp4",
    "accent": const Color(0xFFFFD54F),
    "icon": Icons.architecture_rounded,
    "steps": [
      "Place two spars parallel to each other.",
      "Start with a Clove Hitch on ONE spar.",
      "Make 6 to 8 wrapping turns around both spars. IMPORTANT: Do not wrap too tightly.",
      "Open the spars like a pair of scissors to form an A-frame.",
      "Apply 2 to 3 tight Frapping turns between the spars.",
      "Finish with a Clove Hitch on the opposite spar from where you started."
    ],
    "practical": "Constructing A-frames, shear legs for lifting heavy objects, or the base of a pioneering bridge.",
    "examPoint": "The trap here is tying the wraps too tight. If wrapped too tightly while parallel, you will not be able to open the spars into an A-frame."
  },
  {
    "name": "TRIPOD LASHING",
    "type": "3-SPAR BINDING",
    "startingKnot": "Clove Hitch",
    "endingKnot": "Clove Hitch",
    "videoAsset": "assets/videos/tripodlashing.mp4",
    "accent": const Color(0xFFE57373),
    "icon": Icons.trip_origin_rounded,
    "steps": [
      "Lay three spars parallel, with the center spar pointing in the opposite direction (optional but helpful).",
      "Start with a Clove Hitch on one of the outer spars.",
      "Weave the rope over and under the three spars (Figure-of-Eight style) for 5 to 7 turns.",
      "Apply loose Frapping turns in the two gaps between the spars.",
      "Finish with a Clove Hitch on the outer spar.",
      "Stand the tripod up and adjust the legs to tighten the lashing."
    ],
    "practical": "Constructing wash basins, flagpoles, cooking tripods, or emergency water filtration towers.",
    "examPoint": "The Figure-of-Eight weaving method is required for the tripod. The lashing relies on the mechanical expansion of the legs to achieve final tension."
  }
];

/// The master catalog screen for structural lashings.
///
/// Features a dynamic search bar to filter lashings by name or type. The results
/// are displayed using premium structural list cards with specialized visual cues.
class LashingScreen extends StatefulWidget {
  const LashingScreen({super.key});

  @override
  State<LashingScreen> createState() => _LashingScreenState();
}

class _LashingScreenState extends State<LashingScreen> {
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
        ? lashingData
        : lashingData.where((lash) {
      final nameMatch = lash['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final typeMatch = lash['type'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
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
                        Text("PIONEERING", style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 16))),
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
                                hintText: "Search lashings...",
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
                        ? Center(child: Text("No lashings found.", style: AppTheme.bodyText(width).copyWith(color: Colors.white54)))
                        : ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildStructuralCard(displayedData[index], width, context),
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

  /// Builds a highly stylized, interactive list card tailored for Pioneering structures.
  ///
  /// Implements a custom [PageRouteBuilder] to create a sliding route transition 
  /// when the card is tapped, navigating the user to the detailed view smoothly.
  Widget _buildStructuralCard(Map<String, dynamic> data, double width, BuildContext context) {
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
              pageBuilder: (_, __, ___) => LashingDetailScreen(data: data),
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
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 8))],
          ),
          child: Stack(
            children: [
              // Background accent lines mimicking pioneering spars
              Positioned(
                right: -20,
                top: -20,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    height: 100,
                    width: 20,
                    color: accent.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                right: 20,
                top: -40,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(45 / 360),
                  child: Container(
                    height: 150,
                    width: 40,
                    color: accent.withOpacity(0.05),
                  ),
                ),
              ),
              
              // Foreground Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: accent.withOpacity(0.3)),
                            ),
                            child: Text(
                              data['type'],
                              style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 10), letterSpacing: 2),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data['name'],
                            style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 22), color: Colors.white, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.play_circle_fill_rounded, color: Colors.white.withOpacity(0.5), size: 16),
                              const SizedBox(width: 6),
                              Text(
                                "Watch Tutorial",
                                style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white54),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 55, width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Icon(data['icon'], color: Colors.white, size: 28),
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

/// The detail view for a specific lashing, featuring a local video demonstration 
/// and step-by-step procedures.
///
/// Manages the lifecycle of both the underlying [VideoPlayerController] and the 
/// high-level [ChewieController]. Gracefully handles missing assets and rendering 
/// the advanced, glassmorphic informational layout.
class LashingDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const LashingDetailScreen({super.key, required this.data});

  @override
  State<LashingDetailScreen> createState() => _LashingDetailScreenState();
}

class _LashingDetailScreenState extends State<LashingDetailScreen> {
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
                      boxShadow: [BoxShadow(color: accent.withOpacity(0.2), blurRadius: 25, offset: const Offset(0, 10))],
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                      color: Colors.black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _hasError
                            ? const Center(
                          child: Text("Missing video asset.", style: TextStyle(color: Colors.white54)),
                        )
                            : _isVideoInitialized && _chewieController != null
                            ? Chewie(controller: _chewieController!)
                            : Center(child: CircularProgressIndicator(color: accent)),
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
                              style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 34), fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Starting & Ending Knot Context Badges
                        Row(
                          children: [
                            Expanded(child: _buildKnotBadge("START WITH", widget.data['startingKnot'], accent, width)),
                            const SizedBox(width: 12),
                            Expanded(child: _buildKnotBadge("END WITH", widget.data['endingKnot'], Colors.white54, width)),
                          ],
                        ),
                        const SizedBox(height: 35),

                        // Step-By-Step Procedure Section
                        _buildSectionTitle("Procedure", Icons.format_list_numbered_rounded, accent, width),
                        const SizedBox(height: 16),
                        _buildGlassCard(
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              (widget.data['steps'] as List).length,
                                  (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 26, height: 26,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(top: 2, right: 14),
                                      decoration: BoxDecoration(
                                        color: accent.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: accent.withOpacity(0.5)),
                                      ),
                                      child: Text(
                                        "${index + 1}",
                                        style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 12), color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.data['steps'][index].toString(),
                                        style: AppTheme.bodyText(width).copyWith(
                                            fontSize: AppTheme.scaleText(width, 16),
                                            height: 1.5,
                                            color: Colors.white.withOpacity(0.9)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),

                        // Practical Usage Section
                        _buildSectionTitle("Practical Setup", Icons.handyman_rounded, accent, width),
                        const SizedBox(height: 16),
                        _buildGlassCard(
                          width: width,
                          child: Text(
                            widget.data['practical'],
                            style: AppTheme.bodyText(width).copyWith(
                                fontSize: AppTheme.scaleText(width, 16),
                                height: 1.6,
                                color: Colors.white.withOpacity(0.85)
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

  /// Specialized UI component to display supplemental starting/ending knot context.
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
