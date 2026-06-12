import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A static data dictionary containing comprehensive details on Scouting hitches.
///
/// Each entry defines a specific hitch, including its functional classification,
/// practical applications, a local video asset path for demonstrations, and 
/// a dedicated Rajyapuraskar exam tip.
final List<Map<String, dynamic>> hitchData = [
  {
    "name": "CLOVE HITCH",
    "type": "SECURING HITCH",
    "tiedTo": "Post or Spar",
    "videoAsset": "assets/videos/clovehitch.mp4",
    "accent": const Color(0xFF4FC3F7),
    "icon": Icons.commit_rounded,
    "uses": [
      "Securing a rope to a post, pole, or spar.",
      "Starting and finishing most lashings (Square, Round, Shear, Tripod).",
      "Making a quick, temporary mooring."
    ],
    "practical": "Anchoring tents, tying off loads in cargo, or setting up a campsite clothesline.",
    "examPoint": "Examiners will check if the two ends emerge from opposite directions. Note: It can slip if the object rotates or if the tension is intermittent."
  },
  {
    "name": "ROUND TURN & TWO HALF",
    "type": "MOORING HITCH",
    "tiedTo": "Ring or Bar",
    "videoAsset": "assets/videos/roundturn2half.mp4",
    "accent": const Color(0xFFFF8A65),
    "icon": Icons.loop_rounded,
    "uses": [
      "Creating a highly secure attachment to a ring, pole, or hook.",
      "Tying a line that will be subjected to constant or heavy tension.",
      "Securing guy lines to a peg."
    ],
    "practical": "Mooring boats, securing heavy tent guy lines, or tying an animal to a post.",
    "examPoint": "The 'Round Turn' takes all the strain and friction, preventing jamming. The 'Two Half Hitches' simply lock the knot. It will never jam under heavy load."
  },
  {
    "name": "TIMBER HITCH",
    "type": "FRICTION HITCH",
    "tiedTo": "Log or Timber",
    "videoAsset": "assets/videos/timberhitch.mp4",
    "accent": const Color(0xFFBA68C8),
    "icon": Icons.forest_rounded,
    "uses": [
      "Attaching a rope to a cylindrical object being dragged or lifted.",
      "Starting the Diagonal Lashing.",
      "Securing the string to a bow in archery."
    ],
    "practical": "Dragging heavy logs out of the forest, hoisting timber, or starting diagonal cross-bracing.",
    "examPoint": "In the exam, the tail MUST be tucked back around the loop at least three times, following the lay of the rope. It relies entirely on friction and tension to hold."
  },
  {
    "name": "ROLLING HITCH",
    "type": "GRIPPING HITCH",
    "tiedTo": "Another Rope",
    "videoAsset": "assets/videos/rollinghitch.mp4",
    "accent": const Color(0xFFFFD54F),
    "icon": Icons.moving_rounded,
    "uses": [
      "Attaching a smaller rope to a larger rope that is already under tension.",
      "Relieving the strain on a hawser or cable.",
      "Pulling a cylindrical object lengthwise."
    ],
    "practical": "Taking the load off a jammed knot so it can be untied, or adding a secondary tension line to a tent setup.",
    "examPoint": "Direction is critical! The knot grips when pulled in the direction of the double wraps, but slides freely when pushed the other way."
  },
  {
    "name": "MARLINE SPIKE HITCH",
    "type": "TOGGLE HITCH",
    "tiedTo": "Spike or Peg",
    "videoAsset": "assets/videos/marlinspike.mp4",
    "accent": const Color(0xFFE57373),
    "icon": Icons.hardware_rounded,
    "uses": [
      "Securing a toggle, peg, or spike temporarily into a rope.",
      "Creating a temporary handle to pull a rope tighter.",
      "Making rope ladders."
    ],
    "practical": "Applying extreme leverage to pull a line tight, unlaying strands of rope for splicing, or stepping up a rope ladder.",
    "examPoint": "It is not a permanent knot. Once the spike or toggle is removed, the hitch instantly falls apart into a straight line."
  },
  {
    "name": "DRAW HITCH",
    "type": "QUICK RELEASE",
    "tiedTo": "Post or Ring",
    "videoAsset": "assets/videos/highwaymans.mp4",
    "accent": const Color(0xFF4DB6AC),
    "icon": Icons.speed_rounded,
    "uses": [
      "Securing a rope to a post with adjustable tension that can be released instantly.",
      "Tying a boat or animal temporarily where a quick getaway is needed."
    ],
    "practical": "Also known as the Highwayman's Hitch. Used for temporary tie-down points for tarps, or mooring a boat for a few minutes.",
    "examPoint": "The knot holds firmly under the standing part's load, but collapses instantly when the working end (the tail) is pulled. Never use it for life support."
  }
];

/// The master catalog screen for hitches.
///
/// Features a dynamic search bar to filter hitches by name or type. The results
/// are displayed using ultra-premium glassmorphic cards with custom background 
/// watermarks.
class HitchesScreen extends StatefulWidget {
  const HitchesScreen({super.key});

  @override
  State<HitchesScreen> createState() => _HitchesScreenState();
}

class _HitchesScreenState extends State<HitchesScreen> {
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
        ? hitchData
        : hitchData.where((hitch) {
      final nameMatch = hitch['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final typeMatch = hitch['type'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
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
                        Text("HITCHES", style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 16))),
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
                                hintText: "Search hitches...",
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
                        ? Center(child: Text("No hitches found.", style: AppTheme.bodyText(width).copyWith(color: Colors.white54)))
                        : ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 15, bottom: 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: displayedData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _buildPremiumHitchCard(displayedData[index], width, context),
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

  /// Builds a highly stylized, interactive card for a single hitch.
  ///
  /// Implements a custom [PageRouteBuilder] to create a sliding route transition 
  /// when the card is tapped, navigating the user to the detailed view smoothly.
  Widget _buildPremiumHitchCard(Map<String, dynamic> data, double width, BuildContext context) {
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
              pageBuilder: (_, __, ___) => HitchDetailScreen(data: data),
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
        highlightColor: accent.withOpacity(0.1),
        splashColor: accent.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.02)],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.2),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                
                // Background Watermark Icon
                Positioned(
                  right: -25,
                  bottom: -30,
                  child: Transform.rotate(
                    angle: -0.2,
                    child: Icon(data['icon'], size: 140, color: Colors.white.withOpacity(0.04)),
                  ),
                ),
                
                // Ambient Glow Sphere behind the Play Button
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: accent.withOpacity(0.3), blurRadius: 40)],
                    ),
                  ),
                ),
                
                // Foreground Data Structure
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            // Hitch Classification Pill Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: accent.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: accent.withOpacity(0.3)),
                              ),
                              child: Text(
                                data['type'],
                                style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 10), letterSpacing: 1.5),
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Primary Title
                            Text(
                              data['name'],
                              style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 22), fontWeight: FontWeight.w900, color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            
                            // Attachment Context
                            Row(
                              children: [
                                Icon(Icons.adjust_rounded, color: Colors.white.withOpacity(0.4), size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  "Tied to: ${data['tiedTo']}",
                                  style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 14), color: Colors.white70),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      
                      // Solid Gradient Play Button Indicator
                      Container(
                        width: 58, height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft, end: Alignment.bottomRight,
                            colors: [accent, accent.withOpacity(0.7)],
                          ),
                          boxShadow: [
                            BoxShadow(color: accent.withOpacity(0.5), blurRadius: 15, offset: const Offset(0, 6)),
                          ],
                        ),
                        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The detail view for a specific hitch, featuring a local video demonstration.
///
/// Manages the lifecycle of both the underlying [VideoPlayerController] and the 
/// high-level [ChewieController]. Gracefully handles missing assets and rendering 
/// the advanced, glassmorphic informational layout.
class HitchDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const HitchDetailScreen({super.key, required this.data});

  @override
  State<HitchDetailScreen> createState() => _HitchDetailScreenState();
}

class _HitchDetailScreenState extends State<HitchDetailScreen> {
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

      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: true,
        allowFullScreen: false,
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
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: accent.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 10)),
                        BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 15)),
                      ],
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                      color: Colors.black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: _hasError
                            ? const Center(child: Text("Missing video asset.", style: TextStyle(color: Colors.white54)))
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: accent.withOpacity(0.3)),
                                    ),
                                    child: Text(
                                      widget.data['type'],
                                      style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 11), letterSpacing: 1.5),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    widget.data['name'],
                                    style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 32), fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        // Structural Context Tag
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.02)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white.withOpacity(0.15)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.adjust_rounded, color: accent.withOpacity(0.8), size: 22),
                              const SizedBox(width: 14),
                              Text("Tied around:", style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 15), color: Colors.white54)),
                              const SizedBox(width: 8),
                              Text(widget.data['tiedTo'], style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 16), color: Colors.white)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),

                        // Uses Section (Bulleted List)
                        _buildSectionTitle("Main Uses", Icons.flag_rounded, accent, width),
                        const SizedBox(height: 16),
                        _buildGlassCard(
                          width: width,
                          child: Column(
                            children: (widget.data['uses'] as List).map((use) => Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4, right: 14),
                                    child: Icon(Icons.check_circle_rounded, color: accent.withOpacity(0.9), size: 22),
                                  ),
                                  Expanded(
                                    child: Text(
                                      use.toString(),
                                      style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 16), height: 1.5, color: Colors.white),
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
                            style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 16), height: 1.6, color: Colors.white.withOpacity(0.9)),
                          ),
                        ),
                        const SizedBox(height: 45),

                        // Highly Contrasted Rajyapuraskar Exam Point
                        Container(
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft, end: Alignment.bottomRight,
                              colors: [Color(0xFF2A220A), Color(0xFF141002)],
                            ),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.6), width: 1.5),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFFFFD54F).withOpacity(0.15), blurRadius: 25, spreadRadius: 2),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD54F).withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.5)),
                                    ),
                                    child: const Icon(Icons.emoji_events_rounded, color: Color(0xFFFFD54F), size: 26),
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
                        const SizedBox(height: 50),
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

  /// Encapsulates the core aesthetic of the detail screen sections inside a frosted glass layer.
  Widget _buildGlassCard({required Widget child, required double width}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.02)],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.2),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Reusable UI component for standardizing section headers throughout the detail screen.
  Widget _buildSectionTitle(String title, IconData icon, Color accent, double width) {
    return Row(
      children: [
        Icon(icon, color: accent, size: 24),
        const SizedBox(width: 14),
        Text(
          title.toUpperCase(),
          style: AppTheme.heading(width).copyWith(
              fontSize: AppTheme.scaleText(width, 17),
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w900
          ),
        ),
      ],
    );
  }
}
