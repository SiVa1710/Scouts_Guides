import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'shared_widgets.dart';
import 'homescreen.dart';
import 'auth_screen.dart';

/// The primary entry point for the Scouts & Guides application.
///
/// Bootstraps critical external services including Firebase and Google Mobile Ads,
/// enforces strict device orientation constraints to preserve UI integrity, 
/// and mounts the root application widget.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize backend infrastructure and monetization SDKs
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  MobileAds.instance.initialize();

  // Lock the application to portrait mode to maintain the structural layout
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

/// The root structural widget of the application.
///
/// Responsible for establishing the global design system, applying the custom
/// [AppTheme] parameters, and injecting the [GoogleFonts.plusJakartaSans] typography
/// throughout the entire widget tree.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.pureBlack,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: AppTheme.textMain,
          displayColor: AppTheme.textMain,
        ),
      ),
      home: const PremiumSplash(),
    );
  }
}

/// A highly polished, animated splash screen.
///
/// Serves as the initial branding interface while the application pre-loads 
/// interstitial advertisements and determines the user's authentication state
/// for subsequent routing.
class PremiumSplash extends StatefulWidget {
  const PremiumSplash({super.key});

  @override
  State<PremiumSplash> createState() => _PremiumSplashState();
}

class _PremiumSplashState extends State<PremiumSplash> with SingleTickerProviderStateMixin {
  /// Controls the smooth entrance fade for the branding elements.
  late AnimationController _fade;

  @override
  void initState() {
    super.initState();
    _fade = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();

    // Pre-warm the ad engine so interstitials are ready when requested later
    AdManager.loadInterstitialAd();

    // Enforce a minimum display time for branding before executing the routing logic
    Timer(const Duration(seconds: 3), () {
      _routeBasedOnAuthentication();
    });
  }

  /// Evaluates the current Firebase Authentication state and gracefully transitions
  /// the user to either the Dashboard ([HomeScreen]) or the Onboarding flow ([AuthScreen]).
  void _routeBasedOnAuthentication() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    Widget nextScreen = currentUser == null ? const AuthScreen() : const HomeScreen();

    // Implements a custom, prolonged cross-fade transition replacing the splash screen entirely
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1200),
        pageBuilder: (_, __, ___) => nextScreen,
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SmoothGradientBackground(
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                
                // Central App Logo with ambient glow effect
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.white.withOpacity(0.05), blurRadius: 60, spreadRadius: 20)
                      ]
                  ),
                  child: Image.asset('assets/icons/scouts.png', width: 150),
                ),
                const SizedBox(height: 35),
                
                // Primary Application Title
                Text('SCOUTS & GUIDES', style: AppTheme.display(width).copyWith(fontSize: AppTheme.scaleText(width, 28), letterSpacing: 2)),
                
                const Spacer(flex: 2),
                
                // Developer Attribution Metadata
                Text(
                    'DEVELOPED BY',
                    style: AppTheme.bodyText(width).copyWith(
                      fontSize: AppTheme.scaleText(width, 13),
                      letterSpacing: 8,
                      color: Colors.white60,
                      fontWeight: FontWeight.w700,
                    )
                ),
                const SizedBox(height: 12),
                Text(
                    'Sivasubramanian R',
                    style: AppTheme.heading(width).copyWith(
                      fontSize: AppTheme.scaleText(width, 24),
                      fontWeight: FontWeight.w800,
                    )
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
