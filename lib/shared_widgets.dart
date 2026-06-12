import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'theme.dart';

/// A foundational layout widget providing a consistent, premium gradient background.
///
/// Ensures visual continuity across the application by transitioning from a deep 
/// brand blue to pure black, serving as the canvas for glassmorphic elements.
class SmoothGradientBackground extends StatelessWidget {
  final Widget child;
  const SmoothGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1641D9), // Deep Brand Blue
            Color(0xFF040A18), // Rich Ambient Black
          ],
        ),
      ),
      child: child,
    );
  }
}

/// An ultra-premium, interactive card simulating a physical 3D frosted glass folder.
///
/// This widget utilizes a highly complex architecture combining two layers of custom 
/// Bezier-curved clipping paths ([TwoLayerClipper]), [BackdropFilter] for glassmorphism, 
/// and custom canvas painting ([GlassBorderPainter]) to render realistic edges and shadows.
class FolderGlassCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const FolderGlassCard({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.1, // Maintains a consistent, slightly wide structural proportion
        child: Stack(
          children: [
            
            // BACKGROUND LAYER (The Folder Back & Tab)
            Positioned.fill(
              child: ClipPath(
                clipper: TwoLayerClipper(isBack: true),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.white.withOpacity(0.04),
                    child: CustomPaint(painter: GlassBorderPainter(isBack: true)),
                  ),
                ),
              ),
            ),
            
            // FOREGROUND LAYER (The Folder Front Pocket)
            Positioned.fill(
              child: ClipPath(
                clipper: TwoLayerClipper(isBack: false),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.18),
                        Colors.white.withOpacity(0.02),
                      ],
                      stops: const [0.0, 0.4],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Renders the glowing stroke and shadow on the front lip
                      CustomPaint(painter: GlassBorderPainter(isBack: false)),
                      
                      // Centers the icon/text payload perfectly within the pocket
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(child: child),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A specialized vector clipping engine generating the intricate geometry of the folder.
///
/// Uses standard SVG-style paths with multiple [quadraticBezierTo] sweeps to create 
/// smooth, rounded corners and an asymmetrical top tab for the 'back' layer, while 
/// carving out a lowered 'pocket' for the 'front' layer.
class TwoLayerClipper extends CustomClipper<Path> {
  /// Dictates which path to return: the taller back with the tab, or the shorter front pocket.
  final bool isBack;
  
  TwoLayerClipper({required this.isBack});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double r = 18.0; // Standard Corner Radius
    double tabW = size.width * 0.35; // The width of the protruding folder tab
    double tabH = 22.0; // The depth of the tab cut-out
    double rightEdge = size.width;

    if (isBack) {
      // Path generation for the BACK of the folder (includes the raised top-left tab)
      path.moveTo(0, size.height - r);
      path.quadraticBezierTo(0, size.height, r, size.height);
      path.lineTo(rightEdge - r, size.height);
      path.quadraticBezierTo(rightEdge, size.height, rightEdge, size.height - r);
      path.lineTo(rightEdge, tabH + r);
      path.quadraticBezierTo(rightEdge, tabH, rightEdge - r, tabH);
      path.lineTo(tabW + 25, tabH);
      path.quadraticBezierTo(tabW + 8, tabH, tabW, tabH - 12); // Swooping curve to the tab
      path.lineTo(tabW, r);
      path.quadraticBezierTo(tabW, 0, tabW - r, 0);
      path.lineTo(r, 0);
      path.quadraticBezierTo(0, 0, 0, r);
      path.close();
    } else {
      // Path generation for the FRONT pocket of the folder (cut lower to reveal the back)
      double pocketTop = 35.0;
      path.moveTo(0, size.height - r);
      path.quadraticBezierTo(0, size.height, r, size.height);
      path.lineTo(rightEdge - r, size.height);
      path.quadraticBezierTo(rightEdge, size.height, rightEdge, size.height - r);
      path.lineTo(rightEdge, pocketTop + r);
      path.quadraticBezierTo(rightEdge, pocketTop, rightEdge - r, pocketTop);
      path.lineTo(r, pocketTop);
      path.quadraticBezierTo(0, pocketTop, 0, pocketTop + r);
      path.close();
    }
    return path;
  }
  
  @override 
  bool shouldReclip(oldClipper) => true;
}

/// A high-performance canvas painter that renders strokes and shadows strictly along 
/// the perimeter of the [TwoLayerClipper] paths.
class GlassBorderPainter extends CustomPainter {
  final bool isBack;
  GlassBorderPainter({required this.isBack});

  @override
  void paint(Canvas canvas, Size size) {
    final path = TwoLayerClipper(isBack: isBack).getClip(size);
    
    // Configures the frosted edge highlight
    Paint strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(isBack ? 0.05 : 0.15);

    // Only cast a shadow from the front pocket layer to simulate 3D depth over the back layer
    if (!isBack) {
      canvas.drawShadow(path, Colors.black.withOpacity(0.5), 8.0, false);
    }
    canvas.drawPath(path, strokePaint);
  }
  
  @override 
  bool shouldRepaint(oldDelegate) => false;
}

/// A self-contained, lifecycle-aware AdMob Banner widget.
///
/// Automatically manages the loading state and disposes of the ad safely when 
/// removed from the widget tree to prevent memory leaks.
class BottomBannerAd extends StatefulWidget {
  const BottomBannerAd({super.key});
  @override
  State<BottomBannerAd> createState() => _BottomBannerAdState();
}

class _BottomBannerAdState extends State<BottomBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      // NOTE: Replace with production Ad Unit ID before release
      adUnitId: 'ca-app-pub-9575686800896863/9103367852',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) => setState(() => _isLoaded = true),
        onAdFailedToLoad: (ad, error) => ad.dispose(),
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded ? SizedBox(height: 50, child: AdWidget(ad: _bannerAd!)) : const SizedBox.shrink();
  }
}

/// An ultra-premium, floating bottom navigation bar mimicking modern OS UI standards.
///
/// Features include:
/// * Glassmorphic blurred backdrop.
/// * A neon "spotlight" indicator that physically slides to the active tab via [AnimatedPositioned].
/// * Responsive sizing (caps width on tablet/desktop to avoid unreadable stretch).
/// * Hardware-accelerated icon scaling on selection.
class FloatingPillNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const FloatingPillNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    
    // Responsive width clamping for web/tablet interfaces
    final double navWidth = width > 800 ? 500 : width - 40;

    final List<IconData> icons = [
      Icons.grid_view_rounded,           // Dashboard/Home
      Icons.music_note_rounded,          // Flag Song
      Icons.self_improvement_rounded,    // Prayer/Meditation
      Icons.public_rounded,              // National Anthem
      Icons.volunteer_activism_rounded,  // Good Turn Diary
    ];

    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 20,
      left: (width - navWidth) / 2,
      child: Container(
        width: navWidth,
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C).withOpacity(0.85),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 30, offset: const Offset(0, 15)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Stack(
              children: [
                
                // 1. THE NEON SPOTLIGHT HIGHLIGHT
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutExpo,
                  // Dynamically calculates the offset based on the selected index
                  left: (navWidth / icons.length) * selectedIndex,
                  top: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: SizedBox(
                      width: navWidth / icons.length,
                      height: 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Glowing top bar
                          Container(
                            width: 45,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6BB8FF),
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
                              boxShadow: [
                                BoxShadow(color: const Color(0xFF6BB8FF), blurRadius: 12, spreadRadius: 2),
                                BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 4),
                              ],
                            ),
                          ),
                          // Sweeping light gradient
                          Expanded(
                            child: Container(
                              width: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF6BB8FF).withOpacity(0.3),
                                    const Color(0xFF6BB8FF).withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // 2. THE TOUCHABLE ICONS ROW
                Row(
                  children: List.generate(icons.length, (index) {
                    bool isSelected = selectedIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          onItemTapped(index);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 75,
                          child: AnimatedScale(
                            scale: isSelected ? 1.15 : 1.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutBack,
                            child: Icon(
                              icons[index],
                              color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A singleton utility bridging application state with Google Mobile Ads.
///
/// Optimizes monetization while protecting user experience by aggressively pre-loading 
/// interstitial ads and utilizing a strict click-frequency threshold before rendering.
class AdManager {
  static InterstitialAd? _interstitialAd;
  static int _clickCounter = 0;

  /// Defines how many navigable clicks must occur before an ad is injected.
  static const int _adFrequency = 3;

  /// Proactively fetches and caches an interstitial ad into memory to prevent loading delays.
  static void loadInterstitialAd() {
    InterstitialAd.load(
      // NOTE: Replace with production Ad Unit ID before release
      adUnitId: 'ca-app-pub-9575686800896863/3128561414',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
        },
      ),
    );
  }

  /// Evaluates click frequency and selectively displays a cached ad.
  /// 
  /// Regardless of whether an ad is successfully shown, this method guarantees 
  /// execution of the [onContinue] callback (e.g., `Navigator.push`), ensuring 
  /// the app never hangs if the ad network fails.
  static void showInterstitialAdSafely(VoidCallback onContinue) {
    _clickCounter++;

    // Proceed if the frequency threshold is hit AND an ad is ready
    if (_clickCounter % _adFrequency == 0 && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadInterstitialAd(); // Immediately begin caching the next ad
          onContinue(); // Resume user navigation
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadInterstitialAd(); 
          onContinue(); // Failsafe: Continue navigation even on ad rendering errors
        },
      );
      
      _interstitialAd!.show();
      _interstitialAd = null; // Clear reference to prevent accidental double-showing
    } else {
      // Threshold not met or ad not ready. Yield instantly to the callback.
      onContinue();
    }
  }
}
