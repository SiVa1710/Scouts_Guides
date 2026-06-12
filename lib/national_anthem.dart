import 'dart:ui';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A deeply immersive, animated audio player interface dedicated to the Indian National Anthem.
///
/// This screen orchestrates multiple overlapping [AnimationController]s to create a 
/// cinematic visual experience. It features a dynamically rotating, audio-reactive 
/// "Sunburst" hero graphic, a custom-painted waveform, and meticulously timed 
/// entrance animations for all UI components.
class NationalAnthemTab extends StatefulWidget {
  const NationalAnthemTab({super.key});

  @override
  State<NationalAnthemTab> createState() => _NationalAnthemTabState();
}

class _NationalAnthemTabState extends State<NationalAnthemTab> with TickerProviderStateMixin {
  /// Core audio engine managing the playback state.
  final AudioPlayer _audioPlayer = AudioPlayer();

  // --- Animation Controllers ---
  /// Manages the sequential, cinematic slide-and-fade entrance of the entire screen UI.
  late AnimationController _entranceController;
  /// Controls the ambient background glow expansion.
  late AnimationController _pulseController;
  /// Controls the continuous rotation of the sunburst graphic during playback.
  late AnimationController _rotationController;
  /// Simulates live frequency movement on the waveform.
  late AnimationController _waveController;
  /// Controls the subtle expanding/contracting glow of the play button when paused.
  late AnimationController _breathingController;

  bool _isPlaying = false;
  
  // Tooltip state management
  bool _showRulePopup = false;
  Timer? _popupTimer;

  /// Utilized to selectively rebuild only the waveform and timer texts during playback
  /// without triggering a full screen rebuild.
  final ValueNotifier<Duration> _currentPosition = ValueNotifier(Duration.zero);
  Duration _totalDuration = const Duration(seconds: 52);

  /// The official lyrics structured by stanzas for the modal sheet.
  final List<String> _stanzas = [
    "Jana Gana Mana Adhinaayaka Jaya Hey,\nBharata Bhaagya Vidhaataa\nPunjab Sindhu Gujarat Maraatha,\nDraavid Utkal Banga",
    "Vindhya Himaachal Yamuna Ganga,\nUchchhal Jaladhi Taranga\nTav Shubh Naamey Jaagey,\nTav Shubh Aashish Maange\nGaahey Tav Jayagaathaa",
    "Jana Gana Mangal Daayaka,\nJaya Hey Bhaarat Bhaagya Vidhaataa\nJaya Hey, Jaya Hey, Jaya Hey,\nJaya Jaya Jaya, Jaya Hey"
  ];

  /// Static amplitude values used to render the custom waveform visualizer.
  final List<double> _waveformPattern = [
    0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.45, 0.55, 0.65, 0.70, 0.85, 0.90, 0.95, 1.00,
    0.95, 0.85, 0.75, 0.70, 0.75, 0.80, 0.90, 0.95, 1.00, 0.95, 0.90, 0.85, 0.75, 0.70, 0.75,
    0.80, 0.85, 0.75, 0.65, 0.55, 0.45, 0.35, 0.25, 0.20, 0.15, 0.10, 0.08, 0.05, 0.05, 0.05
  ];

  @override
  void initState() {
    super.initState();
    
    // 1. Cinematic Page Load Sequence
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();

    // 2. Continuous Ambient Effects Choreography
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000))..repeat(reverse: true);
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat(reverse: true);
    _breathingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);

    // Audio Player Initialization
    _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    _audioPlayer.setSource(AssetSource('audio/nationalanthem.mp3'));

    _audioPlayer.onDurationChanged.listen((Duration d) {
      if (!mounted) return;
      setState(() => _totalDuration = d);
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      if (!mounted) return;
      _currentPosition.value = p;
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      if (!mounted) return;
      _onSongComplete();
    });
  }

  /// Handles Play/Pause logic and synchronizes all visual animations accordingly.
  void _togglePlay() async {
    HapticFeedback.heavyImpact();
    if (_isPlaying) {
      await _audioPlayer.pause();
      _rotationController.stop();
      _waveController.stop();
      _breathingController.repeat(reverse: true);
      setState(() => _isPlaying = false);
    } else {
      try {
        await _audioPlayer.resume();
        _rotationController.repeat();
        _waveController.repeat(reverse: true);
        _breathingController.stop();
        _breathingController.value = 0.0;
        setState(() => _isPlaying = true);
      } catch (e) {
        // Handle audio load errors gracefully
      }
    }
  }

  /// Resets state and triggers wind-down animations when the song finishes naturally.
  void _onSongComplete() {
    // Smooth deceleration effect for the rotating graphic
    _rotationController.animateTo(0.0, duration: const Duration(milliseconds: 1200), curve: Curves.easeOutCubic);
    _waveController.stop();
    _breathingController.repeat(reverse: true);
    setState(() {
      _isPlaying = false;
      _currentPosition.value = Duration.zero;
    });
  }

  /// Skips forward or backward in the audio track.
  void _seekBy(int seconds) {
    HapticFeedback.selectionClick();
    int newTime = (_currentPosition.value.inSeconds + seconds).clamp(0, _totalDuration.inSeconds);
    final position = Duration(seconds: newTime);
    _audioPlayer.seek(position);
    _currentPosition.value = position;
  }

  /// Direct seek operation for the waveform tap gesture.
  void _seekAudio(double value) {
    final position = Duration(milliseconds: value.toInt());
    _audioPlayer.seek(position);
    _currentPosition.value = position;
  }

  /// Formats duration objects into a standard MM:SS string.
  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${duration.inMinutes.remainder(60)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  /// Triggers a brief, auto-dismissing tooltip containing exam criteria.
  void _toggleRulePopup() {
    HapticFeedback.selectionClick();
    setState(() => _showRulePopup = true);

    _popupTimer?.cancel();
    _popupTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showRulePopup = false);
    });
  }

  /// Launches the animated bottom sheet containing the song's lyrics formatted as a plaque.
  void _openLyrics() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnthemLyricsModal(
        stanzas: _stanzas,
        accentColor: const Color(0xFFFFB74D),
      ),
    );
  }

  @override
  void dispose() {
    _popupTimer?.cancel();
    _entranceController.dispose();
    _pulseController.dispose();
    _rotationController.dispose();
    _waveController.dispose();
    _breathingController.dispose();
    _currentPosition.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const Color accentGold = Color(0xFFFFB74D);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Ambient Layer
          const Positioned.fill(
            child: RepaintBoundary(
              child: SmoothGradientBackground(child: SizedBox()),
            ),
          ),

          // Main Interactive Layer
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                children: [
                  
                  // --- TOP BAR (Entrance Anim: 0.0 to 0.4) ---
                  FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4, curve: Curves.easeOut))),
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.4, curve: Curves.easeOut))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text("NATIONAL ANTHEM", style: AppTheme.navTitle(width)),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: _toggleRulePopup,
                                icon: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _showRulePopup ? accentGold.withOpacity(0.2) : Colors.white.withOpacity(0.08),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: _showRulePopup ? accentGold : Colors.white.withOpacity(0.15)),
                                    boxShadow: _showRulePopup ? [BoxShadow(color: accentGold.withOpacity(0.5), blurRadius: 15)] : [],
                                  ),
                                  child: Icon(Icons.workspace_premium_rounded, color: _showRulePopup ? Colors.white : accentGold.withOpacity(0.9), size: 22),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // --- RADIANT SUNBURST HERO GRAPHIC (Entrance Anim: 0.2 to 0.7) ---
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.7, curve: Curves.easeOutBack))),
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.2, 0.7, curve: Curves.easeOut))),
                      child: Hero(
                        tag: 'anthem_art',
                        child: RepaintBoundary(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              
                              // AUDIO-REACTIVE AURA
                              AnimatedBuilder(
                                  animation: _waveController,
                                  builder: (context, child) {
                                    // Spreads and brightens dynamically when playing
                                    double dynamicSpread = _isPlaying ? 10 + (_waveController.value * 25) : 10 + (_pulseController.value * 5);
                                    double dynamicBlur = _isPlaying ? 80 + (_waveController.value * 40) : 80;
                                    return Container(
                                      width: width * 0.70,
                                      height: width * 0.70,
                                      constraints: const BoxConstraints(maxWidth: 380, maxHeight: 380),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(color: accentGold.withOpacity(0.20), blurRadius: dynamicBlur, spreadRadius: dynamicSpread)],
                                      ),
                                    );
                                  }
                              ),
                              
                              // Outward Rotating Rays
                              RotationTransition(
                                turns: _rotationController,
                                child: Container(
                                  width: width * 0.62,
                                  height: width * 0.62,
                                  constraints: const BoxConstraints(maxWidth: 280, maxHeight: 280),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: accentGold.withOpacity(0.15), width: 1.5),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    // Generates 12 evenly spaced, intersecting lines
                                    children: List.generate(12, (index) {
                                      return Transform.rotate(
                                        angle: (index * 15) * math.pi / 180,
                                        child: Container(
                                          width: width * 0.62,
                                          height: 1.5,
                                          decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, accentGold.withOpacity(0.3), Colors.transparent])),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              
                              // Inward Counter-Rotating Ring
                              RotationTransition(
                                turns: ReverseAnimation(_rotationController),
                                child: Container(
                                  width: width * 0.50,
                                  height: width * 0.50,
                                  constraints: const BoxConstraints(maxWidth: 220, maxHeight: 220),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF0F0A02),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 40, offset: const Offset(0, 15))],
                                    border: Border.all(color: accentGold.withOpacity(0.25), width: 1.5),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.06), width: 1.5)), margin: const EdgeInsets.all(20)),
                                    ],
                                  ),
                                ),
                              ),
                              
                              // Central Core Emblem
                              Container(
                                width: 100, height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFFF9933), Color(0xFF138808)]),
                                  border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 10, spreadRadius: -2)],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.account_balance_rounded, color: Colors.white, size: 30),
                                    const SizedBox(height: 4),
                                    Text("INDIA", style: AppTheme.heading(width).copyWith(color: Colors.white, letterSpacing: 4, fontSize: AppTheme.scaleText(width, 11), fontWeight: FontWeight.w900)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // --- TITLE & INFO METADATA (Entrance Anim: 0.4 to 0.8) ---
                  FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.4, 0.8, curve: Curves.easeOut))),
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.4, 0.8, curve: Curves.easeOutQuart))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Jana Gana Mana",
                              style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 32), color: Colors.white, fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.1))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit_note_rounded, color: accentGold.withOpacity(0.9), size: 16),
                                      const SizedBox(width: 8),
                                      Text("Rabindranath Tagore", style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white70, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(color: accentGold.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: accentGold.withOpacity(0.4))),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.timer_rounded, color: accentGold, size: 16),
                                      const SizedBox(width: 8),
                                      Text("52 Seconds", style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // --- INTERACTIVE WAVEFORM & TIMERS (Entrance Anim: 0.6 to 1.0) ---
                  FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.6, 1.0, curve: Curves.easeOut))),
                    child: Column(
                      children: [
                        
                        // Custom Waveform Touch Target
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: GestureDetector(
                            onTapDown: (details) {
                              double tapPosition = details.localPosition.dx;
                              double percentage = tapPosition / (width - 60);
                              _seekAudio(percentage.clamp(0.0, 1.0) * _totalDuration.inMilliseconds);
                            },
                            child: Container(
                              height: 60,
                              color: Colors.transparent,
                              width: double.infinity,
                              // Rebuilds only the waveform dynamically as audio progresses
                              child: ValueListenableBuilder<Duration>(
                                  valueListenable: _currentPosition,
                                  builder: (context, pos, child) {
                                    double progress = _totalDuration.inMilliseconds > 0 ? pos.inMilliseconds / _totalDuration.inMilliseconds : 0.0;
                                    return AnimatedBuilder(
                                      animation: _waveController,
                                      builder: (context, child) {
                                        return CustomPaint(
                                          painter: AnthemWaveformPainter(
                                            pattern: _waveformPattern,
                                            progress: progress,
                                            isPlaying: _isPlaying,
                                            waveAnimValue: _waveController.value,
                                            activeColor: Colors.white,
                                            inactiveColor: Colors.white.withOpacity(0.2),
                                            glowColor: accentGold,
                                          ),
                                        );
                                      },
                                    );
                                  }
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        
                        // Numeric Timers
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ValueListenableBuilder<Duration>(
                              valueListenable: _currentPosition,
                              builder: (context, pos, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_formatTime(pos), style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white54, fontWeight: FontWeight.bold)),
                                    Text(_formatTime(_totalDuration), style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white54, fontWeight: FontWeight.bold)),
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 1),

                  // --- PLAYBACK CONTROLS (Entrance Anim: 0.8 to 1.0) ---
                  FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entranceController, curve: const Interval(0.8, 1.0, curve: Curves.easeOut))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                            child: IconButton(onPressed: () => _seekBy(-10), icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 26)),
                          ),

                          GestureDetector(
                            onTap: _togglePlay,
                            child: AnimatedBuilder(
                                animation: _breathingController,
                                builder: (context, child) {
                                  // Subtle scale animation when the track is paused
                                  double scale = _isPlaying ? 1.0 : 1.0 + (_breathingController.value * 0.05);
                                  return Transform.scale(
                                    scale: scale,
                                    child: Container(
                                      height: 72, width: 72,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                                          colors: [accentGold, const Color(0xFFC07000)], // Saffron to deep orange
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(color: accentGold.withOpacity(_isPlaying ? 0.4 : 0.4 + (_breathingController.value * 0.2)), blurRadius: _isPlaying ? 22 : 22 + (_breathingController.value * 10), offset: const Offset(0, 8))
                                        ],
                                      ),
                                      child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 38),
                                    ),
                                  );
                                }
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                            child: IconButton(onPressed: () => _seekBy(10), icon: const Icon(Icons.forward_10_rounded, color: Colors.white, size: 26)),
                          ),

                          Container(
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                            child: IconButton(onPressed: _openLyrics, icon: const Icon(Icons.lyrics_rounded, color: Colors.white, size: 24)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),

          // --- FIXED TOOLTIP ALIGNMENT ---
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            right: 20,
            child: IgnorePointer(
              ignoring: !_showRulePopup,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showRulePopup ? 1.0 : 0.0,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  offset: _showRulePopup ? Offset.zero : const Offset(0, -0.1),
                  child: Container(
                    width: 260,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF040A18).withOpacity(0.98),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accentGold.withOpacity(0.5), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20, offset: const Offset(0, 10)),
                        BoxShadow(color: accentGold.withOpacity(0.25), blurRadius: 25, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.workspace_premium_rounded, color: accentGold, size: 18),
                            const SizedBox(width: 8),
                            Text("RAJYAPURASKAR RULE", style: AppTheme.badgeText(width, accentGold).copyWith(fontSize: 10, letterSpacing: 1.5)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Stand in the Savadhan (Attention) position. Ensure the duration is exactly 52 seconds.",
                          style: AppTheme.bodyText(width).copyWith(color: Colors.white, fontSize: 13.5, fontWeight: FontWeight.w600, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A high-performance custom painter responsible for rendering the audio waveform.
///
/// Iterates over a predefined amplitude [pattern]. Based on the [progress] parameter, 
/// it conditionally applies a glowing, active style to the played segments, leaving 
/// unplayed segments dimmed. When [isPlaying] is true, it layers a micro-animation
/// ([waveAnimValue]) to simulate the "bounce" of live audio playback frequencies.
class AnthemWaveformPainter extends CustomPainter {
  final List<double> pattern;
  final double progress;
  final bool isPlaying;
  final double waveAnimValue;
  final Color activeColor;
  final Color inactiveColor;
  final Color glowColor;

  AnthemWaveformPainter({
    required this.pattern,
    required this.progress,
    required this.isPlaying,
    required this.waveAnimValue,
    required this.activeColor,
    required this.inactiveColor,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final int barCount = pattern.length;
    final double barWidth = 3.5;
    final double spacing = (size.width - (barCount * barWidth)) / (barCount - 1);

    final activePaint = Paint()..color = activeColor..strokeCap = StrokeCap.round..strokeWidth = barWidth;
    final inactivePaint = Paint()..color = inactiveColor..strokeCap = StrokeCap.round..strokeWidth = barWidth;
    
    // MaskFilter used to generate an ambient neon glow behind the active waveform
    final glowPaint = Paint()
      ..color = glowColor.withOpacity(0.45)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = barWidth
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    for (int i = 0; i < barCount; i++) {
      double x = i * (barWidth + spacing);
      bool isPlayed = (i / barCount) <= progress;
      double baseHeight = 6 + (pattern[i] * 40);

      // Micro-animation calculation to create "live" bounce effect on current playback node
      if (isPlaying && isPlayed && (i / barCount) >= (progress - 0.05) && (i / barCount) <= (progress + 0.05)) {
        baseHeight += (waveAnimValue * 8);
      }

      baseHeight = baseHeight.clamp(6.0, 50.0);
      double topY = (size.height - baseHeight) / 2;
      double bottomY = topY + baseHeight;

      if (isPlayed) {
        // Draw the soft blur behind the bar first, then paint the solid line on top
        canvas.drawLine(Offset(x, topY), Offset(x, bottomY), glowPaint);
        canvas.drawLine(Offset(x, topY), Offset(x, bottomY), activePaint);
      } else {
        canvas.drawLine(Offset(x, topY), Offset(x, bottomY), inactivePaint);
      }
    }
  }

  /// Only repaints if the playback position or the micro-animation ticks update.
  @override
  bool shouldRepaint(covariant AnthemWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.waveAnimValue != waveAnimValue || oldDelegate.isPlaying != isPlaying;
  }
}

/// A visually distinct, scrollable bottom sheet displaying the official lyrics formatted 
/// like a commemorative plaque.
///
/// Implements advanced UI techniques like [BackdropFilter] for an underlying glassmorphism 
/// effect, embedded box shadows to create inset depth, and complex staggered entrance 
/// animations for the individual lyrical stanzas.
class AnthemLyricsModal extends StatefulWidget {
  final List<String> stanzas;
  final Color accentColor;

  const AnthemLyricsModal({
    super.key,
    required this.stanzas,
    required this.accentColor
  });

  @override
  State<AnthemLyricsModal> createState() => _AnthemLyricsModalState();
}

class _AnthemLyricsModalState extends State<AnthemLyricsModal> with SingleTickerProviderStateMixin {
  /// Controls the staggered fade-and-slide entrance of the lyrics
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: Stack(
          children: [
            // Deep ambient background
            const Positioned.fill(
              child: SmoothGradientBackground(child: SizedBox()),
            ),

            // Giant ethereal watermark
            Positioned(
              top: 150, left: -50, right: -50,
              child: Opacity(opacity: 0.04, child: Icon(Icons.account_balance_rounded, size: 400, color: widget.accentColor)),
            ),

            // Rich Glassmorphism Base
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.5), border: Border(top: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5)))),
              ),
            ),

            // Fixed Header and Drag Handle
            Positioned(
              top: 16, left: 0, right: 0,
              child: Column(
                children: [
                  Container(width: 42, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(10))),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 60),
                      Text("OFFICIAL LYRICS", style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 16), color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2)),
                      IconButton(padding: const EdgeInsets.only(right: 20), icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 26), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                ],
              ),
            ),

            // Scrollable Animated Plaque Content
            Padding(
              padding: const EdgeInsets.only(top: 85),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 10, 24, 80),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: widget.accentColor.withOpacity(0.3), width: 1.5),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 10)),
                      BoxShadow(color: widget.accentColor.withOpacity(0.04), blurRadius: 60, spreadRadius: 10), // Inner Plaque Glow
                    ],
                  ),
                  child: Column(
                    children: [
                      
                      // Title block (Fades in first: 0.0 to 0.3)
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: const Interval(0.0, 0.3, curve: Curves.easeOut))),
                        child: SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: const Interval(0.0, 0.3, curve: Curves.easeOut))),
                          child: Column(
                            children: [
                              Icon(Icons.auto_awesome_rounded, color: widget.accentColor.withOpacity(0.8), size: 40),
                              const SizedBox(height: 10),
                              Text("Jana Gana Mana", style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 24), color: widget.accentColor)),
                              const SizedBox(height: 4),
                              Text("By Rabindranath Tagore", style: AppTheme.bodyText(width).copyWith(fontStyle: FontStyle.italic, color: Colors.white60)),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),

                      // Staggered Stanzas mapped dynamically
                      ...List.generate(widget.stanzas.length, (index) {
                        
                        // Calculates shifting intervals based on the stanza's index to create a waterfall effect
                        double start = 0.2 + (index * 0.2);
                        double end = start + 0.4;
                        if (end > 1.0) end = 1.0;

                        return FadeTransition(
                          opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Interval(start, end, curve: Curves.easeOut))),
                          child: SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: Interval(start, end, curve: Curves.easeOutQuart))),
                            child: Column(
                              children: [
                                Text(
                                  widget.stanzas[index],
                                  textAlign: TextAlign.center,
                                  style: AppTheme.heading(width).copyWith(
                                    fontSize: AppTheme.scaleText(width, 18),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white.withOpacity(0.95),
                                    height: 2.0,
                                    letterSpacing: 0.5,
                                  ),
                                ),

                                // Elegant Fading Gold Separator (omitted after the final stanza)
                                if (index != widget.stanzas.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 35),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 80, height: 1.5,
                                            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, widget.accentColor.withOpacity(0.5)]))
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Icon(Icons.star_rounded, color: widget.accentColor.withOpacity(0.8), size: 14),
                                        ),
                                        Container(
                                            width: 80, height: 1.5,
                                            decoration: BoxDecoration(gradient: LinearGradient(colors: [widget.accentColor.withOpacity(0.5), Colors.transparent]))
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),

                      const SizedBox(height: 25),
                      
                      // Footer block (Fades in last)
                      FadeTransition(
                        opacity: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: const Interval(0.8, 1.0, curve: Curves.easeIn))),
                        child: Column(
                          children: [
                            Icon(Icons.auto_awesome_rounded, color: widget.accentColor.withOpacity(0.8), size: 30),
                            const SizedBox(height: 15),
                            Text("Adopted January 24, 1950", style: AppTheme.badgeText(width, Colors.white38)),
                          ],
                        ),
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
