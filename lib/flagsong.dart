import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A premium, animated audio player interface dedicated to the official Flag Song.
///
/// This screen leverages multiple synchronized [AnimationController]s to create
/// a highly engaging user experience, including a rotating vinyl record, a pulsating 
/// background aura, and a dynamically painted waveform that responds to the audio's 
/// playback state. Performance is optimized using [ValueNotifier]s to prevent 
/// unnecessary widget tree rebuilds during playback.
class FlagSongTab extends StatefulWidget {
  const FlagSongTab({super.key});

  @override
  State<FlagSongTab> createState() => _FlagSongTabState();
}

class _FlagSongTabState extends State<FlagSongTab> with TickerProviderStateMixin {
  /// Core audio playback engine
  final AudioPlayer _audioPlayer = AudioPlayer();

  // --- Animation Controllers ---
  /// Controls the ambient background glow expansion
  late AnimationController _pulseController;
  /// Controls the continuous rotation of the vinyl record
  late AnimationController _recordController;
  /// Simulates live frequency movement on the waveform
  late AnimationController _waveController;
  /// Controls the subtle expanding/contracting glow of the play button when paused
  late AnimationController _breathingController;

  bool _isPlaying = false;

  // Tooltip state management
  bool _showRulePopup = false;
  Timer? _popupTimer;

  /// Utilized to selectively rebuild only the waveform and timer texts during playback
  final ValueNotifier<Duration> _currentPosition = ValueNotifier(Duration.zero);
  Duration _totalDuration = const Duration(seconds: 45);

  /// The official lyrics structured by stanzas for the modal sheet
  final List<String> _stanzas = [
    "Bharat scout guide jhanda\nUncha sada rahega,\n\nUncha sada rahega jhanda\nUncha sada rahega.",
    "Neela rang gagan sa vistrut\nBhatru bhav failatha,\n\nTridal kamal nit teen pratigna\nonki yad dilate.",
    "Aur chakr kehata hei\nPrathipal agey kadam badega.",
    "Uncha sada rahega jhanda\nUncha sada rahega.\n\nBharat scout guide jhanda\nUncha sada rahega."
  ];

  /// Static amplitude values used to render the custom waveform visualizer
  final List<double> _waveformPattern = [
    0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.45, 0.55, 0.65, 0.70, 0.85, 0.90, 0.95, 1.00,
    0.95, 0.85, 0.75, 0.70, 0.75, 0.80, 0.90, 0.95, 1.00, 0.95, 0.90, 0.85, 0.75, 0.70, 0.75,
    0.80, 0.85, 0.75, 0.65, 0.55, 0.45, 0.35, 0.25, 0.20, 0.15, 0.10, 0.08, 0.05, 0.05, 0.05
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize animation choreography
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500))..repeat(reverse: true);
    _recordController = AnimationController(vsync: this, duration: const Duration(seconds: 15));
    _waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400))..repeat(reverse: true);
    _breathingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);

    // Audio Player Setup
    _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    _audioPlayer.setSource(AssetSource('audio/flagsong.mp3'));

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

  /// Handles Play/Pause logic and synchronizes all visual animations accordingly
  void _togglePlay() async {
    HapticFeedback.heavyImpact();
    if (_isPlaying) {
      await _audioPlayer.pause();
      _recordController.stop();
      _waveController.stop();
      _breathingController.repeat(reverse: true);
      setState(() => _isPlaying = false);
    } else {
      try {
        await _audioPlayer.resume();
        _recordController.repeat();
        _waveController.repeat(reverse: true);
        _breathingController.stop();
        _breathingController.value = 0.0;
        setState(() => _isPlaying = true);
      } catch (e) {
        // Handle audio load errors gracefully
      }
    }
  }

  /// Resets state and animations when the song finishes naturally
  void _onSongComplete() {
    // Spin down effect for the record
    _recordController.animateTo(0.0, duration: const Duration(milliseconds: 800), curve: Curves.easeOutCubic);
    _waveController.stop();
    _breathingController.repeat(reverse: true);
    setState(() {
      _isPlaying = false;
      _currentPosition.value = Duration.zero;
    });
  }

  /// Skips forward or backward in the audio track
  void _seekBy(int seconds) {
    HapticFeedback.selectionClick();
    int newTime = (_currentPosition.value.inSeconds + seconds).clamp(0, _totalDuration.inSeconds);
    final position = Duration(seconds: newTime);
    _audioPlayer.seek(position);
    _currentPosition.value = position;
  }

  /// Direct seek operation for the waveform tap gesture
  void _seekAudio(double value) {
    final position = Duration(milliseconds: value.toInt());
    _audioPlayer.seek(position);
    _currentPosition.value = position;
  }

  /// Formats duration objects into a standard MM:SS string
  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${duration.inMinutes.remainder(60)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  /// Triggers a brief, auto-dismissing tooltip containing exam criteria
  void _toggleRulePopup() {
    HapticFeedback.selectionClick();
    setState(() => _showRulePopup = true);

    _popupTimer?.cancel();
    _popupTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showRulePopup = false);
    });
  }

  /// Launches the animated bottom sheet containing the song's lyrics
  void _openLyrics() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FlagSongLyricsModal(
        stanzas: _stanzas,
        accentColor: const Color(0xFF6BB8FF),
      ),
    );
  }

  @override
  void dispose() {
    _popupTimer?.cancel();
    _pulseController.dispose();
    _recordController.dispose();
    _waveController.dispose();
    _breathingController.dispose();
    _currentPosition.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const Color accentCyan = Color(0xFF6BB8FF);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Gradient Layer
          const Positioned.fill(
            child: RepaintBoundary(
              child: SmoothGradientBackground(child: SizedBox()),
            ),
          ),

          // Main UI Layer
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Column(
                children: [
                  
                  // Top Navigation Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text("FLAG SONG", style: AppTheme.navTitle(width)),

                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: _toggleRulePopup,
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _showRulePopup ? accentCyan.withOpacity(0.2) : Colors.white.withOpacity(0.08),
                                shape: BoxShape.circle,
                                border: Border.all(color: _showRulePopup ? accentCyan : Colors.white.withOpacity(0.15)),
                                boxShadow: _showRulePopup ? [BoxShadow(color: accentCyan.withOpacity(0.5), blurRadius: 15)] : [],
                              ),
                              child: Icon(Icons.workspace_premium_rounded, color: _showRulePopup ? Colors.white : accentCyan.withOpacity(0.9), size: 22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Animated Vinyl Record Display
                  Hero(
                    tag: 'album_art',
                    child: RepaintBoundary(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Ambient pulsing glow
                          FadeTransition(
                            opacity: _pulseController,
                            child: Container(
                              width: width * 0.65,
                              height: width * 0.65,
                              constraints: const BoxConstraints(maxWidth: 350, maxHeight: 350),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: accentCyan.withOpacity(0.20), blurRadius: 75, spreadRadius: 8)],
                              ),
                            ),
                          ),
                          // Rotating record body
                          RotationTransition(
                            turns: _recordController,
                            child: Container(
                              width: width * 0.58,
                              height: width * 0.58,
                              constraints: const BoxConstraints(maxWidth: 250, maxHeight: 250),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF090B11),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.75), blurRadius: 35, offset: const Offset(0, 15))],
                                border: Border.all(color: Colors.white.withOpacity(0.07), width: 1.2),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Record grooves
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.04), width: 1.2)), margin: const EdgeInsets.all(10)),
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.03), width: 1)), margin: const EdgeInsets.all(24)),
                                  Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.04), width: 1.2)), margin: const EdgeInsets.all(40)),

                                  // Record Center Label
                                  Container(
                                    width: 90, height: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFFFF9933).withOpacity(0.9), // Saffron
                                          accentCyan.withOpacity(0.95), // Ashoka Blue
                                          const Color(0xFF138808).withOpacity(0.9), // Green
                                        ],
                                      ),
                                      border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
                                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 8, spreadRadius: -2)],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.tour_rounded, color: Colors.white, size: 26),
                                        const SizedBox(height: 4),
                                        Text("BS&G", style: AppTheme.heading(width).copyWith(color: Colors.white, letterSpacing: 4, fontSize: AppTheme.scaleText(width, 11))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Dynamic sheen/reflection overlay
                          Container(
                            width: width * 0.58, height: width * 0.58,
                            constraints: const BoxConstraints(maxWidth: 250, maxHeight: 250),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  Colors.white.withOpacity(0.09),
                                  Colors.white.withOpacity(0.0),
                                  Colors.white.withOpacity(0.09),
                                  Colors.white.withOpacity(0.0),
                                ],
                                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                              ),
                            ),
                          ),
                          // Spindle hole
                          Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2))),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // Track Info Metadata
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "The Flag Song",
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
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withOpacity(0.1)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.spatial_audio_off_rounded, color: accentCyan.withOpacity(0.9), size: 16),
                                  const SizedBox(width: 8),
                                  Text("Shri Shyamlal Gupta 'Parshad'", style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white70, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: accentCyan.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: accentCyan.withOpacity(0.4)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.timer_rounded, color: accentCyan, size: 16),
                                  const SizedBox(width: 8),
                                  Text("45 Seconds", style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white, fontWeight: FontWeight.bold)),
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
                        // ValueListenableBuilder prevents the entire screen from rebuilding during playback
                        child: ValueListenableBuilder<Duration>(
                            valueListenable: _currentPosition,
                            builder: (context, pos, child) {
                              double progress = _totalDuration.inMilliseconds > 0 ? pos.inMilliseconds / _totalDuration.inMilliseconds : 0.0;
                              return AnimatedBuilder(
                                animation: _waveController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: FlagWaveformPainter(
                                      pattern: _waveformPattern,
                                      progress: progress,
                                      isPlaying: _isPlaying,
                                      waveAnimValue: _waveController.value,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white.withOpacity(0.2),
                                      glowColor: accentCyan,
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

                  // Timers
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
                          child: IconButton(onPressed: () => _seekBy(-10), icon: const Icon(Icons.replay_10_rounded, color: Colors.white, size: 26)),
                        ),
                        GestureDetector(
                          onTap: _togglePlay,
                          child: AnimatedBuilder(
                              animation: _breathingController,
                              builder: (context, child) {
                                // Subtle scaling effect when paused
                                double scale = _isPlaying ? 1.0 : 1.0 + (_breathingController.value * 0.05);
                                return Transform.scale(
                                  scale: scale,
                                  child: Container(
                                    height: 72, width: 72,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                                        colors: [Color(0xFF2E6BFF), Color(0xFF093185)],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: accentCyan.withOpacity(_isPlaying ? 0.4 : 0.4 + (_breathingController.value * 0.2)),
                                            blurRadius: _isPlaying ? 22 : 22 + (_breathingController.value * 10),
                                            offset: const Offset(0, 8)
                                        )
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
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),

          // Rule Popup Tooltip
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
                      border: Border.all(color: accentCyan.withOpacity(0.5), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20, offset: const Offset(0, 10)),
                        BoxShadow(color: accentCyan.withOpacity(0.25), blurRadius: 25, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.workspace_premium_rounded, color: accentCyan, size: 18),
                            const SizedBox(width: 8),
                            Text("RAJYAPURASKAR RULE", style: AppTheme.badgeText(width, accentCyan).copyWith(fontSize: 10, letterSpacing: 1.5)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Stand in the Savadhan (Attention) position. Ensure the duration is exactly 45 seconds.",
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
class FlagWaveformPainter extends CustomPainter {
  final List<double> pattern;
  final double progress;
  final bool isPlaying;
  final double waveAnimValue;
  final Color activeColor;
  final Color inactiveColor;
  final Color glowColor;

  FlagWaveformPainter({
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
  bool shouldRepaint(covariant FlagWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.waveAnimValue != waveAnimValue || oldDelegate.isPlaying != isPlaying;
  }
}

/// A visually distinct, scrollable bottom sheet displaying the official song lyrics.
///
/// Implements advanced UI techniques like [BackdropFilter] for an underlying glassmorphism 
/// effect and an oversized background watermark to give the modal a premium look and feel.
class FlagSongLyricsModal extends StatelessWidget {
  final List<String> stanzas;
  final Color accentColor;

  const FlagSongLyricsModal({
    super.key,
    required this.stanzas,
    required this.accentColor
  });

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
            // Underlying gradient
            const Positioned.fill(
              child: SmoothGradientBackground(child: SizedBox()),
            ),
            
            // Subtle Background Watermark
            Positioned(
              top: 150, left: -50, right: -50,
              child: Opacity(opacity: 0.04, child: Icon(Icons.tour_rounded, size: 400, color: accentColor)),
            ),
            
            // Glassmorphism Blur Filter
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), border: Border(top: BorderSide(color: Colors.white.withOpacity(0.15), width: 1.5)))),
              ),
            ),
            
            // Modal Header and Drag Handle
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
            
            // Scrollable Lyrics Body
            Padding(
              padding: const EdgeInsets.only(top: 85),
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 80),
                  itemCount: stanzas.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 5))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("STANZA 0${index + 1}", style: AppTheme.badgeText(width, accentColor).copyWith(letterSpacing: 2, fontSize: 11)),
                              Icon(Icons.verified_rounded, color: accentColor.withOpacity(0.8), size: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Divider(color: Colors.white.withOpacity(0.1), thickness: 1),
                          ),
                          Text(
                            stanzas[index],
                            style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 18), fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.9), height: 1.8),
                          ),
                        ],
                      ),
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
