import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'shared_widgets.dart';

/// A generic, reusable detail screen for educational modules.
///
/// This screen serves as a dynamic fallback or template for curriculum categories 
/// that do not yet have a fully specialized, hardcoded view (unlike Flags or Knots). 
/// It implements the application's standard glassmorphism design language, providing 
/// a cohesive UI experience while displaying placeholder overview content and resource links.
class ModuleDetailScreen extends StatelessWidget {
  /// The display title of the module passed via navigation routing.
  final String title;
  
  /// The hero icon representing the module's category.
  final IconData icon;

  const ModuleDetailScreen({
    super.key, 
    required this.title, 
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      
      // Custom Frosted Glass App Bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.02),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                title.toUpperCase(), 
                style: AppTheme.navTitle(width).copyWith(fontSize: AppTheme.scaleText(width, 18))
              ),
              centerTitle: true,
            ),
          ),
        ),
      ),
      
      // Main Responsive Body
      body: SmoothGradientBackground(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              // Prevents horizontal stretching on wide desktop/tablet displays
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                children: [
                  
                  // Central Hero Icon
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 40, spreadRadius: 5)],
                      ),
                      child: Icon(icon, size: 60, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Dynamic Content Block
                  _buildContentCard(width),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBannerAd(),
    );
  }

  /// Generates the primary informational card utilizing a [BackdropFilter].
  ///
  /// This creates a premium, frosted-glass depth effect over the underlying 
  /// ambient gradient background, containing the module's overview text and 
  /// interactive resource links.
  Widget _buildContentCard(double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Text Content
              Text(
                'Overview', 
                style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 24))
              ),
              const SizedBox(height: 16),
              Text(
                'This section provides deep training materials and practical exercises for Scouts and Guides in the $title module.',
                style: AppTheme.bodyText(width).copyWith(height: 1.6),
              ),
              const SizedBox(height: 35),
              
              // Resource Links
              Text('Resources', style: AppTheme.heading(width).copyWith(color: Colors.white70)),
              const SizedBox(height: 16),
              _buildListTile(Icons.play_circle_fill_rounded, 'Video Tutorial', width),
              _buildListTile(Icons.menu_book_rounded, 'Reading Guide', width),
              _buildListTile(Icons.quiz_rounded, 'Module Quiz', width),
            ],
          ),
        ),
      ),
    );
  }

  /// A standardized, reusable UI component for rendering interactive resource links.
  ///
  /// Designed to mimic a clickable menu item (e.g., Video Tutorials, Reading Guides) 
  /// within the generic module detail view.
  Widget _buildListTile(IconData icon, String text, double width) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 16),
          Text(text, style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 15))),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: Colors.white38),
        ],
      ),
    );
  }
}
