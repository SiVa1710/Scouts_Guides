import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A deeply immersive, animated audio player interface dedicated to the official Scouts & Guides Prayer.
///
/// This screen orchestrates multiple overlapping [AnimationController]s to create a 
/// calming, meditative visual experience. It features a dynamically rotating, audio-reactive 
/// "Mandala" hero graphic, a custom-painted waveform, and a specialized modal for 
/// devotional lyrics. Performance is optimized using [ValueNotifier]s for playback state.
class PrayerTab extends StatefulWidget {
  const PrayerTab({super.key});

  @override
  State<PrayerTab> createState() => _PrayerTabState();
}

class _PrayerTabState extends State<PrayerTab> with TickerProviderStateMixin {
  /// Core audio engine managing the playback state.
  final AudioPlayer _audioPlayer = AudioPlayer();

  // --- Animation Controllers ---
  /// Controls the ambient background glow expansion.
  late AnimationController _pulseController;
  /// Controls the continuous rotation of the concentric mandala rings.
  late AnimationController _rotationController;
  /// Simulates live frequency movement on the waveform.
  late AnimationController _waveController;
  /// Controls the subtle expanding/contracting glow of the play button when paused.
  late AnimationController _breathingController;

  bool _isPlaying = false;

  /// Manages the visibility state of the floating exam rule tooltip.
  bool _showRulePopup = false;
  Timer? _popupTimer;

  /// Utilized to selectively rebuild only the waveform and timer texts during playback
  /// without triggering a full screen rebuild.
  final ValueNotifier<Duration> _currentPosition = ValueNotifier(Duration.zero);
  
  /// The standard exam duration for the prayer.
  Duration _totalDuration = const Duration(seconds: 90);

  /// The official devotional lyrics structured by stanzas for the modal sheet.
  final List<String> _stanzas = [
    "Daya kar dann Bhakti ka\nHamain Paramatma Dena\nDaya Karna Hamari Atma main\nShudhata Dena",
    "Hamare Dyan main Auvo\nPrabhu Ankho main Bas Jao\nAndhere Dil main aakar Ke\nParam Jyoti Jaga Dena",
    "Bahado Prem Ki Ganga\nDilo main Prem Ka Sagar\nHamain Aapas main miljul Kar\nPrabhu Rahana Sikha Dena",
    "Hamara Karma Ho Seva\nHamara Dharma Ho Seva\nSada Eeman Ho Seva\nVa Sevak Char Bana Dena",
    "Vatan Kay Vaste Jeena\nVatan Kay Vaste Marna\nVatan Par Jaan Fida Karna\nPrabhu Ham Ko Sikha Dena",
    "Daya kar dann Bhakti ka\nHamain Paramatam Dena\nDaya Karna Hamari Atma main\nShudhata Dena"
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
    
    // Initialize animation choreography with calmer, slower durations for the prayer theme
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000))..repeat(reverse: true);
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 40));
    _waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..repeat(reverse: true);
    _breathingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);

    // Audio Player Initialization
    _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    _audioPlayer.setSource(AssetSource('audio/prayer.mp3'));

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
      if (mounted) {
        setState(() => _showRulePopup = false);
      }
    });
  }

  /// Launches the animated bottom sheet containing the devotional lyrics formatted as a hymn.
  void _openLyrics() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PrayerLyricsModal(
        stanzas: _stanzas,
        accentColor: const Color(0xFFBA68C8),
      ),
    );
  }

  @override
  void dispose() {
    _popupTimer?.cancel();
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
    const Color accentPurple = Color(0xFFBA68C8);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Ambient Background Layer
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
                  
                  // Top Navigation Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("MEDITATION", style: AppTheme.navTitle(width)),

                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: _toggleRulePopup,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _showRulePopup ? accentPurple.withOpacity(0.2) : Colors.white.withOpacity(0.08),
                                shape: BoxShape.circle,
                                border: Border.all(color: _showRulePopup ? accentPurple : Colors.white.withOpacity(0.15)),
                                boxShadow: _showRulePopup ? [BoxShadow(color: accentPurple.withOpacity(0.5), blurRadius: 15)] : [],
                              ),
                              child: Icon(Icons.workspace_premium_rounded, color: _showRulePopup ? Colors.white : accentPurple.withOpacity(0.9), size: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // High-Performance Radiant Mandala Graphic
                  Hero(
                    tag: 'prayer_art',
                    child: RepaintBoundary(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          
                          // Base Glowing Aura
                          FadeTransition(
                            opacity: _pulseController,
                            child: Container(
                              width: width * 0.70,
                              height: width * 0.70,
                              constraints: const BoxConstraints(maxWidth: 380, maxHeight: 380),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: accentPurple.withOpacity(0.15), blurRadius: 100, spreadRadius: 15)],
                              ),
                            ),
                          ),
                          
                          // Outer Ring - Slow Clockwise Rotation
                          RotationTransition(
                            turns: _rotationController,
                            child: Container(
                              width: width * 0.62,
                              height: width * 0.62,
                              constraints: const BoxConstraints(maxWidth: 280, maxHeight: 280),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: accentPurple.withOpacity(0.1), width: 1),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.05), width: 2)), margin: const EdgeInsets.all(20)),
                                  Positioned(top: 0, child: Container(width: 6, height: 6, decoration: BoxDecoration(color: accentPurple, shape: BoxShape.circle, boxShadow: [BoxShadow(color: accentPurple, blurRadius: 10)]))),
                                  Positioned(bottom: 0, child: Container(width: 6, height: 6, decoration: BoxDecoration(color: accentPurple, shape: BoxShape.circle, boxShadow: [BoxShadow(color: accentPurple, blurRadius: 10)]))),
                                ],
                              ),
                            ),
                          ),
                          
                          // Inner Ring - Counter Clockwise Rotation
                          RotationTransition(
                            turns: ReverseAnimation(_rotationController),
                            child: Container(
                              width: width * 0.52,
                              height: width * 0.52,
                              constraints: const BoxConstraints(maxWidth: 230, maxHeight: 230),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF130D1A),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 35, offset: const Offset(0, 15))],
                                border: Border.all(color: accentPurple.withOpacity(0.2), width: 1.5),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: accentPurple.withOpacity(0.1), width: 1.5)), margin: const EdgeInsets.all(15)),
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.05), width: 1)), margin: const EdgeInsets.all(35)),
                                ],
                              ),
                            ),
                          ),
                          
                          // Static Core Jewel
                          Container(
                            width: 100, height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft, end: Alignment.bottomRight,
                                colors: [accentPurple.withOpacity(0.95), const Color(0xFF4A148C)],
                              ),
                              border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                              boxShadow: [BoxShadow(color: accentPurple.withOpacity(0.5), blurRadius: 20)],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.self_improvement_rounded, color: Colors.white, size: 32),
                                const SizedBox(height: 6),
                                Text("PRAYER", style: AppTheme.heading(width).copyWith(color: Colors.white, letterSpacing: 4, fontSize: AppTheme.scaleText(width, 10))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Title & Metadata
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Scouts & Guides Prayer",
                          style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 30), color: Colors.white, fontWeight: FontWeight.w900),
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
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withOpacity(0.1)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.edit_note_rounded, color: accentPurple.withOpacity(0.9), size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Veer Deva Veer",
                                    style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: accentPurple.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: accentPurple.withOpacity(0.4)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.timer_rounded, color: accentPurple, size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                    "90 Seconds",
                                    style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Interactive Custom Waveform
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
                        // ValueListenableBuilder prevents full screen rebuilds during playback
                        child: ValueListenableBuilder<Duration>(
                            valueListenable: _currentPosition,
                            builder: (context, pos, child) {
                              double progress = _totalDuration.inMilliseconds > 0 ? pos.inMilliseconds / _totalDuration.inMilliseconds : 0.0;
                              return AnimatedBuilder(
                                animation: _waveController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: PrayerWaveformPainter(
                                      pattern: _waveformPattern,
                                      progress: progress,
                                      isPlaying: _isPlaying,
                                      waveAnimValue: _waveController.value,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white.withOpacity(0.2),
                                      glowColor: accentPurple,
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

                  const Spacer(flex: 1),

                  // Playback Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () => _seekBy(-10),
                            icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 26),
                          ),
                        ),

                        // Central Play Button
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
                                        colors: [accentPurple, accentPurple.withOpacity(0.6)],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: accentPurple.withOpacity(_isPlaying ? 0.4 : 0.4 + (_breathingController.value * 0.2)),
                                            blurRadius: _isPlaying ? 22 : 22 + (_breathingController.value * 10),
                                            offset: const Offset(0, 8)
                                        )
                                      ],
                                    ),
                                    child: Icon(
                                      _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 38,
                                    ),
                                  ),
                                );
                              }
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: () => _seekBy(10),
                            icon: const Icon(Icons.forward_10_rounded, color: Colors.white, size: 26),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: _openLyrics,
                            icon: const Icon(Icons.lyrics_rounded, color: Colors.white, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),

          // In-Screen Floating Tooltip for Exam Rules
          Positioned(
            top: MediaQuery.of(context).padding.top + 65, 
            right: 15,
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
                      color: const Color(0xFF130D1A).withOpacity(0.98),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: accentPurple.withOpacity(0.5), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20, offset: const Offset(0, 10)),
                        BoxShadow(color: accentPurple.withOpacity(0.25), blurRadius: 25, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.workspace_premium_rounded, color: accentPurple, size: 18),
                            const SizedBox(width: 8),
                            Text(
                                "RAJYAPURASKAR RULE",
                                style: AppTheme.badgeText(width, accentPurple).copyWith(fontSize: 10, letterSpacing: 1.5)
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sing with folded hands and closed eyes. Ensure the duration is exactly 1 min 30 sec.",
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
class PrayerWaveformPainter extends CustomPainter {
  final List<double> pattern;
  final double progress;
  final bool isPlaying;
  final double waveAnimValue;
  final Color activeColor;
  final Color inactiveColor;
  final Color glowColor;

  PrayerWaveformPainter({
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
  bool shouldRepaint(covariant PrayerWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.waveAnimValue != waveAnimValue || oldDelegate.isPlaying != isPlaying;
  }
}

/// A visually distinct, scrollable bottom sheet displaying the devotional lyrics.
///
/// Distinct from standard text blocks, this modal formats the text as a centered hymn,
/// separated by delicate thematic dividers. It utilizes [BackdropFilter] for an underlying 
/// glassmorphism effect.
class PrayerLyricsModal extends StatelessWidget {
  final List<String> stanzas;
  final Color accentColor;

  const PrayerLyricsModal({
    super.key,
    required this.stanzas,
    required this.accentColor
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height * 0.90, // Occupies 90% of screen height
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: Stack(
          children: [
            // Dark gradient base
            const Positioned.fill(
              child: SmoothGradientBackground(child: SizedBox()),
            ),

            // Giant ethereal watermark in the background
            Positioned(
              top: 150,
              left: -50,
              right: -50,
              child: Opacity(
                opacity: 0.04,
                child: Icon(Icons.self_improvement_rounded, size: 400, color: accentColor),
              ),
            ),

            // Glassmorphism Filter
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      border: Border(top: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5))
                  ),
                ),
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
                      Text(
                          "DEVOTIONAL LYRICS",
                          style: AppTheme.heading(width).copyWith(
                              fontSize: AppTheme.scaleText(width, 16),
                              color: accentColor.withOpacity(0.9),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3
                          )
                      ),
                      IconButton(
                          padding: const EdgeInsets.only(right: 20),
                          icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 26),
                          onPressed: () => Navigator.pop(context)
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Elegantly centered hymn layout
            Padding(
              padding: const EdgeInsets.only(top: 85),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
                  itemCount: stanzas.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        
                        // Delicate subtle divider between stanzas instead of blocky cards
                        if (index != 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(width: 40, height: 1, color: accentColor.withOpacity(0.3)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Icon(Icons.spa_rounded, color: accentColor.withOpacity(0.6), size: 14),
                                ),
                                Container(width: 40, height: 1, color: accentColor.withOpacity(0.3)),
                              ],
                            ),
                          ),

                        // Hymn Text Block
                        Text(
                          stanzas[index],
                          textAlign: TextAlign.center, // Center aligned for devotional hymns
                          style: AppTheme.heading(width).copyWith(
                            fontSize: AppTheme.scaleText(width, 18),
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.95),
                            height: 1.8,
                            fontStyle: FontStyle.italic, // Adds a devotional feel
                          ),
                        ),
                      ],
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
