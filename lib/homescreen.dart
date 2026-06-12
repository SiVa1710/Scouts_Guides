import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'theme.dart';
import 'shared_widgets.dart';
import 'module_detail.dart';
import 'flags_screen.dart';
import 'history_screen.dart';
import 'firstaid_screen.dart';
import 'auth_screen.dart';
import 'knots_screen.dart';
import 'lashing_screen.dart';
import 'hitches_screen.dart';
import 'patrol_screen.dart';
import 'flagsong.dart';
import 'national_anthem.dart';
import 'prayer.dart';
import 'goodturn.dart';
import 'notes.dart';
import 'exercises.dart';
import 'uniform.dart';

/// The primary dashboard and navigation hub of the application.
///
/// This screen acts as the root structural component after a successful login.
/// It manages the state for the bottom navigation bar, dynamically fetches and 
/// displays the user's profile data, and provides a responsive grid layout to 
/// access the core educational modules.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = "Scout";
  String _fullName = "Scout";
  bool _isLoadingName = true;
  
  /// Tracks the currently active tab in the custom [FloatingPillNavBar].
  int _currentNavIndex = 0;

  /// The master catalog of educational modules available on the home grid.
  final List<Map<String, dynamic>> categories = [
    {"n": "Flags", "i": Icons.tour_rounded},
    {"n": "Notes", "i": Icons.import_contacts_rounded},
    {"n": "History", "i": Icons.auto_stories_rounded},
    {"n": "Uniform", "i": Icons.military_tech_rounded},
    {"n": "First Aid", "i": Icons.medical_services_rounded},
    {"n": "Knots", "i": Icons.all_inclusive_rounded},
    {"n": "Lashing", "i": Icons.cable_rounded},
    {"n": "Hitches", "i": Icons.link_rounded},
    {"n": "Patrols", "i": Icons.groups_rounded},
    {"n": "Exercise", "i": Icons.directions_run_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  /// Asynchronously retrieves the authenticated user's profile data.
  ///
  /// Prioritizes the 'name' field from the Firestore 'users' collection. 
  /// If the document or field is missing, it falls back to the display name 
  /// stored directly within the [FirebaseAuth] token.
  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        String fullName = user.displayName ?? "Scout";

        if (doc.exists && doc.data() != null) {
          final data = doc.data() as Map<String, dynamic>;
          if(data.containsKey('name')) {
            fullName = data['name'];
          }
        }

        // Extract just the first name for the casual dashboard greeting
        String firstName = fullName.split(' ')[0];

        if (mounted) {
          setState(() {
            _fullName = fullName;
            _userName = firstName;
            _isLoadingName = false;
          });
        }
      } catch (e) {
        if (mounted) setState(() => _isLoadingName = false);
      }
    } else {
      if (mounted) setState(() => _isLoadingName = false);
    }
  }

  /// Triggers the interactive, glassmorphic profile settings bottom sheet.
  void _openProfileSettings() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProfileSettingsModal(
        currentName: _fullName,
        onNameUpdated: (newName) {
          setState(() {
            _fullName = newName;
            _userName = newName.split(' ')[0];
          });
        },
      ),
    );
  }

  /// Determines the optimal number of grid columns based on the device's screen width.
  /// Ensures fluid responsiveness across mobile, tablet, and desktop views.
  int getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1000) return 4;
    if (screenWidth > 600) return 3;
    return 2; // Default for standard mobile devices
  }

  /// Routes the main viewport content based on the active bottom navigation index.
  Widget _buildBody() {
    switch (_currentNavIndex) {
      case 0: return _buildHomeGrid();
      case 1: return const FlagSongTab();
      case 2: return const PrayerTab();
      case 3: return const NationalAnthemTab();
      case 4: return const GoodTurnTab();
      default: return _buildHomeGrid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SmoothGradientBackground(
        child: Stack(
          children: [
            // Core viewport wrapped in an AnimatedSwitcher for fluid cross-fading 
            // and sliding transitions between main navigation tabs.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOutQuart,
              switchOutCurve: Curves.easeInQuart,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _buildBody(),
            ),
            
            // Custom floating navigation bar anchored to the bottom of the stack
            FloatingPillNavBar(
              selectedIndex: _currentNavIndex,
              onItemTapped: (index) => setState(() => _currentNavIndex = index),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBannerAd(),
    );
  }

  /// Constructs the primary interactive grid menu for the dashboard.
  Widget _buildHomeGrid() {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      key: const ValueKey(0), // ValueKey ensures AnimatedSwitcher recognizes widget changes
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Top Action Bar (Profile Settings Trigger)
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _openProfileSettings,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.06),
                              border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                            ),
                            child: const Icon(Icons.person_rounded, color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Personalized Greeting View
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _isLoadingName
                      ? Text("Loading...", style: AppTheme.display(width).copyWith(color: Colors.white38))
                      : Text(
                      "Hey $_userName,\nwhat's on your\nmind?",
                      key: ValueKey(_userName),
                      style: AppTheme.display(width)
                  ),
                ),
              ),
              const SizedBox(height: 15),
              
              // Dynamic Module Grid
              Expanded(
                child: GridView.builder(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 120),
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: getCrossAxisCount(width),
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final String name = categories[index]['n'];
                    final IconData icon = categories[index]['i'];

                    return FolderGlassCard(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        
                        // Functional routing based on the grid item tapped
                        Widget screen;
                        if (name == 'Flags') screen = const FlagsScreen();
                        else if (name == 'Notes') screen = const NotesScreen();
                        else if (name == 'History') screen = const HistoryScreen();
                        else if (name == 'Uniform') screen = const Uniform();
                        else if (name == 'First Aid') screen = const FirstAidScreen();
                        else if (name == 'Knots') screen = const KnotsScreen();
                        else if (name == 'Lashing') screen = const LashingScreen();
                        else if (name == 'Hitches') screen = const HitchesScreen();
                        else if (name == 'Patrols') screen = const PatrolScreen();
                        else if (name == 'Exercise') screen = const Exercises();
                        else screen = ModuleDetailScreen(title: name, icon: icon); // Fallback

                        // Ad logic wrapper before pushing the route
                        AdManager.showInterstitialAdSafely(() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: Colors.white, size: width > 600 ? 54 : 48),
                          const SizedBox(height: 12),
                          Text(name, style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 16))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A comprehensive settings modal allowing users to manage their profile data.
///
/// Implements a deeply integrated Firebase pipeline to handle display name updates 
/// (synced across Auth and Firestore) and secure password modifications. Features a 
/// premium frosted glass aesthetic.
class ProfileSettingsModal extends StatefulWidget {
  final String currentName;
  final Function(String) onNameUpdated;

  const ProfileSettingsModal({super.key, required this.currentName, required this.onNameUpdated});

  @override
  State<ProfileSettingsModal> createState() => _ProfileSettingsModalState();
}

class _ProfileSettingsModalState extends State<ProfileSettingsModal> {
  late TextEditingController _nameController;
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    
    // Listeners trigger UI rebuilds to apply 'focused' styling to inputs
    _nameFocus.addListener(() => setState(() {}));
    _passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _nameFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  /// Displays a custom-styled, floating snackbar for operation feedback.
  void _showSnackBar(String message, bool isError) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isError ? const Color(0xFF8A1A1A).withOpacity(0.95) : Colors.green.shade800.withOpacity(0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
          ),
          child: Row(
            children: [
              Icon(isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Expanded(child: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
      ),
    );
  }

  /// Processes the profile update request.
  ///
  /// Intelligently handles separate updates for the user's name and password. 
  /// If the password is changed, it forces a local sign-out to ensure token validity 
  /// and redirects the user to the Authentication screen.
  Future<void> _updateProfile() async {
    FocusScope.of(context).unfocus();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      bool needsRelogin = false;

      // Pipeline 1: Update Name Data
      if (_nameController.text.trim().isNotEmpty && _nameController.text.trim() != widget.currentName) {
        String newName = _nameController.text.trim();
        
        // Update Firebase Auth profile
        await user.updateDisplayName(newName);
        
        // Update Firestore Document using SetOptions(merge: true) to prevent overwriting existing schema
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            {'name': newName},
            SetOptions(merge: true)
        );
        
        // Callback to dynamically update the parent UI
        widget.onNameUpdated(newName);
      }

      // Pipeline 2: Update Password Data
      if (_passwordController.text.trim().isNotEmpty) {
        if (_passwordController.text.length < 6) throw "Password must be at least 6 characters.";
        await user.updatePassword(_passwordController.text.trim());
        needsRelogin = true;
      }

      // Route handling post-update
      if (needsRelogin) {
        _showSnackBar("Password updated successfully! Please sign in again.", false);
        await FirebaseAuth.instance.signOut();
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const AuthScreen()),
                (route) => false,
          );
        }
      } else {
        _showSnackBar("Profile updated successfully!", false);
        if (mounted) Navigator.pop(context);
      }

    } catch (e) {
      _showSnackBar(e.toString(), true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const Color brandAccent = Color(0xFF2E6BFF);

    return GestureDetector(
      // Ensure tapping outside of text fields dismisses the keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        // ViewInsets padding pushes the modal up when the keyboard is active
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF040A18).withOpacity(0.85),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 40, offset: const Offset(0, 10)),
              BoxShadow(color: brandAccent.withOpacity(0.1), blurRadius: 40, spreadRadius: 5),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25), // Core glassmorphism effect
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    // Drag Handle Indicator
                    Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10))),
                    const SizedBox(height: 25),

                    // Decorative Hero Avatar
                    Container(
                      height: 80, width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                          colors: [brandAccent.withOpacity(0.8), brandAccent.withOpacity(0.2)],
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                        boxShadow: [BoxShadow(color: brandAccent.withOpacity(0.4), blurRadius: 20)],
                      ),
                      child: const Icon(Icons.person_rounded, color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 20),

                    Text("Edit Profile", style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 24), fontWeight: FontWeight.w900)),
                    const SizedBox(height: 35),

                    // Input Fields
                    _buildPremiumInput("Full Name", _nameController, Icons.badge_rounded, _nameFocus, brandAccent, width),
                    const SizedBox(height: 16),
                    _buildPremiumInput("New Password", _passwordController, Icons.lock_rounded, _passFocus, brandAccent, width, isPassword: true),

                    const SizedBox(height: 40),

                    // Primary Action Button (Save)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 56, width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: _isLoading ? [] : [BoxShadow(color: brandAccent.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E6BFF), Color(0xFF093185)],
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
                          ),
                        ),
                        onPressed: _isLoading ? null : _updateProfile,
                        child: _isLoading
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                            : Text("SAVE CHANGES", style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 16), fontWeight: FontWeight.w800, letterSpacing: 1.5, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Secondary Action Button (Sign Out)
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                          backgroundColor: Colors.redAccent.withOpacity(0.1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.redAccent.withOpacity(0.3), width: 1.0))
                      ),
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const AuthScreen()), (route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_rounded, color: Colors.redAccent.shade200, size: 20),
                          const SizedBox(width: 10),
                          Text("Sign Out", style: AppTheme.heading(width).copyWith(fontSize: AppTheme.scaleText(width, 15), color: Colors.redAccent.shade200)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable UI component for creating aesthetically consistent, animated text fields.
  Widget _buildPremiumInput(String hint, TextEditingController controller, IconData icon, FocusNode focusNode, Color accent, double width, {bool isPassword = false}) {
    bool isFocused = focusNode.hasFocus;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isFocused ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isFocused ? accent : Colors.white.withOpacity(0.1), width: 1.5),
        boxShadow: isFocused ? [BoxShadow(color: accent.withOpacity(0.2), blurRadius: 15)] : [],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: isPassword && _obscurePassword,
        style: AppTheme.bodyText(width).copyWith(color: Colors.white, fontSize: AppTheme.scaleText(width, 16)),
        cursorColor: accent,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Icon(icon, color: isFocused ? accent : Colors.white.withOpacity(0.5), size: 22),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 60),
          
          // Toggle visibility button for password fields
          suffixIcon: isPassword ? IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: Colors.white.withOpacity(0.4), size: 20),
              onPressed: () {
                HapticFeedback.selectionClick();
                setState(() => _obscurePassword = !_obscurePassword);
              }
          ) : null,
          hintText: hint,
          hintStyle: AppTheme.bodyText(width).copyWith(color: Colors.white.withOpacity(0.3), fontSize: AppTheme.scaleText(width, 16)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}
