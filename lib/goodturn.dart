import 'dart:ui';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A sophisticated, 3D-animated tab displaying a Scout's "Good Turn" diary.
///
/// This widget features a highly interactive 3D book that users can tap to open.
/// It utilizes [AnimationController]s to manage a continuous floating effect 
/// when closed, and a Matrix4 transformation to simulate a realistic cover flip.
class GoodTurnTab extends StatefulWidget {
  const GoodTurnTab({super.key});

  @override
  State<GoodTurnTab> createState() => _GoodTurnTabState();
}

class _GoodTurnTabState extends State<GoodTurnTab> with TickerProviderStateMixin {
  /// Controls the continuous vertical hovering effect of the book when closed.
  late AnimationController _floatController;
  
  /// Controls the 3D rotational flip animation when opening or closing the book.
  late AnimationController _flipController;

  bool _showRulePopup = false;
  Timer? _popupTimer;

  /// Static dataset representing completed good turns.
  /// 
  /// In a production environment, this would be replaced by dynamic data 
  /// fetched from a local database or remote API.
  final List<Map<String, String>> _logEntries = [
    {"sno": "1)", "date1": "20-May", "task": "Helped old lady carry heavy groceries", "whom": "Mrs. Khan", "date2": "20-May"},
    {"sno": "2)", "date1": "21-May", "task": "Picked up litter scattered in community park", "whom": "Community", "date2": "21-May"},
    {"sno": "3)", "date1": "22-May", "task": "Held the door open for juniors at school", "whom": "J. Sharma", "date2": "22-May"},
    {"sno": "4)", "date1": "23-May", "task": "Shared my lunch with a friend in need", "whom": "S. Patel", "date2": "23-May"},
  ];

  @override
  void initState() {
    super.initState();
    
    _floatController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 2500)
    )..repeat(reverse: true);
    
    _flipController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 700)
    );
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

  /// Toggles the book's state between open and closed, triggering the 3D flip.
  void _toggleDiary() {
    HapticFeedback.heavyImpact();
    if (_flipController.isCompleted) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
  }

  @override
  void dispose() {
    _popupTimer?.cancel();
    _floatController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // Responsive constraints calculated to prevent layout overflows
    // regardless of the device's aspect ratio.
    double safeHeight = height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;

    double openBookHeight = (safeHeight - 240).clamp(400.0, 900.0);
    double openBookWidth = (width - 40).clamp(300.0, 700.0);

    double closedBookHeight = 320.0;
    double closedBookWidth = 220.0;

    const Color bookCoverColor = Color(0xFFd01414);
    const Color bookSpineColor = Color(0xFF830b0b);
    const Color accentColor = Color(0xFF4FC3F7);

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

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                
                // Top Navigation Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text("GOOD TURN", style: AppTheme.navTitle(width)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: _toggleRulePopup,
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _showRulePopup ? accentColor.withOpacity(0.3) : Colors.white.withOpacity(0.08),
                              shape: BoxShape.circle,
                              border: Border.all(color: _showRulePopup ? accentColor : Colors.white.withOpacity(0.15)),
                              boxShadow: _showRulePopup ? [BoxShadow(color: accentColor.withOpacity(0.5), blurRadius: 15)] : [],
                            ),
                            child: Icon(Icons.workspace_premium_rounded, color: _showRulePopup ? Colors.white : accentColor, size: 22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Animated Metadata Pills (Fades out when the book is opened)
                AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      double fadeVal = (1.0 - (_flipController.value * 2)).clamp(0.0, 1.0);
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: fadeVal == 0
                            ? const SizedBox(width: double.infinity, height: 0)
                            : Opacity(
                          opacity: fadeVal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("My Scout Log", style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 32), color: Colors.white, fontWeight: FontWeight.w900)),
                                const SizedBox(height: 15),
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
                                          Icon(Icons.fact_check_rounded, color: accentColor, size: 16),
                                          const SizedBox(width: 8),
                                          Text("${_logEntries.length} Current Entries", style: AppTheme.bodyText(width).copyWith(fontSize: AppTheme.scaleText(width, 13), color: Colors.white70, fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),

                // Interactive 3D Book Layer
                Expanded(
                  child: AnimatedBuilder(
                      animation: Listenable.merge([_floatController, _flipController]),
                      builder: (context, child) {
                        double flipVal = _flipController.value;

                        // Linear interpolation between closed and open dimensions
                        double currentWidth = closedBookWidth + ((openBookWidth - closedBookWidth) * flipVal);
                        double currentHeight = closedBookHeight + ((openBookHeight - closedBookHeight) * flipVal);

                        // Nullifies the hover effect progressively as the book opens
                        double yOffset = flipVal == 0 ? -10 + (_floatController.value * 20) : 0;

                        // 3D Matrix Math: Calculates the swing angle of the cover
                        double coverAngle = (flipVal <= 0.5) ? (math.pi * flipVal) : (math.pi / 2);

                        return Transform.translate(
                          offset: Offset(0, yOffset),
                          child: Center(
                            child: GestureDetector(
                              onTap: flipVal == 0 ? _toggleDiary : null,
                              child: SizedBox(
                                width: currentWidth,
                                height: currentHeight,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    
                                    // Bottom Layer: Open Content
                                    // Appears sequentially behind the opening cover
                                    if (flipVal > 0.1)
                                      Opacity(
                                        opacity: ((flipVal - 0.1) / 0.9).clamp(0.0, 1.0),
                                        child: Container(
                                          width: currentWidth,
                                          height: currentHeight,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFCFAF2), 
                                            borderRadius: BorderRadius.circular(6),
                                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
                                          ),
                                          child: _buildOpenPages(width),
                                        ),
                                      ),

                                    // Top Layer: Flipping Cover
                                    // Matrix4 handles the perspective depth (entry 3,2) and Y-axis rotation
                                    if (flipVal <= 0.5)
                                      Transform(
                                        alignment: Alignment.centerLeft,
                                        transform: Matrix4.identity()
                                          ..setEntry(3, 2, 0.0015)
                                          ..rotateY(coverAngle),
                                        child: Container(
                                          width: currentWidth,
                                          height: currentHeight,
                                          decoration: BoxDecoration(
                                            color: bookCoverColor,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(color: Colors.black.withOpacity(0.5 * (1 - flipVal)), blurRadius: 20, offset: const Offset(10, 15)),
                                              BoxShadow(color: bookCoverColor.withOpacity(0.3 * (1 - flipVal)), blurRadius: 30, spreadRadius: 5),
                                            ],
                                          ),
                                          child: _buildClosedCover(width, bookSpineColor),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),

                const SizedBox(height: 120),
              ],
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
                      border: Border.all(color: accentColor.withOpacity(0.5), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 20, offset: const Offset(0, 10)),
                        BoxShadow(color: accentColor.withOpacity(0.25), blurRadius: 25, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.workspace_premium_rounded, color: accentColor, size: 18),
                            const SizedBox(width: 8),
                            Text("RAJYAPURASKAR RULE", style: AppTheme.badgeText(width, accentColor).copyWith(fontSize: 10, letterSpacing: 1.5)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "You must perform at least four distinct good turns each week and strictly record them in your diary.",
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

  /// Constructs the visual elements of the closed book cover, including spine and ribbon.
  Widget _buildClosedCover(double width, Color spineColor) {
    return Stack(
      children: [
        Positioned(
          left: 0, top: 0, bottom: 0,
          child: Container(
            width: 35,
            decoration: BoxDecoration(
                color: spineColor,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 5, offset: const Offset(3, 0))
                ]
            ),
          ),
        ),
        Positioned(
          right: 40, bottom: -10,
          child: Container(
            width: 15, height: 40,
            decoration: const BoxDecoration(
                color: Color(0xFFFFD54F),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(4))
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
                  ),
                  child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 45),
                ),
                const SizedBox(height: 25),
                Text(
                  "GOOD TURN\nDIARY",
                  textAlign: TextAlign.center,
                  style: AppTheme.heading(width).copyWith(
                    fontSize: AppTheme.scaleText(width, 22),
                    color: Colors.white,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.touch_app_rounded, color: Colors.white54, size: 18),
                    const SizedBox(width: 8),
                    Text("Tap to open", style: AppTheme.bodyText(width).copyWith(color: Colors.white54, fontSize: AppTheme.scaleText(width, 13), letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Constructs the inner pages of the diary, mapping data to a structurally constrained table.
  Widget _buildOpenPages(double width) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CustomPaint(painter: UnruledNotebookPainter()),
          ),
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 35),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "My Daily Good Turn Log",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kalam(
                          fontSize: AppTheme.scaleText(width, 26),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF093185),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.close_rounded, color: Color(0xFF093185), size: 28),
                    onPressed: _toggleDiary,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 10),
                child: Column(
                  children: [
                    // Hand-drawn aesthetic table utilizing FractionColumnWidth to prevent render overflows
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF093185), width: 1.5),
                      ),
                      child: Table(
                        border: TableBorder.symmetric(inside: const BorderSide(color: Color(0xFF093185), width: 1.5)),
                        columnWidths: const {
                          0: FractionColumnWidth(0.12),
                          1: FractionColumnWidth(0.18),
                          2: FractionColumnWidth(0.38),
                          3: FractionColumnWidth(0.16),
                          4: FractionColumnWidth(0.16),
                        },
                        children: [
                          TableRow(
                              children: [
                                _buildTableHeader("S.NO", width),
                                _buildTableHeader("DATE", width),
                                _buildTableHeader("GOOD\nTURN", width),
                                _buildTableHeader("TO\nWHOM", width),
                                _buildTableHeader("DATE", width),
                              ]
                          ),
                          ..._logEntries.map((entry) {
                            return TableRow(
                                children: [
                                  _buildPencilCell(entry['sno']!, width, isCenter: true),
                                  _buildPencilCell(entry['date1']!, width),
                                  _buildPencilCell(entry['task']!, width, isTask: true),
                                  _buildPencilCell(entry['whom']!, width),
                                  _buildPencilCell(entry['date2']!, width),
                                ]
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Signature block utilizing FittedBox architectures to secure responsiveness
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF093185), width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: FittedBox(alignment: Alignment.centerLeft, fit: BoxFit.scaleDown, child: Text("SIGN OF SCOUT/GUIDE", style: _headerStyle(width)))),
                              const SizedBox(width: 10),
                              FittedBox(fit: BoxFit.scaleDown, child: Text("A. Sharma", style: _pencilStyle(width).copyWith(fontSize: AppTheme.scaleText(width, 22)))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(height: 1, color: const Color(0xFF093185).withOpacity(0.3)),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: FittedBox(alignment: Alignment.centerLeft, fit: BoxFit.scaleDown, child: Text("SIGN OF SCOUT MASTER", style: _headerStyle(width)))),
                              const SizedBox(width: 10),
                              FittedBox(fit: BoxFit.scaleDown, child: Text("R. Khan", style: _pencilStyle(width).copyWith(fontSize: AppTheme.scaleText(width, 22)))),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.park_rounded, color: const Color(0xFF4A4A4A).withOpacity(0.35), size: 28),
                        Icon(Icons.wb_sunny_outlined, color: const Color(0xFF4A4A4A).withOpacity(0.35), size: 28),
                        Icon(Icons.emoji_nature_rounded, color: const Color(0xFF4A4A4A).withOpacity(0.35), size: 28),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- TYPOGRAPHY HELPERS ---

  /// Primary styling for structural text (headers, labels).
  TextStyle _headerStyle(double width) {
    return GoogleFonts.plusJakartaSans(
      color: const Color(0xFF093185),
      fontSize: AppTheme.scaleText(width, 10.5),
      fontWeight: FontWeight.w900,
      letterSpacing: 0.5,
    );
  }

  /// Handwriting styling for the dynamic user input.
  TextStyle _pencilStyle(double width) {
    return GoogleFonts.kalam(
      color: const Color(0xFF4A4A4A),
      fontWeight: FontWeight.w500,
      height: 1.2,
    );
  }

  /// Encapsulates table header styling logic.
  Widget _buildTableHeader(String text, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(text, textAlign: TextAlign.center, style: _headerStyle(width)),
        ),
      ),
    );
  }

  /// Encapsulates table cell styling logic.
  Widget _buildPencilCell(String text, double width, {bool isCenter = false, bool isTask = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: isTask ? 6 : 4),
      child: Text(
        text,
        textAlign: isCenter ? TextAlign.center : TextAlign.left,
        style: _pencilStyle(width).copyWith(fontSize: AppTheme.scaleText(width, isTask ? 13 : 14)),
      ),
    );
  }
}

/// A custom painter that renders a realistic ambient spine shadow for an unruled notebook.
class UnruledNotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect centerRect = Rect.fromLTWH((size.width / 2) - 15, 0, 30, size.height);
    final Paint spinePaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.transparent, Colors.black.withOpacity(0.04), Colors.transparent],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(centerRect);

    canvas.drawRect(centerRect, spinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
