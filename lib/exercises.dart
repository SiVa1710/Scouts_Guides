import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'shared_widgets.dart';

// ---------------------------------------------------------
// 1. RAJYAPURASKAR EXAM-READY DATA SOURCE
// ---------------------------------------------------------

/// A static, exam-ready data source containing details for Baden-Powell's Six Exercises.
///
/// Each exercise map includes essential metadata such as its physical focus, 
/// recommended repetitions, an illustrative image path, thematic UI colors, 
/// step-by-step instructions, and a crucial tip specifically tailored to help 
/// Scouts & Guides pass the Rajyapuraskar (Governor's Award) examination.
final List<Map<String, dynamic>> exercisesData = [
  {
    "name": "EXERCISE I: HEAD",
    "focus": "Circulation & Awakening",
    "reps": "As needed",
    "image": "assets/images/exercise1.png",
    "accent": const Color(0xFF4FC3F7),
    "icon": Icons.face_rounded,
    "steps": [
      "Rub your head and face firmly with the palms and fingers of both hands.",
      "Massage the muscles of the neck and throat thoroughly with your thumbs."
    ],
    "examPoint": "Purpose: This exercise is designed to massage the head and face to wake up the nervous system and stimulate blood flow to the brain."
  },
  {
    "name": "EXERCISE II: CHEST",
    "focus": "Deep Breathing",
    "reps": "12 Repetitions",
    "image": "assets/images/exercise2.png",
    "accent": const Color(0xFFFF8A65),
    "icon": Icons.air_rounded,
    "steps": [
      "Stand upright, bend forward, arms stretched downwards, with the back of your hands together in front of your knees.",
      "Exhale as you raise your arms gradually over your head and lean back as far as possible.",
      "Inhale deeply through the nose as you lean back.",
      "Lower your arms gradually to the sides, exhaling and saying the word 'Thanks' through your mouth.",
      "Bend forward again, exhaling fully, and count the repetitions."
    ],
    "examPoint": "Exam Trap: Examiners will watch your breathing. You must INHALE when leaning back/arms up, and EXHALE when lowering arms while saying 'Thanks' to God."
  },
  {
    "name": "EXERCISE III: STOMACH",
    "focus": "Core Twisting",
    "reps": "6 Each Side",
    "image": "assets/images/exercise3.png",
    "accent": const Color(0xFFBA68C8),
    "icon": Icons.cached_rounded,
    "steps": [
      "Stand upright and extend both arms straight in front of you.",
      "Slowly swing to the right from the hips without moving your feet.",
      "Point your right arm as far behind you as possible while keeping both arms level with your shoulders.",
      "Pause, then swing to the left as far as you can.",
      "Breathe in as you point left, and exhale as you point right."
    ],
    "examPoint": "Crucial Detail: Your feet must remain firmly planted and point straight ahead. Only your torso from the hips upwards should twist."
  },
  {
    "name": "EXERCISE IV: TRUNK",
    "focus": "Cone Exercise",
    "reps": "6 Each Direction",
    "image": "assets/images/exercise4.png",
    "accent": const Color(0xFFFFD54F),
    "icon": Icons.threesixty_rounded,
    "steps": [
      "Stand at attention, raise both hands as high as possible over your head, and interlock your fingers.",
      "Lean backward, then sway your arms slowly in a wide circle above and around your body.",
      "Turn from the hips, leaning over one side, then to the front, then to the other side, and back.",
      "Inhale as you lean backward and exhale as you lean forward."
    ],
    "examPoint": "Also known as the 'Cone Exercise'. Your interlocked hands trace the circular base of an imaginary cone in the air while your feet act as the point."
  },
  {
    "name": "EXERCISE V: LOWER BODY",
    "focus": "Flexibility",
    "reps": "12 Repetitions",
    "image": "assets/images/exercise5.png",
    "accent": const Color(0xFFE57373),
    "icon": Icons.accessibility_new_rounded,
    "steps": [
      "Stand with feet slightly apart.",
      "Touch your head with both hands, and look up into the sky while leaning back as far as possible.",
      "Bend forward until your fingers touch your toes.",
      "Gradually return to the starting position."
    ],
    "examPoint": "Form Check: You must touch your toes WITHOUT bending your knees. If you cannot reach your toes initially, go as far as you can while keeping legs completely straight."
  },
  {
    "name": "EXERCISE VI: LEGS & FEET",
    "focus": "Balance & Strength",
    "reps": "12 Repetitions",
    "image": "assets/images/exercise6.png",
    "accent": const Color(0xFF4DB6AC),
    "icon": Icons.directions_walk_rounded,
    "steps": [
      "Stand at attention and place your hands on your hips.",
      "Stand on tiptoe and turn your knees outwards.",
      "Slowly bend your knees down to a squatting position while keeping your heels off the ground.",
      "Gradually raise your body back to the starting position.",
      "Inhale as your body rises and exhale as your body sinks."
    ],
    "examPoint": "Balance Rule: Your heels must never touch the ground during the squat. This strengthens the arches of the feet and calf muscles."
  }
];

// ---------------------------------------------------------
// 2. THE MASTER SCREEN
// ---------------------------------------------------------

/// A beautifully crafted screen displaying Baden-Powell's Six Exercises.
///
/// This screen utilizes a highly visual, glassmorphism-inspired design language.
/// It presents the exercises as a scrollable list of interactive, premium cards
/// designed to be both educational and visually engaging for exam preparation.
class Exercises extends StatefulWidget {
  const Exercises({super.key});

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the background gradient to flow seamlessly behind the app bar area
      body: SmoothGradientBackground(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              // ConstrainedBox ensures the UI retains its elegant proportions on wide tablet screens
              constraints: const BoxConstraints(maxWidth: 800), 
              child: Column(
                children: [
                  // PREMIUM HEADER
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
                        Column(
                          children: [
                            Text("BP'S SIX EXERCISES", style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 16))),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8), // Squarer, modern badge design
                                border: Border.all(color: Colors.white.withOpacity(0.2)),
                              ),
                              child: Text(
                                "DAILY ROUTINE",
                                style: AppTheme.badgeText(width, Colors.white70).copyWith(fontSize: AppTheme.scaleText(width, 10), letterSpacing: 2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // EXERCISE CARDS LIST
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 50),
                      physics: const BouncingScrollPhysics(),
                      itemCount: exercisesData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 35),
                          child: _buildPremiumExerciseCard(exercisesData[index], width, index),
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

  /// Constructs a highly detailed, animated card for a single exercise.
  ///
  /// Features include:
  /// * A staggered slide-and-fade entrance animation calculated via the item [index].
  /// * Advanced glassmorphism visual effects using [BackdropFilter] and opacity blends.
  /// * Edge-to-edge instructional imagery with subtle vignette blending.
  /// * A visually distinct vertical timeline layout for step-by-step instructions.
  /// * A dedicated, high-contrast 'Exam Point' section to highlight grading criteria.
  Widget _buildPremiumExerciseCard(Map<String, dynamic> data, double width, int index) {
    final Color accent = data['accent'];
    final List<dynamic> steps = data['steps'];

    // Staggered Entrance Animation: Delays the animation based on the card's index
    // so they cascade onto the screen sequentially rather than appearing all at once.
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100).clamp(0, 500)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 40 * (1 - value)), // Slides up from 40px below
            child: child,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient Glow Layer: Creates a colored aura behind the card matching the accent color
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: accent.withOpacity(0.12), blurRadius: 60, spreadRadius: 10),
                ],
              ),
            ),
          ),

          // Main Card Container (Glassmorphism effect)
          Container(
            decoration: BoxDecoration(
              // Subtly tinted background to match the exercise's accent color
              gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                colors: [
                  accent.withOpacity(0.06),
                  Colors.white.withOpacity(0.02)
                ],
              ),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 25, offset: const Offset(0, 15)),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), // Core glassmorphism blur
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    // TOP BAR: Badges & Title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10), // Modern square-rounded
                                  border: Border.all(color: accent.withOpacity(0.3)),
                                ),
                                child: Text(
                                  data['focus'].toString().toUpperCase(),
                                  style: AppTheme.badgeText(width, accent).copyWith(fontSize: AppTheme.scaleText(width, 10), letterSpacing: 2),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.repeat_rounded, color: Colors.white54, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    data['reps'],
                                    style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white, fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 50, width: 50,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [accent.withOpacity(0.8), accent.withOpacity(0.3)]),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                                    boxShadow: [BoxShadow(color: accent.withOpacity(0.4), blurRadius: 15)]
                                ),
                                child: Icon(data['icon'], color: Colors.white, size: 26),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  data['name'],
                                  style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 24), fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // MASSIVE EDGE-TO-EDGE IMAGE SECTION
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.35),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white, // Pure white background to make the line-drawing illustration pop
                        borderRadius: BorderRadius.circular(20), // Sharper inner radius for the image container
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              data['image'],
                              fit: BoxFit.cover, // Ensures image occupies full space without awkward white gaps
                              alignment: Alignment.topCenter, // Aligns to top so character heads are not cut off
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Text("Image not found", style: TextStyle(color: Colors.black54)),
                                );
                              },
                            ),
                            // Subtle vignette at the bottom of the image to blend smoothly back into the dark UI
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withOpacity(0.0), Colors.black.withOpacity(0.5)],
                                  stops: const [0.0, 0.7, 1.0],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // PROCEDURE (TIMELINE-STYLE HIGHLIGHTED STEPS)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 30, 24, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(steps.length, (stepIndex) {
                          bool isLast = stepIndex == steps.length - 1;
                          
                          // IntrinsicHeight ensures the timeline connection line stretches perfectly to match text length
                          return IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Glowing Timeline Node
                                Column(
                                  children: [
                                    Container(
                                      width: 28, height: 28,
                                      margin: const EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        color: accent.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(8), // Squarer, modern node styling
                                        border: Border.all(color: accent.withOpacity(0.6), width: 1.5),
                                        boxShadow: [BoxShadow(color: accent.withOpacity(0.4), blurRadius: 10)],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${stepIndex + 1}",
                                          style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    
                                    // Connecting line for the timeline (omitted on the last step)
                                    if (!isLast)
                                      Expanded(
                                        child: Container(
                                          width: 2,
                                          margin: const EdgeInsets.symmetric(vertical: 6),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                                                colors: [accent.withOpacity(0.6), accent.withOpacity(0.1)],
                                              )
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                                    child: Text(
                                      steps[stepIndex].toString(),
                                      style: AppTheme.bodyText(width).copyWith(
                                          fontSize: AppTheme.scaleText(width, 16),
                                          height: 1.6,
                                          color: Colors.white.withOpacity(0.9)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),

                    // RAJYAPURASKAR EXAM POINT
                    // A highly contrasted, gold-themed box specifically designed to grab attention for exam criteria.
                    Container(
                      margin: const EdgeInsets.fromLTRB(24, 25, 24, 30),
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                          colors: [Color(0xFF2A220A), Color(0xFF141002)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.8), width: 1.5), // Stronger gold border
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
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFD54F).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFFFD54F).withOpacity(0.5)),
                                ),
                                child: const Icon(Icons.stars_rounded, color: Color(0xFFFFD54F), size: 18),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "RAJYAPURASKAR EXAM",
                                style: AppTheme.badgeText(width, const Color(0xFFFFD54F)).copyWith(fontSize: AppTheme.scaleText(width, 12), letterSpacing: 2),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            data['examPoint'],
                            style: AppTheme.bodyText(width).copyWith(
                                fontSize: AppTheme.scaleText(width, 14.5),
                                color: Colors.white,
                                height: 1.5,
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
          ),
        ],
      ),
    );
  }
}
